
/* Loop to insert 100 daily sales records in sales*/
do $$
declare
	transaction1_id int;
	customer_id int; 
	account_balance numeric; 
	transaction_timestamp timestamp;
	transaction_amount numeric;
begin
   for i in 1..1000 loop
	transaction1_id = (select transaction_id from customer_transaction order by transaction_id desc Limit 1)+1; 
	customer_id := (select floor(random() * 99999999 + 10000000)::int);
	account_balance := (select floor(random() * 9000000 + 1000)::int);
	--transaction_timestamp := (select timestamp '2023-03-31 20:00:00' + random() * (timestamp '1990-04-01 20:00:00' - timestamp '2023-03-31 10:00:00'));
	transaction_timestamp := (select current_timestamp + '1 hour' :: INTERVAL*ROUND(RANDOM() * 8));
	transaction_amount := (select floor(random() * 500000 + 100)::int);
	
	RAISE NOTICE 'Record :%', i;
	RAISE NOTICE 'transaction1_id: %',transaction1_id;
	RAISE NOTICE 'customer_id: %',customer_id;
	RAISE NOTICE 'account_balance: %',account_balance;
	RAISE NOTICE 'transaction_timestamp: %',transaction_timestamp;
	RAISE NOTICE 'transaction_amount: %',transaction_amount;
	
	--ALTER TABLE customer_transaction DISABLE TRIGGER ALL;
	INSERT INTO customer_transaction(transaction_id, customer_id, account_balance, transaction_timestamp, transaction_amount)
	VALUES (transaction1_id, customer_id, account_balance, transaction_timestamp, transaction_amount);
	
   end loop;
end; $$


--select * from customer_transaction;