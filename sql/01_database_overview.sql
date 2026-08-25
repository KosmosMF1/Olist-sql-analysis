--Промежуток заказов--
SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM orders;

--Какие статусы и сколько--
SELECT order_status, COUNT(*) AS count_status 
FROM orders 
GROUP BY order_status
ORDER BY count_status;

--Есть ли пропуски в датах заказов--
SELECT COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS count_approved,
	   COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS count_carrier_date,
	   COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS count_customer_date,
	   order_status
FROM orders
GROUP BY order_status;

--Подозрительные доставленные заказы--
SELECT order_id,  
       order_status,
       order_approved_at,
       order_delivered_carrier_date,
       order_delivered_customer_date
FROM orders
WHERE order_status = 'delivered'
	  AND (order_approved_at IS NULL OR order_delivered_carrier_date IS NULL OR order_delivered_customer_date IS NULL);
	  
--Количество уникальных и общих id--
SELECT COUNT(*) AS all_count,
	   COUNT(DISTINCT order_id) AS unique_count
FROM orders;

--Проверка клиентов--
SELECT COUNT(*) as all_customer,
	   COUNT(DISTINCT customer_id) as count_customer,
	   COUNT(DISTINCT customer_unique_id) as unique_count_customer
FROM customers;

--Сколько уникальных покупателей сделали больше одного заказа--
WITH count_customers AS (
	SELECT customer_unique_id,
		   COUNT(*) AS customer_count
	FROM customers 
	GROUP BY customer_unique_id
	HAVING COUNT(customer_id) > 1
)
SELECT COUNT(*) AS all_count
FROM count_customers;

--Доля повторных покупок от всех уникальных покупателей--
WITH count_customers AS (
	SELECT customer_unique_id,
		   COUNT(*) AS customer_count
	FROM customers 
	GROUP BY customer_unique_id
	HAVING COUNT(*) > 1
),
unique_customers AS(
	SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
	FROM customers
)
SELECT ROUND((COUNT(*) * 100 / total_customers::DECIMAL) , 2) as repeat_customer_rate
FROM count_customers, unique_customers 
GROUP BY total_customers

--Насколько часто люди делают 1, 2, 3, 4 и больше заказов--
WITH count_customers AS (
	SELECT customer_unique_id,
		   COUNT(*) AS customers_count
	FROM customers 
	GROUP BY customer_unique_id
)
SELECT customers_count, 
	   COUNT(*) AS buyers_count
FROM count_customers
GROUP BY customers_count
ORDER BY customers_count;

--Кто сделал 17 заказов?--
WITH count_customers AS (
	SELECT customer_unique_id,
		   COUNT(*) AS customers_count
	FROM customers
	GROUP BY customer_unique_id
)
SELECT customer_unique_id, 
	   customers_count
FROM count_customers
WHERE customers_count = 17;

--Все 17 заказов--
SELECT o.order_id,
	   o.order_status,
	   o.order_purchase_timestamp,
	   o.order_delivered_customer_date
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
WHERE c.customer_unique_id = '8d50f5eadf50201ccdcedfb9e2ac8455'
ORDER BY o.order_purchase_timestamp;
	