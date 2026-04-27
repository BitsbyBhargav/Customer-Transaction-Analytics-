create database retailsales_db;
use retailsales_db;

create table customers(
customer_id int primary key,
name varchar(50) not null,
city varchar(20) not null,
age int,
memberhsip varchar(10));

INSERT INTO customers VALUES
(1,'Aarav','Pune',22,'Gold'),
(2,'Sneha','Mumbai',24,'Silver'),
(3,'Karan','Delhi',21,'None'),
(4,'Priya','Pune',23,'Gold'),
(5,'Rohan','Bangalore',26,'Silver'),
(6,'Simran','Mumbai',20,'None'),
(7,'Arjun','Delhi',25,'Gold'), 
(8,'Meera','Pune',22,'Silver'),
(9,'Rahul','Chennai',27,'Gold'),
(10,'Ishita','Mumbai',23,'None'),
(11,'Kabir','Delhi',24,'Silver'),
(12,'Ananya','Pune',21,'Gold'),
(13,'Yash','Bangalore',22,'None'),
(14,'Tanvi','Mumbai',26,'Gold'),
(15,'Dev','Chennai',23,'Silver'),
(16,'Neha','Delhi',24,'None'),
(17,'Vikram','Pune',28,'Gold'),
(18,'Sanya','Mumbai',22,'Silver'),
(19,'Harsh','Chennai',21,'None'),
(20,'Ritika','Bangalore',25,'Gold');

create table orders(
order_id int primary key,
customer_id int,
order_date date,
amount int,
status varchar(20),
foreign key(customer_id) references customers(customer_id));

INSERT INTO orders VALUES
(101,1,'2024-01-01',5000,'Completed'),
(102,2,'2024-01-02',3000,'Cancelled'),
(103,3,'2024-01-03',7000,'Completed'),
(104,4,'2024-01-04',2000,'Pending'),
(105,5,'2024-01-05',9000,'Completed'),
(106,6,'2024-01-06',4000,'Completed'),
(107,7,'2024-01-07',6000,'Pending'),
(108,8,'2024-01-08',8000,'Completed'),
(109,9,'2024-01-09',10000,'Completed'),
(110,10,'2024-01-10',2500,'Cancelled'),
(111,11,'2024-01-11',4500,'Completed'),
(112,12,'2024-01-12',5500,'Completed'),
(113,13,'2024-01-13',3500,'Pending'),
(114,14,'2024-01-14',7500,'Completed'),
(115,15,'2024-01-15',6500,'Completed'),
(116,16,'2024-01-16',2800,'Cancelled'),
(117,17,'2024-01-17',12000,'Completed'),
(118,18,'2024-01-18',4300,'Pending'),
(119,19,'2024-01-19',5200,'Completed'),
(120,20,'2024-01-20',8800,'Completed'),
(121,1,'2024-01-21',3000,'Completed'),
(122,2,'2024-01-22',7600,'Completed'),
(123,3,'2024-01-23',9100,'Pending'),
(124,4,'2024-01-24',6100,'Completed'),
(125,5,'2024-01-25',4200,'Cancelled'),
(126,6,'2024-01-26',5300,'Completed'),
(127,7,'2024-01-27',6700,'Completed'),
(128,8,'2024-01-28',8200,'Pending'),
(129,9,'2024-01-29',4900,'Completed'),
(130,10,'2024-01-30',7300,'Completed');

/*LO queries */
select * from customers;
select*from orders;
select name,city from customers;
select distinct city from customers;
select* from orders where status='Completed';
select*from orders order by amount desc;
select top 5 *from orders order by amount desc;
select name,customer_id from customers where age>24;
select*from orders where order_date>'2024-01-15';
select name from customers where memberhsip='Gold';
select order_id,amount+500 as revised_salary from orders;

/*L1 queries*/
select * from orders where amount between 4000 and 5000;
select*from customers where city='Pune';
select * from customers where city not in('Mumbai');
select order_id from orders where status!='Cancelled';
select age from customers where age between 22 and 25;
select name from customers where name like'A%';
select name from customers where name like'%a';
select order_id,amount from orders where amount>7000 and status='Completed';
select order_id,amount from orders where amount<7000 OR status='Pending';
select name,memberhsip from customers where memberhsip in('Gold','Silver');
select*from customers where memberhsip is null;
select order_id,amount from orders where amount>3000;
select order_id from orders where order_date='2024-01-10';
select name,customer_id from customers where age>23 and city='Delhi';
select*from orders order by status,amount;

/*L2 queries*/
select count(*) as total_customers from customers;
select count(*) as total_orders from orders;
select avg(amount) as avg_amount from orders;
select sum(amount) as total_revenure from orders where status in('Completed','Pending');
select min(amount) as minimum_order_amount from orders;
select max(amount) as maximum_order_amount from orders;
select status,count(status) as orderper_status from orders group by status;
select customer_id,count(customer_id) as ordersper_customer,sum(amount) as totalrevenue_percustomer from orders group by customer_id;
select status,avg(amount) as avgorder_amount_perstatus from orders group by status;
select top 1 status,sum(amount) as highestrevenue_ofstatus from orders group by status order by highestrevenue_ofstatus desc;
select avg(age) as avgagepermembership,memberhsip from customers group by memberhsip;
select top 1 avg(age) as avgagepermembership,memberhsip from customers group by memberhsip order by memberhsip desc;

/* L3 queries */
/*Sec 1: Analytical Joins */
  select c.name,o.amount from customers c inner join orders o on c.customer_id=o.customer_id ;
  select * from customers c inner join orders on c.customer_id=orders.customer_id where orders.status in('Completed','Pending','Cancelled') order by status;
  select c.name,o.amount from customers c inner join orders o on c.customer_id=o.customer_id order by o.amount desc;
  select top 3 c.name,o.amount from customers c inner join orders o on c.customer_id=o.customer_id order by o.amount desc;
  select c.city,sum(o.amount) as totalrevenue_city from customers c inner join orders o on c.customer_id=o.customer_id group by c.city order by totalrevenue_city desc;
  select c.memberhsip,sum(o.amount) as totalrevenue_permembership from customers c inner join orders o on c.customer_id=o.customer_id group by c.memberhsip order by totalrevenue_permembership asc;
  select c.memberhsip,avg(o.amount) as avg_membershipamt from customers c inner join orders o on c.customer_id=o.customer_id group by c.memberhsip;
  select c.customer_id,c.name,c.city,count(orders.order_id) as totalorders from customers c  inner join orders on c.customer_id=orders.customer_id group by c.name,c.city,c.customer_id having count(orders.order_id)=2;
  select c.name,sum(o.amount) as total_spend from customers c inner join orders o on c.customer_id=o.customer_id group by c.name having sum(o.amount) >10000 ;
  select c.city,sum(o.amount) as totalrevenue_city from customers c inner join orders o on c.customer_id=o.customer_id group by c.city order by totalrevenue_city desc;
  /* Sec 2: Conditional Joins */
   select c.name,o.amount from customers c left join orders o on c.customer_id=o.customer_id where o.status='Completed';
  select c.city,avg(o.amount) as avg_city from customers c inner join orders o on c.customer_id=o.customer_id group by c.city order by avg_city asc;
  select top 1 c.city,sum(o.amount) as highestrevenue_city from customers c inner join orders o on c.customer_id=o.customer_id group by c.city order by highestrevenue_city desc;
  select c.memberhsip,sum(o.amount) as membershipwise_revenue from customers c inner join orders o on c.customer_id=o.customer_id group by c.memberhsip;
  select c.memberhsip,avg(o.amount) as avgmembershipwise_revenue from customers c inner join orders o on c.customer_id=o.customer_id group by c.memberhsip;
  select c.name,count(orders.order_id) as countorder_customer from customers c inner join orders on c.customer_id=orders.customer_id group by c.name having count(orders.order_id)>=2;
  select top 1c.memberhsip,sum(o.amount) as membershipwise_revenue from customers c inner join orders o on c.customer_id=o.customer_id group by c.memberhsip order by membershipwise_revenue desc;
  /* Sec 3: Multi-level aggregation */
  select c.name,c.memberhsip,o.amount,o.status from customers c inner join orders o on c.customer_id=o.customer_id where o.status='Completed' and c.memberhsip='Gold';
  select c.name,count(o.status) from customers c  inner join orders o on c.customer_id=o.customer_id where o.status ='Cancelled'group by c.name having count(o.status)>=1 ;
  select c.name from customers c  left join orders o on c.customer_id=o.customer_id and o.status='Cancelled'where o.order_id is null group by c.name;
  SELECT c.name FROM customers c INNER JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.name HAVING COUNT(CASE WHEN o.status = 'Completed' THEN 1 END) > 0  AND COUNT(CASE WHEN o.status != 'Completed' THEN 1 END) = 0;
  select c.customer_id from customers c inner join orders o on c.customer_id=o.customer_id where o.customer_id is null; 
  select c.customer_id,c.name from customers c right join orders o on c.customer_id=o.customer_id where o.status not in('Pending') ;
  select c.name,avg(o.amount) as avg_amount from customers c inner join orders o on c.customer_id=o.customer_id group by c.name having avg(o.amount)>6000  order by avg_amount asc;
  select c.name,o.order_date  from customers c inner join orders o on c.customer_id=o.customer_id group by c.name,o.order_date having o.order_date>'2024-01-20' order by o.order_date desc;
  select c.name,o.status from customers c right join orders o on c.customer_id=o.customer_id where o.status in ('Completed','Pending')  ;
  select top 1 c.name,max(o.amount) as maxsingle_amount from customers c right join orders o on c.customer_id=o.customer_id group by c.name order by maxsingle_amount desc;

  /* L4 queries */
   select * 
   from customers
   where customer_id in 
   (select customer_id from orders group by customer_id having count(customer_id)=1);


   select * 
   from customers
   where customer_id in 
   (select customer_id from orders group by customer_id having count(customer_id)=0);

  select * from orders
  where amount>(
  select avg(amount) as avg_amount from orders);

  select customer_id,sum(amount)
  as total_spend from orders
  group by customer_id
  having sum(amount)>(select avg(amount) from orders);

  select *
  from orders
  where customer_id in(
  select customer_id from customers where city='Mumbai');

  select distinct memberhsip from customers
  where customer_id in(
  select customer_id from orders);
   
  select *
  from customers
  where customer_id in(
  select customer_id from orders
  group by customer_id
  having sum(amount)>10000
  );

  select name,city
  from customers 
  where customer_id in(
  select customer_id from orders 
  group by customer_id
  having sum(amount)>
  (select avg(amount) from orders)
  );

  select customer_id
  from customers
  where customer_id in(
  select customer_id from orders);

  select amount from orders 
  where amount>(
  select avg(amount) from orders);

  select city from customers
  where customer_id in(
  select customer_id from orders 
  group by customer_id
  having count(order_id)>=1
  )
  group by city;


  select memberhsip,name from customers
  where customer_id in(
  select customer_id from orders 
  group by customer_id
  having count(order_id)=1)
  group by memberhsip,name;

  select*
  from customers
  where customer_id in (
  select customer_id from orders 
  group by customer_id
  having sum(amount)>8000
  );

  
  
select c.city, SUM(o.amount) as total_revenue
from customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
having SUM(o.amount) > (
    select AVG(city_total) 
from (
        SELECT SUM(amount) as city_total 
        FROM customers c2 
        JOIN orders o2 ON c2.customer_id = o2.customer_id 
        GROUP BY c2.city
    ) as sub
);


select c.name,max(o.amount) as maxsingle_amount
from customers c right join orders o on c.customer_id=o.customer_id
group by c.name
having max(o.amount)>
(select avg(amount) from orders);

select name 
from customers
where customer_id in(
select customer_id from orders 
group by customer_id
having min(amount)>2500
)
group by name;


SELECT c.name, c.city
FROM customers c
WHERE (
    SELECT SUM(o.amount) 
    FROM orders o 
    WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(city_total) 
    FROM (
        SELECT SUM(o2.amount) as city_total
        FROM orders o2
        JOIN customers c2 ON o2.customer_id = c2.customer_id
        WHERE c2.city = c.city -- This links the average to the current city
        GROUP BY c2.customer_id
    ) as city_averages
);

select c.name 
from customers c
join orders o on c.customer_id=o.customer_id
group by c.customer_id,c.name
having count(o.order_id)>(
select avg(order_count) 
from (
select count(order_id) as order_count 
from orders
group by customer_id
   ) as subquery
);
    
select * from customers 
where customer_id in(
select top 1 customer_id from orders
group by customer_id
order by sum(amount) desc
 );

 select * from customers 
where customer_id in(
select top 3 customer_id from orders
group by customer_id
order by sum(amount) desc
 );

 select  c.name,c.customer_id,sum(o.amount) as total_spent from customers c
 join orders o on c.customer_id=o.customer_id
 group by c.customer_id,c.name
 having sum(o.amount)=(
 select max(total_per_customer)
 from(
 select sum(amount) as total_per_customer
 from orders
 group by customer_id
 ) as total_spendings
 );
 
 select c.city,sum(amount) as total_revenue_city
 from customers c join orders o on c.customer_id=o.customer_id
 group by c.city

 insert into customers values
(21,'Aman','Pune',28,'Gold'),
(22,'Nikhil','Mumbai',31,'Silver'),
(23,'Riya','Surat',26,'Gold'),
(24,'Pooja','Ahmedabad',29,'None'),
(25,'Rohan','Pune',34,'Silver'),
(26,'Sneha','Mumbai',27,'Gold'),
(27,'Arjun','Surat',32,'None'),
(28,'Megha','Ahmedabad',32,'Silver'),
(29,'Kunal','Pune',25,'Gold'),
(30,'Divya','Mumbai',33,'None');

insert into customers values
(31,'Bhargav','Surat',20,'Gold'),
(32,'Adhiraj','Sambhajinagar',19,'Gold'),
(33,'Gaurav','Badlapur',18,'Silver'),
(34,'Soham','Surat',19,'None');
insert into customers values
(35,'Pandit','Pune',26,'None');

insert into orders values 
(31,1,'2024-01-12',1200,'Completed'),
(32,2,'2024-01-14',900,'Completed'),
(33,3,'2024-01-16',2100,'Completed'),
(34,4,'2024-01-18',1500,'Completed'),
(35,5,'2024-01-20',1800,'Completed'),
(36,6,'2024-01-22',2400,'Completed'),
(37,7,'2024-01-25',1100,'Completed'),
(38,8,'2024-01-26',3100,'Completed'),
(39,9,'2024-01-28',900,'Completed'),
(40,10,'2024-01-30',2200,'Completed'),

(41,11,'2024-02-01',1500,'Completed'),
(42,12,'2024-02-03',2800,'Completed'),
(43,13,'2024-02-05',1700,'Completed'),
(44,14,'2024-02-07',2100,'Completed'),
(45,15,'2024-02-09',1300,'Completed'),
(46,16,'2024-02-11',2600,'Completed'),
(47,17,'2024-02-13',3000,'Completed'),
(48,18,'2024-02-15',900,'Completed'),
(49,19,'2024-02-17',3400,'Completed'),
(50,20,'2024-02-19',1500,'Completed'),

(51,21,'2024-02-21',2800,'Completed'),
(52,22,'2024-02-22',900,'Completed'),
(53,23,'2024-02-23',3100,'Completed'),
(54,24,'2024-02-24',1800,'Completed'),
(55,25,'2024-02-25',2700,'Completed'),
(56,26,'2024-02-26',1100,'Completed'),
(57,27,'2024-02-27',3500,'Completed'),
(58,28,'2024-02-28',1900,'Completed'),
(59,29,'2024-03-01',2300,'Completed'),
(60,30,'2024-03-02',1600,'Completed');

insert into orders values
(61,31,'2025-03-03',25000,'Completed'),
(62,32,'2026-01-03',6969,'Completed'),
(63,33,'2025-03-22',8733,'Completed'),
(64,34,'2026-03-12',3693,'Completed');
insert into orders values
(,35,null,null,null);


--updation checking
select*from customers;
select*from orders;

 --subquery additional questions
 --1. order amount than higher than average order amount

select c.name,c.customer_id,o.order_id,o.amount
from customers c right join orders o on c.customer_id=o.customer_id
group by c.name,c.customer_id,o.order_id,o.amount
having(o.amount)>(
select avg(amount) as avg_amount_order from orders );

--2.customers who atleast placed one order 
select name,city,customer_id from customers
where customer_id in(
select customer_id from orders 
group by customer_id
having count(order_id)=1);

--3.customers who never placed an order 
select*from customers
where customer_id in(
select customer_id from orders
group by customer_id
having count(order_id)=0);

--4. customers whose total spending is greater than avg order amount
select c.customer_id,o.amount 
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_id,o.amount
having sum(amount)>(
select avg(amount) from orders);

--5. orders higher greater than the average order amount of customers
select customer_id,order_id,amount
from orders 
where amount>(
select avg(total_spend_customer)
from(
select sum(amount) as total_spend_customer
from orders
group by customer_id) as subquery
);

--6.customer with highest total spending
select customer_id,amount
from orders 
where amount=(
select max(total_spending) as highest_revenue
from(
select sum(amount) as total_spending
from orders
group by customer_id) as subquery
);

--7.city whose total revenue is greater than avergage revenue of cities

select c.city,sum(o.amount) as total_revenue_city
from customers c join orders o on c.customer_id=o.customer_id
group by c.city
having sum(o.amount)>(
select avg(total_spend_city) as avg_revenue_ofcities
from(
select c1.city,sum(o1.amount) as total_spend_city
from customers c1 join orders o1 on c1.customer_id=o1.customer_id
group by c1.city) as subquery
)order by total_revenue_city desc;


--8.customers with more orders than overall average orders
select customer_id from orders
group by customer_id 
having count(order_id)>(
select avg(countoforders) as noofavg_orders 
from(
select count(order_id) as countoforders
from orders
group by customer_id) as subquery
);

--CTE's
--Using CTE calculate total Spendings per customer id 

 with total_spend_customer as( 
 select customer_id,sum(amount)as total_spent
 from orders
 group by customer_id)

 select*from total_spend_customer;

 --From that show customers whose spending is more than 4000
 with total_spend_customer as( 
 select customer_id,sum(amount)as total_spent
 from orders
 group by customer_id)

 select*from total_spend_customer where total_spent>4000;

 --using CTE, Calculate city-wise total Revenue
 with city_revenue as(
 select  c.city,sum(o.amount) as total_city_revenue from customers c
 join orders o on c.customer_id=o.customer_id
 group by c.city
 )
 select*from city_revenue;

  
  --Using CTE, find top 5 customers by spending 
  with total_spend_customer as( 
 select top 5 customer_id,sum(amount)as total_spent
 from orders
 group by customer_id
 order by total_spent desc
 )
 select  *from total_spend_customer ;

 --Using CTE< find customer whose spending>average spending

 with total_spend_customer as( 
  select  customer_id,sum(amount)as total_spent
  from orders
  group by customer_id
  )
  select c.name,cs.total_spent from customers c
  join total_spend_customer cs on c.customer_id=cs.customer_id
  where cs.total_spent>(select avg(total_spent) from total_spend_customer);

  --Case Statements
  /*Categorize each orders:
  1.High: Amount>10000
  2.Medium: Amount between 5000 and 10000
  3.Low: Amount less than 5000*/

  select customer_id,amount,
  case
  when amount>10000 then 'High Amount'
  when amount between 5000 and 10000 then 'Medium Amount'
  when amount <5000 then'Low Amount'
  end as amount_category
  from orders;

 --Label Customers: Gold Membership:Premium,Silver:Regular & None:Basic

 select name,
 case
 when memberhsip='Gold' then 'Premium Customer'
  when memberhsip='Silver' then 'Regular Customer'
   when memberhsip='None' then 'Basic Customer'
   end as customer_category
   from customers;

   --total number of categorize value orders

 
with category_value_count as (select customer_id,
count(case when amount>10000 then 1 end) as high_value_order,
count(case when amount between 5000 and 10000 then 1 end ) as Medium_Value_order,
count (case when amount <5000 then 1 end )as  Basic_value_order,
count(order_id) as total_orders
from orders
group by customer_id)
select c.name,ct.high_value_order,ct.Medium_Value_order,ct.Basic_value_order,ct.total_orders 
from customers c join category_value_count ct on c.customer_id=ct.customer_id;

  
 --CITY WISE COUNT OF HIGH VALUE ORDERS
 with category_value_count as (select customer_id,
count(case when amount>10000 then 1 end) as high_value_order,
count(case when amount between 5000 and 10000 then 1 end ) as Medium_Value_order,
count (case when amount <5000 then 1 end )as  Basic_value_order,
count(order_id) as total_orders
from orders
group by customer_id)
select c.city,sum(ct.high_value_order) as total_high_value_orders_city,sum(ct.Medium_Value_order) as total_medium_value_orders_city,sum(ct.Basic_value_order) as total_basic_value_orders_city,sum(ct.total_orders) total_orders_city 
from customers c join category_value_count ct on c.customer_id=ct.customer_id
group by c.city;

-- Window's Function
--Assign ROW_NUMBER to orders ordered by amount desc
select order_id,amount,
row_number() over(order by amount desc) as row_num
from orders;

--Rank customers based on total spending 
select c.customer_id,c.name,sum(amount) as total_spend,
rank() over(order by sum(amount) desc) as spendingbased_rank,
dense_rank() over(order by sum(amount) desc) as dense_spendingbased_rank
from customers c join orders o on c.customer_id=o.customer_id
group by c.name,c.customer_id;

--Find highest order per customer usig rank()/dense rank()
select  c.customer_id,c.name,sum(amount) as total_spend,
dense_rank() over(order by sum(amount) desc) as dense_spendingbased_rank
from customers c join orders o on c.customer_id=o.customer_id
group by c.name,c.customer_id;

--Show running total of sales by order_date
 select order_id,order_date,amount,
 sum(amount) over(order by order_date) as revenuecount
 from orders;

 --SET 1: Analytical Queries
 --Find Customers whose total spending is greater than the average spending of all customers 

 select c.name,sum(o.amount) as total_spent
 from customers c join orders o on c.customer_id=o.customer_id
 group by c.name
 having sum(o.amount)>(
 select avg(amount) as avg_spent
 from orders);


 --Find top 3 customers per city based on spending
with customer_ranking_city as (
select c.name,c.city,sum(o.amount) as total_spent,
dense_rank() over(partition by city order by sum(o.amount) desc) as rnk
from customers c join orders o on c.customer_id=o.customer_id
group by c.city,c.name)

select city,name,total_spent,rnk 
from customer_ranking_city
where rnk<=3
order by city,rnk;

--Find customers whose average value is higher than overall average order value

select c.name,avg(o.amount) as avg_order_customer
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_id,c.name 
having avg(o.amount)>(
select avg(amount) as avg_overall 
from orders);

--Find Cities where total revenue is above overall average city revenue 
with total_city_revenue as(
select c.city,sum(o.amount) as city_revenue
from customers c join orders o on c.customer_id=o.customer_id
group by c.city
)
select city,city_revenue
from total_city_revenue
where city_revenue>(select avg(city_revenue) as avg_city_revenue from total_city_revenue);

--Find customers who made more orders than the average number of orders per customer
with orderidcount as(
select customer_id, count(order_id) as count_of_orders
from orders
group by customer_id)
select customer_id,count_of_orders
from orderidcount
where count_of_orders>(select avg(count_of_orders) as avg_order_count from orderidcount);

--SET 2: Window + Business Logic
--For each customers find: Total Spending 
--                         Rank within their cities
 
 with customer_total as(
 select c.name,c.city,sum(o.amount) as total_spent
 from customers c join orders o on c.customer_id=o.customer_id
 group by c.name,c.city),

 ranking as(
 select name,total_spent,city,
 dense_rank() over(partition by city order by total_spent desc) as customer_ranking
 from customer_total)

 select name,total_spent,city,customer_ranking
 from ranking
 order by city,customer_ranking;

 INSERT INTO customers (customer_id, name, city, age, memberhsip) VALUES
(36, 'Aman Verma', 'Mumbai', 28, 'Gold'),
(37, 'Riya Shah', 'Ahmedabad', 24, 'Silver'),
(38, 'Karan Mehta', 'Pune', 30, 'None'),
(39, 'Sneha Patil', 'Mumbai', 27, 'Gold'),
(40, 'Rahul Jain', 'Surat', 35, 'Silver'),
(41, 'Neha Kapoor', 'Pune', 22, 'None'),
(42, 'Arjun Singh', 'Delhi', 29, 'Gold'),
(43, 'Pooja Desai', 'Ahmedabad', 26, 'Silver'),
(44, 'Vikas Yadav', 'Mumbai', 31, 'None'),
(45, 'Anjali Gupta', 'Delhi', 23, 'Gold'),
(46, 'Rohit Sharma', 'Pune', 34, 'Silver'),
(47, 'Meera Nair', 'Mumbai', 28, 'Gold'),
(48, 'Siddharth Roy', 'Surat', 32, 'None'),
(49, 'Isha Kulkarni', 'Pune', 25, 'Silver'),
(50, 'Dev Patel', 'Ahmedabad', 29, 'Gold');

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES
(141, 36, '2024-01-15', 12000, 'Completed'),
(142, 37, '2024-01-18', 4500, 'Pending'),
(143, 38, '2024-01-20', 8000, 'Completed'),
(144, 39, '2024-01-22', 15000, 'Completed'),
(145, 40, '2024-01-25', 3000, 'Cancelled'),
(146, 41, '2024-02-01', 6000, 'Completed'),
(147, 42, '2024-02-03', 20000, 'Completed'),
(148, 43, '2024-02-05', 7000, 'Pending'),
(149, 44, '2024-02-07', 4000, 'Completed'),
(150, 45, '2024-02-10', 11000, 'Completed'),
(151, 46, '2024-02-12', 5000, 'Completed'),
(152, 47, '2024-02-15', 9000, 'Pending'),
(153, 48, '2024-02-18', 2500, 'Completed'),
(154, 49, '2024-02-20', 10000, 'Completed'),
(155, 50, '2024-02-22', 18000, 'Completed'),
(156, 36, '2024-03-01', 7000, 'Completed'),
(157, 37, '2024-03-03', 9500, 'Completed'),
(158, 38, '2024-03-05', 3000, 'Cancelled'),
(159, 39, '2024-03-07', 22000, 'Completed'),
(160, 40, '2024-03-10', 4500, 'Completed'),
(161, 41, '2024-03-12', 8000, 'Completed'),
(162, 42, '2024-03-15', 17000, 'Pending'),
(163, 43, '2024-03-18', 6000, 'Completed'),
(164, 44, '2024-03-20', 7500, 'Completed'),
(165, 45, '2024-03-22', 13000, 'Completed');

select*from customers;
select*from orders;

--                                         MOCK TEST 1
-- Section 1: Core Analytics(30 MARKS)
--1.Customers whose total spending is greater than average customer spending.
with total_spending as(
select c.name,sum(o.amount) as total_spent
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_id,c.name)

select name,total_spent
from total_spending
where total_spent>(select avg(amount) as avg_order_amount from orders);

--2.Top 2 customers per city by total spending.
with total_order_amount as(
select c.city,c.name,sum(o.amount) as total_spent,
dense_rank() over(partition by c.city order by sum(o.amount) desc) as citybased_rank
from customers c join orders o on c.customer_id=o.customer_id
group by c.city,c.name)

select city,name,total_spent,citybased_rank
from total_order_amount
where citybased_rank<=2
order by city,citybased_rank;

--3.Customers with more orders than average orders per customer.
with order_count as(
select c.name,count(order_id) as totalorder_count
from customers c join orders o on c.customer_id=o.customer_id
group by c.name,c.customer_id)

select name,totalorder_count
from order_count
where totalorder_count>(select avg(totalorder_count) as avg_order_count from order_count);

--4.Cities where total revenue > overall average city revenue.
with city_revenue as(
select c.city,sum(o.amount) as citywise_revenue
from customers c join orders o on c.customer_id=o.customer_id
group by c.city)

select city,citywise_revenue
from city_revenue
where citywise_revenue>(select avg(citywise_revenue) as avgcityrevenue from city_revenue);

--5.Customers whose average order > overall average order
with avgamount_order as(
select c.name,avg(o.amount) as avg_customer_amount
from customers c join orders o on c.customer_id=o.customer_id
group by c.name,c.customer_id)

select name,avg_customer_amount
from avgamount_order 
where avg_customer_amount>(select avg(amount) as avg_amount from orders);

--Section 2: Window's Function(35 MARKS)
--6.Assign row number to orders per customer (latest first).
select order_id,order_date,customer_id,
row_number() over(order by order_date desc) as ROWNUM
from orders;

--7.Rank customers based on total spending.
select c.name,sum(o.amount) as total_spending,
dense_rank() over(order by sum(o.amount) desc) as rankbased_onamount
from customers c join orders o on c.customer_id=o.customer_id
group by c.name;

--8.Second highest order per customer.
with second_highest as(
select c.name,o.amount,
dense_rank() over(partition by c.customer_id order by o.amount desc) rnk
from customers c join orders o on c.customer_id=o.customer_id)

select name,amount
from second_highest
where rnk=2;

--9.Running total of revenue by date.
select customer_id,order_id,order_date,amount,
sum(amount) over(partition by customer_id order by order_date asc) as running_total
from orders;

--10.Top 3 highest orders overall using dense_rank
with highest_revenue as(
select c.name,c.city,o.amount,
dense_rank() over(order by o.amount desc) as highest_rank
from customers c join orders o on c.customer_id=o.customer_id)

select name,city,amount,highest_rank
from highest_revenue
where highest_rank<=3;

--Section 3:Advanced
---11.Customers whose total spending > 5% of total revenue
with customer_spending as(
select c.name,sum(o.amount) as total_spent
from customers c join orders o on c.customer_id=o.customer_id
group by c.name)

select name,total_spent 
from customer_spending
where total_spent>(select 0.05*sum(amount) as fivepercent_total_revenue from orders)

--12.City where highest revenue customer contributes most
with revenue_calculation as(
select c.name,c.city,sum(o.amount) as total_spent,
dense_rank() over(order by sum(o.amount) desc) as cus_rank --for contribution
from customers c join orders o on c.customer_id=o.customer_id
group by c.name,c.city)

select name,city,total_spent
from revenue_calculation 
where cus_rank=1;

--13.Customers who placed orders in every month present in dataset
select customer_id,order_date,
row_number() over(partition by order_date order by order_date asc) as order_check --checking orders
from orders;

--14.Customers whose spending trend is increasing

--15.Customers who never placed a ‘cancelled’ order
select c.name,o.status
from customers c join orders o on c.customer_id=o.customer_id
where o.status not in('Cancelled') order by o.status;