-- How can you isolate (or group) the transactions of each cardholder?

SELECT ch.name, cc.card, t.date, t.amount, m.name AS merchant,
        mc.name AS category
FROM transaction AS t
JOIN credit_card AS cc ON cc.card = t.card
JOIN card_holder AS ch ON ch.id = cc.cardholder_id
JOIN merchant AS m ON m.id = t.id_merchant
JOIN merchant_category AS mc ON mc.id = m.id_merchant_category
ORDER BY ch.name;

-- Count the transactions that are less than $2.00 per cardholder.

SELECT COUNT(t.amount) AS "Transactions less that $2.00"
FROM transaction AS t
WHERE t.amount < 2;

-- Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.

SELECT * 
FROM transaction AS t
WHERE t.amount < 2
ORDER BY t.card, t.amount DESC 

-- What are the top 100 highest transactions made between 7:00 am and 9:00 am?

SELECT * 
FROM transaction AS t
WHERE date_part('hour', t.date) >= 7 AND date_part('hour', t.date) <= 9
ORDER BY t.amount DESC 
LIMIT 100

-- Do you see any anomalous transactions that could be fraudulent?

SELECT * 
FROM transaction AS t
WHERE date_part('hour', t.date) >= 7 
AND date_part('hour', t.date) <= 9
ORDER BY t.amount ASC 
LIMIT 43

-- Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?

SELECT COUNT (t.amount) AS "Fradulent Transactions between 7:00 a.m. - 9:00 a.m." 
FROM transaction AS t
WHERE t.amount < 2
AND date_part('hour', t.date) >= 7 
OR date_part ('hour', t.date) <= 9

SELECT COUNT (t.amount) AS "Fradulent Transactions Rest of Day" 
FROM transaction AS t
WHERE t.amount < 2
AND date_part('hour', t.date) <= 7 
OR date_part ('hour', t.date) >= 9

-- If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.

-- What are the top 5 merchants prone to being hacked using small transactions?

SELECT m.name AS merchant, mc.name AS category,
        COUNT(t.amount) AS micro_transactions
FROM transaction AS t
JOIN merchant AS m ON m.id = t.id_merchant
JOIN merchant_category AS mc ON mc.id = m.id_merchant_category
WHERE t.amount < 2
GROUP BY m.name, mc.name
ORDER BY micro_transactions DESC
LIMIT 5

--Create a view for each of your queries.
CREATE VIEW transactions_cardholders AS 
	SELECT ch.name, cc.card, t.date, t.amount, m.name AS merchant,
			mc.name AS category
	FROM transaction AS t
	JOIN credit_card AS cc ON cc.card = t.card
	JOIN card_holder AS ch ON ch.id = cc.cardholder_id
	JOIN merchant AS m ON m.id = t.id_merchant
	JOIN merchant_category AS mc ON mc.id = m.id_merchant_category
	ORDER BY ch.name;
	
CREATE VIEW transactions_less_than_2_dollars AS
	SELECT COUNT(t.amount) AS "Transactions less that $2.00"
	FROM transaction AS t
	WHERE t.amount < 2;
	
CREATE VIEW potential_hacked_credit_cards AS
	SELECT * 
	FROM transaction AS t
	WHERE t.amount < 2
	ORDER BY t.card, t.amount DESC
	
CREATE VIEW top_highest_transactions_between_7am_and_9am AS
	SELECT * 
	FROM transaction AS t
	WHERE date_part('hour', t.date) >= 7 AND date_part('hour', t.date) <= 9
	ORDER BY t.amount DESC 
	LIMIT 100
	
