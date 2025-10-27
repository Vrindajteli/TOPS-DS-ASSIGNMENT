create database assessment_db;
use assessment_db;

CREATE TABLE country (
    id INT PRIMARY KEY,
    country_name VARCHAR(50),
    country_name_eng VARCHAR(50),
    country_code VARCHAR(10)
);

CREATE TABLE city (
    id INT PRIMARY KEY,
    city_name VARCHAR(50),
    country_id INT,
    lat FLOAT,
    lang FLOAT,
    FOREIGN KEY (id) REFERENCES country(id)
);

CREATE TABLE customer (
    id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city_id INT,
    customer_address VARCHAR(70),
    next_call_date DATE,
    ts_inserted datetime,
    FOREIGN KEY (id) REFERENCES city(id)
);

INSERT INTO country  VALUES
(1, 'Deutschland', 'Germany', 'DEU'),
(2, 'Srbija', 'Serbia', 'SRB'),
(3, 'Hrvatska', 'Croatia', 'HRV'),
(4, 'United States Of America', 'United States Of America', 'USA'),
(5, 'Роlska', 'Poland', 'POL'),
(6, 'Espana', 'Spain', 'ESP'),
(7, 'Rossiya', 'Russia', 'RUS');

INSERT INTO city VALUES
(1, 'Berlin',52.52,13.40,1),
(2, 'Belgrade',44.78,20.45,2),
(3, 'Zagreb',45.81,15.96,3),
(4, 'New York',40.73,-73.93,4),
(5, 'Los Angeles',34.05,-118.24,4),
(6, 'Warsaw',52.23,21.01,5);


# task 1 
SELECT 
    country.country_name AS Country,
    city.city_name AS City,
    customer.customer_name AS Customer
FROM 
    country
LEFT JOIN 
    city ON country.id = city.id
LEFT JOIN 
    customer ON city.id = customer.id
ORDER BY 
    country.country_name;

# task 2
SELECT 
    country.country_name AS Country,
    city.city_name AS City,
    customer.customer_name AS Customer
FROM 
    country
INNER JOIN 
    city ON country.id = city.id
LEFT JOIN 
    customer ON city.id = customer.id
ORDER BY 
    country.country_name;
