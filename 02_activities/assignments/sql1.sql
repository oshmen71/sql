SELECT *
FROM customer;

SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;

SELECT *
FROM customer_purchases
WHERE product_id IN (4, 9);

SELECT *
FROM vendor_inventory
WHERE quantity>5 and original_price>5;

SELECT customer_id
FROM customer_purchases
WHERE quantity>2.5 and cost_to_customer_per_qty>2.5;

SELECT customer_id
FROM customer_purchases
WHERE quantity BETWEEN 2.5 AND 3.5;

SELECT product_id,product_name,
 CASE WHEN product_qty_type = 'unit' THEN 'unit'
      ELSE 'bulk'
 END AS prod_qty_type_condensed
FROM product;

SELECT product_id,product_name,
CASE WHEN LOWER(product_name) LIKE '%pepper%' THEN 1
        ELSE 0
END AS pepper_flag
FROM product;

SELECT   v.vendor_name,
    vba.market_date,
   
    v.*,
    vba.*
FROM
    vendor v
INNER JOIN
    vendor_booth_assignments vba ON v.vendor_id = vba.vendor_id
ORDER BY
    v.vendor_name ASC,
    vba.market_date ASC;
	
SELECT vendor_id,
    COUNT(*) AS booth_rental_count
FROM vendor_booth_assignments
GROUP BY vendor_id
ORDER BY booth_rental_count DESC;	
	
SELECT 
    c.customer_id,
    SUM(cp.quantity) AS TotalSpent
FROM customer AS c
JOIN customer_purchases AS cp
    ON c.customer_id = cp.customer_id
GROUP BY 
    c.customer_id
HAVING TotalSpent > 2000
ORDER BY 
    c.customer_id;
	
	
	
CREATE TABLE temp.new_vendor AS
SELECT *
FROM vendor;
INSERT INTO temp.new_vendor (vendor_id, vendor_name, vendor_type, owner_first_name, owner_last_name)
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused store', 'Thomas', 'Rosenthal');
	
SELECT 
    customer_id,
    strftime('%m', purchase_date) AS month,
    strftime('%Y', purchase_date) AS year
FROM customer_purchases;





SELECT customer_id,
    SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM customer_purchases
WHERE strftime('%m', purchase_date) = '04'
  AND strftime('%Y', purchase_date) = '2022'
GROUP BY customer_id;
