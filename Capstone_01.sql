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
--Using case whne
SELECT ROUND(COUNT(case when arrival_delay + weather_delay + carrier_delay +late_aircraft_delay + air_traffic_delay + security_delay>0 then 1 end)*100/count(*),2) as percentage_delayed_flights
from tutorial.flights;
