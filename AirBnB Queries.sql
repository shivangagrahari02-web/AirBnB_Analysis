-- creating listing table and importing csv
Create table listings(
id BIGINT,
listing_url TEXT,
name TEXT,
description TEXT,
host_id BIGINT,
host_name TEXT,
host_since TEXT,
host_location TEXT,
host_response_time TEXT,
host_response_rate TEXT,
host_acceptance_rate TEXT,
host_is_superhost TEXT,
host_listings_count INTEGER,
host_total_listings_count INTEGER,
host_verifications TEXT,
property_type TEXT,
room_type TEXT,
accommodates INTEGER,
bathrooms NUMERIC,
bathrooms_text TEXT,
bedrooms NUMERIC,
beds NUMERIC,
number_of_reviews INTEGER,
review_scores_rating NUMERIC
)

--updating date datatype to date from text
ALTER TABLE listings
add column host_since_date DATE;

update listings 
set host_since_date = to_date(host_since::TEXT, 'DD/MM/YY')


-- creating calender table and importing calender csv
CREATE TABLE calender(
listing_id BIGINT,
date TEXT,
available TEXT,
price TEXT,
minimum_nights INTEGER,
maximum_nights INTEGER
)

-- updating price column by removing $ and , and making it to numeric
ALTER TABLE calender
ALTER COLUMN price TYPE NUMERIC(10,2)
USING REPLACE(REPLACE(price, '$', ''), ',', '')::NUMERIC;

-- updating date datatype to date from text
ALTER TABLE calender
add column date2 DATE;

update calender 
set date2 = to_date(date::TEXT, 'DD/MM/YY')	

--creating reviews table and importing reviews csv
create table reviews(

listing_id BIGINT,
id BIGINT,
date TEXT,
reviewer_id BIGINT,
reviewer_name TEXT,
comments TEXT
)

-- updating date datatype to date from text
ALTER TABLE reviews
add column date2 DATE;

update reviews 
set date2 = to_date(date::TEXT, 'DD/MM/YY')	

select * from listings
select * from calender 
select * from reviews

/*Question 1: Property Diversity
With a wide range of property types available, from apartments and villas to unique stays like treehouses and boats, 
the management team wants to evaluate whether they are meeting customer needs.

Highlight the most common property types and uncover underserved categories.

Task:

Calculate the total number of listings and unique property types.
Identify the top 5 most common property types and their respective counts.*/

--1

select 
		count(id) as total_number_of_listing, 
		count(distinct(property_type)) as unique_property_type 
from listings

--2

select 
	property_type, 
	count(*) as respective_counts
from listings
	group by property_type 
	order by count(*) desc
	limit 5

/*Question 2: Guest Ratings
Guest satisfaction is critical to Airbnb’s success, as high ratings lead to repeat bookings and positive word-of-mouth. 
Identifying top-rated listings can help Airbnb feature these properties in promotional campaigns and inspire other hosts to improve their offerings.

Conversely, understanding listings with poor ratings will allow Airbnb to address guest concerns through targeted interventions, 
such as host training or quality assurance checks.

Task:

Calculate the average review score across all listings.
List the top 10 listings with the highest review scores.
Count the number of listings with an average review score below 4.0.*/

--1

select 
	Round(avg(review_scores_rating), 2) as avg_review_score 
from listings

--2

select 
	name, 
	review_scores_rating 
from listings
	where review_scores_rating is not null
	order by review_scores_rating desc
	limit 10;

--3

select 
	name, 
	Round(avg(review_scores_rating),2)
from listings
	group by name
	having Round(avg(review_scores_rating),2) < 4.0


/* Question 3: Host Engagement
Hosts are the backbone of Airbnb’s platform, and their success directly impacts the company’s growth. 
Hosts managing multiple listings contribute significantly to the platform’s inventory and revenue. 
Airbnb wants to identify its most engaged hosts and understand their performance.

Task:

Identify hosts managing more than 3 listings.
Calculate the average review score for each host across their listings.
List hosts with at least 2 listings and an average review score above 4.0.*/

--1

select
	host_id,
	count(id) as number_of_listings
from listings
	group by host_id
	having count(id)>3
	order by number_of_listings desc

--2 

select
	host_id,
	id,
	Round(avg(review_scores_rating),2) as avg_review_score
from listings
	group by host_id, id
	order by avg_review_score

--3

select 
	host_id,
	count(host_id) as total_listing,
	Round(avg(review_scores_rating),2) as avg_rating_score
from listings
	group by host_id
	having 
	count(host_id) > 2 
    and 
	avg(review_scores_rating)>4.0

/*Question 4: Booking Trends
Occupancy rates are one of the most critical indicators of a listing’s success. 
Listings with high occupancy rates indicate strong demand, while low-occupancy listings may signal pricing issues or uncompetitive offerings.

Airbnb’s sales team is keen to understand which listings perform well and which are underutilised during specific periods, 
such as January 2024. This insight will help them optimise marketing strategies and identify patterns in guest booking behaviour.

Task:

Calculate the occupancy rate for each listing for January 2024.
Identify the top 5 listings with the highest occupancy rates in January 2024.
List all listings that were not booked at all in January 2024.*/

--1
select 
	id, 
	host_since_date,
	((host_listings_count)/(host_total_listings_count))*100 as occupancy_rate
from listings
	where host_since_date BETWEEN '2024-01-01' AND '2024-01-31' 

--2

select 
	id, 
	host_since_date,
	((host_listings_count)/(host_total_listings_count))*100 as occupancy_rate
from listings
	where host_since_date BETWEEN '2024-01-01' AND '2024-01-31'
	order by occupancy_rate  desc
	limit 5

--3
-- available: Indicates if the listing is available (t for true, f for false)

select 
	listing_id
from calender
	where date2 Between '2024-01-01' AND '2024-01-31'
	group by listing_id
	having sum(case when available = 't' then 1 else 0 end) = 0
	

/* Question 5: Pricing Patterns Across Property Types
Airbnb’s pricing strategy team wants to understand how property type influences nightly rates. 
Identifying undervalued property types can guide pricing adjustments, while understanding high-value categories can inform marketing priorities.

Analysing pricing patterns will also help identify trends in demand and inform strategic decisions about property offerings.

Task:

Calculate the average price per night for each property type.
Identify the top 5 listings with the highest average price per night and their property type.
Find property types with an average price below $150 per night.*/

--1

select 
	listing_id, 
	Round(avg(price),2) as average_price_per_night
from calender
	group by listing_id
	
--2

select 
	C.listing_id, 
	Round(avg(C.price),2) as avg_price_per_night, 
	L.property_type
from Calender as C
	join listings as L
	on C.listing_id = L.id
	group by C.listing_id, L.property_type
	order by Round(avg(C.price),2) desc
	limit 5

--3

select 
	L.property_type, 
	Round(avg(C.price),2) as avg_price_per_night
from Calender as C
	join listings as L
	on C.listing_id = L.id
	group by L.property_type
	having Round(avg(C.price),2) < 150.0

/*Question 6: Guest Review Insights
Guest reviews offer invaluable insights into the strengths and weaknesses of Airbnb’s platform. 
Identifying frequent reviewers can help the company understand customer behaviour, 
while analysing listings with no reviews reveals areas of potential improvement in guest engagement.

Task:

Identify the top 10 reviewers by the total number of reviews submitted.
Calculate the average number of reviews per listing.
Identify all listings with no reviews in 2023.*/

--1

select 
	reviewer_id, 
	count(*)
from reviews
	group by reviewer_id
	order by count(*) desc
	limit 10

--2

select 
	id,
	Round(avg (number_of_reviews),2) as avg_no_of_reviews
from listings
	group by id
	
--3

select 
	id
from listings
	where host_since_date between '2023-01-01' and '2023-12-31'
	group by id
	having sum(number_of_reviews) = 0

/*Questions
1. Analyze Customer Engagement Trends:

The team wants to analyze customer engagement across all listings within a specific time period. 
By identifying and ranking reviews submitted between two dates, the business can understand trends in 
customer interactions and review activity during that timeframe. 

Question: Rank all reviews submitted between '2015-01-01' and '2015-06-30' by their submission date. 

Display:

Listing ID
Review Date
Reviewer Name
Rank of the Review by Date*/


select 
listing_id, 
date2 as review_date, 
reviewer_name,
dense_rank()over(order by date2) as rank_of_review_by_date
from reviews
where date2 between '2015-01-01' and '2015-06-30'

/*2. Identify Most Active Hosts

The management team wants to identify the most active hosts based on the total number of reviews their listings have received. 
This analysis will help the team recognize high-performing hosts who maintain popular and engaging properties. 
The total number of reviews for each host is calculated by summing up the reviews of all their listings.

Question: Calculate the total number of reviews received by each host across all their listings. 
Rank the hosts based on the total number of reviews. 

Display:

Host ID
Host Name
Total Number of Reviews (sum of reviews for all their listings)
Rank of the Host by Reviews*/

select * from listings

select
host_id,
host_name,
sum(number_of_reviews) as total_number_of_reviews,
dense_rank()over(order by sum(number_of_reviews) desc) as rank_of_host
from listings
group by host_id,id, host_name

/*3. Analyze Revenue for Top Listings

The finance team wants to identify the top revenue-generating listings. 
By analyzing the total revenue earned by each listing, 
the team can prioritize these listings for promotional strategies or investment. 
The revenue is calculated by summing up the price for all available days in the calendars table.

Question: Calculate the total revenue for each listing by summing up the price for all available days. 
Use a window function to rank the listings based on their total revenue in descending order. 

Display:

Listing ID
Total Revenue
Rank of the Listing by Revenue*/

select 
	listing_id, 
	sum((price) * (case when available ='t' then 1 else 0 end)) as Total_revenue, 
	dense_rank()over(order by sum((price) * (case when available ='t' then 1 else 0 end)) desc) as Rank_of_list_by_revenue
from calender
	group by listing_id


/*4. Compare Property Type Performance in Summer

The marketing team wants to identify how property types perform relative to each other during the summer months. 
By calculating percentile ranks for property types based on their total summer revenue, 
the team can classify property types into performance tiers, such as top-80 percentile performing property types.

Question: Calculate the total summer revenue (June, July, and August) for each property type. 
Determine its percentile rank among all property types based on their revenue. Display:

Property Type
Total Summer Revenue
Percentile Rank (based on summer revenue, between 0 and 1)*/


select  
	L.property_type,  
	sum((C.price)*(case when C.available ='t' then 1 else 0 end)) as Total_revenue,
	Percent_Rank()over(order by sum((C.price)*(case when C.available ='t' then 1 else 0 end)))*100 as Percentile_Rank
from listings as L
	join calender as C
	on L.id = C.listing_id
	where EXTRACT(MONTH FROM date2) IN (6, 7, 8)
	group by L.property_type


/*5. Analyze Year-over-Year (YoY) Growth in Listing Revenue The finance team wants to analyze how listing 
revenue changes over time by comparing year-over-year (YoY) growth. This information can help identify trends 
in revenue generation and highlight listings that are growing or declining in performance.

Question: For each listing, calculate the total revenue per year and determine its YoY growth as a percentage. 
Use window functions to retrieve the previous year's revenue for each listing and calculate the YoY growth. 
Finally, rank listings based on their YoY growth percentage to identify top-performing listings.


Display

Listing ID
Year
Total Revenue
Year-over-Year Growth (%)
Rank of Each Listing by YoY Growth*/

with my_cte as (
	select 
	listing_id, 
	extract(Year from date2) as year, 
	sum((price) * (case when available ='t' then 1 else 0 end)) as Total_revenue
from calender
	group by year, listing_id
	order by listing_id, year)
select *,
	lag(total_revenue,1)over(partition by listing_id) as pre_value,
	round((Total_revenue - (lag(total_revenue,1)over(partition by listing_id)))*100/NULLIF(lag(total_revenue,1)over(partition by listing_id),0),2) as YOY_growth
from my_cte

