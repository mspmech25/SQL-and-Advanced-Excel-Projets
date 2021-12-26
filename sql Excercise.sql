create database item_customer;
use item_customer;
create table items_ordered
(customerid	int null,
order_date date null,
	item	varchar(300) null,
    quantity int null,	
    price int null);
desc items_ordered;

create table customers
(customerid	int null,
firstname	 varchar(300) null,
lastname varchar(300) null,
	city varchar(300) null,
	state char(200) null);
    
    desc customers;

select * from customers;
select * from items_ordered;

/* from the items_ordered table,select a list of all items purchased for customerid 10449 
display the customerid,item,and price for this customer*/

select customerid,item,price
from items_ordered
where customerid=10449;

select * from items_ordered
where item="tent";

/* select the cuatomer_id,,order-date,and item values  from the items _ordered table for any items in thwe item column that starts with letter "S"*/
use item_customer;
select customerid,order_date,item from items_ordered
where item like "S%";

select distinct(item),customerid,order_date
from items_ordered;

select count(item) as distinctitem
from (select distinct(item),customerid,order_date
from items_ordered) as tst;

/* practical Excercise on aggregate function */

/* select the maximum price of any item in the items_ordered table*/
select item,price  from items_ordered
group by item;

select item,max(price) from(select item,price from items_ordered) as vtt;
use item_customer;

/* how many people are in each unique state in the customer table ? select the state and display the number of people in each*/
select distinct(state),count(customerid) from customers
group by state;

/* from the table,select the item , maximum price,and minimum price fro each specific item in the table */
select item,max(price),min(price)
from items_ordered 
group by item;

/* how many orders did each customer make? use the items_ordered*/
select customerid,count(*) as nooforders,sum(price*quantity) as sumorders 
from items_ordered
group by customerid;


alter table items_ordered
add column new_order_date date;

update items_ordered
set new_order_date =str_to_date(order_date,"%d-%m-%Y");

/* select the average price of all of the items ordered that were purchased in the month of dec.*/
select avg(price) from 
items_ordered
where order_date between "1999-12-01" and "1999-12-30";

/* what ate the total  rows inthe items_ordered*/
select count(*)  as totalrows from items_ordered;

select item,price from items_ordered
where item="tent";

use item_customer;

select min(price) from (select item,price from items_ordered
where item="tent") as tnt;

/* Practice on aggregrate*/

/*how manuy people are in each unique state in customer table? select the state and display the number of people in each*/
select state,count(*)as noofpeople 
from customers
group by state;

/* from the items table select item ,maximum price and minimum price fro each specific item in the table*/
select item,max(price),min(price)
from items_ordered
group by item;

/* how many orders did each customers make*/
select customerid,count(*) as nooforders,sum(quantity*price) as totalorders
from items_ordered
group by customerid;

/* having clausd exercise*/
/* how many people are in each unique state in the customers table that have more than one person in the state*/
select state,count(*) as noofpeople
from customers
group by state 
having count(*)>1;

/* from the item_ordered ,select the item ,maximum price,and minimum price fro each specific item in the table.
only display the results if the maximum price for one of the items is greater than 190 */
select item,max(price),min(price)
from items_ordered
group by item
having max(price)>190;

/* how man orders did each customer make*/
select customerid,count(*) as nooforders,sum(quantity)
from items_ordered
group by customerid
having sum(quantity)>1;

/* practice excercises on order by clause*/

/* select the last name,firstname,and city for all customers in the customers table . display the results in ascending order based on last name*/
select lastname,firstname,city
from customers
order by lastname asc;
 
 select lastname,firstname,city
from customers
order by lastname desc;
/* select the item and price fro all of the items in the items_ordered table that the price is greater than 10 .display the results in ascending order on the price*/
select item,price
from items_ordered
having price>10
order by price asc;

/* practice exercises on combining conditions & Boolean Operators */
/* select the customerid,order_date and item from th eitems table.unless they are 'snow shoes ' or if they are 'ear muffs'.display the rows as long as they ar not either of two*/

select customerid,order_date,item
from items_ordered
where item not like "snow shoes" and item not like "ear muffs";

/* select the item and price of all items that start with letter 's','p' or 'f'*/
select item,price 
from item_ordered
where item like"S%" and  item like "P%" and  item like "F%";

select curdate();


/* practise exercise*/
/* select the date ,item and price from the items tabe fro all the rows that have a price value ranging from 10 to 80*/
select order_date,item,price
from items_ordered
where price between '10' and '80';
use item_customer;
SELECT  item, price
  FROM items_ordered
 WHERE price BETWEEN 10.00 AND 80.00;
 
 /* Select the firstname, city, and state from the customers table for all
-- of the rows where the state value is either: Arizona, Washington, Oklahoma,
-- Colorado, or Hawaii.*/

select firstname,city,state
from customers
where state in("Arizona", "Washington", "Oklahoma",
"Colorado", "Hawaii");


/* mathematical function*/
/* select the item and per unit price for each item inthe items_ordered table .*/
select item,round(price/quantity,2) as perprice
from items_ordered;


/* excercise on joins*/
/* write query using join TO DETERMNE WHich items were ordered by each of the customers in customers table.*/
select customers.customerid,customers.firstname,customers.lastname,items_ordered.item,items_ordered.order_date,items_ordered.price
from items_ordered,customers 
where items_ordered.customerid=customers.customerid;


select customers.customerid,customers.firstname,customers.lastname,customers.state,items_ordered.item,items_ordered.order_date,items_ordered.price
from items_ordered,customers 
where items_ordered.customerid=customers.customerid
order by customers.state desc;
