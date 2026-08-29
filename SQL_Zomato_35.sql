create database Zomato_db
use Zomato_db

Describe zomato
select * from zomato
select count(*) from zomato # it means all 9551 rows are imported 

🌍 Category 1: Global Operations & Expansion

1. Which country has the highest number of restaurant listings on the Zomato platform?
select country_name, count(RestaurantID) as Number_of_Restaurant from Zomato 
group by country_name
order by Number_of_Restaurant desc 
limit 1

Business Insights:
1. Market Dominance:
Identifying the country with the maximum listings highlights Zomato primary revenue hub and its most established operational network.

2.Resource Allocation:
This insight helps the corporate team decide where to focus their primary infrastructure,
such as major server capacity and large-scale marketing campaigns.

2.Identify the top 10 cities globally with the most restaurants.
select city , count(RestaurantID) as No_of_Restaurant from zomato 
group by city
order by No_of_Restaurant desc 
limit 10

Business Insights :
Strategic Hub Identification:For Zomato, these cities are the "Revenue Engines" 
where marketing campaigns and premium services like "Zomato Gold" should be prioritized to maximize returns.

3. How many unique countries does Zomato currently operate in (according to this dataset)?
select count(distinct country_name) as Unique_Countries from zomato

Business Insights:
Market Diversification:
A high count of unique countries indicates a well-distributed risk profile, 
where the company is not over-dependent on a single economy, allowing for stable growth even if one market faces a downturn.

4. Find the count of restaurants in each city within a specific country (e.g., India).
select country_name,city, count(RestaurantID) as No_of_Restaurant from zomato 
group by city , country_name
order by No_of_Restaurant desc 

Business Insights:
Market Concentration:
Identifying high-density cities helps in localized resource allocation,
such as setting up dedicated delivery hubs and account management teams for top-performing urban centers.

5. Which cities have fewer than 50 restaurant listings? (Potential areas for expansion). 
select city, count(RestaurantID) as No_of_Restaurant from zomato 
group by city 
having No_of_Restaurant< 50

Business Insights:
Market Expansion Opportunity:
Cities with low restaurant density highlight untapped regions 
where Zomato can launch targeted vendor-onboarding campaigns to increase its market share and competitive presence.

💰 Category 2: Financials & Pricing Strategy

6. What is the average "Cost for Two" (in INR) across the entire global dataset?
select round(avg(Average_Cost_for_two_INR),2) as avg_cost_for_two from zomato 

Business Insights: 
Pricing Benchmark:
This global average serves as a baseline for the company to standardize its "Mid-Range" category,
helping to identify which markets are performing above or below the global spending average.


7. Which city has the highest average dining cost for two people?
select city, round(avg(Average_Cost_for_two_INR),2) as avg_cost_for_two from zomato
group by city 
order by avg_cost_for_two desc

Business Insights:
Premium Market Identification:
Identifying cities with the highest average dining costs helps Zomato pinpoint high-wealth clusters 
where customers have significant purchasing power, making these cities ideal for launching premium subscription services like "Zomato Gold."


8. List all restaurants that fall into the "Luxury" Price_Range_Category.
select RestaurantName from zomato 
where Price_Range_Category ="Luxury"

Business Insgights:
High-Value Inventory Tracking: Filtering for luxury restaurants identifies the top-tier segment of the platform,
enabling targeted partnerships with high-end brands and specialized marketing for affluent customer segments.

9. Find the top 5 most expensive restaurants in the dataset based on the INR cost.
with base as (select RestaurantName,sum(Average_Cost_for_two_INR) as sum_Average_Cost_for_two_INR  from zomato 
group by RestaurantName),
base1 as (select RestaurantName, 
dense_rank() over(partition by RestaurantName order by sum_Average_Cost_for_two_INR desc) as rnk from base)
select RestaurantName from base1 
where rnk <=5

select RestaurantName,Average_Cost_for_two_INR from zomato 
order by  Average_Cost_for_two_INR desc 
limit 5

Business Insights:
Ultra-High-End Portfolio:
Identifying the top 5 most expensive outlets helps the business team 
curate a "Luxury Dining" collection for high-net-worth individuals (HNIs) who prioritize exclusivity over price.

10. Calculate the total number of restaurants in each Price_Range (1, 2, 3, 4).
select Price_Range,count(RestaurantID) as No_of_Restaurants from zomato 
group by Price_Range

Business Insights:
Market Segmentation Analysis:
Understanding the volume of restaurants in each price tier helps Zomato identify its core target audience (Budget vs. Premium),
allowing for more effective allocation of marketing budgets and promotional offers tailored to the largest segment

11. What is the average cost for two in each country?
select country_name , round(avg(Average_Cost_for_two_INR),2) as avg_cost_two_per_country from zomato 
group by country_name 

Business Insights  :
Market-Specific Pricing Strategy:
Identifying the average dining cost per country allows Zomato to customize its subscription fees (like Zomato Gold) a
nd delivery charges based on the local economic standards and consumer spending habits.

select * from zomato 
where country_name="Singapore"

💰 Category 3: Customer Sentiment & Performance
12. What is the overall average rating for the entire platform?
select round(avg(Rating),2) as avg_rating from zomato

Business Insights:
Platform Quality Benchmark: 
-- The overall average rating acts as a primary health indicator for the platform; a high average suggests a satisfied customer base, 
whereas a lower-than-expected score signals a need for stricter restaurant auditing and improved service standards.

13. Which restaurant received the maximum number of Votes?
select RestaurantName, Votes from zomato 
order by Votes desc 
limit 1

with base as (select RestaurantName,Votes ,dense_rank() over(order by Votes desc) as rnk from zomato)
select RestaurantName,Votes from base 
where rnk =1

Business Insights :
Brand Advocacy & Popularity: High vote counts indicate strong customer engagement and brand loyalty,
identifying "Market Influencers" that Zomato can leverage for exclusive brand-led marketing campaigns.

14. Find the top 10 highest-rated restaurants that have more than 500 votes.
select RestaurantName, Rating, Votes from zomato 
where Votes>500 
order by Rating desc 
limit 10

Business Insights:
Customer Trust & Reliability: 
Identifying restaurants with both high ratings and a large voting base helps Zomato showcase "Verified Excellence,"
which can be used to improve user trust and drive higher conversion rates for new app users. 

15. How many restaurants have a rating of 0.0? (Identify unrated or poor-performing ones).
select count(RestaurantID) as cnt_restaurants from zomato 
where rating = 0

Business Insights:
New Vendor Support: 
Identifying restaurants with a 0.0 rating highlights the "Cold Start" problem where new vendors struggle for visibility; 
-- targeting these outlets for promotional boosts can help them get their first set of reviews and improve platform engagement.


16. List the average rating for each Price_Range_Category. (Does "Luxury" always mean better ratings?).
select Price_Range_Category, round(avg(Rating),2) as avg_rating from zomato 
group by Price_Range_Category

Business Insights:
Value-for-Money Correlation: 
Analyzing average ratings across price tiers helps Zomato identify 
if premium-priced restaurants are meeting customer expectations, allowing the platform to flag high-priced but low-rated outlets for service improvements.


17. Count how many restaurants fall under each Rating_text (e.g., Excellent, Good, Average).
select Rating_text , count(RestaurantID) as cnt_restaurant from zomato 
group by Rating_text

Business Insights:
Service Quality Distribution: 
Understanding the volume of restaurants in each rating category helps Zomato identify the "Service Gap"; 
-- a high concentration of "Average" ratings suggests a need for restaurant-partner training programs to elevate the overall platform experience.


💰 Category 4: Cuisine & Service Analysis

18. What are the top 5 most popular All_Cuisines combinations in India?
select All_Cuisines,count(All_Cuisines) as cnt_cuisine from zomato
where country_name ="India"
group by All_Cuisines
order by cnt_cuisine desc 
limit 5

Business Insights :
Menu Optimization & Demand Forecasting: 
Identifying the top 5 cuisine combinations helps Zomato provide data-driven consultancy to new restaurant partners 
on which menu types have the highest historical demand and market acceptance in India.
How many restaurants offer "Online Delivery" versus those that do not?

19. What is the average rating of restaurants that offer "Table Booking" vs. those that don’t?
select Has_Table_booking as Table_Booking, round(avg(rating),2) as avg_rating from zomato 
group by Has_Table_booking

Business Insights:
Service Premiumization: 
Comparing ratings between booking-enabled and non-enabled outlets helps Zomato quantify the value of "Dine-in Experience" features,
-- providing a data-backed case to upsell reservation management tools to mid-tier restaurant partners.

20. Find restaurants that offer "Online Delivery" but have a rating below 2.5.
select RestaurantName from zomato 
where Has_Online_delivery="yes" and rating <2.5

Business Insights:
Churn Prevention & Quality Control: 
Identifying low-rated delivery partners is crucial for protecting the platform’s reputation; 
proactively flagging these outlets allows Zomato to intervene with quality audits, preventing customer dissatisfaction and long-term user churn.

21. Which city has the highest percentage of restaurants offering "Online Delivery"?
select city ,
(sum(case when Has_Online_delivery="yes" then 1 else 0 end)/count(Has_Online_delivery)) as online_del_percentage 
from zomato 
group by city 
order by online_del_percentage desc 
limit 1 


with base1 as (select city , count(Has_Online_delivery) as cnt_on_delivery from zomato 
where Has_Online_delivery="yes"
group by city),
base2 as (select city , count(Has_Online_delivery) as cnt_total from zomato 
group by city),
base3 as(
select a.*,b.cnt_total from base1 a 
join base2 b on a.city =b.city )
select city , ((cnt_on_delivery)*100/(cnt_total)) as online_delv_percentage from base3
order by online_delv_percentage desc 
limit 1
-- It gives Mohali city --> means in mohali only 1 restaurant is available as per this data and that restr also provides online delivery 

select city ,count(RestaurantID), Has_Online_delivery from zomato 
where city ="Mohali"
group by city,Has_Online_delivery

Business Insights: 
Digital Adoption Index: 
Cities with the highest online delivery percentages represent "Digitally Mature" markets where the infrastructure and consumer behavior are perfectly aligned for rapid scaling, 
making them the most profitable zones for hyper-local advertising.

📈 Category 5: Strategic Business Growth
22. In which year were the maximum number of restaurants in this dataset opened?
select opening_year, count(RestaurantID) as No_of_Restaurant from zomato 
group by opening_year
order by No_of_Restaurant desc
limit 1

Business Insights:
Market Growth Velocity: 
Identifying the peak year of restaurant openings helps Zomato track historical market expansion trends,
allowing the strategy team to correlate growth spurts with external factors like economic stability or digital infrastructure development.

23. Identify "High-Value" restaurants: Rating > 4.5 and Price Range = 1 or 2.
select RestaurantName from zomato 
where Rating> 4.5 and Price_Range in (1,2)

Business Insights:
Customer Acquisition Engine:
-- High-rated, low-cost restaurants are the primary drivers for new user acquisition and repeat orders. 
Identifying these "Value Gems" allows Zomato to create high-converting marketing collections 
that appeal to the largest consumer segment (budget-conscious yet quality-seeking).

24. Find the names of restaurants that have "Excellent" ratings but fewer than 50 votes (Hidden Gems).
Select RestaurantName from zomato 
where Rating_Text="Excellent" and Votes <50

Business Insights:
Niche Market Discovery: 
Identifying high-rated but low-engagement outlets helps Zomato discover "Hidden Gems" 
Promoting these restaurants can balance the order load across the platform and 
-- provide users with exclusive, high-quality dining options that aren't yet mainstream.

25. Find the restaurants where the Rating is greater than 4.5 but the Rating_Text is NOT "Excellent".
select RestaurantName from zomato 
where rating>4.5 and rating_text!="Excellent"

Business Insights :
Data Validation & Accuracy: 
A zero-result set for conflicting conditions confirms high data integrity 
and ensures that the automated rating-to-text mapping logic is functioning correctly across the platform.

Task 26: Identify the "Top 3 Popularity Leaders" per City
Write a query to display the names of the top 3 restaurants in each city based on their total number of Votes.
The output should show the City, Restaurant Name, Votes, and their respective Rank.

with base as (select city,RestaurantName,Votes ,
dense_rank() over(partition by city order by Votes desc) as rnk
from zomato 
group by city,RestaurantName,Votes )
select * from base 
where rnk <=3

Business Insights:
Identification of Regional Powerhouses: 
By partitioning the data by city, Zomato can identify regional trendsetters. 
These top-3 restaurants are the primary drivers of platform traffic. Marketing teams can use this list to curate "City Favorites" collections, 
which typically see a much higher Click-Through Rate (CTR) compared to generic recommendations.

Task 27: Filter "Outperforming" Restaurants based on City Average
Find all restaurants that have a Rating higher than the average rating of the city they belong to. 
Display the Restaurant Name, City, Restaurant Rating, and the City’s Average Rating.

with base as (select city,restaurantName,Rating ,
round(avg(rating) over(partition by city),2) as avg_rating
from zomato)
select * from base 
where rating > avg_rating

Business Insights:
Contextual Benchmarking: 
Evaluating performance relative to the local market average (City Avg) rather than a global average provides a fairer assessment of a restaurant quality. 
This helps Zomato identify local leaders in emerging cities where overall ratings might be lower than in Tier-1 cities.

Task 28: Calculate the "Cumulative Vote Contribution" of Restaurants
List all restaurants in descending order of Votes and calculate the "Running Total" of votes across the entire dataset.

select RestaurantName,city, Votes ,
sum(Votes) over(order by Votes desc rows between unbounded preceding and current row ) as cumm_sum 
from zomato 

Business Insights: 
Pareto Principle Analysis (80/20 Rule): 
This query helps in identifying if a small percentage of restaurants contribute to the majority of customer engagement (Votes). 
Understanding the cumulative distribution allows Zomato to strategize 
whether they need to promote smaller vendors or double down on the high-engagement leaders to maintain revenue stability.

Task 29: Analyze the "Cuisine Variety vs. Quality" Correlation
Categorize restaurants into two groups: those serving "More than 3 Cuisines" and those serving "3 or Fewer Cuisines."
Compare the average Rating for these two groups to see which model performs better.

select All_Cuisines from zomato 
where All_Cuisines  not like ("%,%")

with base as(select RestaurantName, All_Cuisines,Rating,
case when  All_Cuisines like ("%,%,%,%") then "More than 3 Cuisines"
	 else "3 or Fewer Cuisines" 
     end as Group_category
from zomato )
select  Group_category , count(Group_category) as cnt_grp_cat ,round(avg(Rating),2) as avg_rating from base
group by Group_category

Business Insights:
Operational Efficiency vs. Customer Choice: 
This analysis helps determine the "Sweet Spot" for the number of cuisines.
If "3 or Fewer Cuisines" has a higher average rating, it indicates that specialization leads to better quality control. 
Conversely, if "More than 3" wins, it suggests that customers value convenience and variety over deep culinary expertise.
This is a key insight for Zomato’s "Restaurant Partner" advisory team.

Task 30: Determine the "Digital Revenue Share" for each City
For every city, calculate the percentage of total votes that are contributed only by restaurants offering "Online Delivery."

with base1 as (select city , sum(Votes) as Total_votes from zomato 
group by city),
base2 as(select city, sum(Votes) as Total_online_votes from zomato 
where Has_Online_delivery="yes"
group by city)
select a.*,b.Total_online_votes,concat(((b.Total_online_votes)*100/a.Total_votes),"%") as percentage_online_votes from base1 a
join base2 b on a.city=b.city
 
 Business Insights :
Market Penetration Strategy: 
Identifying cities with high digital vote shares helps Zomato prioritize infrastructure investment (e.g., cloud kitchens and logistics). 
Cities with low digital share but high total votes represent an untapped "Offline-to-Online" conversion opportunity.

Ques 31: The "Market Cannibalization" 
Identify "Duplicate" or "Nearby" competitors. Find pairs of restaurants that have the same City, Cuisines, and Rating, 
but different RestaurantNames.

select r1.locality,r1.RestaurantName,r2.locality,r2.RestaurantName from zomato r1 
join zomato r2 on r1.city=r2.city and r1.All_Cuisines=r2.All_Cuisines 
and r1.rating=r2.rating  
where  r1.RestaurantName<r2.RestaurantName

Business Insight:
Market Cannibalization & Strategic Differentiation: 
Identifying restaurant pairs with identical profiles highlights saturated micro-markets vulnerable to intense competition. 
This data allows Zomato to advise vendors on menu innovation or unique value propositions, preventing price wars 
and maintaining healthy competition within these specific zones.

Ques 32: The "Rating Momentum" 
For each city, find the restaurant with the highest votes and 
show the name of the restaurant that is "just below" it (the runner-up) in the same row.

with base as (select RestaurantName,city,Votes,
dense_rank() over(partition by city order by Votes desc) as rnk 
from zomato ),
base2 as(
select*, lead(Votes,1) over(partition by city) as runner_up_Votes,
lead(RestaurantName,1) over (partition by city) as runner_up_Rest_Name
from base)
select RestaurantName,city,Votes,runner_up_Rest_Name,runner_up_Votes from base2
where rnk=1

Business Insight:
Competitive Benchmarking: 
Identifying the market leader alongside its immediate runner-up exposes the competitive landscape within each city. 
This insight empowers Zomato’s sales team to prioritize B2B acquisition strategies by targeting high-performing "runner-up" vendors 
who are actively challenging the current market leaders.

Ques_33: The "Elite Cluster" Analysis (Complex CTEs)
Find cities where at least 20% of the restaurants have "Table Booking" and "Online Delivery" both available, 
and their average rating is above 4.2.

with base as(select city , count(RestaurantID) as cnt_restaurant from zomato
group by city),
base1 as (select city , count(RestaurantID) as cnt_premium from zomato
where rating >4.2 and  Has_Table_booking="yes" and Has_Online_delivery="yes"
group by city),
base2 as(
select b.city, ((b1.cnt_premium*100)/b.cnt_restaurant) as top_20_per from base b
join base1 b1 on b.city=b1.city )
select * from base2 
where top_20_per>20

Business Insight:
Elite Cluster Expansion: 
Identifying cities with a high density of "Elite" restaurants (high ratings and full service capabilities) pinpoints mature, 
high-value market ecosystems. This enables Zomato to prioritize these specific regions for premium subscription rollouts 
and exclusive partnership campaigns, as they possess the validated supply and infrastructure to support high-end user experiences.

Ques 34: City-Specific "Top Performer" Ranking
The Goal: Rank restaurants within each city based on their Votes to identify who the local market leaders are.

with base as(select city,restaurantname,votes,
dense_rank() over(partition by city order by votes desc) as rnk 
from zomato)
select city,restaurantname,votes from base 
where rnk<=3

Business Insight:
Local Market Leadership: 
Identifying the top 3 restaurants per city based on customer votes reveals the "Local Kings" driving platform engagement. 
This allows Zomato to prioritize these influential partners for high-visibility marketing partnerships 
and use them as "Gold Standard" benchmarks to motivate other vendors to improve their service quality.

Ques 35: Relative Performance Against City Average
The Goal: Identify "Over-Achieving" restaurants that have a rating higher than the average rating of their specific city.

with base as(select city,restaurantname , rating , 
round(avg(rating) over(partition by city),2) as avg_rating
from zomato)
select * from base 
where rating >avg_rating

Business Insight:
Benchmarking & Quality Outliers: 
Identifying restaurants that consistently outpace their local city-average rating reveals "Hidden Gems" 
that offer superior customer experiences. These over-achievers are prime candidates for Zomato’s spotlight campaigns 
and premium collections, as they set the benchmark for quality that drives higher user trust and platform retention.