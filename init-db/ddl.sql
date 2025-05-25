
-- === География ===
CREATE TABLE dim_countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50) UNIQUE
);

CREATE TABLE dim_states (
    state_id SERIAL PRIMARY KEY,
    state_name VARCHAR(50) UNIQUE
);

CREATE TABLE dim_cities (
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(50) UNIQUE
);

-- === Продукты ===
CREATE TABLE dim_product_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE
);

CREATE TABLE dim_pet_categories (
    pet_category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE
);

CREATE TABLE dim_brands (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(50) UNIQUE
);

CREATE TABLE dim_materials (
    material_id SERIAL PRIMARY KEY,
    material_name VARCHAR(50) UNIQUE
);

CREATE TABLE dim_colors (
    color_id SERIAL PRIMARY KEY,
    color_name VARCHAR(50) UNIQUE
);

-- === Питомцы ===
CREATE TABLE dim_pet_types (
    pet_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) UNIQUE
);

CREATE TABLE dim_breeds (
    breed_id SERIAL PRIMARY KEY,
    breed_name VARCHAR(50) UNIQUE
);

-- === Основные измерения ===
CREATE TABLE dim_customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    email VARCHAR(50),
    postal_code VARCHAR(50),
    country_id INT REFERENCES dim_countries(country_id),
    state_id INT REFERENCES dim_states(state_id),
    city_id INT REFERENCES dim_cities(city_id)
);

CREATE TABLE dim_sellers (
    seller_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    postal_code VARCHAR(50),
    country_id INT REFERENCES dim_countries(country_id),
    state_id INT REFERENCES dim_states(state_id),
    city_id INT REFERENCES dim_cities(city_id)
);

CREATE TABLE dim_suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    contact VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(50),
    address VARCHAR(50),
    country_id INT REFERENCES dim_countries(country_id),
    state_id INT REFERENCES dim_states(state_id),
    city_id INT REFERENCES dim_cities(city_id)
);

CREATE TABLE dim_stores (
    store_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    phone VARCHAR(50),
    email VARCHAR(50),
    country_id INT REFERENCES dim_countries(country_id),
    state_id INT REFERENCES dim_states(state_id),
    city_id INT REFERENCES dim_cities(city_id),
    location VARCHAR(50)
);

CREATE TABLE dim_products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    product_category_id INT REFERENCES dim_product_categories(category_id),
    pet_category_id INT REFERENCES dim_pet_categories(pet_category_id),
    brand_id INT REFERENCES dim_brands(brand_id),
    material_id INT REFERENCES dim_materials(material_id),
    color_id INT REFERENCES dim_colors(color_id),
    weight FLOAT,
    size VARCHAR(50),
    description VARCHAR(1024),
    rating FLOAT,
    reviews INT,
    release_date DATE,
    expiry_date DATE,
    supplier_id INT REFERENCES dim_suppliers(supplier_id)
);

CREATE TABLE dim_pets (
    pet_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES dim_customers(customer_id),
    pet_type_id INT REFERENCES dim_pet_types(pet_type_id),
    breed_id INT REFERENCES dim_breeds(breed_id),
    name VARCHAR(50)
);

-- === Таблица фактов ===
CREATE TABLE fact_sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE,
    customer_id INT REFERENCES dim_customers(customer_id),
    seller_id INT REFERENCES dim_sellers(seller_id),
    product_id INT REFERENCES dim_products(product_id),
    store_id INT REFERENCES dim_stores(store_id),
    quantity INT,
    total_price FLOAT
);

