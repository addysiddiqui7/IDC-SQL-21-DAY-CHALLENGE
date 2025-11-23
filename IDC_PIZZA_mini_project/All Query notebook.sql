/* Phase 1: Foundation & Inspection */

--# QUE.1 Database schema and table design

-- creating new database for IDC PIZZA Data Analyis mini challenge
create database mini_challenge;
use mini_challenge;

-- creating nessary tables and their schemas
create table order_details(
order_details_id int , order_id int, pizza_id VARCHAR(30), quantity int);
create table orders(
order_id int , date DATE, time TIME);
create table pizza_types(
pizza_type_id VARCHAR(30), name VARCHAR(30), category VARCHAR(20), ingredients VARCHAR(150));
create table pizzas(
pizza_id VARCHAR(50), pizza_type_id VARCHAR(50), size VARCHAR(1), price FLOAT);

-- importing 500kb-1mb data files using infile query for fast data import, other two using import wiz.
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_details.csv'
into table order_details
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
into table orders
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

--#QUE.2: List all unique pizza categories (DISTINCT)
select DISTINCT(category)
       from pizza_types;

--#QUE.3: Display `pizza_type_id`, `name`, and ingredients, replacing NULL ingredients with `"Missing Data"`. Show first 5 rows.
select pizza_type_id, name, 
       CASE when ingredients is null then "Missing Data" 
       else ingredients END as INGREDIENTS
from pizza_types
limit 5;

--#QUE.4: Check for pizzas missing a price (IS NULL).
select * from pizzas 
       where price is null;

/* Phase 2: Filtering & Exploration */

--#QUE.5: Orders placed on '2015-01-01' (SELECT + WHERE).
select * from orders 
       where date = '2015-01-01';

--#QUE.6: Pizzas sold in sizes 'L' or 'XL'.
select * from pizzas 
       where size = 'L' or 'XL';

--#QUE.7: Pizzas priced between $15.00 and $17.00.
select * from pizzas 
       where price >= 15.00 and price <= 17.00;

--#QUE.8: Pizzas with "Chicken" in the name.
select * from pizza_types 
       where name like "%Chicken%";

--#QUE.9: Orders on '2015-02-15' or placed after 8 PM.
select * from orders 
       where date = '2015-02-15' 
       or time > '20:00:00';

/*Phase 3: Sales Performance*/

--#QUE.10: Total quantity of pizzas sold (SUM).
select sum(quantity) as Total_Quantity_Sold 
       from order_details;

--#QUE.11: Average pizza price (AVG).
select round(avg(price),2) 
       as "Avg Pizza Price (in $$)" 
from pizzas;

--#QUE.12: Total order value per order (JOIN, SUM, GROUP BY).
select 
 o.order_id,
 round(sum(od.quantity * p.price),0) as total_order_value
from orders o
join order_details od on o.order_id = od.order_id
join pizzas p on od.pizza_id = p.pizza_id
group by o.order_id order by total_order_value desc;

--#QUE.13: Total quantity sold per pizza category (JOIN, GROUP BY).
select 
    pt.category,
    sum(od.quantity) as total_quantity
from order_details od
join pizzas p on od.pizza_id = p.pizza_id
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by pt.category
order by total_quantity desc;

--#QUE.14: Categories with more than 5,000 pizzas sold (HAVING).
select 
    pt.category,
    sum(od.quantity) as total_quantity
from order_details od
join pizzas p on od.pizza_id = p.pizza_id
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by pt.category
having sum(od.quantity) > 5000
order by total_quantity desc;

--#QUE.15: Pizzas never ordered (LEFT/RIGHT JOIN).
select 
    p.pizza_id,
    p.pizza_type_id,
    p.size,
    p.price
from pizzas p
left join order_details od on p.pizza_id = od.pizza_id
where od.pizza_id is null;

--#QUE.16: Price differences between different sizes of the same pizza (SELF JOIN).
select 
    p1.pizza_type_id,
    p1.size as size1,
    p1.price as price1,
    p2.size as size2,
    p2.price as price2,
    abs(p1.price - p2.price) as price_difference
from pizzas p1
join pizzas p2 
    on p1.pizza_type_id = p2.pizza_type_id 
   and p1.size <> p2.size
order by p1.pizza_type_id, price_difference desc;















