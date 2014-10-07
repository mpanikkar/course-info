-- these are ETL scripts created in class

INSERT INTO store_dim ( store_number, store_name,
		store_street_address, store_city,
		store_county, store_state,
		store_zipcode, store_manager,
		store_region )

	SELECT 
	storeid AS store_number, 
	store_name,
	streetaddr AS store_street_address,
	city AS store_city,
	'unknown' AS store_county,
	stateprov AS store_state,
	postalcode AS store_zipcode,
	manager AS store_manager,
	'America' AS store_region
	FROM store;


INSERT INTO product_dim ( sku, product_description, brand_description,
		subcategory_description, category_description,
		department_description )


	select 
	sku,
	product.description AS product_description,
	brandname AS brand_description,
	C1.description AS subcategory_description,
	C2.description AS category_description,
	C3.description AS department_description
	from product
		join brand on product.brand=brand.brandid
		join category C1 on product.category=C1.categoryid
		join category C2 on C1.parent_cat=C2.categoryid
		join category C3 on C2.parent_cat=C3.categoryid






INSERT INTO retail_fact

select
	--dimension keys
	(SELECT date_key FROM date_dim WHERE date=transxndate) AS date_key,
	(SELECT product_key FROM product_dim PD WHERE PD.sku=P.sku) AS product_key,
	(SELECT store_key FROM store_dim WHERE store_number=transxn.store),
	transxnid AS pos_transxn_number,
	--fact columns
	quantity AS sales_quantity,
	unitprice AS regular_unit_price,
	0.00 AS discount_unit_amount,
	(unitprice) AS net_unit_price,
	(unitprice*quantity) AS total_sales_dollar_amount,
	0.00 AS total_discount_dollar_amount
from transxn_line
	join product P on transxn_line.product=P.sku
	join transxn on transxn_line.transxn=transxn.transxnid
