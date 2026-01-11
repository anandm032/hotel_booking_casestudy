# Hotel Booking Cancellation & Demand Analysis

**Author:** ANAND M  

---

## Overview
Analyze hotel booking data (~119K records) to identify drivers of cancellations, seasonal demand trends, and provide recommendations to improve revenue.

---

## Key Questions
- Which hotel type has higher cancellations?  
- How does lead time affect cancellations?  
- Does deposit type reduce cancellations?  
- Which months show peak demand?  
- How does ADR influence cancellations?  

---

## Tools
- R: `tidyverse`, `lubridate`, `janitor`, `ggplot2`  
- R Markdown  

---

## Dataset
City & Resort hotel bookings with variables: `hotel`, `is_canceled`, `lead_time`, `adr`, `deposit_type`, `arrival_date_month`, `adults`, `children`, `babies`.

---

## Insights
- City hotels cancel more than resort hotels  
- Longer lead times → higher cancellations  
- Non-refundable deposits reduce cancellations  
- Peak demand: July–August  
- ADR extremes affect cancellations  

---

## Recommendations
- Stricter cancellation policies for long lead times  
- Promote non-refundable deposits in peak season  
- Optimize pricing based on seasonal demand  

---

