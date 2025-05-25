
-- География
INSERT INTO dim_countries (country_name)
SELECT DISTINCT country FROM (
    SELECT customer_country AS country FROM mock_data
    UNION ALL SELECT seller_country FROM mock_data
    UNION ALL SELECT store_country FROM mock_data
    UNION ALL SELECT supplier_country FROM mock_data
) t WHERE country IS NOT NULL;

INSERT INTO dim_states (state_name)
SELECT DISTINCT store_state FROM mock_data WHERE store_state IS NOT NULL;

INSERT INTO dim_cities (city_name)
SELECT DISTINCT store_city FROM mock_data WHERE store_city IS NOT NULL;

-- Продуктовые измерения
INSERT INTO dim_product_categories (category_name)
SELECT DISTINCT product_category FROM mock_data WHERE product_category IS NOT NULL;

INSERT INTO dim_pet_categories (category_name)
SELECT DISTINCT pet_category FROM mock_data WHERE pet_category IS NOT NULL;

INSERT INTO dim_brands (brand_name)
SELECT DISTINCT product_brand FROM mock_data WHERE product_brand IS NOT NULL;

INSERT INTO dim_materials (material_name)
SELECT DISTINCT product_material FROM mock_data WHERE product_material IS NOT NULL;

INSERT INTO dim_colors (color_name)
SELECT DISTINCT product_color FROM mock_data WHERE product_color IS NOT NULL;

-- Питомцев измерения
INSERT INTO dim_pet_types (type_name)
SELECT DISTINCT customer_pet_type FROM mock_data WHERE customer_pet_type IS NOT NULL;

INSERT INTO dim_breeds (breed_name)
SELECT DISTINCT customer_pet_breed FROM mock_data WHERE customer_pet_breed IS NOT NULL;

-- Покупатели
INSERT INTO dim_customers (first_name, last_name, age, email, postal_code, country_id, state_id, city_id)
SELECT DISTINCT 
    customer_first_name, 
    customer_last_name,
    customer_age,
    customer_email,
    customer_postal_code,
    (
        SELECT country_id 
        FROM dim_countries 
        WHERE country_name = md.customer_country
    ) AS country_id,
    NULL::integer, 
    NULL::integer  
FROM mock_data md;


-- Продавцы
INSERT INTO dim_sellers (first_name, last_name, email, postal_code, country_id, state_id, city_id)
SELECT DISTINCT 
    seller_first_name, 
    seller_last_name,
    seller_email,
    seller_postal_code,
    (SELECT country_id FROM dim_countries WHERE country_name = md.seller_country),
    NULL::integer,
    NULL::integer
FROM mock_data md;

-- Поставщики
INSERT INTO dim_suppliers (name, contact, email, phone, address, country_id, state_id, city_id)
SELECT DISTINCT 
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    (SELECT country_id FROM dim_countries WHERE country_name = md.supplier_country),
    NULL::integer,
    (SELECT city_id FROM dim_cities WHERE city_name = md.supplier_city)
FROM mock_data md;

-- Магазины
INSERT INTO dim_stores (name, phone, email, country_id, state_id, city_id, location)
SELECT DISTINCT 
    store_name,
    store_phone,
    store_email,
    (SELECT country_id FROM dim_countries WHERE country_name = md.store_country),
    (SELECT state_id FROM dim_states WHERE state_name = md.store_state),
    (SELECT city_id FROM dim_cities WHERE city_name = md.store_city),
    store_location
FROM mock_data md;

-- Продукты
INSERT INTO dim_products (
    name, product_category_id, pet_category_id, brand_id, material_id, color_id,
    weight, size, description, rating, reviews, release_date, expiry_date, supplier_id
)
SELECT DISTINCT
    product_name,
    (SELECT category_id FROM dim_product_categories WHERE category_name = md.product_category),
    (SELECT pet_category_id FROM dim_pet_categories WHERE category_name = md.pet_category),
    (SELECT brand_id FROM dim_brands WHERE brand_name = md.product_brand),
    (SELECT material_id FROM dim_materials WHERE material_name = md.product_material),
    (SELECT color_id FROM dim_colors WHERE color_name = md.product_color),
    product_weight,
    product_size,
    product_description,
    product_rating,
    product_reviews,
    TO_DATE(product_release_date, 'MM/DD/YYYY'),
    TO_DATE(product_expiry_date, 'MM/DD/YYYY'),
    (SELECT supplier_id FROM dim_suppliers WHERE name = md.supplier_name AND email = md.supplier_email)
FROM mock_data md;

-- Питомцы
INSERT INTO dim_pets (customer_id, pet_type_id, breed_id, name)
SELECT 
    dc.customer_id,
    (SELECT pet_type_id FROM dim_pet_types WHERE type_name = md.customer_pet_type),
    (SELECT breed_id FROM dim_breeds WHERE breed_name = md.customer_pet_breed),
    customer_pet_name
FROM mock_data md
JOIN dim_customers dc ON dc.email = md.customer_email;

-- Факт продаж
INSERT INTO fact_sales (sale_date, customer_id, seller_id, product_id, store_id, quantity, total_price)
SELECT 
    TO_DATE(md.sale_date, 'MM/DD/YYYY'),
    dc.customer_id,
    ds.seller_id,
    dp.product_id,
    dst.store_id,
    md.sale_quantity,
    md.sale_total_price
FROM mock_data md
JOIN dim_customers dc ON dc.email = md.customer_email
JOIN dim_sellers ds ON ds.email = md.seller_email
JOIN dim_brands b ON b.brand_name = md.product_brand
JOIN dim_product_categories pc ON pc.category_name = md.product_category
JOIN dim_pet_categories pt ON pt.category_name = md.pet_category
JOIN dim_materials m ON m.material_name = md.product_material
JOIN dim_colors c ON c.color_name = md.product_color
JOIN dim_products dp 
  ON dp.name = md.product_name
 AND dp.product_category_id = pc.category_id
 AND dp.pet_category_id = pt.pet_category_id
 AND dp.brand_id = b.brand_id
 AND dp.material_id = m.material_id
 AND dp.color_id = c.color_id
 AND dp.weight = md.product_weight
 AND dp.size = md.product_size
JOIN dim_cities city ON city.city_name = md.store_city
JOIN dim_stores dst
  ON dst.name = md.store_name
 AND dst.phone = md.store_phone
 AND dst.city_id = city.city_id;




