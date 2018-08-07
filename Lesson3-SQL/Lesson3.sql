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

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;

/*
1. Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for the Midwest region. Your final table should include three columns: 
the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.


2. Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name. 


3. Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.

4. Provide the name for each region for every order, as well as the account name and the unit price they paid 
(total_amt_usd/total) for the order. However, you should only provide the results 
if the standard order quantity exceeds 100. Your final table should have 3 columns: 
region name, account name, and unit price. In order to avoid a division by zero error, 
adding .01 to the denominator here is helpful total_amt_usd/(total+0.01). 


5. Provide the name for each region for every order, as well as the account name and the unit price they paid 
(total_amt_usd/total) for the order. However, you should only provide the results 
if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
Your final table should have 3 columns: region name, account name, and unit price. 
Sort for the smallest unit price first. In order to avoid a division by zero error, 
adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). 


6. Provide the name for each region for every order, as well as the account name and the unit price they paid 
(total_amt_usd/total) for the order. However, you should only provide the results 
if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
Your final table should have 3 columns: region name, account name, and unit price. 
Sort for the largest unit price first. In order to avoid a division by zero error, 
adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). 

7. What are the different channels used by account id 1001? Your final table should have only 2 columns: 
account name and the different channels. You can try SELECT DISTINCT to narrow down the results 
to only the unique values.

8. Find all the orders that occurred in 2015. Your final table should have 4 columns: 
occurred_at, account name, order total, and order total_amt_usd.*/

SELECT r.name region, sr.name rep, a.name account
FROM region AS r
JOIN sales_reps AS sr
ON sr.region_id = r.id
JOIN accounts AS a
ON sr.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name;

SELECT r.name region, sr.name rep, a.name account
FROM region AS r
JOIN sales_reps AS sr
ON sr.region_id = r.id
JOIN accounts AS a
ON sr.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND sr.name LIKE 'S%'
ORDER BY a.name;

SELECT r.name region, sr.name rep, a.name account
FROM region AS r
JOIN sales_reps AS sr
ON sr.region_id = r.id
JOIN accounts AS a
ON sr.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND sr.name LIKE '% K%'
ORDER BY a.name;

SELECT r.name region, a.name account, (o.total_amt_usd / (o.total + 0.01)) unit_price 
FROM region as r
JOIN sales_reps as sr
ON sr.region_id = r.id
JOIN accounts as a
ON sr.id = a.sales_rep_id
JOIN orders AS o
ON a.id = o.account_id
WHERE o.standard_qty > 100;

SELECT r.name region, a.name account, (o.total_amt_usd / (o.total + 0.01)) unit_price 
FROM region as r
JOIN sales_reps as sr
ON sr.region_id = r.id
JOIN accounts as a
ON sr.id = a.sales_rep_id
JOIN orders AS o
ON a.id = o.account_id
WHERE o.standard_qty > 100
AND o.poster_qty > 50
ORDER BY unit_price;

SELECT r.name region, a.name account, (o.total_amt_usd / (o.total + 0.01)) unit_price 
FROM region as r
JOIN sales_reps as sr
ON sr.region_id = r.id
JOIN accounts as a
ON sr.id = a.sales_rep_id
JOIN orders AS o
ON a.id = o.account_id
WHERE o.standard_qty > 100
AND o.poster_qty > 50
ORDER BY unit_price DESC;

SELECT DISTINCT a.name account, w.channel channel
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
WHERE a.id = 1001;

SELECT o.occurred_at occurred, a.name account, o.total, o.total_amt_usd
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

/*Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.

Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? 
Your query should return only three values - the date, channel, and account name.

Find the total number of times each type of channel from the web_events was used. 
Your final table should have two columns - the channel and the number of times the channel was used.

Who was the primary contact associated with the earliest web_event? 

What was the smallest order placed by each account in terms of total usd. 
Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. 
Order from fewest reps to most reps.
*/

SELECT a.name account, o.occurred_at occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY o.occurred_at
LIMIT 1;

SELECT a.name account, sum(o.total_amt_usd) total
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;
