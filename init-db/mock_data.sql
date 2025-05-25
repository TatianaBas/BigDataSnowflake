-- public.mock_data определение

-- Drop table

-- DROP TABLE public.mock_data;

CREATE TABLE mock_data (
	id int4 NULL,
	customer_first_name varchar(50) NULL,
	customer_last_name varchar(50) NULL,
	customer_age int4 NULL,
	customer_email varchar(50) NULL,
	customer_country varchar(50) NULL,
	customer_postal_code varchar(50) NULL,
	customer_pet_type varchar(50) NULL,
	customer_pet_name varchar(50) NULL,
	customer_pet_breed varchar(50) NULL,
	seller_first_name varchar(50) NULL,
	seller_last_name varchar(50) NULL,
	seller_email varchar(50) NULL,
	seller_country varchar(50) NULL,
	seller_postal_code varchar(50) NULL,
	product_name varchar(50) NULL,
	product_category varchar(50) NULL,
	product_price float4 NULL,
	product_quantity int4 NULL,
	sale_date varchar(50) NULL,
	sale_customer_id int4 NULL,
	sale_seller_id int4 NULL,
	sale_product_id int4 NULL,
	sale_quantity int4 NULL,
	sale_total_price float4 NULL,
	store_name varchar(50) NULL,
	store_location varchar(50) NULL,
	store_city varchar(50) NULL,
	store_state varchar(50) NULL,
	store_country varchar(50) NULL,
	store_phone varchar(50) NULL,
	store_email varchar(50) NULL,
	pet_category varchar(50) NULL,
	product_weight float4 NULL,
	product_color varchar(50) NULL,
	product_size varchar(50) NULL,
	product_brand varchar(50) NULL,
	product_material varchar(50) NULL,
	product_description varchar(1024) NULL,
	product_rating float4 NULL,
	product_reviews int4 NULL,
	product_release_date varchar(50) NULL,
	product_expiry_date varchar(50) NULL,
	supplier_name varchar(50) NULL,
	supplier_contact varchar(50) NULL,
	supplier_email varchar(50) NULL,
	supplier_phone varchar(50) NULL,
	supplier_address varchar(50) NULL,
	supplier_city varchar(50) NULL,
	supplier_country varchar(50) NULL
);

COPY mock_data FROM '/csv-data/mock_data1.csv' CSV HEADER;
COPY mock_data FROM '/csv-data/mock_data2.csv' CSV HEADER;
COPY mock_data FROM '/csv-data/mock_data3.csv' CSV HEADER;
COPY mock_data FROM '/csv-data/mock_data4.csv' CSV HEADER;
COPY mock_data FROM '/csv-data/mock_data5.csv' CSV HEADER;
COPY mock_data FROM '/csv-data/mock_data6.csv' CSV HEADER;
COPY mock_data FROM '/csv-data/mock_data7.csv' CSV HEADER;
COPY mock_data FROM '/csv-data/mock_data8.csv' CSV HEADER;
COPY mock_data FROM '/csv-data/mock_data9.csv' CSV HEADER;
COPY mock_data FROM '/csv-data/mock_data.csv' CSV HEADER;

