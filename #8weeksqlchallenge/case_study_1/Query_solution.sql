/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
-- 2. How many days has each customer visited the restaurant?
-- 3. What was the first item from the menu purchased by each customer?
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- 5. Which item was the most popular for each customer?
-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?


--Query-1 - What is the total amount each customer spent at the restaurant?

select customer_id , sum(menu.price) as expenditure
from dannys_diner.sales 
left join dannys_diner.menu 
on sales.product_id=menu.product_id
group by sales.customer_id 
order by sales.customer_id;

/* Output
"customer_id"	"expenditure"
	"A"					76
	"B"					74
	"C"					36 */
	

--Query-2-How many days has each customer visited the restaurant?

select sales.customer_id , count(sales.order_date) as no_of_days_visited 
from dannys_diner.sales
left join dannys_diner.members 
on sales.customer_id=members.customer_id
left join dannys_diner.menu 
on sales.product_id=menu.product_id
group by sales.customer_id 
order by sales.customer_id;  

/* Output
"customer_id"	"no_of_days_visited "
	"A"					6
	"B"					6
	"C"					3	*/
	

--Query-3-What was the first item from the menu purchased by each customer?

select distinct menu.product_name as first_product,sales.customer_id 
from dannys_diner.sales 
left join dannys_diner.menu 
on sales.product_id=menu.product_id
where sales.order_date in (select min(order_date)from dannys_diner.sales group by customer_id) 
order by sales.customer_id;

--Output
/*"first_product"	"customer_id"    {A has pusrchased two products on same day}
	"curry"				"A"
	"sushi"				"A"
	"curry"				"B"
	"ramen"				"C"				*/
	
	
--Query-4- What is the most purchased item on the menu and how many times was it purchased by all customers?

select menu.product_name,count(menu.product_name) as times_purchased
from dannys_diner.sales 
left join dannys_diner.menu
on sales.product_id=menu.product_id
group by menu.product_name
order by count(menu.product_name) DESC
limit 1;

/*Output 
"product_name"	"times_purchased"
	"ramen"				8				*/
	
	
--Query-5-Which item was the most popular for each customer?

select sales.customer_id,menu.product_name,count(menu.product_name)
from dannys_diner.sales 
left join dannys_diner.menu 
on sales.product_id=menu.product_id
group by sales.customer_id,menu.product_name
order by sales.customer_id,count(menu.product_name) DESC;

--Output
/*"customer_id"	"product_name"	"count"
		"A"			"ramen"			3		For customer A -Ramen is his most ordered product 
		"A"			"curry"			2					 B-All products are equally ordered
		"A"			"sushi"			1					 C- Ramen is his most ordered product 
		"B"			"sushi"			2
		"B"			"curry"			2
		"B"			"ramen"			2
		"C"			"ramen"			3	*/
	
/*with clause for temporary calculation*/
with customer_order_count as (select 
	 customer_id,product_name ,count(sales.product_id)as order_count,
	 dense_rank() over (partition by customer_id order by count(customer_id) desc ) as item_rank
	 from dannys_diner.sales 
	 join dannys_diner.menu 
	 on sales.product_id=menu.product_id
	 group by customer_id,product_name)
select customer_id,product_name,order_count
from customer_order_count
where item_rank=1;	

--Output
/*"customer_id"	"product_name"	"order_count"
		"A"			"ramen"			3
		"B"			"sushi"			2
		"B"			"curry"			2
		"B"			"ramen"			2
		"C"			"ramen"			3		*/
	
--Query-6-Which item was purchased first by the customer after they became a member?

with customer_product as (
	select 
	 sales.customer_id,product_name ,order_date,join_date,
	 row_number() over (partition by sales.customer_id order by sales.order_date ASC ) as item_rank
	 from dannys_diner.sales 
	 right join dannys_diner.members on sales.customer_id=members.customer_id
	 left join dannys_diner.menu on sales.product_id =menu.product_id
	 where sales.order_date>=members.join_date)
select customer_id,product_name ,join_date,order_date
from customer_product
where item_rank=1;

--Output
/*"customer_id"	"product_name"	"join_date"	   "order_date"
	 "A"			"curry"		"2021-01-07"   "2021-01-07"
	 "B"			"sushi"		"2021-01-09"   "2021-01-11" */
	 

--Query-7-Which item was purchased just before the customer became a member?

with customer_product as (
	select 
	 sales.customer_id,product_name ,order_date,join_date,
	 dense_rank() over (partition by sales.customer_id order by sales.order_date DESC ) as item_rank
	 from dannys_diner.sales 
	 right join dannys_diner.members on sales.customer_id=members.customer_id
	 left join dannys_diner.menu on sales.product_id =menu.product_id
	 where sales.order_date < members.join_date)
select customer_id,product_name ,join_date,order_date
from customer_product
where item_rank=1;

--Output
/*"customer_id"	"product_name"	"join_date"		"order_date"
	"A"			"sushi"			"2021-01-07"	"2021-01-01"
	"A"			"curry"			"2021-01-07"	"2021-01-01"
	"B"			"sushi"			"2021-01-09"	"2021-01-04"*/

--Query-8-What is the total items and amount spent for each member before they became a member?

select sales.customer_id,
	   sum(menu.price) as Amount_spend,
	   count(menu.product_id) as total_item
from dannys_diner.sales
join dannys_diner.members on sales.customer_id=members.customer_id
join dannys_diner.menu on sales.product_id= menu.product_id
where sales.order_date< members.join_date
group by sales.customer_id
order by sales.customer_id;

--Output-
/*"customer_id"	"amount_spend"	"total_item"
		"A"			25				2
		"B"			40				3		*/
		

--Query-9-If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

select sales.customer_id,
	   sum(case when menu.product_name='sushi' then price*20
		  		else price*10 end) as total_points
from dannys_diner.sales
join dannys_diner.menu on sales.product_id= menu.product_id
group by sales.customer_id
order by sales.customer_id;

--Output-9
/*"customer_id"	"total_points"
		"A"			860
		"B"			940
		"C"			360		*/
		
--Query_10

select sales.customer_id,
	sum( case 
			when sales.order_date < members.join_date then
			  case when sales.product_id=1 then 
				   menu.price*20 else menu.price*10 
			  	   end
			when sales.order_date > (members.join_date+6) then
			  case when sales.product_id=1 then 
				   menu.price*20 else menu.price*10 
			  	   end
		else (menu.price*20) end
	) as points_earned 
from dannys_diner.sales
join dannys_diner.members on sales.customer_id= members.customer_id
join dannys_diner.menu on sales.product_id= menu.product_id
where sales.order_date between '2021-01-01' and '2021-01-31'
group by sales.customer_id
order by sales.customer_id;

--Output-10
/*"customer_id"	"pionts_earned"
		"A"			1370
		"B"			820		*/


