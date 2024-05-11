--select * from Sales;

/*
/* FOR loop to update customer_id*/
do $$
begin
   for i in 10001..121253 loop
		update sales
		set customer_id = (select customer_id from customer order by random() Limit 1)
		where id = i;
   end loop;
end; $$

/*
*/
update sales
set territory_id = 4
where id>=90000;

/* Add new column Sr No*/
ALTER TABLE customer ADD COLUMN sr_no bigserial;

delete from customer where customer_id=-1;

*/

/* Get Random record from table
WITH x AS (
       SELECT customer_id
         FROM customer
        ORDER BY random()
)

select * from x order by random() Limit 1;
*/

/*
/* Get random timestamp between selected timestamp*/
select timestamp '2014-01-10 20:00:00' +
       random() * (timestamp '2014-01-20 20:00:00' -
                   timestamp '2014-01-10 10:00:00');
				   
/* Insert random added hours in existing date */				   
select start_date + '2 hours':: interval*ROUND(RANDOM() * 360) as delivery_date from projects;

*/


/* Add two timestamp columns in sales table*/
alter table sales add column order_date TIMESTAMP;
alter table sales add column delivery_date TIMESTAMP;
ALTER TABLE customer ADD COLUMN row_no bigserial;

/* Loop to insert timestamps in order_date and delivery_date columns*/
do $$
begin
   for i in 100001..121253 loop
    /* Insert Order_Date */
	update sales
    set order_date = (select timestamp '2023-03-31 20:00:00' +
       random() * (timestamp '2013-04-01 20:00:00' -
                   timestamp '2023-03-31 10:00:00'))
    where row_no = i;
	
	/* Insert Delivery date*/
	update sales
    set delivery_date = (select order_date + '2 hours':: interval*ROUND(RANDOM() * 360) from sales where row_no=i)
    where row_no = i;
	
	
   end loop;
end; $$


select * from sales;

/* Loop to insert 100 daily sales records in sales*/
do $$
declare
	sales_order1_id int; --sales table
	reseller1_id int; --reseller table
	customer1_id int; --customer table
	product1_id int; --product table
	territory1_id int; --territory table
	order_quantity numeric; --random(1,30)
	unit_price numeric; --
	product_standard_cost numeric; --product table
	total_product_cost numeric; --[total_product_cost = order_quantity * product_standard_cost]
	sales_amount numeric; --[sales_amount = order_quantity * unit_price]
	order_date timestamp;
	delivery_date timestamp;
	--new_date timestamp;
begin
   for i in 1..25000 loop
   	sales_order1_id = (select sales_order_id from sales order by sales_order_id desc Limit 1)+1; 
	reseller1_id := (select reseller_id from reseller order by random() Limit 1);
	customer1_id := (select customer_id from customer order by random() Limit 1);
	product1_id := (select product_id from product order by random() Limit 1);
	territory1_id := (select territory_id from sales_territory order by random() Limit 1);
	order_quantity := (select floor(random() * 20 + 1)::int);
	unit_price := (select list_price from product where product_id = product1_id);
	product_standard_cost := (select standard_cost from product where product_id = product1_id);
	total_product_cost := order_quantity * product_standard_cost;
	sales_amount := order_quantity * unit_price;
	--new_date := (select current_timestamp - interval '2 days');
	--order_date := (select new_date + '1 hour' :: INTERVAL*ROUND(RANDOM() * 12));	
	--order_date := (select current_timestamp + '1 hour' :: INTERVAL*ROUND(RANDOM() * 12));	
	order_date := (select timestamp '2023-06-21 20:00:00' +
       random() * (timestamp '2003-04-01 20:00:00' -
                   timestamp '2023-06-21 10:00:00'));
	--delivery_date := (select new_date + '14 hours':: INTERVAL*ROUND(RANDOM() * 240));
	--delivery_date := (select current_timestamp + '14 hours':: INTERVAL*ROUND(RANDOM() * 240));
	delivery_date := (select order_date + '14 hours':: interval*ROUND(RANDOM() * 120));

	--RAISE NOTICE 'Record :%', i;
	--RAISE NOTICE 'reseller_id: %',reseller1_id;
	--RAISE NOTICE 'customer_id: %',customer1_id;
	--RAISE NOTICE 'product_id: %',product1_id;
	--RAISE NOTICE 'territory_id: %',territory1_id;
	--RAISE NOTICE 'order_quantity: %',order_quantity;
	--RAISE NOTICE 'unit_price: %',unit_price;
	--RAISE NOTICE 'product_standard_cost: %',product_standard_cost;
	--RAISE NOTICE 'total_product_cost: %',total_product_cost;
	--RAISE NOTICE 'sales_amount: %',sales_amount;
	--RAISE NOTICE 'order_date: %',order_date;
	--RAISE NOTICE 'delivery_date: %',delivery_date;
	
	ALTER TABLE sales DISABLE TRIGGER ALL;
	INSERT INTO sales(sales_order_id, reseller_id, customer_id, product_id, territory_id, order_quantity, unit_price, product_standard_cost, total_product_cost, sales_amount, order_date, delivery_date)
	VALUES (sales_order1_id, reseller1_id, customer1_id, product1_id, territory1_id, order_quantity, unit_price, product_standard_cost, total_product_cost, sales_amount, order_date, delivery_date);

   end loop;
end; $$


--select * from sales;
--delete from sales where sales_order_id is null;
--select * from sales where delivery_date > current_timestamp;
--select * from product where product_id=400;
--select sales_order_id from sales order by sales_order_id desc Limit 1;
--select * from sales_order;

-- Database Size
--SELECT pg_size_pretty(pg_database_size('imdb'));
-- Table Size
--SELECT pg_size_pretty(pg_relation_size('table_name'));
--delete from sales where to_char(order_date, 'yyyy-MM-DD') = '2023-05-28';
--select * from sales;
