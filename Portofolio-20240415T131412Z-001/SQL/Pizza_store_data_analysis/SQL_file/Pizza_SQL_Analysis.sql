show databases;
use pizza;
show tables;
desc pizza_sales;
select* from pizza_sales;

select sum(total_price) as Total_Revenue from pizza_sales;  #Total Revenue

select sum(total_price)/count(distinct order_id) as Average_order_value from pizza_sales; #Average_order_value

select sum(quantity) as total_pizza_sold from pizza_sales; #total_pizza_sold

select count(distinct order_id)from pizza_sales;  # total_pizza_order

select cast(sum(quantity)as decimal(10,2))/cast(count(distinct order_id)as decimal(10,2)) as avg_pizza_per_order from pizza_sales; #Average pizza per order

select dayname(order_date) as name_of_the_day,    #dialy trend of orders
       count(distinct(order_id)) from pizza_sales
       group by name_of_the_day
       order by name_of_the_day asc;

select hour(order_time)as hours,                #hourly trend of orders
       count(distinct(order_id))as Total_Orders
       from pizza_sales
       group by hours
       order by hours asc; 

select pizza_category,round(sum(total_price),0)as total,         #percentage_of_sales_by_pizza category
       round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as PCT
       from pizza_sales
       group by pizza_category;
       
       
select pizza_size,round(sum(total_price),0)as total,         #percentage_of_size of _pizza _orderd_by_pizza category
       round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as PCT
       from pizza_sales
       group by pizza_size
       order by PCT DESC; 
       
select pizza_category,sum(quantity) as Total_Pizza_Sold   #pizza_sold_by_category
from pizza_sales
group by pizza_category; 

select pizza_name,sum(quantity)as Total_Pizzas_Sold   #top 5 best seller pizza
from pizza_sales
group by pizza_name
order by sum(quantity)desc limit 5;   

select pizza_name,sum(quantity)as Total_Pizzas_Sold   #bottom  5  seller pizza
from pizza_sales
group by pizza_name
order by sum(quantity)asc limit 5;

select * from pizza_Sales;  
        
select order_id  from pizza_sales  #orders that have ordered more than 1 pizza in an  particular order
group by order_id
having  count(pizza_id)>1
limit 10; 

select order_id, count(pizza_id)as number_of_pizzas  #orders that have orderd that most number of pizzas 
 from pizza_sales  
group by order_id
order by number_of_pizzas desc;



select order_id,count(pizza_id) as number_of_pizzas  #orders with numberofpizzas between a given range 
from pizza_sales
group by order_id
having  count(pizza_id) between 15 and 20 
order by number_of_pizzas desc ;


select pizza_name,order_id from pizza_sales 
where pizza_category='Classic'
group by order_id,pizza_name;
      
select distinct(pizza_ingredients) from pizza_sales;    

select * from pizza_sales; 

select pizza_name_id,order_date,order_time from pizza_sales 
where order_id=18845
group by pizza_name_id, order_date,order_time;

SELECT pizza_size,COUNT( pizza_size) AS distinct_pizza_sizes
FROM pizza_sales
WHERE order_id = 18845
group by pizza_size;
