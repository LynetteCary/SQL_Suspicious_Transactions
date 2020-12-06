SELECT id, name
	FROM "card_holder";
	
SELECT *
	FROM "credit_card";

SELECT *
	FROM "transaction";

SELECT id, name
FROM card_holder AS a
LEFT JOIN credit_card AS b ON a.id = b.id_card_holder
ORDER BY id_card_holder

SELECT *
FROM transaction AS t
INNER JOIN credit_card AS cc ON cc.card = t.card
INNER JOIN card_holder AS ch ON ch.id = cc.id_card_holder
WHERE cc.id_card_holder = 2
OR cc.id_card_holder = 18

SELECT *
FROM transaction AS t
INNER JOIN credit_card AS cc ON cc.card = t.card
INNER JOIN card_holder AS ch ON ch.id = cc.id_card_holder
WHERE t.date > '2018-01-01' AND t.date < '2018-06-01' AND cc.id_card_holder = 25

SELECT *
FROM transaction
WHERE date::time between '07:00:00' AND '09:00:00'

SELECT *
FROM transaction
WHERE date::time between '07:00:00' AND '09:00:00'
ORDER BY amount DESC
LIMIT 100

CREATE VIEW small_transactions AS
SELECT ch.id, ch.name, t.amount, t.card
FROM card_holder as ch
INNER JOIN credit_card AS cc ON ch.id = cc.id_card_holder
INNER JOIN transaction as t ON cc.card = t.card
WHERE amount < 2
ORDER BY amount DESC

SELECT *
	FROM "small_transactions";

DROP VIEW top_merchants CASCADE
CREATE VIEW top_merchants AS
SELECT m.id, m.name, m.id_merchant_category, t.amount, t.id_merchant
FROM merchant as m
INNER JOIN transaction AS t ON m.id = t.id_merchant
WHERE amount < 2
ORDER BY amount DESC

SELECT *
	FROM "top_merchants";

ALTER TABLE merchant_category RENAME COLUMN name TO merchant_name;
ALTER TABLE merchant_category RENAME COLUMN id TO merchant_id

CREATE VIEW five_merchants AS
SELECT tm.id, tm.name, tm.id_merchant_category, tm.amount, tm.id_merchant, mc.merchant_id, mc.merchant_name
FROM top_merchants AS tm
INNER JOIN merchant_category AS mc ON tm.id_merchant_category = mc.merchant_id 
WHERE amount < 2

SELECT *
	FROM "five_merchants"
	
SELECT name, amount, id_merchant_category, merchant_name 
FROM top_merchants AS tm
INNER JOIN merchant_category AS mc ON tm.id_merchant_category = mc.merchant_id 
WHERE amount < 2
LIMIT 5
