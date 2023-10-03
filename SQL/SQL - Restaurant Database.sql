.open restaurant.db
.mode column
.table

-- Creating Customer Table
CREATE TABLE IF NOT EXISTS customers (
    id int,
    name text,
    city text,
    email text
);

INSERT INTO customers VALUES 
  (1, "Peanot", "Bangkok", "peanot@gmail.com"),
  (2, "Roger", "London", "roger@hotmail.com"),
  (3, "Peter", "New York", "peter@hotmail.com"),
  (4, "Melissa", "England", "melissa@gmail.com"),
  (5, "Rafael", "Jerusalem", "rafael@hotmail.com");

-- Creating Menu Table
CREATE TABLE IF NOT EXISTS menu (
  menuid int primary key,
  menuname text not null,
  price int not null
);

INSERT INTO menu VALUES
(1, "Thai Spring Rolls", 80),
(2, "Green Papaya Salad", 45),
(3, "Red Curry", 70),
(4, "Pad Gra Prow", 45),
(5, "Thai Iced Coffee", 30);

-- Creating Ingredient Table
CREATE TABLE ingredient (
  ingredientid int primary key,
  ingredientname text not null
);

INSERT INTO ingredient VALUES
(1, "Oil"),
(2, "Chili"),
(3, "Coconut Milk"),
(4, "Thai Brasil"),
(5, "Sugar");

-- Creating Menu and Ingredient ID Table
CREATE TABLE menu_ingredient (
  menuid int not null,
  ingredientid int not null,
  foreign key (menuid) references menu (menuid),
  foreign key (ingredientid) references ingredient (ingredientid)
);

INSERT INTO menu_ingredient VALUES
(1,2),
(1,5),
(2,2),
(3,1),
(3,2),
(3,3),
(3,4),
(4,1),
(4,2),
(4,4),
(5,5);

-- Creating Invoice Table
CREATE TABLE invoice (
  customerid int not null,
  invoicedate text not null,
  totalprice int not null,
	foreign key (customerid) references customers (customerid)
);

INSERT INTO invoice VALUES
(1, "2023-01-02", 125),
(2, "2023-02-25", 75),
(3, "2023-02-26", 170),
(4, "2023-03-12", 115),
(5, "2023-04-09", 60);

-- Join Table
-- Customers with their invoices
SELECT
  A.id,
  A.name as cus_name,
  b.totalprice as ttp 
FROM customers A 
JOIN invoice B 
ON A.id = B.customerid;

-- Aggregrate (SUM)
-- Sum of all customers' spending
SELECT
 sum(totalprice)
FROM customers A 
JOIN invoice B 
ON A.id = B.customerid;

-- With
-- Find customer(s) with '@hotmail' domain and spent more than 100
WITH sub1 as (
    SELECT * from customers
    WHERE email like "%@hotmail.com"
  ), sub2 as (
    SELECT * from invoice
    WHERE totalprice >= 100  
  )
SELECT
  sub1.id,
  sub1.name as cus_name,
  sub2.totalprice
FROM sub1
JOIN sub2
ON sub1.id = sub2.customerid;

-- Many to Many
-- Find all ingredient for cooking 'Pad Gra Prow'
SELECT 
   C.ingredientname  
FROM menu as A 
JOIN menu_ingredient as B 
ON A.menuid = B.menuid 
JOIN ingredient as C 
ON B.ingredientid = C.ingredientid
WHERE menuname = 'Pad Gra Prow';
