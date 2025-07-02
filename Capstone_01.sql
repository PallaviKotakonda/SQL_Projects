-- Platform used: mode.com 
-- Table used: tutorial.flights
-- Date: 24th June'25

-- Q1: List all flights with a departure delay greater than 30 minutes.
SELECT *                          --Multliple Column Selection
FROM tutorial.flights
where departure_delay>30;         --Departure delay more than 30 mins

-- Q2: Count the number of flights per destination city. Sort the result by highest flight count first. 
SELECT destination_city , count(*) as flight_count
FROM tutorial.flights
group by destination_city 
ORDER by flight_count DESC;       --highest flight count should come at top

-- Q3: Find flights that arrived early (arrival delay < 0).
SELECT *
from tutorial.flights 
where arrival_delay<0;            -- flights arrvied early

-- Q4: Calculate the average flight distance.
SELECT AVG(distance) as AVG_flight_distance   -- using aggregate function 
from tutorial.flights;

-- Q5: List the top 5 origin airports by flight count.
SELECT origin_airport , count(*) as flights_count 
from tutorial.flights 
GROUP by origin_airport
ORDER by flights_count desc 
LIMIT 5;       --Top 5 airports by flight count

-- Q6: Find flights with air traffic control delays.
SELECT * 
from tutorial.flights 
where air_traffic_delay>0;             -- with air traffic control delay

-- Q7: Calculate the total actual flight time for all flights.
SELECT sum(actual_flight_time) as total_flight_time     --total flight time for all the flights
from tutorial.flights;

-- Q8: List flights with a distance less than 500 miles.
SELECT *
from tutorial.flights 
where distance<500;     -- distance less than 500 miles

-- Q9: Find the flight with the longest actual flight time.
--Methond 1 (Using subquery)
SELECT * 
from tutorial.flights
where actual_flight_time = (SELECT max(actual_flight_time) from tutorial.flights);   -- comparing with maximun flight time 
--Method 2 (Using CTE)
with cte as 
(
SELECT max(actual_flight_time) as longest_flight_time from tutorial.flights                          
)
SELECT * from tutorial.flights where  actual_flight_time = (SELECT longest_flight_time from cte);          

-- Q10: Count flights by destination state.
SELECT destination_state , COUNT(*) as destination_flights
from tutorial.flights 
group by destination_state;    -- count of flights by destination

-- Q11: List flights where the actual flight time differs from the scheduled flight time by more than 10 minutes.
SELECT * 
from tutorial.flights
where ABS(actual_flight_time - scheduled_flight_time)>10;    --actual flight tile differes from scheduled flight time by 10 minutes

-- Q12: Find flights with no delays (both departure and arrival delays are 0 or negative).
SELECT * 
from tutorial.flights
where arrival_delay <=0 and departure_delay <=0 ;       --flights with no delays

-- Q13: Calculate the average arrival delay per origin airport.
SELECT origin_airport , avg(arrival_delay) as avg_arrival_delay      -- average arrival delay per origin airpot
from tutorial.flights
group by origin_airport;

-- Q14: List flights with a carrier delay greater than 0
SELECT * 
from tutorial.flights
where carrier_delay>0;           --with carrier delay greater than 0

-- Q15: Find the shortest scheduled flight time.
SELECT min(scheduled_flight_time) as shortest_scheduled_flight_time    --shortest scheduled flight time
from tutorial.flights;

-- Q16: List flights with a positive arrival delay.
SELECT * 
from tutorial.flights
where arrival_delay>0;      -- flights with positive arrival delay

-- Q17: Count flights by origin state.
SELECT origin_state , count(*) as total_flights    -- total count of flights  by origin state
from tutorial.flights
group by origin_state;

-- Q18: Find flights with a distance greater than 2000 miles.
SELECT * 
from tutorial.flights
where distance > 2000;  --distance greater than 2000 miles

-- Q19: Calculate the maximum arrival delay.
SELECT max(arrival_delay) as max_arrival_delay   --maximum arrival delay
from tutorial.flights;

-- Q20: List flights with no cancellation.
SELECT * 
from tutorial.flights
where was_cancelled='False';        --flights with no cancellation

-- Q21: Calculate the average air time per flight.
SELECT flight_number , avg(air_time) as avg_air_time     -- average airtime per flight
from tutorial.flights
group By flight_number;

-- Q22: Find flights with a scheduled departure time before 8 AM.
SELECT * 
from tutorial.flights
where scheduled_departure_time <800;     --scheduled departure time before 8AM

-- Q23: Count flights per airline code.
SELECT airline_code , count(*) as flights_airline_code  --flights count per airline code
from tutorial.flights
group by airline_code;

-- Q24: List flights with a late aircraft delay greater than 0.
SELECT * 
from tutorial.flights
where late_aircraft_delay >0;    --with late aircraft delay greater than 0

-- Q25: Calculate the total distance flown.
SELECT sum(distance) as total_distance_flown      -- total distance flown
from tutorial.flights;

-- Q26: Find flights with a scheduled arrival time after 10 PM.
SELECT *
FROM tutorial.flights
where schedued_arrival_time > 2200;

-- Q27: List flights with a flight number between 2450 and 2500.
--Method 1 (Using AND Operator)
SELECT *
from tutorial.flights
where flight_number>=2450 and flight_number<=2500;  --flight number between 2450 and 2500
--Method 2 (Using between operator)
SELECT *
from tutorial.flights
where flight_number BETWEEN 2450 and 2500;

-- Q28: Calculate the average departure delay.
SELECT avg(departure_delay) as avg_departure_delay   --average departure delay
from tutorial.flights;

-- Q29: Find flights with a security delay greater than 0.
SELECT *
from tutorial.flights
where security_delay > 0    -- with security delay greater than 0

-- Q30: List flights sorted by distance in descending order.
SELECT *
from tutorial.flights 
order by distance desc;      --disatnce in descending order

-- Q31: Find round-trip flights (same origin and destination airports).
-- Hint: Use self join 
-- DEL TO MUMBAI, MUMBAI TO DEL (ROUND TRIP FLIGHT EXAMPLE)
-- MUMBAI TO DEL, DEL TO MUMBAI,
-- A-> B, B-> A: B->A, A->B
SELECT T1.flight_number , T1.origin_airport , T1.destination_airport
from tutorial.flights as T1
join tutorial.flights as T2 
on T1.origin_airport=T2.destination_airport and T1.destination_airport=T2.origin_airport AND T1.flight_number < T2.flight_number;

-- Q32: Calculate the average departure delay by destination city.
SELECT destination_city , avg(departure_delay) as avg_departure_delay    --average delay by destination city
from tutorial.flights 
group by destination_city; 

-- Q33: Find total arrival and departure delay for all flights 
SELECT (arrival_delay + departure_delay) as total_arrival_dep_delay   -- total arrival and departure delay
from tutorial.flights;

-- Q34: Find the top 3 routes (origin to destination) by flight count.
SELECT origin_airport, destination_airport , count(*) as flight_count 
from tutorial.flights 
group by origin_airport  , destination_airport
order by flight_count desc limit 3 ;     -- top 3 routes by flight count

-- Q35: Calculate the percentage of flights delayed (arrival delay > 0)
--Method 1 (Using case when)
SELECT ROUND(COUNT(case when arrival_delay>0 then 1 end)*100/count(*),2) as percentage_delayed_flights
from tutorial.flights;
--Method 2 (Using Sub query)
SELECT ROUND((SELECT count(flight_number) from  tutorial.flights where arrival_delay>0) * 100/count(*),2) as percentage_delayed_flights
from  tutorial.flights;

-- Q36: List flights where the air time is less than 90% of the actual flight time.
SELECT *
from tutorial.flights 
where air_time < 0.9*actual_flight_time;   --air time is less than 90% of actual flight time

-- Q37: Find flights with a weather delay and their origin state.
SELECT flight_number,weather_delay , origin_state    --flights with weather ddealy and origin state
from tutorial.flights 
where weather_delay > 0;

-- Q38: Calculate the total distance flown by flights originating from Atlanta.
SELECT sum(distance) as distance_flown  --total distancce flown from Atlanta city
from tutorial.flights 
where origin_city='Atlanta';
 
-- Q39: List flights where the actual arrival time is earlier than the scheduled arrival time.
SELECT *
from tutorial.flights 
where actual_arrival_time < schedued_arrival_time;   --actual arrval time is earlier than scheduled arrival time

-- Q40: Find the average flight time for flights over 1000 miles. 
SELECT AVG(air_time) as avg_flight_time   -- average flight time
from tutorial.flights 
where distance > 1000;   -- for flights over 1000 miles
 
 -- Q41: List flights with the same origin and destination state.
SELECT *
from tutorial.flights 
where origin_state = destination_state;   -- flights with same origin and destination state 

-- Q42: Calculate the maximum departure delay per origin airport.
SELECT origin_airport , max(departure_delay) --max departure delay 
from tutorial.flights 
group by origin_airport;   -- per origin airport

-- Q43: List flights sorted by total delay (arrival + departure).
SELECT (arrival_delay + departure_delay) as total_arrival_dep_delay  --total delay
from tutorial.flights
order by total_arrival_dep_delay;  -- sorted by total delay

-- Q44: Find flights with a departure delay but no arrival delay.
SELECT *
from tutorial.flights
where arrival_delay <= 0 and departure_delay >0;   --departure delay but no arrival delay

-- Q45: Calculate the average distance by origin city.
SELECT origin_city , avg(distance) as avg_distance  --average distance 
from tutorial.flights 
group by origin_city;   --by origin city

-- Q46: List flights with actual flight time less than scheduled flight time
SELECT *
from tutorial.flights 
where actual_flight_time < scheduled_flight_time;     --actuval flight time less than scheduled flight time

-- Q47: Find the top 5 destination airports by total distance flown.
SELECT destination_airport , sum(distance) as distance_flown
from tutorial.flights 
group by destination_airport
order by distance_flown desc limit 5; --top 5 destination airports by total distance flown

-- Q48: Calculate the percentage of flights with any delay type.
--Using case when
SELECT ROUND(COUNT(case when arrival_delay + weather_delay + carrier_delay +late_aircraft_delay + air_traffic_delay + security_delay>0 then 1 end)*100/count(*),2) as percentage_delayed_flights
from tutorial.flights;

-- Q49: List flights with a wheels-off time after scheduled departure.
SELECT *
from tutorial.flights 
where wheels_off_time > scheduled_departure_time;   -- wheels off time after scheduled departure

-- Q50: Find flights with the same origin and destination city.
SELECT *
FROM tutorial.flights 
where origin_city = destination_city;      --same origin and destination city

-- Q51: Calculate the total air traffic delay by destination state.
SELECT destination_state , sum(air_traffic_delay) as total_air_traffic_delay
FROM tutorial.flights 
group by destination_state;

-- Q52: List flights with a flight number divisible by 2.
SELECT *
FROM tutorial.flights 
where MOD(flight_number::INTEGER, 2) =0;   --flight number divisible by 2 and converting flight_number to integer

-- Q53: Find flights with a departure delay greater than the average departure delay.
--Using sub query
SELECT * 
from tutorial.flights 
where departure_delay > (SELECT avg(departure_delay) from tutorial.flights); -- departure delay greater than average departure delay

-- Q54: Calculate the minimum actual flight time per origin airport.
SELECT origin_airport , min(actual_flight_time) as min_actual_flight_time -- minimum actual flight time
from tutorial.flights
GROUP by origin_airport;-- per origin airport

-- Q55: List flights with a wheels-on time before actual arrival time.
SELECT *
FROM tutorial.flights 
where wheels_on_time < actual_arrival_time;     -- wheels on time before actual arrival time

-- Q56: Find flights with a distance less than the average distance.
SELECT * 
from tutorial.flights 
where distance < (SELECT avg(distance) from tutorial.flights);  --distance less than average distance

-- Q57: Calculate the total carrier delay by origin city.
SELECT origin_city , sum(carrier_delay) as total_carrier_delay
from tutorial.flights 
group by origin_city;     -- total carrier delay by origin city

-- Q58: List flights with a scheduled flight time greater than 3 hours.
SELECT * 
from tutorial.flights
where scheduled_flight_time >180; --scheduled flight time greater than 3 hours (180 mins)

-- Q59: Rank flights by arrival delay within each origin airport.
SELECT flight_number, arrival_delay, origin_airport , 
DENSE_RANK() OVER(PARTITION by origin_airport order by arrival_delay) as delay_rank   --rank by arrival delay within each origin airport
from tutorial.flights;

-- Q60: Calculate the running total of flight distances by flight number
SELECT flight_number, distance,
sum(distance) over 
  (PARTITION by flight_number 
  order by distance                       --ensures distance are added in an order
  ROWS BETWEEN Unbounded preceding and CURRENT ROW) as running_total_flight_distance --running total distance is cummulative distance
 FROM tutorial.flights 

-- Q61: Find the top 3 flights by departure delay per destination state.
--Using Windows function and sub query
 SELECT flight_number , destination_state, departure_delay , top_flights
 FROM
 (SELECT * , RANK()
    OVER(PARTITION by destination_state order by departure_delay) as top_flights  -- ranking flights by destination state and order by departure delay
    FROM tutorial.flights 
    where departure_delay is not null ) as ranked    --consider only not null 
 where top_flights<=3  --filtering only top 3

--62Calculate the average arrival delay for flights departing within 1 hour of each flight.
--Using self join
SELECT f1.flight_number, f1.acutal_departure_time,f1.arrival_delay, AVG(f2.arrival_delay)
FROM tutorial.flights as f1
join tutorial.flights  as f2 on f2.acutal_departure_time BETWEEN f1.acutal_departure_time AND f1.acutal_departure_time + 60   --flights departing within 1 hour of each flight
group BY f1.flight_number,f1.acutal_departure_time,f1.arrival_delay,
ORDER BY f1.acutal_departure_time;

-- Q63: Find flights with above-average arrival delays for their origin airport.
--Using CTE and Joins
with Avg_delay_origin_airport as(                -- cte for average arrival delay per origin airport
SELECT origin_airport , avg(arrival_delay) as avg_arrival_delay
FROM tutorial.flights 
group by origin_airport)
SELECT flight_number,arrival_delay, f1.origin_airport , f2.origin_airport , f2.avg_arrival_delay
from tutorial.flights as f1
left join Avg_delay_origin_airport as f2 on f1.origin_airport = f2.origin_airport         -- using left join on origin airpot
where arrival_delay > avg_arrival_delay   -- filtering flights above average arrival delay 

-- Q64: Calculate the percentage contribution of each flight’s distance to the total distance
--Using CTE and Joins
with total_distance as (
SELECT flight_number, sum(distance)  as total_distance from tutorial.flights group by flight_number) -- total distance per each flight
SELECT f1.flight_number , f1.distance , f2.total_distance, ROUND((distance*100/ f2.total_distance):: NUMERIC,2) as percentage_distance    -- calculating percentage contribution of each flight
FROM tutorial.flights  as f1
left join total_distance as f2 on f1.flight_number = f2.flight_number 
order by f1.flight_number

-- Q65: Find the 5th longest flight by actual flight time
SELECT *
FROM (
 SELECT * ,RANK() OVER (ORDER BY actual_flight_time DESC) as ranked           --ranking the flights using actual flight time 
 FROM tutorial.flights  where actual_flight_time is not NULL) ranked_flight
where ranked = 5;    -- 5th longest flight 

-- Q66: List flights with consecutive departure times within 30 minutes from the same airport.
SELECT f1.flight_number as flight_1, f1.origin_airport as Airport_flight_1 ,
f2.flight_number as flight_2, f2.origin_airport as Airport_fight_2 , 
f1.acutal_departure_time as flight_1_departure , f2.acutal_departure_time as flight_2_departure ,
(f2.acutal_departure_time - f1.acutal_departure_time) as Diff_departure
FROM tutorial.flights f1
join tutorial.flights f2 on f2.origin_airport = f1.origin_airport          --departure from the same airport
where f1.acutal_departure_time < f2.acutal_departure_time  
AND (f2.acutal_departure_time - f1.acutal_departure_time) >0 and (f2.acutal_departure_time - f1.acutal_departure_time) <=30  --consecutive departure times within 30 minutes
order by f1.origin_airport; 

-- Q67: Calculate the month-over-month delay trend (assuming more data).
--Using CTE and window function
with month_delay as --total delay per month
(select EXTRACT(MONTH from day) as month  ,  SUM(( arrival_delay + departure_delay)) as total_delay 
from tutorial.flights
group by month)
SELECT month , total_delay , (total_delay-lag(total_delay) over(order by month)) as month_over_month_trend  --month_over_month trend using lag window function
from month_delay 
ORDER by month;

-- Q68: Rank flights by distance within each destination city.
SELECT flight_number, destination_city ,distance,
RANK() over(PARTITION by destination_city order by distance DESC) as flight_rank  --ranking flights by distance within each destination city
FROM tutorial.flights;

-- Q69: Calculate the cumulative arrival delay by origin airport.
Select origin_airport , day ,       --cumulative arrival delay 
SUM(arrival_delay) OVER (PARTITION by origin_airport order by day ROWS BETWEEN Unbounded preceding and CURRENT ROW) as Cummulative_arrival_delay
FROM tutorial.flights;

-- Q70: Find flights with the highest departure delay in each origin state.



