QUICK VERIFICATION QUERIES
-- --------------------------

select count(customer_id) as no_of_customers from customers;
select count(order_id) as no_of_orders from orders;
select count(product_id)  as no_of_products from products;
select count(order_item_id) as no_of_order_list from order_items;
select count(payment_id) as no_of_paymen from payments;

--CHECK FOREIGN KEY INTERGRITY
SELECT c.customer_id,o.order_id 
from customers c join orders o on c.customer_id=o.customer_id; --customers --.orders 

SELECT p.payment_id,o.order_id 
from payments p join orders o on p.order_id=o.order_id;

--check orphan records
select * from orders o 
left join customers c on o.customer_id=c.customer_id
where c.customer_id is NULL;