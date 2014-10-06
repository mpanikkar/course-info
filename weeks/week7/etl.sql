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
