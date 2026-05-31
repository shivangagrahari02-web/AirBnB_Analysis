# Airbnb Data Analysis 

# Overview

This project focuses on analyzing Airbnb listing, booking, pricing, and review data to understand the key drivers of occupancy, customer satisfaction, and revenue performance.

The analysis was conducted using PostgreSQL by working with multiple interconnected datasets including listings, calendar availability, and customer reviews.

The project covers SQL concepts ranging from basic aggregations to advanced analytical techniques such as joins, CTEs, window functions, ranking, and year-over-year growth analysis.

---

# Problem Statement

Airbnb aims to leverage data-driven insights to better understand:

- Property performance
- Occupancy trends
- Pricing effectiveness
- Customer satisfaction
- Host performance
- Revenue distribution
- Seasonal demand patterns
- Customer engagement behavior

The goal is to identify factors that influence booking success and revenue generation while providing actionable recommendations to improve host performance, customer experience, and marketplace growth.

---

# Dataset

The dataset consists of multiple relational tables representing Airbnb marketplace operations.

Dataset : https://drive.google.com/drive/folders/1qiLvOM4JyNTMPkjcHqQy86ubEiTZeA0h?usp=sharing

| Table Name | Description |
|---|---|
| Listings | Property details, host information, room types, pricing, and ratings |
| Calendar | Daily availability status, pricing, and occupancy information |
| Reviews | Customer reviews, review dates, and engagement data |

<img width="1576" height="1374" alt="image" src="https://github.com/user-attachments/assets/910095f0-ec9d-4e52-aadb-85a006ab4fc7" />


### Key Data Areas
- Property Information
- Host Information
- Room Types
- Pricing Data
- Availability Data
- Occupancy Data
- Customer Reviews
- Guest Ratings

---

# Tools and Technologies

- PostgreSQL
- pgAdmin
- SQL
- Data Formating
- Exploratory Data Analysis (EDA)

---

# Methods Used

## SQL Concepts Applied
- Aggregations
- GROUP BY & HAVING
- Joins
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- CASE Statements
- Date Functions
- Year-over-Year Analysis

## Analytical Techniques
- Occupancy Trend Analysis
- Revenue Analysis
- Pricing Analysis
- Host Performance Analysis
- Customer Engagement Analysis
- Customer Satisfaction Analysis
- Listing Performance Analysis
- Growth Trend Analysis

---

# Key Insights

- A small percentage of listings contribute a significant portion of total platform revenue.
- Multi-property hosts manage a substantial share of Airbnb inventory, making host retention strategically important.
- Highly rated listings consistently demonstrate stronger occupancy performance.
- Premium-priced properties generate higher revenue despite lower booking frequency.
- Customer review activity serves as a strong indicator of listing popularity and engagement.
- Certain property types dominate the marketplace inventory while others remain underserved.
- Seasonal demand fluctuations create opportunities for dynamic pricing optimization.
- Year-over-year analysis helps identify high-growth listings and emerging market opportunities.

---


# How to Run This Project

## 1. Create Database

```sql
CREATE DATABASE airbnb;
```

## 2. Create Tables

Import the following datasets into PostgreSQL:

```text
listings.csv
calendar.csv
reviews.csv
```

## 3. Run SQL Queries

Execute queries from:

```bash
AirBnB Queries.sql
```

## 4. Analyze Results

Review outputs for:

- Occupancy Insights
- Revenue Trends
- Host Performance
- Customer Engagement
- Pricing Analysis
- Listing Performance

---

# Results & Conclusion

This project demonstrates how SQL can be used for large-scale marketplace and hospitality analytics.

The analysis successfully identified:

- High-performing listings
- Revenue-driving properties
- Customer engagement patterns
- Occupancy trends
- Host performance indicators
- Pricing opportunities
- Seasonal demand behavior

The project highlights the importance of relational database analysis in supporting strategic decisions related to revenue optimization, host management, customer experience, and marketplace growth.

---

# Future Work

- Build an interactive Power BI dashboard
- Perform predictive occupancy forecasting

---

# Author & Contact

## Shivang Agrahari


- GitHub: https://github.com/shivangagrahari02-web
- LinkedIn: https://www.linkedin.com/in/shivangagrahari02/
