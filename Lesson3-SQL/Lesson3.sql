/*
1.Try pulling all the data from the accounts table, and all the data from the orders table.

2. Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, 
and the website and the primary_poc from the accounts table.*/

SELECT orders.*, accounts.*
FROM accounts JOIN orders
ON orders.account_id = accounts.id

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders 
JOIN accounts 
ON orders.account_id = accounts.id

/*
1. Provide a table for all web_events associated with account name of Walmart. 
There should be three columns. 
Be sure to include the primary_poc, time of the event, and the channel for each event. 
Additionally, you might choose to add a fourth column to assure only Walmart events were chosen. 

2. Provide a table that provides the region for each sales_rep along with their associated accounts. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name. 

3. Provide the name for each region for every order, as well as the account name 
and the unit price they paid 
(total_amt_usd/total) for the order. Your final table should have 3 columns: 
region name, account name, and unit price. A few accounts have 0 for total, 
so I divided by (total + 0.01) to assure not dividing by zero.*/

SELECT accounts.primary_poc, web_events.occurred_at, web_events.channel, accounts.name
FROM web_events JOIN accounts
ON accounts.id = web_events.account_id
WHERE name = 'Walmart';

SELECT region.name, 
