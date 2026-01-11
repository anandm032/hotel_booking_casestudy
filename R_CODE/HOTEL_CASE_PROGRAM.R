install.packages(c("tidyverse", "lubridate", "janitor"))

library(tidyverse)
library(lubridate)
library(janitor)
hotel_df <- read_csv("data/hotel_bookings.csv")
head(hotel_df)
dim(hotel_df)
colnames(hotel_df)
str(hotel_df)
summarise(hotel_df)


## cleaning colnames

hotel_df<-hotel_df %>% 
  clean_names()
##finding is there any missing value in any of columns

colSums(is.na(hotel_df))

## replace the missing value
hotel_df<- hotel_df %>% 
  mutate(children = replace_na(children,0))

##Remove rows with negative ADR (invalid revenue)


hotel_df <- hotel_df %>%
  filter(adr >= 0)
## creating new columns

hotel_df <- hotel_df %>%
  mutate(total_guests = adults + children + babies)
colnames(hotel_df)


###Remove bookings with zero guests (data error)


hotel_df <- hotel_df %>%
  filter(total_guests > 0)


##prepartion



hotel_df <- hotel_df %>%
  mutate(
    hotel = as.factor(hotel),
    is_canceled = as.factor(is_canceled),
    arrival_date_month = factor(
      arrival_date_month,
      levels = c("January","February","March","April","May","June",
                 "July","August","September","October","November","December")
    ),
    deposit_type = as.factor(deposit_type),
    market_segment = as.factor(market_segment)
  )

dim(hotel_df)
str(hotel_df)
summary(hotel_df)

###EDA PROCESS


hotel_df %>%
  group_by(hotel) %>%
  summarise(
    total_bookings = n(),
    cancellations = sum(as.numeric(as.character(is_canceled))),
    cancellation_rate = mean(as.numeric(as.character(is_canceled)))*100
  )
## visulization of cancellaction rate

library(ggplot2)

ggplot(hotel_df, aes(x=hotel, fill=is_canceled)) +
  geom_bar(position="fill") +
  ylab("Proportion") +
  ggtitle("Cancellation Rate by Hotel Type") +
  scale_fill_manual(values=c("0"="green","1"="red"), labels=c("Not Canceled","Canceled"))

##Lead Time vs Cancellation

hotel_df %>%
  group_by(is_canceled) %>%
  summarise(
    avg_lead_time = mean(lead_time)
  )

##visual of lead time

ggplot(hotel_df, aes(x=is_canceled, y=lead_time, fill=is_canceled)) +
  geom_boxplot() +
  ylab("Lead Time (Days)") +
  xlab("Canceled") +
  ggtitle("Lead Time vs Cancellation") +
  scale_fill_manual(values=c("0"="green","1"="red"))

##Monthly Demand Trend

monthly_demand <- hotel_df %>%
  group_by(arrival_date_month) %>%
  summarise(total_bookings = n())

##visual
ggplot(monthly_demand, aes(x=arrival_date_month, y=total_bookings, group=1)) +
  geom_line(color="blue", size=1.2) +
  geom_point(color="red", size=2) +
  xlab("Month") + ylab("Total Bookings") +
  ggtitle("Monthly Booking Demand Trend") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

##Deposit Type vs Cancellation

hotel_df %>%
  group_by(deposit_type) %>%
  summarise(cancellation_rate = mean(as.numeric(as.character(is_canceled)))*100)

##visual

ggplot(hotel_df, aes(x=deposit_type, fill=is_canceled)) +
  geom_bar(position="fill") +
  ylab("Proportion") +
  ggtitle("Cancellation Rate by Deposit Type") +
  scale_fill_manual(values=c("0"="green","1"="red"), labels=c("Not Canceled","Canceled"))

##ADR vs Cancellation

ggplot(hotel_df, aes(x=is_canceled, y=adr, fill=is_canceled)) +
  geom_boxplot() +
  ylab("Average Daily Rate (ADR)") +
  xlab("Canceled") +
  ggtitle("ADR vs Cancellation") +
  scale_fill_manual(values=c("0"="green","1"="red"))



##Total Guests vs Cancellation

ggplot(hotel_df, aes(x=is_canceled, y=total_guests, fill=is_canceled)) +
  geom_boxplot() +
  ylab("Total Guests") +
  xlab("Canceled") +
  ggtitle("Total Guests vs Cancellation") +
  scale_fill_manual(values=c("0"="green","1"="red"))



