-- ============================================================
--  Customer Transaction Analytics
--  SQL Server (SSMS) Setup Script
--  Tables: customers, orders, products, order_items, payments
--  Author : CTA Project
--  Date   : 2025-03-25
-- ============================================================

-- ============================================================
--  SECTION 1 : CREATE DATABASE (run once)
-- ============================================================

CREATE DATABASE CustomerTransactionDB;
USE CustomerTransactionDB;

-- =========================================
-- SECTION 2: CREATE TABLES
-- =========================================

-- 2.1 Customers

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
age INT CHECK(age between 18 and 70),
city VARCHAR(50) NOT NULL,
membership VARCHAR(20) CHECK(membership IN('Gold','Silver','None'))
DEFAULT 'None'
);


--2.2 Products

CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name VARCHAR(50) NOT NULL,
category VARCHAR(50) NOT NULL,
price DECIMAL(10,2) NOT NULL CHECK(price>0)
);

--2.3 Orders

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
amount DECIMAL(10,2) NOT NULL CHECK(amount>0),
status VARCHAR(20) CHECK(status IN('Completed','Pending','Cancelled'))
Default 'Pending',
CONSTRAINT fk_orders_customers
FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

--2.4 Order_Items

CREATE TABLE order_items(
order_item_id INT PRIMARY KEY,
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL CHECK(quantity>=1),
CONSTRAINT fk_oi_order
FOREIGN KEY(order_id) REFERENCES orders(order_id),
CONSTRAINT fk_oi_products
FOREIGN KEY(product_id) REFERENCES products(product_id)
);

--2.5 Payments

CREATE TABLE payments(
payment_id INT PRIMARY KEY,
order_id INT NOT NULL UNIQUE, -- 1 PAYMENT PER ORDER
payment_method VARCHAR(20) NOT NULL CHECK(payment_method IN('UPI','Card','COD')),
payment_status VARCHAR(20) NOT NULL CHECK(payment_status IN('Success','Failed','Pending')),
CONSTRAINT fk_pay_order
FOREIGN KEY(order_id) references orders(order_id)
);

-- =================================
-- SECTION 3: INSERT DATA
-- =================================

-- ---------------------------------
--3.1 customers (35 rows)
--ciites: mumbai,delhi,pune,bangalore,hyderabad,chennai,kolkata,ahmedabad,jaipur,surat
-- ---------------------------------

INSERT INTO customers(customer_id,name,age,city,membership) VALUES
(1,  'Aarav Sharma',      28, 'Mumbai',    'Gold'),
(2,  'Priya Patel',       34, 'Ahmedabad', 'Silver'),
(3,  'Rohan Mehta',       22, 'Pune',      'None'),
(4,  'Sneha Iyer',        30, 'Chennai',   'Silver'),
(5,  'Karan Gupta',       45, 'Delhi',     'Gold'),
(6,  'Ananya Singh',      27, 'Kolkata',   'None'),
(7,  'Vikram Nair',       38, 'Bangalore', 'Gold'),
(8,  'Pooja Desai',       24, 'Surat',     'Silver'),
(9,  'Arjun Reddy',       31, 'Hyderabad', 'None'),
(10, 'Divya Joshi',       29, 'Jaipur',    'Silver'),
(11, 'Nikhil Verma',      36, 'Mumbai',    'None'),
(12, 'Kavya Nair',        23, 'Bangalore', 'Silver'),
(13, 'Rahul Tiwari',      41, 'Delhi',     'Gold'),
(14, 'Meera Pillai',      26, 'Chennai',   'None'),
(15, 'Siddharth Rao',     33, 'Hyderabad', 'Silver'),
(16, 'Tanvi Kulkarni',    28, 'Pune',      'Gold'),
(17, 'Aditya Bose',       39, 'Kolkata',   'None'),
(18, 'Riya Shah',         21, 'Ahmedabad', 'None'),
(19, 'Manish Kumar',      47, 'Jaipur',    'Silver'),
(20, 'Simran Kaur',       32, 'Delhi',     'Gold'),
(21, 'Deepak Mishra',     25, 'Mumbai',    'None'),
(22, 'Nisha Agarwal',     44, 'Surat',     'Silver'),
(23, 'Suresh Pandey',     37, 'Pune',      'None'),
(24, 'Anjali Chatterjee', 29, 'Kolkata',   'Gold'),
(25, 'Rajesh Patil',      52, 'Nashik',    'None'),
(26, 'Shreya Menon',      24, 'Bangalore', 'Silver'),
(27, 'Mohit Saxena',      35, 'Delhi',     'None'),
(28, 'Neha Jain',         28, 'Jaipur',    'Silver'),
(29, 'Vivek Tripathi',    43, 'Lucknow',   'Gold'),
(30, 'Preeti Dubey',      31, 'Mumbai',    'None'),
(31, 'Harish Nambiar',    26, 'Chennai',   'Silver'),
(32, 'Sonali Bhatt',      38, 'Ahmedabad', 'None'),
(33, 'Gaurav Kapoor',     22, 'Pune',      'Silver'),
(34, 'Leena Srivastava',  46, 'Lucknow',   'Gold'),
(35, 'Tarun Yadav',       30, 'Hyderabad', 'None');

-- ---------------------------------
--3.2 products( 35 rows)
--categories: electronics,fashion,groceries,home&kitchen,beauty,books and sports
-- ---------------------------------
 INSERT INTO products(product_id,product_name,category,price) VALUES
(1,  'boAt Airdopes 141',          'Electronics',    1299.00),
(2,  'Samsung 43" Smart TV',       'Electronics',   28999.00),
(3,  'Lenovo IdeaPad Slim 3',      'Electronics',   42999.00),
(4,  'Mi Power Bank 20000mAh',     'Electronics',    1499.00),
(5,  'Noise ColorFit Pro 4',       'Electronics',    4999.00),
(6,  'Levi''s 511 Slim Jeans',     'Fashion',        2499.00), -- Fixed apostrophe
(7,  'Nike Air Max 270',           'Fashion',        8999.00),
(8,  'Fabindia Kurta Set',         'Fashion',        1899.00),
(9,  'H&M Regular T-Shirt',        'Fashion',         699.00),
(10, 'Peter England Formal Shirt', 'Fashion',        1299.00),
(11, 'Aashirvaad Atta 10kg',       'Groceries',       449.00),
(12, 'Tata Gold Tea 500g',         'Groceries',       299.00),
(13, 'Fortune Sunflower Oil 5L',   'Groceries',       699.00),
(14, 'Maggi Noodles Pack of 12',   'Groceries',       180.00),
(15, 'Amul Butter 500g',           'Groceries',       275.00),
(16, 'Prestige Pressure Cooker 5L','Home & Kitchen', 2199.00),
(17, 'Milton Thermos 1L',          'Home & Kitchen',  899.00),
(18, 'Pigeon Non-Stick Tawa',      'Home & Kitchen',  799.00),
(19, 'Solimo Bedsheet Queen',      'Home & Kitchen', 1199.00),
(20, 'Philips Room Heater',        'Home & Kitchen', 2499.00),
(21, 'Lakme CC Cream',             'Beauty',          349.00),
(22, 'Mamaearth Vitamin C Serum',  'Beauty',          599.00),
(23, 'Dove Body Lotion 400ml',     'Beauty',          349.00),
(24, 'WOW Shampoo 300ml',          'Beauty',          449.00),
(25, 'Himalaya Face Wash 150ml',   'Beauty',          199.00),
(26, 'Atomic Habits - James Clear','Books',           399.00),
(27, 'The Psychology of Money',    'Books',           349.00),
(28, 'Wings of Fire - APJ Kalam',  'Books',           199.00),
(29, 'Zero to One - Peter Thiel',  'Books',           449.00),
(30, 'Rich Dad Poor Dad',          'Books',           299.00),
(31, 'Nivia Football Size 5',      'Sports',          999.00),
(32, 'Cosco Badminton Set',        'Sports',         1299.00),
(33, 'Boldfit Yoga Mat',           'Sports',          699.00),
(34, 'Skipping Rope Steel',        'Sports',          399.00),
(35, 'Protein Shaker Bottle',      'Sports',          349.00); 

-- --------------------------
-- 3.3 orders (100 rows) 
--dates: Jan 2024- Mar 2025
-- --------------------------

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES
(1001,  1,  '2024-01-05', 2598.00, 'Completed'),
(1002,  3,  '2024-01-08', 1299.00, 'Completed'),
(1003,  5,  '2024-01-12', 8999.00, 'Completed'),
(1004,  2,  '2024-01-15',  898.00, 'Cancelled'),
(1005,  7,  '2024-01-18', 5998.00, 'Completed'),
(1006,  9,  '2024-01-22', 1398.00, 'Pending'),
(1007,  4,  '2024-01-25',  699.00, 'Completed'),
(1008,  6,  '2024-01-28', 3798.00, 'Completed'),
(1009,  10, '2024-02-02', 2199.00, 'Completed'),
(1010,  12, '2024-02-05', 4999.00, 'Cancelled'),
(1011,  13, '2024-02-08', 1498.00, 'Completed'),
(1012,  15, '2024-02-11',  798.00, 'Completed'),
(1013,  8,  '2024-02-14', 2798.00, 'Pending'),
(1014,  11, '2024-02-17', 1199.00, 'Completed'),
(1015,  16, '2024-02-20', 9998.00, 'Completed'),
(1016,  18, '2024-02-23',  549.00, 'Completed'),
(1017,  20, '2024-02-26', 3598.00, 'Cancelled'),
(1018,  14, '2024-03-01', 1799.00, 'Completed'),
(1019,  17, '2024-03-04',  448.00, 'Completed'),
(1020,  19, '2024-03-07', 2498.00, 'Completed'),
(1021,  21, '2024-03-10', 1299.00, 'Pending'),
(1022,  22, '2024-03-13', 6998.00, 'Completed'),
(1023,  23, '2024-03-16',  898.00, 'Completed'),
(1024,  24, '2024-03-19', 1598.00, 'Cancelled'),
(1025,  25, '2024-03-22', 2998.00, 'Completed'),
(1026,  26, '2024-03-25', 4499.00, 'Completed'),
(1027,  1,  '2024-04-01', 1799.00, 'Completed'),
(1028,  5,  '2024-04-04', 3298.00, 'Completed'),
(1029,  7,  '2024-04-07', 5499.00, 'Cancelled'),
(1030,  13, '2024-04-10', 2399.00, 'Completed'),
(1031,  27, '2024-04-13',  699.00, 'Completed'),
(1032,  28, '2024-04-16', 1148.00, 'Pending'),
(1033,  29, '2024-04-19', 8999.00, 'Completed'),
(1034,  30, '2024-04-22', 1299.00, 'Completed'),
(1035,  2,  '2024-04-25',  499.00, 'Completed'),
(1036,  31, '2024-04-28', 2998.00, 'Cancelled'),
(1037,  32, '2024-05-01', 1799.00, 'Completed'),
(1038,  3,  '2024-05-04', 4999.00, 'Completed'),
(1039,  33, '2024-05-07',  798.00, 'Completed'),
(1040,  34, '2024-05-10', 3198.00, 'Pending'),
(1041,  35, '2024-05-13', 1099.00, 'Completed'),
(1042,  4,  '2024-05-16', 2698.00, 'Completed'),
(1043,  6,  '2024-05-19',  648.00, 'Cancelled'),
(1044,  8,  '2024-05-22', 5299.00, 'Completed'),
(1045,  10, '2024-05-25', 1999.00, 'Completed'),
(1046,  12, '2024-05-28', 3499.00, 'Completed'),
(1047,  14, '2024-06-01',  899.00, 'Pending'),
(1048,  16, '2024-06-04', 2199.00, 'Completed'),
(1049,  18, '2024-06-07', 1399.00, 'Completed'),
(1050,  20, '2024-06-10', 6999.00, 'Completed'),
(1051,  22, '2024-06-13',  749.00, 'Cancelled'),
(1052,  24, '2024-06-16', 2499.00, 'Completed'),
(1053,  26, '2024-06-19', 1299.00, 'Completed'),
(1054,  9,  '2024-06-22', 4799.00, 'Completed'),
(1055,  11, '2024-06-25', 1698.00, 'Pending'),
(1056,  15, '2024-06-28',  999.00, 'Completed'),
(1057,  17, '2024-07-01', 3299.00, 'Completed'),
(1058,  19, '2024-07-04', 2099.00, 'Cancelled'),
(1059,  21, '2024-07-07', 1499.00, 'Completed'),
(1060,  23, '2024-07-10',  849.00, 'Completed'),
(1061,  25, '2024-07-13', 5799.00, 'Completed'),
(1062,  27, '2024-07-16', 1199.00, 'Pending'),
(1063,  29, '2024-07-19', 2899.00, 'Completed'),
(1064,  31, '2024-07-22', 3999.00, 'Completed'),
(1065,  33, '2024-07-25',  699.00, 'Cancelled'),
(1066,  35, '2024-07-28', 1899.00, 'Completed'),
(1067,  1,  '2024-08-01', 4299.00, 'Completed'),
(1068,  5,  '2024-08-04', 2799.00, 'Completed'),
(1069,  7,  '2024-08-07', 1099.00, 'Pending'),
(1070,  13, '2024-08-10', 6499.00, 'Completed'),
(1071,  2,  '2024-08-13',  549.00, 'Completed'),
(1072,  4,  '2024-08-16', 3799.00, 'Cancelled'),
(1073,  6,  '2024-08-19', 1599.00, 'Completed'),
(1074,  8,  '2024-08-22', 2299.00, 'Completed'),
(1075,  20, '2024-09-01', 4999.00, 'Completed'),
(1076,  22, '2024-09-05', 1299.00, 'Pending'),
(1077,  24, '2024-09-09', 3499.00, 'Completed'),
(1078,  16, '2024-09-13', 2199.00, 'Completed'),
(1079,  28, '2024-09-17',  999.00, 'Cancelled'),
(1080,  30, '2024-09-21', 5299.00, 'Completed'),
(1081,  34, '2024-10-01', 1799.00, 'Completed'),
(1082,  3,  '2024-10-06', 2999.00, 'Completed'),
(1083,  9,  '2024-10-11', 4499.00, 'Pending'),
(1084,  11, '2024-10-16', 1299.00, 'Completed'),
(1085,  15, '2024-10-21', 3299.00, 'Completed'),
(1086,  17, '2024-10-26', 1099.00, 'Cancelled'),
(1087,  1,  '2024-11-02', 7999.00, 'Completed'),  -- Diwali spike
(1088,  5,  '2024-11-05', 5499.00, 'Completed'),  -- Diwali spike
(1089,  7,  '2024-11-08', 8999.00, 'Completed'),  -- Diwali spike
(1090,  13, '2024-11-11', 3799.00, 'Completed'),
(1091,  20, '2024-11-14', 6299.00, 'Completed'),
(1092,  29, '2024-11-17', 4199.00, 'Pending'),
(1093,  34, '2024-11-20', 2499.00, 'Completed'),
(1094,  16, '2024-12-05', 9499.00, 'Completed'),  -- Year-end spike
(1095,  24, '2024-12-10', 5999.00, 'Completed'),
(1096,  2,  '2024-12-15', 3299.00, 'Cancelled'),
(1097,  8,  '2024-12-20', 7499.00, 'Completed'),
(1098,  12, '2024-12-26', 2999.00, 'Completed'),
(1099,  30, '2025-01-10', 1899.00, 'Completed'),
(1100,  35, '2025-01-18', 3499.00, 'Pending'),
(1101,  19, '2025-02-05', 2199.00, 'Completed'),
(1102,  27, '2025-02-14', 4999.00, 'Completed'),  -- Valentine's
(1103,  33, '2025-02-22', 1299.00, 'Completed'),
(1104,  6,  '2025-03-01', 3799.00, 'Cancelled'),
(1105,  14, '2025-03-10', 2099.00, 'Completed');

-- --------------------------
--3.4 order_items (200 rows- every order has 1-3 items)
-- --------------------------

INSERT INTO order_items( order_item_id,order_id,product_id,quantity) VALUES
-- order 1001
(1, 1001, 1, 2),  -- 2× boAt Airdopes = 2598
-- order 1002
(2, 1002, 1, 1),  -- 1299
-- order 1003
(3, 1003, 7, 1),  -- Nike = 8999
-- order 1004
(4, 1004, 23, 2),(5, 1004, 25, 1),  -- cancelled
-- order 1005
(6, 1005, 5, 1),(7, 1005, 4, 1),
-- order 1006
(8, 1006, 11, 2),(9, 1006, 12, 1),
-- order 1007
(10, 1007, 9, 1),
-- order 1008
(11, 1008, 19, 2),(12, 1008, 17, 1),(13, 1008, 25, 3),
-- order 1009
(14, 1009, 16, 1),
-- order 1010
(15, 1010, 5, 1),
-- order 1011
(16, 1011, 4, 1),(17, 1011, 35, 1),
-- order 1012
(18, 1012, 18, 1),
-- order 1013
(19, 1013, 6, 1),(20, 1013, 10, 1),
-- order 1014
(21, 1014, 19, 1),
-- order 1015
(22, 1015, 2, 1),(23, 1015, 4, 2),(24, 1015, 33, 2),
-- order 1016
(25, 1016, 12, 1),(26, 1016, 15, 1),
-- order 1017
(27, 1017, 26, 1),(28, 1017, 27, 1),(29, 1017, 30, 1),(30, 1017, 29, 1),
-- order 1018
(31, 1018, 8, 1),(32, 1018, 24, 2),
-- order 1019
(33, 1019, 14, 2),(34, 1019, 15, 1),
-- order 1020
(35, 1020, 6, 1),(36, 1020, 10, 1),
-- order 1021
(37, 1021, 1, 1),
-- order 1022
(38, 1022, 3, 1),(39, 1022, 33, 2),(40, 1022, 34, 1),
-- order 1023
(41, 1023, 17, 1),
-- order 1024
(42, 1024, 21, 2),(43, 1024, 24, 2),
-- order 1025
(44, 1025, 20, 1),(45, 1025, 17, 1),(46, 1025, 35, 1),
-- order 1026
(47, 1026, 5, 1),(48, 1026, 33, 1),(49, 1026, 34, 2),
-- order 1027
(50, 1027, 8, 1),(51, 1027, 24, 1),(52, 1027, 22, 1),
-- order 1028
(53, 1028, 29, 1),(54, 1028, 27, 2),(55, 1028, 26, 2),(56, 1028, 28, 2),
-- order 1029
(57, 1029, 7, 1),(58, 1029, 34, 1),
-- order 1030
(59, 1030, 6, 1),(60, 1030, 9, 1),(61, 1030, 23, 1),
-- order 1031
(62, 1031, 9, 1),
-- order 1032
(63, 1032, 11, 1),(64, 1032, 14, 2),(65, 1032, 15, 1),
-- order 1033
(66, 1033, 2, 1),(67, 1033, 4, 1),(68, 1033, 35, 2),
-- order 1034
(69, 1034, 1, 1),
-- order 1035
(70, 1035, 25, 1),(71, 1035, 23, 1),(72, 1035, 28, 1),
-- order 1036
(73, 1036, 20, 1),(74, 1036, 17, 1),
-- order 1037
(75, 1037, 8, 1),(76, 1037, 21, 2),(77, 1037, 25, 1),
-- order 1038
(78, 1038, 5, 1),
-- order 1039
(79, 1039, 18, 1),
-- order 1040
(80, 1040, 19, 1),(81, 1040, 16, 1),(82, 1040, 17, 1),
-- order 1041
(83, 1041, 11, 2),(84, 1041, 12, 1),
-- order 1042
(85, 1042, 1, 1),(86, 1042, 4, 1),(87, 1042, 5, 1),(88, 1042, 32, 1),
-- order 1043
(89, 1043, 13, 1),(90, 1043, 14, 1),
-- order 1044
(91, 1044, 3, 1),(92, 1044, 35, 1),(93, 1044, 9, 2),
-- order 1045
(94, 1045, 20, 1),(95, 1045, 25, 1),
-- order 1046
(96, 1046, 5, 1),(97, 1046, 26, 1),(98, 1046, 27, 1),(99, 1046, 29, 1),
-- order 1047
(100, 1047, 17, 1),
-- order 1048
(101, 1048, 16, 1),
-- order 1049
(102, 1049, 10, 1),(103, 1049, 9, 1),
-- order 1050
(104, 1050, 2, 1),(105, 1050, 1, 1),(106, 1050, 17, 1),(107, 1050, 14, 1),
-- order 1051
(108, 1051, 21, 1),(109, 1051, 25, 2),
-- order 1052
(110, 1052, 6, 1),(111, 1052, 10, 1),(112, 1052, 24, 1),
-- order 1053
(113, 1053, 1, 1),
-- order 1054
(114, 1054, 5, 1),(115, 1054, 1, 2),(116, 1054, 35, 1),
-- order 1055
(117, 1055, 19, 1),(118, 1055, 17, 1),(119, 1055, 12, 1),
-- order 1056
(120, 1056, 31, 1),
-- order 1057
(121, 1057, 6, 1),(122, 1057, 9, 2),(123, 1057, 27, 2),(124, 1057, 34, 1),
-- order 1058
(125, 1058, 20, 1),(126, 1058, 12, 1),
-- order 1059
(127, 1059, 4, 1),(128, 1059, 1, 1),(129, 1059, 25, 1),(130, 1059, 35, 1),
-- order 1060
(131, 1060, 28, 2),(132, 1060, 25, 1),
-- order 1061
(133, 1061, 2, 1),(134, 1061, 33, 2),(135, 1061, 1, 1),
-- order 1062
(136, 1062, 19, 1),
-- order 1063
(137, 1063, 16, 1),(138, 1063, 18, 1),(139, 1063, 25, 1),
-- order 1064
(140, 1064, 5, 1),(141, 1064, 26, 2),(142, 1064, 7, 1),(143, 1064, 34, 2),
-- order 1065
(144, 1065, 9, 1),
-- order 1066
(145, 1066, 8, 1),(146, 1066, 10, 1),(147, 1066, 24, 1),
-- order 1067
(148, 1067, 1, 1),(149, 1067, 5, 1),(150, 1067, 32, 2),(151, 1067, 33, 1),
-- order 1068
(152, 1068, 6, 1),(153, 1068, 9, 2),(154, 1068, 27, 2),
-- order 1069
(155, 1069, 11, 2),(156, 1069, 13, 1),
-- order 1070
(157, 1070, 3, 1),(158, 1070, 1, 2),(159, 1070, 5, 1),
-- order 1071
(160, 1071, 15, 1),(161, 1071, 25, 1),(162, 1071, 12, 1),
-- order 1072
(163, 1072, 5, 1),(164, 1072, 16, 1),(165, 1072, 19, 1),(166, 1072, 35, 1),
-- order 1073
(167, 1073, 1, 1),(168, 1073, 10, 1),(169, 1073, 23, 1),
-- order 1074
(170, 1074, 17, 1),(171, 1074, 18, 1),(172, 1074, 19, 1),
-- order 1075
(173, 1075, 5, 1),(174, 1075, 26, 2),(175, 1075, 27, 2),(176, 1075, 29, 1),
-- order 1076
(177, 1076, 1, 1),
-- order 1077
(178, 1077, 20, 1),(179, 1077, 5, 1),(180, 1077, 31, 1),(181, 1077, 33, 1),
-- order 1078
(182, 1078, 16, 1),
-- order 1079
(183, 1079, 31, 1),(184, 1079, 25, 1),(185, 1079, 28, 1),(186, 1079, 12, 2),
-- order 1080
(187, 1080, 3, 1),(188, 1080, 1, 2),(189, 1080, 35, 2),
-- order 1081
(190, 1081, 8, 1),(191, 1081, 24, 2),(192, 1081, 25, 1),
-- order 1082
(193, 1082, 20, 1),(194, 1082, 17, 1),(195, 1082, 35, 1),(196, 1082, 23, 1),
-- order 1083
(197, 1083, 5, 1),(198, 1083, 26, 2),(199, 1083, 27, 1),(200, 1083, 30, 1),
-- order 1084
(201, 1084, 1, 1),
-- order 1085
(202, 1085, 6, 1),(203, 1085, 9, 2),(204, 1085, 27, 2),(205, 1085, 34, 1),
-- order 1086
(206, 1086, 11, 1),(207, 1086, 15, 2),
-- order 1087  (Diwali)
(208, 1087, 2, 1),(209, 1087, 1, 2),(210, 1087, 5, 1),(211, 1087, 33, 2),
-- order 1088  (Diwali)
(212, 1088, 3, 1),(213, 1088, 4, 1),(214, 1088, 35, 2),
-- order 1089  (Diwali)
(215, 1089, 2, 1),(216, 1089, 7, 1),(217, 1089, 5, 1),
-- order 1090
(218, 1090, 20, 1),(219, 1090, 1, 1),(220, 1090, 17, 1),(221, 1090, 19, 1),
-- order 1091
(222, 1091, 3, 1),(223, 1091, 5, 1),(224, 1091, 1, 1),(225, 1091, 32, 1),
-- order 1092
(226, 1092, 16, 1),(227, 1092, 5, 1),(228, 1092, 34, 2),(229, 1092, 33, 2),
-- order 1093
(230, 1093, 6, 1),(231, 1093, 10, 1),(232, 1093, 9, 1),(233, 1093, 23, 1),
-- order 1094  (Year-end)
(234, 1094, 3, 1),(235, 1094, 2, 1),(236, 1094, 1, 1),(237, 1094, 33, 1),
-- order 1095
(238, 1095, 7, 1),(239, 1095, 26, 2),(240, 1095, 29, 1),(241, 1095, 27, 2),
-- order 1096
(242, 1096, 20, 1),(243, 1096, 17, 1),(244, 1096, 35, 1),(245, 1096, 23, 1),
-- order 1097
(246, 1097, 3, 1),(247, 1097, 5, 1),(248, 1097, 2, 1),
-- order 1098
(249, 1098, 20, 1),(250, 1098, 17, 1),(251, 1098, 35, 1),
-- order 1099
(252, 1099, 8, 1),(253, 1099, 10, 1),(254, 1099, 24, 1),
-- order 1100
(255, 1100, 5, 1),(256, 1100, 26, 1),(257, 1100, 29, 2),(258, 1100, 27, 1),
-- order 1101
(259, 1101, 16, 1),
-- order 1102 (Valentine's)
(260, 1102, 7, 1),(261, 1102, 22, 2),(262, 1102, 23, 1),(263, 1102, 21, 2),
-- order 1103
(264, 1103, 1, 1),
-- order 1104
(265, 1104, 20, 1),(266, 1104, 5, 1),(267, 1104, 1, 1),(268, 1104, 19, 1),
-- order 1105
(269, 1105, 6, 1),(270, 1105, 9, 1),(271, 1105, 27, 2),(272, 1105, 23, 1);

-- --------------------------
-- 3.5 Payments (105 rows- one per order)
-- methods: UPI,Card,COD
--Status matches order logically
-- completed -> successfull
-- cancelled -> Failed
-- pending -> Pending
-- --------------------------

INSERT INTO payments(payment_id,order_id,payment_method,payment_status) VALUES
(2001, 1001, 'UPI',  'Success'),
(2002, 1002, 'Card', 'Success'),
(2003, 1003, 'Card', 'Success'),
(2004, 1004, 'UPI',  'Failed'),
(2005, 1005, 'UPI',  'Success'),
(2006, 1006, 'COD',  'Pending'),
(2007, 1007, 'UPI',  'Success'),
(2008, 1008, 'Card', 'Success'),
(2009, 1009, 'COD',  'Success'),
(2010, 1010, 'Card', 'Failed'),
(2011, 1011, 'UPI',  'Success'),
(2012, 1012, 'COD',  'Success'),
(2013, 1013, 'UPI',  'Pending'),
(2014, 1014, 'Card', 'Success'),
(2015, 1015, 'Card', 'Success'),
(2016, 1016, 'UPI',  'Success'),
(2017, 1017, 'COD',  'Failed'),
(2018, 1018, 'UPI',  'Success'),
(2019, 1019, 'COD',  'Success'),
(2020, 1020, 'Card', 'Success'),
(2021, 1021, 'UPI',  'Pending'),
(2022, 1022, 'Card', 'Success'),
(2023, 1023, 'COD',  'Success'),
(2024, 1024, 'UPI',  'Failed'),
(2025, 1025, 'Card', 'Success'),
(2026, 1026, 'UPI',  'Success'),
(2027, 1027, 'COD',  'Success'),
(2028, 1028, 'Card', 'Success'),
(2029, 1029, 'UPI',  'Failed'),
(2030, 1030, 'Card', 'Success'),
(2031, 1031, 'COD',  'Success'),
(2032, 1032, 'UPI',  'Pending'),
(2033, 1033, 'Card', 'Success'),
(2034, 1034, 'UPI',  'Success'),
(2035, 1035, 'COD',  'Success'),
(2036, 1036, 'Card', 'Failed'),
(2037, 1037, 'UPI',  'Success'),
(2038, 1038, 'Card', 'Success'),
(2039, 1039, 'COD',  'Success'),
(2040, 1040, 'UPI',  'Pending'),
(2041, 1041, 'COD',  'Success'),
(2042, 1042, 'Card', 'Success'),
(2043, 1043, 'UPI',  'Failed'),
(2044, 1044, 'Card', 'Success'),
(2045, 1045, 'COD',  'Success'),
(2046, 1046, 'UPI',  'Success'),
(2047, 1047, 'COD',  'Pending'),
(2048, 1048, 'Card', 'Success'),
(2049, 1049, 'UPI',  'Success'),
(2050, 1050, 'Card', 'Success'),
(2051, 1051, 'UPI',  'Failed'),
(2052, 1052, 'Card', 'Success'),
(2053, 1053, 'COD',  'Success'),
(2054, 1054, 'UPI',  'Success'),
(2055, 1055, 'Card', 'Pending'),
(2056, 1056, 'COD',  'Success'),
(2057, 1057, 'UPI',  'Success'),
(2058, 1058, 'Card', 'Failed'),
(2059, 1059, 'UPI',  'Success'),
(2060, 1060, 'COD',  'Success'),
(2061, 1061, 'Card', 'Success'),
(2062, 1062, 'UPI',  'Pending'),
(2063, 1063, 'Card', 'Success'),
(2064, 1064, 'COD',  'Success'),
(2065, 1065, 'UPI',  'Failed'),
(2066, 1066, 'Card', 'Success'),
(2067, 1067, 'UPI',  'Success'),
(2068, 1068, 'Card', 'Success'),
(2069, 1069, 'COD',  'Pending'),
(2070, 1070, 'Card', 'Success'),
(2071, 1071, 'UPI',  'Success'),
(2072, 1072, 'COD',  'Failed'),
(2073, 1073, 'UPI',  'Success'),
(2074, 1074, 'Card', 'Success'),
(2075, 1075, 'UPI',  'Success'),
(2076, 1076, 'COD',  'Pending'),
(2077, 1077, 'Card', 'Success'),
(2078, 1078, 'UPI',  'Success'),
(2079, 1079, 'Card', 'Failed'),
(2080, 1080, 'COD',  'Success'),
(2081, 1081, 'UPI',  'Success'),
(2082, 1082, 'Card', 'Success'),
(2083, 1083, 'UPI',  'Pending'),
(2084, 1084, 'COD',  'Success'),
(2085, 1085, 'Card', 'Success'),
(2086, 1086, 'UPI',  'Failed'),
(2087, 1087, 'Card', 'Success'),
(2088, 1088, 'UPI',  'Success'),
(2089, 1089, 'Card', 'Success'),
(2090, 1090, 'COD',  'Success'),
(2091, 1091, 'UPI',  'Success'),
(2092, 1092, 'Card', 'Pending'),
(2093, 1093, 'COD',  'Success'),
(2094, 1094, 'Card', 'Success'),
(2095, 1095, 'UPI',  'Success'),
(2096, 1096, 'COD',  'Failed'),
(2097, 1097, 'Card', 'Success'),
(2098, 1098, 'UPI',  'Success'),
(2099, 1099, 'COD',  'Success'),
(2100, 1100, 'Card', 'Pending'),
(2101, 1101, 'UPI',  'Success'),
(2102, 1102, 'Card', 'Success'),
(2103, 1103, 'COD',  'Success'),
(2104, 1104, 'UPI',  'Failed'),
(2105, 1105, 'Card', 'Success');

-- ============================================================
--  Customer Transaction Analytics — DATASET EXTENSION
--  Adds: 115 customers, 500 orders, 45 products,
--        1170 order_items, 500 payments
--  Extended date range: Jan 2023 – Apr 2026
--  Run in: CustomerTransactionDB (SSMS)
--  IMPORTANT: Run AFTER the original script
-- ============================================================

USE CustomerTransactionDB;
GO

-- ============================================================
--  SECTION 1 : NEW CUSTOMERS (IDs 36–150)
-- ============================================================
INSERT INTO customers (customer_id, name, age, city, membership) VALUES
(36, 'Divya Patel', 24, 'Delhi', 'None'),
(37, 'Divya Banerjee', 23, 'Mumbai', 'Silver'),
(38, 'Divya Kulkarni', 27, 'Visakhapatnam', 'Silver'),
(39, 'Divya Subramanian', 54, 'Mumbai', 'Silver'),
(40, 'Divya Pillai', 57, 'Delhi', 'Silver'),
(41, 'Divya Ghosh', 53, 'Bangalore', 'Silver'),
(42, 'Divya Naik', 38, 'Surat', 'None'),
(43, 'Divya Rajput', 42, 'Bangalore', 'None'),
(44, 'Divya Saxena', 26, 'Bangalore', 'Silver'),
(45, 'Divya Kaur', 20, 'Delhi', 'Gold'),
(46, 'Divya Tripathi', 33, 'Chennai', 'Silver'),
(47, 'Divya Thakur', 22, 'Mumbai', 'None'),
(48, 'Divya Menon', 40, 'Delhi', 'None'),
(49, 'Divya Mehta', 61, 'Mumbai', 'Silver'),
(50, 'Divya Tiwari', 55, 'Hyderabad', 'Silver'),
(51, 'Divya Kapoor', 49, 'Chennai', 'Silver'),
(52, 'Divya Ahuja', 25, 'Nashik', 'Gold'),
(53, 'Divya Nair', 45, 'Ahmedabad', 'Silver'),
(54, 'Divya Pandey', 62, 'Hyderabad', 'None'),
(55, 'Divya Kamath', 22, 'Ahmedabad', 'None'),
(56, 'Divya Mishra', 25, 'Bangalore', 'Silver'),
(57, 'Divya Gowda', 47, 'Delhi', 'Gold'),
(58, 'Divya Arora', 48, 'Mumbai', 'Gold'),
(59, 'Divya Nambiar', 47, 'Delhi', 'None'),
(60, 'Divya Shetty', 25, 'Nashik', 'None'),
(61, 'Divya Krishnan', 19, 'Mumbai', 'None'),
(62, 'Divya Anand', 34, 'Visakhapatnam', 'None'),
(63, 'Divya Chatterjee', 32, 'Delhi', 'Silver'),
(64, 'Divya Khanna', 29, 'Bhopal', 'None'),
(65, 'Divya Rao', 35, 'Bangalore', 'None'),
(66, 'Divya Rajan', 37, 'Kochi', 'None'),
(67, 'Divya Murthy', 54, 'Bangalore', 'None'),
(68, 'Divya Kumar', 31, 'Ahmedabad', 'Silver'),
(69, 'Divya Das', 56, 'Pune', 'None'),
(70, 'Divya Agarwal', 39, 'Surat', 'Gold'),
(71, 'Divya Shah', 51, 'Mumbai', 'None'),
(72, 'Divya Malhotra', 22, 'Coimbatore', 'Silver'),
(73, 'Divya Hegde', 30, 'Nagpur', 'Gold'),
(74, 'Divya Sharma', 34, 'Mumbai', 'Gold'),
(75, 'Divya Chandra', 55, 'Bangalore', 'None'),
(76, 'Divya Bose', 58, 'Delhi', 'None'),
(77, 'Divya Yadav', 55, 'Mumbai', 'None'),
(78, 'Divya Dubey', 32, 'Hyderabad', 'None'),
(79, 'Divya Chopra', 35, 'Ahmedabad', 'Silver'),
(80, 'Divya Sethi', 38, 'Bangalore', 'None'),
(81, 'Divya Patil', 23, 'Hyderabad', 'None'),
(82, 'Divya Gupta', 55, 'Mumbai', 'None'),
(83, 'Divya Roy', 32, 'Chandigarh', 'Gold'),
(84, 'Divya Jain', 41, 'Hyderabad', 'Gold'),
(85, 'Divya Bhatia', 42, 'Bhopal', 'None');

INSERT INTO customers (customer_id, name, age, city, membership) VALUES
(86, 'Divya Verma', 53, 'Pune', 'Silver'),
(87, 'Divya Chauhan', 60, 'Jaipur', 'None'),
(88, 'Divya Desai', 54, 'Chennai', 'None'),
(89, 'Divya Iyer', 27, 'Pune', 'None'),
(90, 'Divya Grover', 54, 'Pune', 'None'),
(91, 'Divya Singh', 32, 'Delhi', 'Silver'),
(92, 'Divya Bhatt', 59, 'Jaipur', 'Silver'),
(93, 'Divya Srivastava', 35, 'Indore', 'Silver'),
(94, 'Divya Reddy', 24, 'Coimbatore', 'None'),
(95, 'Anil Patel', 21, 'Kolkata', 'None'),
(96, 'Anil Banerjee', 59, 'Mumbai', 'None'),
(97, 'Anil Kulkarni', 47, 'Visakhapatnam', 'Gold'),
(98, 'Anil Subramanian', 19, 'Chennai', 'Silver'),
(99, 'Anil Pillai', 28, 'Mumbai', 'None'),
(100, 'Anil Ghosh', 56, 'Chennai', 'None'),
(101, 'Anil Naik', 21, 'Chennai', 'Silver'),
(102, 'Anil Rajput', 21, 'Pune', 'None'),
(103, 'Anil Saxena', 34, 'Vadodara', 'Silver'),
(104, 'Anil Kaur', 54, 'Ahmedabad', 'Silver'),
(105, 'Anil Tripathi', 58, 'Bhopal', 'Silver'),
(106, 'Anil Thakur', 34, 'Surat', 'None'),
(107, 'Anil Menon', 30, 'Bhopal', 'None'),
(108, 'Anil Mehta', 40, 'Bhopal', 'Gold'),
(109, 'Anil Tiwari', 61, 'Lucknow', 'Silver'),
(110, 'Anil Kapoor', 36, 'Bhopal', 'None'),
(111, 'Anil Ahuja', 43, 'Delhi', 'None'),
(112, 'Anil Nair', 33, 'Bhopal', 'None'),
(113, 'Anil Pandey', 41, 'Delhi', 'None'),
(114, 'Anil Kamath', 33, 'Pune', 'None'),
(115, 'Anil Mishra', 44, 'Delhi', 'None'),
(116, 'Anil Gowda', 36, 'Pune', 'None'),
(117, 'Anil Arora', 62, 'Pune', 'Silver'),
(118, 'Anil Nambiar', 20, 'Chandigarh', 'Silver'),
(119, 'Anil Shetty', 30, 'Mumbai', 'None'),
(120, 'Anil Krishnan', 21, 'Chennai', 'None'),
(121, 'Anil Anand', 39, 'Mumbai', 'Silver'),
(122, 'Anil Chatterjee', 26, 'Bangalore', 'None'),
(123, 'Anil Khanna', 35, 'Bangalore', 'None'),
(124, 'Anil Rao', 52, 'Mumbai', 'Silver'),
(125, 'Anil Rajan', 61, 'Kochi', 'Silver'),
(126, 'Anil Murthy', 61, 'Delhi', 'Silver'),
(127, 'Anil Kumar', 61, 'Coimbatore', 'None'),
(128, 'Anil Das', 38, 'Indore', 'None'),
(129, 'Anil Agarwal', 39, 'Hyderabad', 'None'),
(130, 'Anil Shah', 27, 'Bangalore', 'Silver'),
(131, 'Anil Malhotra', 43, 'Delhi', 'None'),
(132, 'Anil Hegde', 58, 'Ahmedabad', 'None'),
(133, 'Anil Sharma', 19, 'Chennai', 'Silver'),
(134, 'Anil Chandra', 56, 'Pune', 'Silver'),
(135, 'Anil Bose', 47, 'Kolkata', 'Silver');

INSERT INTO customers (customer_id, name, age, city, membership) VALUES
(136, 'Anil Yadav', 49, 'Bangalore', 'Silver'),
(137, 'Anil Dubey', 29, 'Lucknow', 'None'),
(138, 'Anil Chopra', 61, 'Ahmedabad', 'Silver'),
(139, 'Anil Sethi', 34, 'Kolkata', 'Silver'),
(140, 'Anil Patil', 31, 'Ahmedabad', 'Silver'),
(141, 'Anil Gupta', 49, 'Delhi', 'Gold'),
(142, 'Anil Roy', 48, 'Kolkata', 'None'),
(143, 'Anil Jain', 31, 'Bangalore', 'None'),
(144, 'Anil Bhatia', 44, 'Jaipur', 'Silver'),
(145, 'Anil Verma', 19, 'Delhi', 'None'),
(146, 'Anil Chauhan', 25, 'Vadodara', 'None'),
(147, 'Anil Joshi', 52, 'Lucknow', 'Silver'),
(148, 'Anil Desai', 26, 'Hyderabad', 'None'),
(149, 'Anil Iyer', 61, 'Hyderabad', 'None'),
(150, 'Anil Grover', 39, 'Chennai', 'None');
GO

-- ============================================================
--  SECTION 2 : NEW PRODUCTS (IDs 36–80)
-- ============================================================
INSERT INTO products (product_id, product_name, category, price) VALUES
(36, 'OnePlus Nord CE 4', 'Electronics', 24999.00),
(37, 'Realme Narzo 70 Pro', 'Electronics', 18999.00),
(38, 'HP Pavilion Laptop 15', 'Electronics', 52999.00),
(39, 'Logitech MX Master 3', 'Electronics', 8999.00),
(40, 'JBL Flip 6 Speaker', 'Electronics', 11999.00),
(41, 'Zebronics Zeb-Rush Keyboard', 'Electronics', 1299.00),
(42, 'D-Link WiFi Router AC750', 'Electronics', 1499.00),
(43, 'Canon EOS M50 Camera', 'Electronics', 49999.00),
(44, 'Fastrack Analog Watch', 'Fashion', 1999.00),
(45, 'Zara Floral Dress', 'Fashion', 3499.00),
(46, 'US Polo T-Shirt Pack of 3', 'Fashion', 1899.00),
(47, 'Puma Running Shoes', 'Fashion', 4499.00),
(48, 'Van Heusen Formal Trousers', 'Fashion', 2299.00),
(49, 'Raymond Suit Fabric 1.5m', 'Fashion', 3999.00),
(50, 'Woodland Leather Shoes', 'Fashion', 5499.00),
(51, 'Basmati Rice 5kg', 'Groceries', 649.00),
(52, 'Saffola Gold Oil 2L', 'Groceries', 399.00),
(53, 'Britannia Good Day Biscuits', 'Groceries', 160.00),
(54, 'Kissan Mixed Fruit Jam 500g', 'Groceries', 189.00),
(55, 'Haldiram Bhujia 1kg', 'Groceries', 349.00),
(56, 'Catch Black Pepper 100g', 'Groceries', 129.00),
(57, 'Surf Excel Matic 2kg', 'Groceries', 499.00),
(58, 'Cello Opalware Dinner Set', 'Home & Kitchen', 1799.00),
(59, 'Prestige Mixer Grinder 750W', 'Home & Kitchen', 3299.00),
(60, 'Asian Paints Royale 1L', 'Home & Kitchen', 899.00),
(61, 'Godrej Locks Deadbolt', 'Home & Kitchen', 1299.00),
(62, 'Eureka Forbes Vacuum Cleaner', 'Home & Kitchen', 5999.00),
(63, 'Nilkamal Plastic Chair', 'Home & Kitchen', 1499.00),
(64, 'WOW Vitamin C Face Wash', 'Beauty', 399.00),
(65, 'Biotique Bio Honey Gel', 'Beauty', 299.00),
(66, 'Nivea Body Lotion SPF 50', 'Beauty', 549.00),
(67, 'Forest Essentials Face Oil', 'Beauty', 1850.00),
(68, 'Plum Goodness Green Tea Toner', 'Beauty', 449.00),
(69, 'Heads Up For Tails Dog Food', 'Sports', 2199.00),
(70, 'Cosco Basketball Size 7', 'Sports', 1499.00),
(71, 'Strauss Cricket Bat', 'Sports', 1999.00),
(72, 'Yonex Badminton Racket', 'Sports', 2499.00),
(73, 'TrueBasics Whey Protein 1kg', 'Sports', 2999.00),
(74, 'Decathlon Cycling Helmet', 'Sports', 1299.00),
(75, 'Think and Grow Rich', 'Books', 299.00),
(76, 'The Lean Startup', 'Books', 449.00),
(77, 'Sapiens - Yuval Noah Harari', 'Books', 599.00),
(78, 'Deep Work - Cal Newport', 'Books', 399.00),
(79, 'The Alchemist', 'Books', 299.00),
(80, 'Ikigai - Japanese Philosophy', 'Books', 349.00);
GO

-- ============================================================
--  SECTION 3 : NEW ORDERS (IDs 1106–1605)
--  Date range: Jan 2023 – Apr 2026
--  Seasonal patterns: Nov–Dec spike (Diwali/Christmas)
-- ============================================================

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES
(1106, 114, '2025-11-13', 480.00, 'Completed'),
(1107, 64, '2025-12-17', 2960.00, 'Completed'),
(1108, 70, '2024-12-02', 22700.00, 'Completed'),
(1109, 40, '2024-03-28', 2160.00, 'Completed'),
(1110, 108, '2026-01-12', 6350.00, 'Completed'),
(1111, 110, '2023-10-19', 400.00, 'Completed'),
(1112, 84, '2024-12-06', 17420.00, 'Completed'),
(1113, 5, '2026-01-23', 16470.00, 'Pending'),
(1114, 11, '2023-11-23', 390.00, 'Completed'),
(1115, 66, '2025-02-08', 500.00, 'Pending'),
(1116, 28, '2024-02-25', 1790.00, 'Completed'),
(1117, 31, '2024-12-26', 2320.00, 'Completed'),
(1118, 108, '2025-10-14', 6710.00, 'Completed'),
(1119, 134, '2025-08-24', 530.00, 'Cancelled'),
(1120, 23, '2025-10-23', 1300.00, 'Completed'),
(1121, 72, '2025-12-08', 1790.00, 'Completed'),
(1122, 62, '2025-10-16', 490.00, 'Completed'),
(1123, 79, '2025-08-01', 1740.00, 'Completed'),
(1124, 138, '2024-01-29', 2780.00, 'Pending'),
(1125, 135, '2025-01-23', 2230.00, 'Pending'),
(1126, 142, '2025-10-16', 1480.00, 'Completed'),
(1127, 48, '2023-04-30', 4910.00, 'Completed'),
(1128, 148, '2023-05-04', 1450.00, 'Pending'),
(1129, 31, '2025-07-09', 2560.00, 'Completed'),
(1130, 26, '2023-12-02', 11040.00, 'Completed'),
(1131, 121, '2024-09-02', 920.00, 'Completed'),
(1132, 60, '2023-11-16', 7770.00, 'Cancelled'),
(1133, 146, '2024-08-28', 920.00, 'Completed'),
(1134, 139, '2025-10-22', 960.00, 'Completed'),
(1135, 7, '2023-07-21', 1700.00, 'Pending'),
(1136, 69, '2026-04-09', 660.00, 'Completed'),
(1137, 72, '2025-10-18', 2220.00, 'Completed'),
(1138, 42, '2024-11-20', 440.00, 'Cancelled'),
(1139, 141, '2024-10-20', 1330.00, 'Cancelled'),
(1140, 1, '2023-05-06', 6600.00, 'Completed'),
(1141, 53, '2024-08-26', 13440.00, 'Completed'),
(1142, 62, '2023-12-05', 1110.00, 'Pending'),
(1143, 30, '2023-11-26', 360.00, 'Completed'),
(1144, 124, '2025-09-08', 11030.00, 'Completed'),
(1145, 35, '2023-06-06', 270.00, 'Completed'),
(1146, 1, '2025-10-13', 19630.00, 'Completed'),
(1147, 140, '2024-11-04', 440.00, 'Completed'),
(1148, 82, '2023-11-22', 360.00, 'Completed'),
(1149, 26, '2025-07-04', 9490.00, 'Cancelled'),
(1150, 40, '2024-07-10', 13350.00, 'Completed'),
(1151, 137, '2025-10-10', 440.00, 'Pending'),
(1152, 59, '2023-08-08', 6680.00, 'Completed'),
(1153, 15, '2024-09-06', 1400.00, 'Completed'),
(1154, 47, '2023-12-29', 1080.00, 'Completed'),
(1155, 150, '2023-11-04', 4760.00, 'Cancelled'),
(1156, 74, '2026-02-07', 19470.00, 'Pending'),
(1157, 65, '2025-09-30', 1470.00, 'Pending'),
(1158, 76, '2025-04-04', 400.00, 'Completed'),
(1159, 74, '2023-10-22', 25560.00, 'Completed'),
(1160, 149, '2024-11-03', 550.00, 'Completed'),
(1161, 70, '2023-12-17', 1190.00, 'Completed'),
(1162, 20, '2023-10-30', 7040.00, 'Completed'),
(1163, 143, '2025-02-02', 330.00, 'Completed'),
(1164, 68, '2025-02-13', 2730.00, 'Pending'),
(1165, 84, '2023-09-10', 6220.00, 'Completed'),
(1166, 138, '2023-10-19', 2520.00, 'Completed'),
(1167, 107, '2024-08-09', 740.00, 'Completed'),
(1168, 93, '2025-01-18', 320.00, 'Cancelled'),
(1169, 24, '2023-02-27', 3500.00, 'Completed'),
(1170, 142, '2023-11-05', 570.00, 'Completed'),
(1171, 7, '2023-10-11', 12800.00, 'Completed'),
(1172, 33, '2023-08-26', 980.00, 'Cancelled'),
(1173, 134, '2024-09-23', 690.00, 'Completed'),
(1174, 28, '2025-10-15', 1100.00, 'Completed'),
(1175, 33, '2025-11-12', 1680.00, 'Completed'),
(1176, 87, '2025-07-31', 490.00, 'Completed'),
(1177, 96, '2023-11-23', 150.00, 'Completed'),
(1178, 25, '2026-02-27', 1450.00, 'Completed'),
(1179, 109, '2024-10-15', 11470.00, 'Completed'),
(1180, 28, '2025-02-05', 640.00, 'Pending'),
(1181, 143, '2024-07-15', 930.00, 'Completed'),
(1182, 37, '2023-06-06', 920.00, 'Completed'),
(1183, 108, '2025-08-01', 17120.00, 'Pending'),
(1184, 22, '2023-05-02', 14360.00, 'Completed'),
(1185, 109, '2025-10-05', 1920.00, 'Completed'),
(1186, 111, '2023-08-30', 1300.00, 'Completed'),
(1187, 102, '2023-05-07', 3470.00, 'Completed'),
(1188, 84, '2023-09-17', 29480.00, 'Completed'),
(1189, 59, '2025-11-04', 300.00, 'Completed'),
(1190, 5, '2024-10-17', 4810.00, 'Completed'),
(1191, 104, '2025-01-25', 1800.00, 'Completed'),
(1192, 102, '2024-10-11', 2820.00, 'Completed'),
(1193, 30, '2024-12-30', 7710.00, 'Completed'),
(1194, 45, '2023-11-24', 860.00, 'Completed'),
(1195, 119, '2024-11-06', 1200.00, 'Completed'),
(1196, 71, '2023-06-15', 380.00, 'Completed'),
(1197, 24, '2025-11-18', 6040.00, 'Completed'),
(1198, 49, '2024-11-01', 550.00, 'Completed'),
(1199, 45, '2023-04-05', 5100.00, 'Completed'),
(1200, 96, '2024-08-16', 990.00, 'Cancelled'),
(1201, 86, '2024-08-18', 12760.00, 'Completed'),
(1202, 90, '2024-10-11', 1100.00, 'Pending'),
(1203, 80, '2024-11-17', 1380.00, 'Completed'),
(1204, 93, '2024-12-14', 430.00, 'Completed'),
(1205, 76, '2023-08-10', 1380.00, 'Cancelled');

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES
(1206, 34, '2025-02-24', 1780.00, 'Completed'),
(1207, 113, '2025-07-22', 590.00, 'Completed'),
(1208, 50, '2023-10-25', 2770.00, 'Completed'),
(1209, 133, '2023-09-27', 1460.00, 'Completed'),
(1210, 112, '2024-12-30', 410.00, 'Completed'),
(1211, 21, '2024-10-28', 7870.00, 'Completed'),
(1212, 121, '2023-10-26', 9680.00, 'Completed'),
(1213, 66, '2025-12-30', 890.00, 'Completed'),
(1214, 108, '2025-08-08', 21380.00, 'Completed'),
(1215, 62, '2023-11-06', 2970.00, 'Completed'),
(1216, 135, '2025-01-22', 2880.00, 'Completed'),
(1217, 121, '2023-06-02', 1220.00, 'Cancelled'),
(1218, 35, '2024-12-08', 1250.00, 'Completed'),
(1219, 35, '2025-08-09', 2650.00, 'Completed'),
(1220, 80, '2025-12-05', 1410.00, 'Cancelled'),
(1221, 49, '2024-08-22', 1000.00, 'Completed'),
(1222, 95, '2025-10-29', 240.00, 'Cancelled'),
(1223, 21, '2024-11-05', 410.00, 'Completed'),
(1224, 114, '2025-06-23', 420.00, 'Completed'),
(1225, 132, '2023-12-08', 2170.00, 'Completed'),
(1226, 94, '2026-03-21', 1220.00, 'Completed'),
(1227, 20, '2026-04-04', 4760.00, 'Completed'),
(1228, 30, '2025-11-02', 840.00, 'Completed'),
(1229, 74, '2025-10-16', 9450.00, 'Completed'),
(1230, 23, '2024-10-30', 430.00, 'Cancelled'),
(1231, 41, '2025-11-21', 1370.00, 'Completed'),
(1232, 142, '2026-02-17', 430.00, 'Completed'),
(1233, 123, '2025-12-26', 4350.00, 'Completed'),
(1234, 19, '2025-12-09', 990.00, 'Completed'),
(1235, 15, '2024-09-28', 550.00, 'Completed'),
(1236, 73, '2023-06-25', 25810.00, 'Completed'),
(1237, 137, '2023-12-26', 620.00, 'Cancelled'),
(1238, 87, '2026-03-14', 120.00, 'Cancelled'),
(1239, 68, '2024-09-24', 2460.00, 'Completed'),
(1240, 41, '2025-08-23', 520.00, 'Completed'),
(1241, 89, '2025-04-10', 4040.00, 'Completed'),
(1242, 32, '2023-10-30', 1090.00, 'Completed'),
(1243, 41, '2024-11-15', 710.00, 'Completed'),
(1244, 79, '2025-10-29', 670.00, 'Completed'),
(1245, 91, '2023-04-24', 2730.00, 'Cancelled'),
(1246, 111, '2023-10-16', 1050.00, 'Completed'),
(1247, 14, '2023-06-14', 240.00, 'Completed'),
(1248, 31, '2023-10-05', 2330.00, 'Completed'),
(1249, 37, '2023-04-17', 2160.00, 'Completed'),
(1250, 132, '2023-10-28', 950.00, 'Completed'),
(1251, 77, '2024-12-03', 350.00, 'Completed'),
(1252, 5, '2024-10-06', 28770.00, 'Completed'),
(1253, 149, '2025-09-24', 180.00, 'Completed'),
(1254, 147, '2023-08-28', 9220.00, 'Completed'),
(1255, 106, '2025-11-07', 7950.00, 'Completed'),
(1256, 84, '2024-10-18', 5870.00, 'Completed'),
(1257, 68, '2025-10-02', 6040.00, 'Pending'),
(1258, 77, '2025-10-12', 580.00, 'Cancelled'),
(1259, 74, '2023-11-12', 4340.00, 'Completed'),
(1260, 55, '2024-07-24', 6040.00, 'Pending'),
(1261, 58, '2024-05-05', 4200.00, 'Completed'),
(1262, 36, '2023-12-04', 4900.00, 'Pending'),
(1263, 83, '2024-12-01', 5950.00, 'Pending'),
(1264, 130, '2025-08-30', 2150.00, 'Completed'),
(1265, 48, '2024-02-14', 1130.00, 'Completed'),
(1266, 103, '2023-07-29', 530.00, 'Completed'),
(1267, 99, '2026-04-02', 1040.00, 'Completed'),
(1268, 120, '2024-10-04', 570.00, 'Completed'),
(1269, 80, '2024-09-10', 2810.00, 'Completed'),
(1270, 96, '2025-12-31', 1640.00, 'Completed'),
(1271, 130, '2023-11-17', 2610.00, 'Completed'),
(1272, 126, '2025-07-31', 8810.00, 'Completed'),
(1273, 79, '2023-06-13', 750.00, 'Pending'),
(1274, 18, '2025-09-07', 4350.00, 'Completed'),
(1275, 108, '2026-01-23', 860.00, 'Completed'),
(1276, 33, '2023-11-28', 230.00, 'Completed'),
(1277, 5, '2024-05-21', 6360.00, 'Completed'),
(1278, 13, '2023-05-10', 3420.00, 'Completed'),
(1279, 83, '2023-11-07', 3750.00, 'Completed'),
(1280, 45, '2024-10-28', 18380.00, 'Completed'),
(1281, 122, '2023-11-06', 1140.00, 'Completed'),
(1282, 100, '2024-05-26', 460.00, 'Completed'),
(1283, 138, '2024-02-09', 8180.00, 'Cancelled'),
(1284, 144, '2024-11-26', 390.00, 'Completed'),
(1285, 123, '2024-08-16', 1040.00, 'Completed'),
(1286, 128, '2025-08-26', 490.00, 'Pending'),
(1287, 95, '2024-10-16', 5610.00, 'Completed'),
(1288, 150, '2024-12-06', 590.00, 'Cancelled'),
(1289, 118, '2023-12-25', 1490.00, 'Completed'),
(1290, 139, '2025-05-08', 1750.00, 'Completed'),
(1291, 130, '2025-08-05', 2780.00, 'Completed'),
(1292, 142, '2025-05-06', 370.00, 'Completed'),
(1293, 111, '2024-01-17', 1370.00, 'Completed'),
(1294, 65, '2025-04-06', 1240.00, 'Completed'),
(1295, 77, '2023-03-20', 1070.00, 'Completed'),
(1296, 44, '2024-11-23', 3560.00, 'Pending'),
(1297, 146, '2025-09-14', 870.00, 'Completed'),
(1298, 46, '2024-10-20', 970.00, 'Cancelled'),
(1299, 20, '2024-09-18', 6140.00, 'Completed'),
(1300, 99, '2023-10-28', 360.00, 'Completed'),
(1301, 26, '2025-06-28', 2200.00, 'Pending'),
(1302, 102, '2024-11-08', 770.00, 'Completed'),
(1303, 48, '2025-03-03', 900.00, 'Completed'),
(1304, 69, '2023-11-26', 620.00, 'Completed'),
(1305, 24, '2025-07-13', 13840.00, 'Completed');

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES
(1306, 143, '2023-08-14', 1440.00, 'Cancelled'),
(1307, 99, '2023-12-28', 580.00, 'Completed'),
(1308, 17, '2023-12-23', 350.00, 'Completed'),
(1309, 64, '2025-10-26', 2600.00, 'Completed'),
(1310, 102, '2024-11-25', 970.00, 'Cancelled'),
(1311, 35, '2024-09-21', 710.00, 'Pending'),
(1312, 82, '2025-10-16', 800.00, 'Cancelled'),
(1313, 101, '2025-01-31', 810.00, 'Completed'),
(1314, 141, '2023-10-27', 12930.00, 'Completed'),
(1315, 97, '2023-07-08', 13130.00, 'Completed'),
(1316, 12, '2024-11-24', 9050.00, 'Completed'),
(1317, 133, '2026-04-07', 2400.00, 'Completed'),
(1318, 129, '2023-11-19', 1290.00, 'Pending'),
(1319, 22, '2023-11-13', 2930.00, 'Completed'),
(1320, 116, '2024-10-29', 110.00, 'Completed'),
(1321, 43, '2026-02-18', 1170.00, 'Cancelled'),
(1322, 48, '2025-06-18', 700.00, 'Completed'),
(1323, 55, '2024-03-11', 6760.00, 'Cancelled'),
(1324, 48, '2025-08-09', 370.00, 'Completed'),
(1325, 100, '2024-12-27', 650.00, 'Cancelled'),
(1326, 22, '2023-10-16', 5910.00, 'Completed'),
(1327, 131, '2023-10-24', 680.00, 'Completed'),
(1328, 45, '2026-02-24', 14460.00, 'Completed'),
(1329, 14, '2025-10-03', 1090.00, 'Completed'),
(1330, 105, '2025-10-18', 9270.00, 'Completed'),
(1331, 57, '2024-09-04', 12370.00, 'Completed'),
(1332, 127, '2026-04-01', 520.00, 'Completed'),
(1333, 11, '2025-06-03', 250.00, 'Completed'),
(1334, 68, '2024-12-28', 2600.00, 'Completed'),
(1335, 90, '2025-06-09', 720.00, 'Completed'),
(1336, 90, '2026-01-22', 900.00, 'Pending'),
(1337, 132, '2023-07-29', 7140.00, 'Completed'),
(1338, 33, '2023-10-13', 2120.00, 'Completed'),
(1339, 126, '2023-11-07', 2650.00, 'Cancelled'),
(1340, 24, '2025-10-10', 5080.00, 'Pending'),
(1341, 92, '2025-04-08', 9040.00, 'Cancelled'),
(1342, 87, '2024-12-18', 7240.00, 'Cancelled'),
(1343, 118, '2023-02-17', 4590.00, 'Pending'),
(1344, 52, '2023-10-12', 14890.00, 'Completed'),
(1345, 22, '2023-12-19', 2050.00, 'Completed'),
(1346, 24, '2023-07-28', 2140.00, 'Completed'),
(1347, 114, '2023-02-03', 550.00, 'Completed'),
(1348, 19, '2023-08-12', 2020.00, 'Cancelled'),
(1349, 35, '2023-11-10', 640.00, 'Completed'),
(1350, 39, '2023-10-28', 560.00, 'Completed'),
(1351, 36, '2024-06-05', 810.00, 'Cancelled'),
(1352, 73, '2024-09-23', 5670.00, 'Completed'),
(1353, 14, '2023-09-02', 370.00, 'Completed'),
(1354, 93, '2024-10-24', 2520.00, 'Completed'),
(1355, 121, '2023-06-13', 3110.00, 'Pending'),
(1356, 102, '2025-11-17', 1330.00, 'Completed'),
(1357, 22, '2023-11-23', 720.00, 'Pending'),
(1358, 40, '2024-05-17', 2580.00, 'Completed'),
(1359, 80, '2024-01-09', 6800.00, 'Completed'),
(1360, 89, '2025-12-21', 830.00, 'Cancelled'),
(1361, 69, '2025-06-12', 460.00, 'Completed'),
(1362, 128, '2025-08-04', 1320.00, 'Completed'),
(1363, 66, '2023-09-08', 120.00, 'Completed'),
(1364, 12, '2025-09-07', 1530.00, 'Pending'),
(1365, 108, '2024-10-31', 7550.00, 'Completed'),
(1366, 14, '2025-12-06', 440.00, 'Completed'),
(1367, 80, '2024-11-06', 390.00, 'Cancelled'),
(1368, 63, '2025-08-22', 950.00, 'Cancelled'),
(1369, 63, '2023-11-19', 900.00, 'Completed'),
(1370, 3, '2024-12-01', 530.00, 'Completed'),
(1371, 53, '2023-11-15', 2930.00, 'Completed'),
(1372, 22, '2025-04-01', 1060.00, 'Completed'),
(1373, 75, '2024-11-02', 500.00, 'Completed'),
(1374, 28, '2023-12-17', 2460.00, 'Pending'),
(1375, 54, '2025-07-28', 3170.00, 'Completed'),
(1376, 11, '2024-11-16', 810.00, 'Completed'),
(1377, 77, '2024-01-06', 380.00, 'Completed'),
(1378, 119, '2023-10-28', 1500.00, 'Completed'),
(1379, 22, '2023-06-17', 1610.00, 'Completed'),
(1380, 85, '2023-09-22', 190.00, 'Completed'),
(1381, 102, '2025-10-27', 1170.00, 'Pending'),
(1382, 71, '2024-08-10', 370.00, 'Completed'),
(1383, 76, '2025-11-01', 1720.00, 'Completed'),
(1384, 135, '2025-10-03', 2860.00, 'Completed'),
(1385, 82, '2024-04-07', 130.00, 'Completed'),
(1386, 92, '2023-08-08', 750.00, 'Pending'),
(1387, 15, '2024-01-05', 2100.00, 'Pending'),
(1388, 8, '2026-03-14', 2820.00, 'Completed'),
(1389, 24, '2023-05-10', 1660.00, 'Completed'),
(1390, 52, '2023-10-09', 10820.00, 'Completed'),
(1391, 37, '2024-12-04', 950.00, 'Cancelled'),
(1392, 125, '2024-10-25', 2260.00, 'Cancelled'),
(1393, 97, '2024-10-04', 2540.00, 'Pending'),
(1394, 147, '2026-03-22', 11870.00, 'Completed'),
(1395, 128, '2023-10-30', 280.00, 'Completed'),
(1396, 23, '2024-12-02', 730.00, 'Completed'),
(1397, 28, '2023-01-17', 370.00, 'Completed'),
(1398, 97, '2024-04-20', 7420.00, 'Completed'),
(1399, 27, '2023-06-15', 4080.00, 'Pending'),
(1400, 24, '2024-12-07', 25110.00, 'Pending'),
(1401, 43, '2025-06-22', 200.00, 'Completed'),
(1402, 142, '2024-08-13', 400.00, 'Cancelled'),
(1403, 40, '2025-06-08', 12850.00, 'Completed'),
(1404, 75, '2023-09-08', 350.00, 'Completed'),
(1405, 140, '2025-03-18', 2310.00, 'Completed');

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES
(1406, 120, '2024-07-07', 3200.00, 'Completed'),
(1407, 25, '2023-06-25', 370.00, 'Completed'),
(1408, 147, '2023-11-12', 420.00, 'Completed'),
(1409, 109, '2025-06-24', 12280.00, 'Pending'),
(1410, 18, '2023-07-12', 270.00, 'Completed'),
(1411, 4, '2025-12-20', 3840.00, 'Completed'),
(1412, 26, '2025-05-05', 2790.00, 'Completed'),
(1413, 71, '2025-04-19', 1120.00, 'Cancelled'),
(1414, 61, '2024-09-26', 1310.00, 'Completed'),
(1415, 59, '2023-10-17', 500.00, 'Completed'),
(1416, 107, '2023-07-16', 1130.00, 'Completed'),
(1417, 96, '2023-12-06', 6810.00, 'Cancelled'),
(1418, 146, '2023-03-15', 7820.00, 'Completed'),
(1419, 13, '2024-07-29', 5640.00, 'Completed'),
(1420, 8, '2025-07-16', 9780.00, 'Cancelled'),
(1421, 24, '2024-08-20', 2830.00, 'Completed'),
(1422, 57, '2025-12-01', 1470.00, 'Completed'),
(1423, 3, '2024-04-17', 460.00, 'Completed'),
(1424, 109, '2025-08-12', 2040.00, 'Completed'),
(1425, 150, '2023-08-12', 1070.00, 'Completed'),
(1426, 77, '2023-08-24', 870.00, 'Completed'),
(1427, 77, '2024-02-04', 7270.00, 'Cancelled'),
(1428, 104, '2024-10-30', 900.00, 'Completed'),
(1429, 108, '2024-12-17', 7120.00, 'Completed'),
(1430, 92, '2025-11-18', 4780.00, 'Completed'),
(1431, 67, '2024-12-02', 210.00, 'Completed'),
(1432, 85, '2024-09-08', 130.00, 'Completed'),
(1433, 19, '2025-11-04', 10680.00, 'Cancelled'),
(1434, 36, '2025-08-09', 6860.00, 'Completed'),
(1435, 46, '2024-10-17', 2080.00, 'Cancelled'),
(1436, 148, '2023-12-05', 480.00, 'Completed'),
(1437, 104, '2025-03-10', 1620.00, 'Completed'),
(1438, 83, '2026-01-06', 1530.00, 'Completed'),
(1439, 89, '2024-10-15', 1330.00, 'Completed'),
(1440, 12, '2025-12-23', 550.00, 'Completed'),
(1441, 49, '2023-12-18', 8610.00, 'Pending'),
(1442, 55, '2023-12-27', 290.00, 'Completed'),
(1443, 137, '2023-02-24', 1150.00, 'Completed'),
(1444, 122, '2023-11-24', 320.00, 'Completed'),
(1445, 134, '2023-10-22', 2900.00, 'Completed'),
(1446, 28, '2025-10-30', 740.00, 'Completed'),
(1447, 105, '2024-09-10', 2830.00, 'Completed'),
(1448, 61, '2023-01-20', 530.00, 'Completed'),
(1449, 24, '2025-11-27', 2330.00, 'Completed'),
(1450, 76, '2024-10-16', 540.00, 'Completed'),
(1451, 36, '2023-12-30', 550.00, 'Completed'),
(1452, 88, '2024-01-24', 240.00, 'Completed'),
(1453, 123, '2023-12-22', 580.00, 'Completed'),
(1454, 124, '2023-10-09', 1260.00, 'Completed'),
(1455, 81, '2025-12-24', 210.00, 'Completed'),
(1456, 87, '2025-12-13', 500.00, 'Completed'),
(1457, 89, '2025-03-13', 560.00, 'Completed'),
(1458, 41, '2025-11-15', 1110.00, 'Completed'),
(1459, 72, '2025-10-31', 2840.00, 'Completed'),
(1460, 106, '2026-03-11', 1230.00, 'Cancelled'),
(1461, 58, '2025-08-02', 6410.00, 'Completed'),
(1462, 116, '2023-09-05', 750.00, 'Cancelled'),
(1463, 75, '2023-08-20', 170.00, 'Cancelled'),
(1464, 105, '2023-08-22', 320.00, 'Completed'),
(1465, 118, '2025-11-09', 770.00, 'Cancelled'),
(1466, 124, '2025-11-21', 950.00, 'Completed'),
(1467, 83, '2025-11-10', 27690.00, 'Pending'),
(1468, 76, '2023-10-24', 250.00, 'Completed'),
(1469, 81, '2024-03-01', 900.00, 'Completed'),
(1470, 46, '2025-11-11', 1270.00, 'Completed'),
(1471, 147, '2025-12-20', 1400.00, 'Completed'),
(1472, 42, '2023-11-10', 720.00, 'Completed'),
(1473, 116, '2025-11-26', 890.00, 'Pending'),
(1474, 100, '2024-10-16', 330.00, 'Completed'),
(1475, 114, '2023-06-16', 1350.00, 'Completed'),
(1476, 143, '2024-07-09', 820.00, 'Completed'),
(1477, 40, '2023-04-06', 990.00, 'Completed'),
(1478, 78, '2025-10-15', 140.00, 'Completed'),
(1479, 57, '2025-11-07', 950.00, 'Completed'),
(1480, 85, '2023-02-02', 220.00, 'Completed'),
(1481, 63, '2024-11-02', 2380.00, 'Completed'),
(1482, 133, '2025-11-21', 2720.00, 'Completed'),
(1483, 25, '2023-12-23', 7340.00, 'Completed'),
(1484, 55, '2023-11-25', 6870.00, 'Completed'),
(1485, 65, '2026-03-02', 770.00, 'Completed'),
(1486, 104, '2025-06-19', 8380.00, 'Completed'),
(1487, 17, '2023-06-12', 250.00, 'Completed'),
(1488, 23, '2025-06-29', 7730.00, 'Completed'),
(1489, 101, '2023-11-06', 2330.00, 'Completed'),
(1490, 32, '2023-04-10', 1110.00, 'Completed'),
(1491, 54, '2024-12-19', 6290.00, 'Completed'),
(1492, 65, '2024-02-16', 6500.00, 'Cancelled'),
(1493, 141, '2023-06-13', 7210.00, 'Completed'),
(1494, 85, '2025-01-15', 780.00, 'Completed'),
(1495, 50, '2024-10-26', 2050.00, 'Completed'),
(1496, 94, '2024-10-23', 310.00, 'Completed'),
(1497, 112, '2023-10-17', 1280.00, 'Cancelled'),
(1498, 125, '2026-02-17', 490.00, 'Completed'),
(1499, 138, '2023-11-13', 1990.00, 'Completed'),
(1500, 102, '2023-12-20', 2150.00, 'Pending'),
(1501, 38, '2025-10-01', 1700.00, 'Completed'),
(1502, 95, '2024-05-08', 560.00, 'Completed'),
(1503, 117, '2023-04-20', 2130.00, 'Completed'),
(1504, 71, '2026-03-27', 1080.00, 'Cancelled'),
(1505, 20, '2025-12-08', 12300.00, 'Cancelled');

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES
(1506, 125, '2023-10-26', 1120.00, 'Completed'),
(1507, 48, '2023-12-03', 540.00, 'Cancelled'),
(1508, 30, '2025-09-22', 1140.00, 'Completed'),
(1509, 42, '2023-10-17', 1320.00, 'Completed'),
(1510, 47, '2025-12-08', 5910.00, 'Completed'),
(1511, 73, '2023-07-09', 24870.00, 'Cancelled'),
(1512, 37, '2025-11-26', 2200.00, 'Completed'),
(1513, 97, '2025-03-14', 1570.00, 'Completed'),
(1514, 108, '2023-11-17', 5400.00, 'Cancelled'),
(1515, 137, '2025-11-11', 2070.00, 'Pending'),
(1516, 111, '2025-12-19', 1380.00, 'Cancelled'),
(1517, 98, '2026-04-08', 1840.00, 'Pending'),
(1518, 22, '2024-02-06', 830.00, 'Completed'),
(1519, 97, '2024-10-22', 2770.00, 'Completed'),
(1520, 138, '2025-10-01', 2210.00, 'Completed'),
(1521, 31, '2023-12-12', 550.00, 'Completed'),
(1522, 14, '2023-12-10', 6210.00, 'Completed'),
(1523, 112, '2023-07-14', 1060.00, 'Cancelled'),
(1524, 103, '2025-12-17', 990.00, 'Completed'),
(1525, 113, '2025-12-11', 1340.00, 'Completed'),
(1526, 10, '2024-12-27', 820.00, 'Completed'),
(1527, 104, '2026-04-06', 4870.00, 'Completed'),
(1528, 76, '2024-12-11', 1350.00, 'Completed'),
(1529, 148, '2024-06-26', 450.00, 'Cancelled'),
(1530, 106, '2024-07-07', 440.00, 'Completed'),
(1531, 142, '2026-04-03', 360.00, 'Completed'),
(1532, 62, '2024-07-11', 810.00, 'Completed'),
(1533, 28, '2025-10-19', 970.00, 'Completed'),
(1534, 148, '2025-11-26', 2820.00, 'Cancelled'),
(1535, 123, '2026-01-26', 1110.00, 'Completed'),
(1536, 31, '2025-12-11', 830.00, 'Completed'),
(1537, 26, '2024-11-11', 5070.00, 'Pending'),
(1538, 88, '2025-02-02', 310.00, 'Completed'),
(1539, 103, '2024-08-09', 1340.00, 'Cancelled'),
(1540, 70, '2025-03-05', 1470.00, 'Completed'),
(1541, 128, '2023-10-17', 370.00, 'Cancelled'),
(1542, 77, '2026-03-22', 630.00, 'Completed'),
(1543, 25, '2024-06-30', 580.00, 'Completed'),
(1544, 106, '2023-09-20', 710.00, 'Completed'),
(1545, 45, '2024-08-19', 5680.00, 'Completed'),
(1546, 21, '2023-11-07', 1160.00, 'Completed'),
(1547, 19, '2023-06-26', 2080.00, 'Completed'),
(1548, 102, '2025-12-16', 190.00, 'Completed'),
(1549, 61, '2023-06-27', 4250.00, 'Cancelled'),
(1550, 141, '2023-05-05', 18010.00, 'Completed'),
(1551, 22, '2023-10-10', 920.00, 'Cancelled'),
(1552, 84, '2025-09-16', 3730.00, 'Pending'),
(1553, 139, '2024-12-26', 1170.00, 'Completed'),
(1554, 40, '2024-09-27', 10570.00, 'Completed'),
(1555, 126, '2025-09-18', 2560.00, 'Cancelled'),
(1556, 141, '2025-02-18', 23370.00, 'Completed'),
(1557, 100, '2024-07-24', 1390.00, 'Completed'),
(1558, 18, '2024-01-23', 1230.00, 'Completed'),
(1559, 126, '2023-11-22', 390.00, 'Completed'),
(1560, 33, '2024-05-05', 2820.00, 'Completed'),
(1561, 128, '2023-11-10', 1580.00, 'Cancelled'),
(1562, 65, '2024-06-07', 480.00, 'Completed'),
(1563, 25, '2025-12-17', 1270.00, 'Completed'),
(1564, 83, '2023-12-05', 7600.00, 'Completed'),
(1565, 77, '2024-11-09', 300.00, 'Completed'),
(1566, 11, '2023-11-28', 810.00, 'Completed'),
(1567, 87, '2023-05-17', 620.00, 'Completed'),
(1568, 125, '2024-12-26', 1590.00, 'Completed'),
(1569, 35, '2025-10-04', 900.00, 'Completed'),
(1570, 48, '2025-08-31', 7810.00, 'Completed'),
(1571, 76, '2025-08-01', 290.00, 'Cancelled'),
(1572, 94, '2025-10-29', 880.00, 'Completed'),
(1573, 25, '2025-12-21', 190.00, 'Completed'),
(1574, 125, '2024-02-11', 2390.00, 'Completed'),
(1575, 66, '2023-06-09', 580.00, 'Completed'),
(1576, 16, '2025-12-13', 28760.00, 'Completed'),
(1577, 64, '2023-12-22', 1120.00, 'Completed'),
(1578, 114, '2024-11-11', 960.00, 'Completed'),
(1579, 97, '2024-06-18', 19820.00, 'Completed'),
(1580, 73, '2024-09-24', 12270.00, 'Cancelled'),
(1581, 71, '2023-11-27', 4770.00, 'Completed'),
(1582, 150, '2024-06-09', 920.00, 'Completed'),
(1583, 56, '2025-09-29', 1190.00, 'Completed'),
(1584, 148, '2025-03-06', 280.00, 'Completed'),
(1585, 31, '2025-03-08', 970.00, 'Completed'),
(1586, 129, '2024-04-11', 1100.00, 'Completed'),
(1587, 130, '2023-07-18', 6750.00, 'Completed'),
(1588, 147, '2024-07-05', 2580.00, 'Cancelled'),
(1589, 124, '2026-03-05', 1600.00, 'Completed'),
(1590, 64, '2024-05-25', 1180.00, 'Completed'),
(1591, 29, '2024-12-28', 16290.00, 'Completed'),
(1592, 90, '2025-07-05', 780.00, 'Completed'),
(1593, 22, '2023-11-13', 910.00, 'Completed'),
(1594, 121, '2023-10-31', 880.00, 'Completed'),
(1595, 12, '2024-06-21', 1620.00, 'Completed'),
(1596, 3, '2025-03-16', 600.00, 'Pending'),
(1597, 125, '2026-01-07', 2850.00, 'Completed'),
(1598, 11, '2024-09-30', 620.00, 'Completed'),
(1599, 78, '2025-11-05', 360.00, 'Completed'),
(1600, 39, '2024-12-14', 1360.00, 'Completed'),
(1601, 59, '2025-05-18', 1170.00, 'Completed'),
(1602, 115, '2026-01-29', 580.00, 'Cancelled'),
(1603, 36, '2024-10-08', 320.00, 'Pending'),
(1604, 38, '2024-10-26', 1280.00, 'Cancelled'),
(1605, 8, '2024-10-28', 2480.00, 'Pending');
GO

-- ============================================================
--  SECTION 4 : NEW ORDER_ITEMS (IDs 273+)
-- ============================================================

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(273, 1106, 36, 1),
(274, 1106, 20, 1),
(275, 1106, 25, 3),
(276, 1106, 14, 1),
(277, 1107, 79, 1),
(278, 1107, 30, 2),
(279, 1107, 77, 1),
(280, 1108, 62, 2),
(281, 1108, 18, 1),
(282, 1108, 65, 1),
(283, 1109, 50, 1),
(284, 1110, 25, 1),
(285, 1111, 2, 3),
(286, 1111, 35, 1),
(287, 1112, 26, 1),
(288, 1112, 27, 3),
(289, 1112, 9, 1),
(290, 1113, 42, 1),
(291, 1113, 59, 2),
(292, 1113, 32, 1),
(293, 1114, 41, 3),
(294, 1114, 51, 1),
(295, 1114, 79, 1),
(296, 1115, 5, 1),
(297, 1115, 67, 2),
(298, 1115, 14, 1),
(299, 1116, 67, 1),
(300, 1116, 69, 2),
(301, 1116, 51, 3),
(302, 1116, 6, 1),
(303, 1116, 72, 1),
(304, 1117, 37, 1),
(305, 1117, 60, 3),
(306, 1117, 22, 2),
(307, 1117, 55, 3),
(308, 1118, 58, 2),
(309, 1118, 12, 1),
(310, 1119, 70, 1),
(311, 1119, 18, 1),
(312, 1119, 51, 1),
(313, 1120, 26, 1),
(314, 1120, 59, 1),
(315, 1121, 21, 1),
(316, 1121, 16, 1),
(317, 1121, 12, 1),
(318, 1122, 50, 1),
(319, 1122, 66, 1),
(320, 1123, 6, 3),
(321, 1123, 22, 1),
(322, 1124, 20, 1),
(323, 1124, 21, 2),
(324, 1124, 19, 1),
(325, 1125, 58, 1),
(326, 1125, 37, 1),
(327, 1126, 26, 1),
(328, 1127, 2, 2),
(329, 1127, 59, 1),
(330, 1127, 64, 1),
(331, 1128, 31, 1),
(332, 1128, 28, 1),
(333, 1128, 76, 1),
(334, 1128, 61, 1),
(335, 1129, 36, 1),
(336, 1129, 80, 1),
(337, 1129, 72, 2),
(338, 1129, 27, 1),
(339, 1130, 74, 3),
(340, 1130, 78, 1),
(341, 1130, 39, 1),
(342, 1130, 43, 1),
(343, 1131, 79, 2),
(344, 1131, 77, 1),
(345, 1131, 74, 1),
(346, 1132, 5, 2),
(347, 1132, 12, 1),
(348, 1133, 9, 1),
(349, 1133, 55, 1),
(350, 1133, 71, 2),
(351, 1133, 38, 1),
(352, 1134, 27, 1),
(353, 1134, 79, 1),
(354, 1135, 68, 1),
(355, 1135, 12, 2),
(356, 1135, 62, 1),
(357, 1135, 78, 1),
(358, 1135, 37, 1),
(359, 1136, 79, 2),
(360, 1136, 73, 1),
(361, 1136, 64, 2),
(362, 1136, 67, 2),
(363, 1137, 38, 3),
(364, 1138, 4, 1),
(365, 1139, 27, 1),
(366, 1139, 79, 1),
(367, 1139, 54, 1),
(368, 1140, 2, 1),
(369, 1140, 26, 1),
(370, 1140, 37, 1),
(371, 1141, 1, 2),
(372, 1141, 15, 1),
(373, 1142, 79, 1),
(374, 1142, 4, 2),
(375, 1142, 23, 3),
(376, 1143, 61, 1),
(377, 1143, 5, 1),
(378, 1144, 69, 2),
(379, 1144, 43, 1),
(380, 1144, 60, 2),
(381, 1145, 39, 1),
(382, 1145, 73, 1),
(383, 1145, 41, 1),
(384, 1146, 46, 3),
(385, 1146, 9, 1),
(386, 1147, 49, 1),
(387, 1148, 74, 1),
(388, 1148, 78, 1),
(389, 1148, 50, 2),
(390, 1149, 41, 1),
(391, 1149, 5, 1),
(392, 1150, 48, 1),
(393, 1150, 58, 1),
(394, 1150, 39, 1),
(395, 1150, 28, 1),
(396, 1151, 12, 1),
(397, 1152, 62, 3),
(398, 1153, 44, 3),
(399, 1154, 68, 1),
(400, 1154, 40, 2),
(401, 1154, 42, 2),
(402, 1155, 17, 1),
(403, 1155, 27, 2),
(404, 1155, 5, 1),
(405, 1155, 59, 1),
(406, 1156, 77, 2),
(407, 1157, 6, 1),
(408, 1157, 14, 2),
(409, 1158, 74, 1),
(410, 1158, 40, 1),
(411, 1159, 37, 1),
(412, 1160, 57, 1),
(413, 1160, 16, 1),
(414, 1161, 80, 1),
(415, 1162, 70, 1),
(416, 1163, 19, 1),
(417, 1163, 37, 1),
(418, 1164, 44, 1),
(419, 1164, 70, 1),
(420, 1165, 7, 1),
(421, 1165, 14, 1),
(422, 1166, 77, 1);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(423, 1166, 76, 2),
(424, 1167, 46, 1),
(425, 1167, 40, 1),
(426, 1168, 69, 1),
(427, 1168, 11, 1),
(428, 1168, 60, 2),
(429, 1169, 13, 2),
(430, 1169, 59, 2),
(431, 1169, 40, 1),
(432, 1170, 29, 1),
(433, 1171, 34, 2),
(434, 1171, 47, 2),
(435, 1171, 51, 2),
(436, 1171, 24, 2),
(437, 1172, 4, 1),
(438, 1172, 9, 1),
(439, 1173, 22, 2),
(440, 1173, 37, 1),
(441, 1174, 14, 1),
(442, 1175, 14, 1),
(443, 1175, 42, 2),
(444, 1175, 72, 1),
(445, 1176, 53, 1),
(446, 1176, 31, 1),
(447, 1177, 50, 1),
(448, 1177, 9, 3),
(449, 1177, 44, 1),
(450, 1177, 27, 1),
(451, 1177, 76, 2),
(452, 1178, 10, 2),
(453, 1179, 63, 1),
(454, 1179, 15, 1),
(455, 1179, 76, 1),
(456, 1180, 40, 1),
(457, 1180, 52, 1),
(458, 1181, 49, 1),
(459, 1181, 42, 1),
(460, 1181, 64, 1),
(461, 1182, 75, 3),
(462, 1183, 1, 1),
(463, 1183, 19, 1),
(464, 1183, 20, 1),
(465, 1184, 27, 1),
(466, 1184, 41, 2),
(467, 1185, 56, 1),
(468, 1185, 45, 1),
(469, 1185, 12, 1),
(470, 1186, 38, 3),
(471, 1186, 8, 3),
(472, 1186, 48, 1),
(473, 1187, 46, 2),
(474, 1187, 15, 2),
(475, 1188, 76, 1),
(476, 1189, 49, 1),
(477, 1189, 52, 1),
(478, 1190, 61, 1),
(479, 1190, 18, 2),
(480, 1190, 25, 1),
(481, 1191, 37, 1),
(482, 1191, 17, 1),
(483, 1192, 63, 2),
(484, 1193, 18, 3),
(485, 1193, 11, 1),
(486, 1193, 54, 1),
(487, 1193, 59, 1),
(488, 1193, 78, 2),
(489, 1194, 29, 1),
(490, 1194, 24, 1),
(491, 1195, 31, 1),
(492, 1195, 65, 3),
(493, 1196, 5, 1),
(494, 1196, 73, 1),
(495, 1197, 11, 2),
(496, 1197, 19, 1),
(497, 1198, 36, 1),
(498, 1198, 60, 1),
(499, 1198, 67, 1),
(500, 1198, 11, 1),
(501, 1199, 10, 1),
(502, 1199, 70, 1),
(503, 1199, 75, 1),
(504, 1200, 61, 3),
(505, 1200, 59, 1),
(506, 1200, 66, 1),
(507, 1201, 38, 1),
(508, 1201, 22, 3),
(509, 1202, 73, 1),
(510, 1202, 34, 1),
(511, 1202, 8, 1),
(512, 1203, 38, 1),
(513, 1203, 80, 1),
(514, 1203, 4, 1),
(515, 1204, 36, 1),
(516, 1204, 33, 2),
(517, 1204, 17, 1),
(518, 1204, 79, 1),
(519, 1205, 76, 2),
(520, 1206, 48, 2),
(521, 1206, 23, 1),
(522, 1206, 34, 1),
(523, 1207, 5, 3),
(524, 1207, 44, 3),
(525, 1208, 20, 2),
(526, 1208, 64, 1),
(527, 1209, 57, 1),
(528, 1209, 22, 2),
(529, 1210, 34, 1),
(530, 1210, 15, 1),
(531, 1211, 61, 1),
(532, 1211, 69, 2),
(533, 1212, 34, 1),
(534, 1212, 19, 1),
(535, 1213, 58, 2),
(536, 1213, 49, 3),
(537, 1214, 6, 1),
(538, 1214, 13, 3),
(539, 1214, 69, 1),
(540, 1215, 35, 2),
(541, 1215, 43, 1),
(542, 1215, 13, 2),
(543, 1215, 33, 2),
(544, 1216, 76, 1),
(545, 1216, 25, 2),
(546, 1216, 67, 1),
(547, 1217, 2, 1),
(548, 1217, 9, 1),
(549, 1218, 58, 1),
(550, 1219, 33, 1),
(551, 1219, 25, 1),
(552, 1219, 5, 3),
(553, 1220, 28, 2),
(554, 1220, 77, 1),
(555, 1220, 16, 2),
(556, 1221, 73, 2),
(557, 1222, 15, 2),
(558, 1223, 60, 1),
(559, 1223, 10, 3),
(560, 1224, 55, 1),
(561, 1224, 42, 2),
(562, 1225, 8, 1),
(563, 1225, 49, 3),
(564, 1226, 34, 1),
(565, 1226, 23, 1),
(566, 1227, 79, 1),
(567, 1227, 51, 1),
(568, 1227, 23, 1),
(569, 1227, 63, 1),
(570, 1228, 57, 2),
(571, 1229, 10, 1),
(572, 1230, 58, 1);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(573, 1230, 3, 1),
(574, 1230, 64, 3),
(575, 1231, 35, 3),
(576, 1231, 20, 1),
(577, 1231, 43, 1),
(578, 1232, 63, 2),
(579, 1232, 62, 2),
(580, 1232, 56, 2),
(581, 1232, 52, 1),
(582, 1233, 62, 1),
(583, 1234, 46, 2),
(584, 1234, 43, 1),
(585, 1235, 12, 2),
(586, 1235, 47, 1),
(587, 1235, 69, 2),
(588, 1236, 38, 1),
(589, 1236, 26, 3),
(590, 1236, 23, 2),
(591, 1237, 50, 1),
(592, 1237, 14, 1),
(593, 1238, 57, 2),
(594, 1239, 25, 1),
(595, 1240, 31, 1),
(596, 1240, 63, 1),
(597, 1240, 50, 3),
(598, 1240, 9, 2),
(599, 1240, 70, 3),
(600, 1241, 44, 1),
(601, 1242, 6, 1),
(602, 1242, 52, 2),
(603, 1242, 16, 1),
(604, 1243, 69, 3),
(605, 1243, 20, 1),
(606, 1243, 75, 1),
(607, 1243, 30, 2),
(608, 1244, 80, 1),
(609, 1244, 6, 1),
(610, 1245, 7, 3),
(611, 1246, 13, 1),
(612, 1246, 59, 1),
(613, 1246, 79, 2),
(614, 1247, 64, 1),
(615, 1248, 9, 1),
(616, 1248, 26, 2),
(617, 1248, 55, 2),
(618, 1249, 16, 1),
(619, 1249, 74, 1),
(620, 1250, 28, 1),
(621, 1250, 6, 1),
(622, 1250, 76, 2),
(623, 1250, 23, 1),
(624, 1250, 43, 1),
(625, 1251, 32, 3),
(626, 1252, 13, 2),
(627, 1253, 49, 2),
(628, 1253, 21, 1),
(629, 1253, 3, 1),
(630, 1254, 76, 2),
(631, 1254, 37, 1),
(632, 1254, 54, 1),
(633, 1254, 61, 1),
(634, 1255, 23, 2),
(635, 1255, 79, 1),
(636, 1256, 79, 1),
(637, 1256, 12, 1),
(638, 1256, 39, 1),
(639, 1257, 68, 3),
(640, 1258, 70, 1),
(641, 1258, 65, 1),
(642, 1258, 29, 1),
(643, 1259, 15, 2),
(644, 1260, 61, 1),
(645, 1260, 64, 3),
(646, 1260, 23, 1),
(647, 1261, 27, 1),
(648, 1261, 56, 1),
(649, 1262, 59, 3),
(650, 1262, 6, 1),
(651, 1262, 14, 2),
(652, 1262, 7, 1),
(653, 1263, 31, 2),
(654, 1264, 42, 1),
(655, 1264, 54, 2),
(656, 1265, 15, 1),
(657, 1265, 42, 1),
(658, 1266, 26, 2),
(659, 1266, 49, 1),
(660, 1267, 7, 1),
(661, 1267, 56, 3),
(662, 1268, 50, 1),
(663, 1268, 48, 2),
(664, 1269, 35, 1),
(665, 1269, 26, 2),
(666, 1269, 43, 1),
(667, 1270, 60, 1),
(668, 1271, 44, 1),
(669, 1272, 21, 3),
(670, 1272, 79, 1),
(671, 1273, 30, 1),
(672, 1273, 12, 1),
(673, 1274, 28, 1),
(674, 1274, 76, 2),
(675, 1274, 61, 2),
(676, 1274, 60, 1),
(677, 1275, 75, 2),
(678, 1275, 29, 1),
(679, 1276, 74, 2),
(680, 1277, 6, 2),
(681, 1277, 61, 1),
(682, 1278, 51, 2),
(683, 1278, 62, 2),
(684, 1279, 64, 1),
(685, 1280, 2, 3),
(686, 1280, 53, 1),
(687, 1281, 12, 1),
(688, 1281, 3, 1),
(689, 1282, 74, 3),
(690, 1282, 75, 1),
(691, 1282, 4, 1),
(692, 1283, 24, 2),
(693, 1283, 48, 1),
(694, 1283, 60, 1),
(695, 1284, 43, 1),
(696, 1284, 68, 1),
(697, 1285, 79, 1),
(698, 1285, 70, 1),
(699, 1286, 80, 1),
(700, 1286, 43, 3),
(701, 1286, 8, 1),
(702, 1287, 50, 1),
(703, 1288, 47, 2),
(704, 1288, 23, 1),
(705, 1288, 72, 2),
(706, 1289, 43, 1),
(707, 1290, 62, 2),
(708, 1291, 27, 1),
(709, 1291, 29, 1),
(710, 1291, 42, 2),
(711, 1292, 9, 1),
(712, 1292, 48, 1),
(713, 1293, 16, 2),
(714, 1293, 61, 2),
(715, 1294, 38, 1),
(716, 1294, 58, 2),
(717, 1295, 9, 1),
(718, 1295, 25, 2),
(719, 1295, 59, 1),
(720, 1295, 12, 3),
(721, 1296, 36, 1),
(722, 1297, 20, 2);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(723, 1298, 3, 1),
(724, 1298, 38, 2),
(725, 1299, 61, 2),
(726, 1299, 45, 1),
(727, 1299, 54, 1),
(728, 1299, 57, 1),
(729, 1300, 67, 1),
(730, 1300, 43, 2),
(731, 1300, 53, 2),
(732, 1301, 68, 1),
(733, 1301, 71, 1),
(734, 1302, 40, 1),
(735, 1303, 62, 3),
(736, 1303, 48, 2),
(737, 1304, 46, 1),
(738, 1305, 80, 3),
(739, 1305, 21, 2),
(740, 1305, 69, 2),
(741, 1305, 37, 2),
(742, 1305, 24, 1),
(743, 1306, 6, 3),
(744, 1307, 57, 1),
(745, 1307, 34, 1),
(746, 1308, 41, 1),
(747, 1308, 45, 1),
(748, 1308, 19, 1),
(749, 1309, 4, 3),
(750, 1309, 52, 2),
(751, 1310, 41, 3),
(752, 1310, 20, 1),
(753, 1310, 1, 2),
(754, 1310, 70, 1),
(755, 1311, 74, 2),
(756, 1311, 19, 2),
(757, 1312, 44, 1),
(758, 1312, 15, 1),
(759, 1312, 62, 1),
(760, 1312, 6, 1),
(761, 1313, 58, 1),
(762, 1313, 46, 1),
(763, 1313, 12, 1),
(764, 1314, 36, 1),
(765, 1314, 26, 1),
(766, 1315, 12, 1),
(767, 1315, 66, 1),
(768, 1316, 66, 1),
(769, 1316, 8, 2),
(770, 1316, 47, 1),
(771, 1317, 2, 1),
(772, 1317, 37, 1),
(773, 1318, 72, 1),
(774, 1318, 12, 2),
(775, 1319, 54, 1),
(776, 1319, 57, 2),
(777, 1319, 37, 2),
(778, 1320, 54, 1),
(779, 1320, 18, 1),
(780, 1320, 76, 1),
(781, 1321, 68, 1),
(782, 1321, 43, 1),
(783, 1321, 9, 3),
(784, 1321, 76, 1),
(785, 1321, 49, 1),
(786, 1322, 18, 2),
(787, 1322, 26, 1),
(788, 1322, 24, 1),
(789, 1323, 39, 1),
(790, 1323, 75, 1),
(791, 1323, 64, 1),
(792, 1324, 34, 1),
(793, 1325, 61, 1),
(794, 1325, 16, 1),
(795, 1325, 37, 2),
(796, 1326, 16, 2),
(797, 1327, 9, 2),
(798, 1327, 77, 1),
(799, 1328, 34, 3),
(800, 1328, 61, 2),
(801, 1329, 74, 2),
(802, 1329, 3, 1),
(803, 1330, 41, 1),
(804, 1331, 46, 1),
(805, 1331, 21, 1),
(806, 1331, 7, 3),
(807, 1332, 38, 1),
(808, 1332, 68, 1),
(809, 1333, 24, 2),
(810, 1334, 22, 1),
(811, 1334, 70, 1),
(812, 1335, 39, 1),
(813, 1335, 35, 1),
(814, 1335, 47, 2),
(815, 1336, 67, 1),
(816, 1337, 53, 1),
(817, 1337, 44, 1),
(818, 1337, 21, 1),
(819, 1338, 72, 1),
(820, 1339, 68, 2),
(821, 1339, 69, 2),
(822, 1339, 71, 1),
(823, 1340, 15, 1),
(824, 1340, 17, 2),
(825, 1340, 3, 1),
(826, 1340, 62, 1),
(827, 1341, 67, 2),
(828, 1341, 44, 1),
(829, 1341, 23, 1),
(830, 1341, 39, 2),
(831, 1341, 4, 2),
(832, 1342, 27, 3),
(833, 1342, 17, 1),
(834, 1343, 15, 2),
(835, 1343, 10, 2),
(836, 1343, 3, 1),
(837, 1344, 66, 1),
(838, 1345, 33, 1),
(839, 1345, 6, 2),
(840, 1346, 16, 1),
(841, 1346, 78, 1),
(842, 1346, 27, 2),
(843, 1347, 19, 2),
(844, 1348, 75, 2),
(845, 1348, 45, 2),
(846, 1348, 46, 1),
(847, 1348, 21, 1),
(848, 1349, 75, 2),
(849, 1350, 25, 1),
(850, 1350, 37, 2),
(851, 1351, 13, 3),
(852, 1352, 61, 1),
(853, 1352, 47, 3),
(854, 1352, 76, 1),
(855, 1352, 24, 1),
(856, 1353, 28, 1),
(857, 1353, 66, 1),
(858, 1354, 16, 1),
(859, 1354, 60, 1),
(860, 1354, 15, 1),
(861, 1354, 67, 2),
(862, 1354, 18, 1),
(863, 1355, 50, 1),
(864, 1355, 37, 2),
(865, 1356, 57, 1),
(866, 1356, 29, 3),
(867, 1356, 71, 1),
(868, 1357, 61, 3),
(869, 1357, 48, 1),
(870, 1357, 23, 1),
(871, 1357, 2, 1),
(872, 1358, 11, 1);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(873, 1358, 16, 2),
(874, 1358, 19, 3),
(875, 1359, 22, 3),
(876, 1359, 9, 1),
(877, 1359, 47, 1),
(878, 1360, 16, 2),
(879, 1360, 30, 2),
(880, 1360, 55, 1),
(881, 1360, 64, 2),
(882, 1360, 36, 2),
(883, 1361, 46, 3),
(884, 1361, 61, 1),
(885, 1361, 78, 1),
(886, 1361, 52, 1),
(887, 1362, 63, 1),
(888, 1363, 18, 2),
(889, 1363, 4, 2),
(890, 1363, 13, 1),
(891, 1364, 23, 1),
(892, 1365, 20, 1),
(893, 1365, 39, 2),
(894, 1365, 80, 2),
(895, 1366, 64, 1),
(896, 1366, 60, 2),
(897, 1367, 34, 1),
(898, 1367, 70, 2),
(899, 1368, 5, 2),
(900, 1368, 56, 1),
(901, 1369, 49, 1),
(902, 1369, 57, 1),
(903, 1370, 39, 1),
(904, 1370, 22, 1),
(905, 1371, 63, 2),
(906, 1371, 15, 2),
(907, 1371, 73, 2),
(908, 1372, 61, 2),
(909, 1372, 72, 1),
(910, 1373, 64, 3),
(911, 1373, 76, 1),
(912, 1374, 37, 1),
(913, 1374, 42, 1),
(914, 1375, 47, 1),
(915, 1376, 4, 1),
(916, 1376, 44, 1),
(917, 1376, 49, 1),
(918, 1377, 32, 1),
(919, 1377, 31, 1),
(920, 1378, 9, 1),
(921, 1378, 40, 1),
(922, 1378, 15, 1),
(923, 1378, 44, 2),
(924, 1379, 66, 1),
(925, 1379, 54, 2),
(926, 1380, 41, 1),
(927, 1380, 49, 1),
(928, 1381, 63, 1),
(929, 1382, 44, 2),
(930, 1382, 64, 2),
(931, 1382, 65, 1),
(932, 1383, 56, 1),
(933, 1383, 26, 2),
(934, 1384, 69, 1),
(935, 1384, 28, 1),
(936, 1384, 37, 1),
(937, 1385, 80, 1),
(938, 1385, 12, 1),
(939, 1385, 75, 1),
(940, 1386, 61, 1),
(941, 1386, 55, 1),
(942, 1386, 27, 2),
(943, 1387, 39, 2),
(944, 1387, 56, 1),
(945, 1388, 33, 1),
(946, 1388, 80, 2),
(947, 1389, 3, 2),
(948, 1389, 67, 1),
(949, 1390, 60, 1),
(950, 1391, 79, 2),
(951, 1391, 56, 1),
(952, 1391, 73, 1),
(953, 1392, 31, 2),
(954, 1392, 20, 2),
(955, 1393, 53, 1),
(956, 1393, 41, 2),
(957, 1393, 9, 1),
(958, 1394, 21, 2),
(959, 1394, 33, 1),
(960, 1395, 20, 1),
(961, 1396, 40, 1),
(962, 1397, 56, 1),
(963, 1397, 55, 1),
(964, 1398, 18, 1),
(965, 1399, 36, 1),
(966, 1399, 71, 1),
(967, 1399, 23, 2),
(968, 1400, 8, 1),
(969, 1400, 11, 2),
(970, 1400, 41, 3),
(971, 1401, 47, 1),
(972, 1401, 12, 2),
(973, 1402, 31, 2),
(974, 1402, 15, 3),
(975, 1402, 74, 1),
(976, 1403, 68, 2),
(977, 1403, 33, 1),
(978, 1403, 64, 1),
(979, 1404, 43, 2),
(980, 1404, 75, 2),
(981, 1404, 50, 3),
(982, 1405, 14, 1),
(983, 1406, 57, 1),
(984, 1406, 53, 1),
(985, 1406, 33, 3),
(986, 1406, 76, 1),
(987, 1406, 8, 1),
(988, 1407, 36, 1),
(989, 1407, 19, 1),
(990, 1407, 47, 1),
(991, 1408, 78, 2),
(992, 1408, 5, 2),
(993, 1408, 7, 1),
(994, 1409, 40, 3),
(995, 1409, 47, 2),
(996, 1410, 31, 1),
(997, 1410, 57, 3),
(998, 1411, 33, 1),
(999, 1411, 39, 2),
(1000, 1412, 27, 2),
(1001, 1413, 57, 1),
(1002, 1414, 53, 2),
(1003, 1414, 5, 3),
(1004, 1414, 36, 1),
(1005, 1414, 11, 1),
(1006, 1415, 55, 2),
(1007, 1415, 13, 1),
(1008, 1415, 21, 1),
(1009, 1416, 71, 2),
(1010, 1416, 42, 2),
(1011, 1416, 59, 1),
(1012, 1417, 57, 2),
(1013, 1418, 52, 1),
(1014, 1419, 74, 1),
(1015, 1419, 11, 1),
(1016, 1420, 17, 2),
(1017, 1420, 77, 1),
(1018, 1420, 53, 1),
(1019, 1421, 34, 2),
(1020, 1421, 23, 2),
(1021, 1421, 76, 1),
(1022, 1422, 24, 2);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(1023, 1422, 51, 3),
(1024, 1423, 29, 1),
(1025, 1423, 3, 3),
(1026, 1423, 72, 3),
(1027, 1423, 79, 1),
(1028, 1424, 22, 1),
(1029, 1424, 7, 1),
(1030, 1424, 52, 1),
(1031, 1425, 22, 1),
(1032, 1425, 73, 3),
(1033, 1425, 16, 1),
(1034, 1425, 2, 2),
(1035, 1425, 68, 1),
(1036, 1426, 25, 2),
(1037, 1426, 35, 1),
(1038, 1426, 37, 1),
(1039, 1427, 28, 3),
(1040, 1428, 25, 1),
(1041, 1428, 54, 2),
(1042, 1429, 34, 1),
(1043, 1430, 32, 1),
(1044, 1430, 48, 1),
(1045, 1431, 61, 1),
(1046, 1432, 51, 2),
(1047, 1432, 28, 2),
(1048, 1433, 33, 1),
(1049, 1433, 10, 1),
(1050, 1433, 13, 3),
(1051, 1434, 46, 3),
(1052, 1434, 78, 3),
(1053, 1435, 6, 1),
(1054, 1435, 1, 1),
(1055, 1436, 51, 1),
(1056, 1436, 48, 2),
(1057, 1437, 23, 1),
(1058, 1438, 44, 1),
(1059, 1438, 60, 1),
(1060, 1439, 19, 1),
(1061, 1439, 34, 1),
(1062, 1440, 36, 2),
(1063, 1441, 37, 1),
(1064, 1441, 34, 2),
(1065, 1441, 79, 1),
(1066, 1441, 67, 3),
(1067, 1442, 20, 1),
(1068, 1442, 72, 1),
(1069, 1442, 57, 1),
(1070, 1443, 34, 1),
(1071, 1444, 15, 1),
(1072, 1444, 64, 1),
(1073, 1445, 63, 1),
(1074, 1445, 59, 2),
(1075, 1445, 64, 1),
(1076, 1446, 27, 1),
(1077, 1446, 37, 1),
(1078, 1447, 35, 2),
(1079, 1447, 73, 1),
(1080, 1448, 1, 2),
(1081, 1448, 68, 1),
(1082, 1449, 32, 1),
(1083, 1449, 64, 2),
(1084, 1449, 13, 2),
(1085, 1449, 43, 1),
(1086, 1450, 14, 1),
(1087, 1450, 42, 1),
(1088, 1451, 62, 1),
(1089, 1451, 59, 1),
(1090, 1451, 35, 3),
(1091, 1452, 58, 1),
(1092, 1452, 42, 2),
(1093, 1452, 73, 2),
(1094, 1453, 8, 1),
(1095, 1453, 10, 1),
(1096, 1454, 33, 1),
(1097, 1455, 52, 1),
(1098, 1455, 12, 1),
(1099, 1455, 3, 1),
(1100, 1455, 27, 3),
(1101, 1455, 21, 1),
(1102, 1456, 56, 3),
(1103, 1456, 40, 1),
(1104, 1457, 13, 1),
(1105, 1457, 48, 1),
(1106, 1458, 61, 1),
(1107, 1458, 35, 2),
(1108, 1458, 73, 2),
(1109, 1458, 77, 1),
(1110, 1459, 55, 1),
(1111, 1459, 12, 1),
(1112, 1460, 29, 3),
(1113, 1460, 20, 1),
(1114, 1461, 11, 1),
(1115, 1461, 38, 3),
(1116, 1461, 60, 1),
(1117, 1462, 17, 2),
(1118, 1463, 32, 1),
(1119, 1463, 67, 1),
(1120, 1464, 6, 1),
(1121, 1464, 66, 1),
(1122, 1465, 73, 2),
(1123, 1466, 75, 2),
(1124, 1466, 11, 1),
(1125, 1467, 60, 2),
(1126, 1467, 23, 1),
(1127, 1467, 24, 1),
(1128, 1468, 41, 2),
(1129, 1468, 76, 1),
(1130, 1468, 59, 2),
(1131, 1469, 24, 1),
(1132, 1469, 28, 2),
(1133, 1470, 14, 1),
(1134, 1470, 56, 1),
(1135, 1470, 69, 1),
(1136, 1471, 59, 2),
(1137, 1471, 52, 1),
(1138, 1471, 78, 2),
(1139, 1472, 51, 1),
(1140, 1472, 39, 1),
(1141, 1472, 12, 1),
(1142, 1473, 25, 2),
(1143, 1474, 19, 1),
(1144, 1475, 69, 1),
(1145, 1475, 25, 2),
(1146, 1476, 55, 1),
(1147, 1477, 20, 2),
(1148, 1478, 63, 1),
(1149, 1478, 61, 1),
(1150, 1479, 38, 1),
(1151, 1480, 7, 1),
(1152, 1480, 43, 2),
(1153, 1480, 2, 1),
(1154, 1481, 64, 1),
(1155, 1481, 75, 1),
(1156, 1482, 63, 1),
(1157, 1482, 52, 1),
(1158, 1483, 63, 1),
(1159, 1483, 30, 1),
(1160, 1483, 8, 1),
(1161, 1484, 54, 2),
(1162, 1485, 80, 3),
(1163, 1486, 56, 1),
(1164, 1486, 3, 2),
(1165, 1487, 57, 1),
(1166, 1487, 30, 1),
(1167, 1488, 78, 2),
(1168, 1488, 60, 2),
(1169, 1488, 17, 1),
(1170, 1489, 47, 2),
(1171, 1489, 61, 2),
(1172, 1490, 37, 1);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(1173, 1490, 12, 1),
(1174, 1490, 62, 1),
(1175, 1491, 54, 3),
(1176, 1492, 31, 1),
(1177, 1492, 27, 3),
(1178, 1493, 34, 2),
(1179, 1493, 46, 1),
(1180, 1494, 65, 1),
(1181, 1494, 5, 1),
(1182, 1494, 9, 1),
(1183, 1494, 44, 1),
(1184, 1495, 44, 2),
(1185, 1495, 46, 2),
(1186, 1496, 20, 1),
(1187, 1496, 66, 1),
(1188, 1497, 57, 2),
(1189, 1498, 15, 1),
(1190, 1498, 14, 1),
(1191, 1498, 79, 1),
(1192, 1498, 72, 1),
(1193, 1498, 6, 1),
(1194, 1499, 57, 2),
(1195, 1499, 65, 1),
(1196, 1499, 64, 1),
(1197, 1500, 18, 2),
(1198, 1500, 16, 1),
(1199, 1501, 1, 2),
(1200, 1501, 32, 1),
(1201, 1502, 22, 1),
(1202, 1502, 11, 2),
(1203, 1503, 32, 2),
(1204, 1503, 20, 1),
(1205, 1504, 18, 3),
(1206, 1504, 55, 2),
(1207, 1504, 53, 3),
(1208, 1505, 47, 1),
(1209, 1505, 4, 2),
(1210, 1506, 67, 1),
(1211, 1506, 9, 1),
(1212, 1506, 11, 2),
(1213, 1507, 51, 2),
(1214, 1507, 5, 1),
(1215, 1508, 8, 1),
(1216, 1508, 67, 2),
(1217, 1508, 38, 1),
(1218, 1508, 54, 1),
(1219, 1509, 45, 3),
(1220, 1509, 2, 1),
(1221, 1509, 36, 1),
(1222, 1510, 27, 1),
(1223, 1510, 70, 1),
(1224, 1511, 45, 2),
(1225, 1511, 52, 2),
(1226, 1512, 69, 1),
(1227, 1513, 17, 1),
(1228, 1513, 67, 1),
(1229, 1513, 70, 1),
(1230, 1514, 21, 1),
(1231, 1514, 3, 2),
(1232, 1515, 31, 2),
(1233, 1515, 39, 3),
(1234, 1516, 8, 2),
(1235, 1517, 65, 1),
(1236, 1517, 46, 2),
(1237, 1518, 58, 1),
(1238, 1518, 39, 3),
(1239, 1518, 74, 2),
(1240, 1518, 1, 3),
(1241, 1519, 69, 1),
(1242, 1519, 77, 1),
(1243, 1520, 74, 1),
(1244, 1520, 18, 1),
(1245, 1520, 49, 1),
(1246, 1521, 47, 1),
(1247, 1521, 59, 2),
(1248, 1522, 11, 1),
(1249, 1522, 12, 1),
(1250, 1522, 8, 1),
(1251, 1523, 68, 1),
(1252, 1524, 51, 1),
(1253, 1524, 34, 1),
(1254, 1525, 63, 1),
(1255, 1525, 54, 2),
(1256, 1525, 21, 1),
(1257, 1525, 19, 2),
(1258, 1525, 65, 2),
(1259, 1526, 28, 1),
(1260, 1527, 21, 3),
(1261, 1528, 16, 2),
(1262, 1528, 78, 1),
(1263, 1529, 38, 1),
(1264, 1529, 6, 1),
(1265, 1530, 48, 1),
(1266, 1530, 39, 1),
(1267, 1531, 76, 1),
(1268, 1532, 40, 2),
(1269, 1532, 37, 1),
(1270, 1532, 28, 1),
(1271, 1532, 24, 1),
(1272, 1533, 54, 1),
(1273, 1533, 62, 3),
(1274, 1533, 74, 2),
(1275, 1533, 40, 1),
(1276, 1534, 78, 1),
(1277, 1534, 17, 1),
(1278, 1534, 18, 1),
(1279, 1535, 42, 2),
(1280, 1535, 12, 2),
(1281, 1536, 30, 1),
(1282, 1536, 51, 1),
(1283, 1537, 57, 2),
(1284, 1537, 36, 2),
(1285, 1537, 12, 1),
(1286, 1538, 40, 1),
(1287, 1538, 72, 1),
(1288, 1538, 16, 3),
(1289, 1539, 7, 1),
(1290, 1539, 73, 2),
(1291, 1540, 3, 2),
(1292, 1540, 16, 1),
(1293, 1541, 36, 1),
(1294, 1541, 27, 1),
(1295, 1541, 32, 1),
(1296, 1541, 75, 1),
(1297, 1541, 57, 1),
(1298, 1542, 44, 1),
(1299, 1542, 56, 1),
(1300, 1542, 24, 1),
(1301, 1542, 54, 1),
(1302, 1543, 70, 1),
(1303, 1543, 22, 1),
(1304, 1543, 37, 1),
(1305, 1543, 19, 1),
(1306, 1543, 24, 1),
(1307, 1544, 42, 2),
(1308, 1544, 24, 1),
(1309, 1544, 4, 1),
(1310, 1545, 42, 1),
(1311, 1546, 16, 2),
(1312, 1546, 7, 1),
(1313, 1546, 26, 1),
(1314, 1546, 31, 2),
(1315, 1547, 15, 1),
(1316, 1547, 35, 1),
(1317, 1548, 62, 1),
(1318, 1548, 4, 1),
(1319, 1549, 35, 1),
(1320, 1549, 71, 1),
(1321, 1549, 76, 2),
(1322, 1549, 13, 1);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(1323, 1550, 11, 1),
(1324, 1550, 65, 3),
(1325, 1551, 22, 1),
(1326, 1551, 32, 1),
(1327, 1552, 58, 3),
(1328, 1552, 6, 1),
(1329, 1552, 1, 2),
(1330, 1552, 60, 1),
(1331, 1553, 62, 1),
(1332, 1554, 49, 2),
(1333, 1554, 45, 1),
(1334, 1555, 37, 2),
(1335, 1555, 6, 1),
(1336, 1555, 21, 1),
(1337, 1556, 16, 2),
(1338, 1556, 18, 3),
(1339, 1557, 27, 2),
(1340, 1557, 79, 3),
(1341, 1557, 65, 1),
(1342, 1557, 41, 3),
(1343, 1558, 35, 1),
(1344, 1558, 32, 1),
(1345, 1558, 42, 1),
(1346, 1559, 18, 1),
(1347, 1560, 61, 1),
(1348, 1561, 23, 1),
(1349, 1562, 63, 2),
(1350, 1562, 51, 1),
(1351, 1562, 69, 1),
(1352, 1562, 11, 1),
(1353, 1563, 57, 3),
(1354, 1563, 16, 1),
(1355, 1563, 46, 1),
(1356, 1564, 2, 1),
(1357, 1564, 16, 3),
(1358, 1565, 29, 2),
(1359, 1565, 3, 2),
(1360, 1566, 25, 1),
(1361, 1566, 12, 2),
(1362, 1566, 79, 1),
(1363, 1567, 47, 1),
(1364, 1567, 5, 1),
(1365, 1567, 36, 2),
(1366, 1567, 64, 1),
(1367, 1567, 78, 2),
(1368, 1568, 64, 1),
(1369, 1568, 22, 2),
(1370, 1569, 78, 1),
(1371, 1569, 73, 1),
(1372, 1570, 17, 2),
(1373, 1570, 34, 2),
(1374, 1570, 73, 2),
(1375, 1571, 3, 1),
(1376, 1571, 69, 2),
(1377, 1572, 1, 1),
(1378, 1572, 55, 3),
(1379, 1572, 7, 1),
(1380, 1572, 42, 2),
(1381, 1573, 47, 2),
(1382, 1573, 67, 2),
(1383, 1574, 36, 3),
(1384, 1575, 41, 1),
(1385, 1575, 1, 1),
(1386, 1576, 4, 3),
(1387, 1576, 29, 1),
(1388, 1576, 55, 1),
(1389, 1576, 10, 1),
(1390, 1577, 4, 2),
(1391, 1577, 62, 1),
(1392, 1577, 56, 1),
(1393, 1578, 33, 1),
(1394, 1578, 32, 1),
(1395, 1579, 7, 1),
(1396, 1579, 43, 1),
(1397, 1580, 77, 1),
(1398, 1581, 58, 1),
(1399, 1581, 75, 1),
(1400, 1581, 16, 1),
(1401, 1582, 9, 1),
(1402, 1582, 17, 2),
(1403, 1583, 79, 1),
(1404, 1584, 8, 1),
(1405, 1585, 49, 1),
(1406, 1585, 52, 2),
(1407, 1586, 77, 2),
(1408, 1587, 59, 2),
(1409, 1587, 50, 2),
(1410, 1587, 60, 1),
(1411, 1588, 4, 1),
(1412, 1588, 59, 1),
(1413, 1589, 2, 1),
(1414, 1590, 25, 3),
(1415, 1591, 66, 1),
(1416, 1592, 80, 1),
(1417, 1592, 57, 1),
(1418, 1593, 17, 1),
(1419, 1594, 46, 1),
(1420, 1594, 40, 1),
(1421, 1595, 61, 1),
(1422, 1596, 48, 1),
(1423, 1596, 2, 2),
(1424, 1597, 31, 1),
(1425, 1598, 7, 1),
(1426, 1598, 55, 1),
(1427, 1598, 45, 3),
(1428, 1599, 44, 2),
(1429, 1599, 25, 3),
(1430, 1599, 61, 1),
(1431, 1600, 75, 3),
(1432, 1600, 73, 1),
(1433, 1601, 21, 1),
(1434, 1601, 14, 2),
(1435, 1602, 29, 3),
(1436, 1603, 30, 1),
(1437, 1603, 60, 1),
(1438, 1603, 80, 2),
(1439, 1604, 49, 1),
(1440, 1604, 27, 3),
(1441, 1604, 52, 1),
(1442, 1605, 4, 1);
GO

-- ============================================================
--  SECTION 5 : NEW PAYMENTS (IDs 2106–2605)
--  Logic: Completed→Success, Cancelled→Failed, Pending→Pending
--  City-aware payment method distribution
-- ============================================================

INSERT INTO payments (payment_id, order_id, payment_method, payment_status) VALUES
(2106, 1106, 'UPI', 'Success'),
(2107, 1107, 'COD', 'Success'),
(2108, 1108, 'Card', 'Failed'),
(2109, 1109, 'UPI', 'Success'),
(2110, 1110, 'UPI', 'Success'),
(2111, 1111, 'UPI', 'Success'),
(2112, 1112, 'Card', 'Success'),
(2113, 1113, 'Card', 'Pending'),
(2114, 1114, 'UPI', 'Success'),
(2115, 1115, 'UPI', 'Pending'),
(2116, 1116, 'Card', 'Success'),
(2117, 1117, 'UPI', 'Success'),
(2118, 1118, 'UPI', 'Success'),
(2119, 1119, 'UPI', 'Failed'),
(2120, 1120, 'Card', 'Success'),
(2121, 1121, 'COD', 'Success'),
(2122, 1122, 'UPI', 'Success'),
(2123, 1123, 'UPI', 'Success'),
(2124, 1124, 'COD', 'Pending'),
(2125, 1125, 'UPI', 'Pending'),
(2126, 1126, 'COD', 'Success'),
(2127, 1127, 'Card', 'Success'),
(2128, 1128, 'COD', 'Pending'),
(2129, 1129, 'UPI', 'Success'),
(2130, 1130, 'Card', 'Success'),
(2131, 1131, 'UPI', 'Success'),
(2132, 1132, 'COD', 'Failed'),
(2133, 1133, 'COD', 'Success'),
(2134, 1134, 'COD', 'Success'),
(2135, 1135, 'UPI', 'Pending'),
(2136, 1136, 'Card', 'Success'),
(2137, 1137, 'UPI', 'Success'),
(2138, 1138, 'UPI', 'Failed'),
(2139, 1139, 'Card', 'Failed'),
(2140, 1140, 'COD', 'Success'),
(2141, 1141, 'COD', 'Success'),
(2142, 1142, 'Card', 'Pending'),
(2143, 1143, 'UPI', 'Success'),
(2144, 1144, 'Card', 'Success'),
(2145, 1145, 'UPI', 'Success'),
(2146, 1146, 'Card', 'Success'),
(2147, 1147, 'Card', 'Success'),
(2148, 1148, 'UPI', 'Success'),
(2149, 1149, 'UPI', 'Failed'),
(2150, 1150, 'UPI', 'Success'),
(2151, 1151, 'COD', 'Pending'),
(2152, 1152, 'Card', 'Success'),
(2153, 1153, 'UPI', 'Success'),
(2154, 1154, 'UPI', 'Success'),
(2155, 1155, 'COD', 'Failed'),
(2156, 1156, 'Card', 'Failed'),
(2157, 1157, 'UPI', 'Pending'),
(2158, 1158, 'COD', 'Success'),
(2159, 1159, 'Card', 'Success'),
(2160, 1160, 'UPI', 'Success'),
(2161, 1161, 'COD', 'Success'),
(2162, 1162, 'Card', 'Success'),
(2163, 1163, 'COD', 'Success'),
(2164, 1164, 'Card', 'Pending'),
(2165, 1165, 'Card', 'Success'),
(2166, 1166, 'Card', 'Success'),
(2167, 1167, 'COD', 'Success'),
(2168, 1168, 'COD', 'Failed'),
(2169, 1169, 'UPI', 'Failed'),
(2170, 1170, 'Card', 'Success'),
(2171, 1171, 'Card', 'Success'),
(2172, 1172, 'COD', 'Pending'),
(2173, 1173, 'Card', 'Success'),
(2174, 1174, 'UPI', 'Success'),
(2175, 1175, 'UPI', 'Success'),
(2176, 1176, 'COD', 'Success'),
(2177, 1177, 'COD', 'Success'),
(2178, 1178, 'UPI', 'Success'),
(2179, 1179, 'Card', 'Success'),
(2180, 1180, 'Card', 'Pending'),
(2181, 1181, 'UPI', 'Success'),
(2182, 1182, 'UPI', 'Success'),
(2183, 1183, 'UPI', 'Pending'),
(2184, 1184, 'Card', 'Success'),
(2185, 1185, 'COD', 'Success'),
(2186, 1186, 'UPI', 'Success'),
(2187, 1187, 'Card', 'Success'),
(2188, 1188, 'UPI', 'Success'),
(2189, 1189, 'COD', 'Success'),
(2190, 1190, 'UPI', 'Success'),
(2191, 1191, 'Card', 'Failed'),
(2192, 1192, 'Card', 'Success'),
(2193, 1193, 'COD', 'Success'),
(2194, 1194, 'UPI', 'Success'),
(2195, 1195, 'COD', 'Success'),
(2196, 1196, 'UPI', 'Success'),
(2197, 1197, 'UPI', 'Failed'),
(2198, 1198, 'COD', 'Success'),
(2199, 1199, 'UPI', 'Success'),
(2200, 1200, 'UPI', 'Pending'),
(2201, 1201, 'Card', 'Success'),
(2202, 1202, 'UPI', 'Failed'),
(2203, 1203, 'UPI', 'Success'),
(2204, 1204, 'UPI', 'Success'),
(2205, 1205, 'Card', 'Failed');

INSERT INTO payments (payment_id, order_id, payment_method, payment_status) VALUES
(2206, 1206, 'UPI', 'Success'),
(2207, 1207, 'Card', 'Success'),
(2208, 1208, 'COD', 'Success'),
(2209, 1209, 'COD', 'Success'),
(2210, 1210, 'UPI', 'Success'),
(2211, 1211, 'UPI', 'Success'),
(2212, 1212, 'UPI', 'Success'),
(2213, 1213, 'COD', 'Success'),
(2214, 1214, 'Card', 'Success'),
(2215, 1215, 'UPI', 'Success'),
(2216, 1216, 'COD', 'Success'),
(2217, 1217, 'COD', 'Failed'),
(2218, 1218, 'Card', 'Success'),
(2219, 1219, 'UPI', 'Success'),
(2220, 1220, 'Card', 'Failed'),
(2221, 1221, 'Card', 'Success'),
(2222, 1222, 'UPI', 'Failed'),
(2223, 1223, 'Card', 'Success'),
(2224, 1224, 'Card', 'Success'),
(2225, 1225, 'COD', 'Success'),
(2226, 1226, 'Card', 'Success'),
(2227, 1227, 'UPI', 'Success'),
(2228, 1228, 'UPI', 'Success'),
(2229, 1229, 'Card', 'Success'),
(2230, 1230, 'UPI', 'Failed'),
(2231, 1231, 'UPI', 'Success'),
(2232, 1232, 'UPI', 'Success'),
(2233, 1233, 'Card', 'Success'),
(2234, 1234, 'UPI', 'Success'),
(2235, 1235, 'Card', 'Success'),
(2236, 1236, 'Card', 'Success'),
(2237, 1237, 'UPI', 'Failed'),
(2238, 1238, 'COD', 'Failed'),
(2239, 1239, 'Card', 'Success'),
(2240, 1240, 'UPI', 'Success'),
(2241, 1241, 'UPI', 'Success'),
(2242, 1242, 'COD', 'Success'),
(2243, 1243, 'COD', 'Success'),
(2244, 1244, 'UPI', 'Success'),
(2245, 1245, 'UPI', 'Failed'),
(2246, 1246, 'Card', 'Success'),
(2247, 1247, 'COD', 'Success'),
(2248, 1248, 'COD', 'Success'),
(2249, 1249, 'Card', 'Success'),
(2250, 1250, 'UPI', 'Success'),
(2251, 1251, 'UPI', 'Success'),
(2252, 1252, 'UPI', 'Success'),
(2253, 1253, 'UPI', 'Success'),
(2254, 1254, 'Card', 'Success'),
(2255, 1255, 'COD', 'Success'),
(2256, 1256, 'UPI', 'Success'),
(2257, 1257, 'UPI', 'Failed'),
(2258, 1258, 'Card', 'Failed'),
(2259, 1259, 'UPI', 'Success'),
(2260, 1260, 'COD', 'Pending'),
(2261, 1261, 'Card', 'Success'),
(2262, 1262, 'UPI', 'Pending'),
(2263, 1263, 'COD', 'Pending'),
(2264, 1264, 'UPI', 'Success'),
(2265, 1265, 'UPI', 'Success'),
(2266, 1266, 'Card', 'Success'),
(2267, 1267, 'UPI', 'Success'),
(2268, 1268, 'UPI', 'Success'),
(2269, 1269, 'Card', 'Success'),
(2270, 1270, 'COD', 'Success'),
(2271, 1271, 'Card', 'Success'),
(2272, 1272, 'Card', 'Success'),
(2273, 1273, 'COD', 'Failed'),
(2274, 1274, 'UPI', 'Success'),
(2275, 1275, 'COD', 'Success'),
(2276, 1276, 'UPI', 'Success'),
(2277, 1277, 'UPI', 'Success'),
(2278, 1278, 'UPI', 'Success'),
(2279, 1279, 'COD', 'Success'),
(2280, 1280, 'Card', 'Success'),
(2281, 1281, 'Card', 'Success'),
(2282, 1282, 'COD', 'Success'),
(2283, 1283, 'Card', 'Failed'),
(2284, 1284, 'COD', 'Success'),
(2285, 1285, 'COD', 'Success'),
(2286, 1286, 'COD', 'Failed'),
(2287, 1287, 'COD', 'Success'),
(2288, 1288, 'UPI', 'Failed'),
(2289, 1289, 'COD', 'Success'),
(2290, 1290, 'Card', 'Success'),
(2291, 1291, 'UPI', 'Success'),
(2292, 1292, 'COD', 'Success'),
(2293, 1293, 'COD', 'Success'),
(2294, 1294, 'UPI', 'Success'),
(2295, 1295, 'COD', 'Success'),
(2296, 1296, 'Card', 'Failed'),
(2297, 1297, 'COD', 'Success'),
(2298, 1298, 'UPI', 'Failed'),
(2299, 1299, 'Card', 'Success'),
(2300, 1300, 'UPI', 'Success'),
(2301, 1301, 'UPI', 'Pending'),
(2302, 1302, 'UPI', 'Success'),
(2303, 1303, 'UPI', 'Success'),
(2304, 1304, 'COD', 'Success'),
(2305, 1305, 'COD', 'Failed');

INSERT INTO payments (payment_id, order_id, payment_method, payment_status) VALUES
(2306, 1306, 'UPI', 'Pending'),
(2307, 1307, 'UPI', 'Success'),
(2308, 1308, 'COD', 'Success'),
(2309, 1309, 'Card', 'Success'),
(2310, 1310, 'Card', 'Pending'),
(2311, 1311, 'UPI', 'Failed'),
(2312, 1312, 'UPI', 'Failed'),
(2313, 1313, 'UPI', 'Success'),
(2314, 1314, 'COD', 'Success'),
(2315, 1315, 'COD', 'Success'),
(2316, 1316, 'COD', 'Success'),
(2317, 1317, 'UPI', 'Success'),
(2318, 1318, 'UPI', 'Pending'),
(2319, 1319, 'Card', 'Success'),
(2320, 1320, 'Card', 'Success'),
(2321, 1321, 'UPI', 'Failed'),
(2322, 1322, 'COD', 'Success'),
(2323, 1323, 'UPI', 'Failed'),
(2324, 1324, 'UPI', 'Success'),
(2325, 1325, 'UPI', 'Failed'),
(2326, 1326, 'COD', 'Success'),
(2327, 1327, 'UPI', 'Success'),
(2328, 1328, 'COD', 'Success'),
(2329, 1329, 'Card', 'Success'),
(2330, 1330, 'Card', 'Success'),
(2331, 1331, 'UPI', 'Success'),
(2332, 1332, 'UPI', 'Success'),
(2333, 1333, 'UPI', 'Success'),
(2334, 1334, 'Card', 'Success'),
(2335, 1335, 'COD', 'Success'),
(2336, 1336, 'UPI', 'Failed'),
(2337, 1337, 'UPI', 'Success'),
(2338, 1338, 'Card', 'Success'),
(2339, 1339, 'UPI', 'Failed'),
(2340, 1340, 'UPI', 'Pending'),
(2341, 1341, 'COD', 'Failed'),
(2342, 1342, 'COD', 'Failed'),
(2343, 1343, 'Card', 'Pending'),
(2344, 1344, 'Card', 'Success'),
(2345, 1345, 'UPI', 'Success'),
(2346, 1346, 'COD', 'Success'),
(2347, 1347, 'COD', 'Success'),
(2348, 1348, 'UPI', 'Pending'),
(2349, 1349, 'UPI', 'Success'),
(2350, 1350, 'Card', 'Success'),
(2351, 1351, 'Card', 'Failed'),
(2352, 1352, 'Card', 'Failed'),
(2353, 1353, 'COD', 'Success'),
(2354, 1354, 'UPI', 'Success'),
(2355, 1355, 'Card', 'Pending'),
(2356, 1356, 'UPI', 'Success'),
(2357, 1357, 'UPI', 'Pending'),
(2358, 1358, 'Card', 'Success'),
(2359, 1359, 'UPI', 'Success'),
(2360, 1360, 'UPI', 'Failed'),
(2361, 1361, 'UPI', 'Success'),
(2362, 1362, 'Card', 'Success'),
(2363, 1363, 'UPI', 'Success'),
(2364, 1364, 'Card', 'Pending'),
(2365, 1365, 'UPI', 'Success'),
(2366, 1366, 'COD', 'Success'),
(2367, 1367, 'COD', 'Pending'),
(2368, 1368, 'UPI', 'Pending'),
(2369, 1369, 'Card', 'Success'),
(2370, 1370, 'UPI', 'Success'),
(2371, 1371, 'COD', 'Success'),
(2372, 1372, 'Card', 'Success'),
(2373, 1373, 'COD', 'Success'),
(2374, 1374, 'Card', 'Failed'),
(2375, 1375, 'UPI', 'Success'),
(2376, 1376, 'COD', 'Success'),
(2377, 1377, 'UPI', 'Success'),
(2378, 1378, 'Card', 'Success'),
(2379, 1379, 'UPI', 'Success'),
(2380, 1380, 'COD', 'Success'),
(2381, 1381, 'Card', 'Pending'),
(2382, 1382, 'UPI', 'Success'),
(2383, 1383, 'UPI', 'Success'),
(2384, 1384, 'UPI', 'Success'),
(2385, 1385, 'COD', 'Success'),
(2386, 1386, 'UPI', 'Pending'),
(2387, 1387, 'UPI', 'Pending'),
(2388, 1388, 'Card', 'Success'),
(2389, 1389, 'UPI', 'Failed'),
(2390, 1390, 'Card', 'Success'),
(2391, 1391, 'Card', 'Failed'),
(2392, 1392, 'COD', 'Failed'),
(2393, 1393, 'UPI', 'Pending'),
(2394, 1394, 'UPI', 'Success'),
(2395, 1395, 'UPI', 'Success'),
(2396, 1396, 'COD', 'Success'),
(2397, 1397, 'UPI', 'Failed'),
(2398, 1398, 'COD', 'Success'),
(2399, 1399, 'UPI', 'Pending'),
(2400, 1400, 'UPI', 'Pending'),
(2401, 1401, 'COD', 'Failed'),
(2402, 1402, 'UPI', 'Failed'),
(2403, 1403, 'Card', 'Success'),
(2404, 1404, 'UPI', 'Success'),
(2405, 1405, 'UPI', 'Success');

INSERT INTO payments (payment_id, order_id, payment_method, payment_status) VALUES
(2406, 1406, 'UPI', 'Success'),
(2407, 1407, 'UPI', 'Success'),
(2408, 1408, 'Card', 'Success'),
(2409, 1409, 'Card', 'Pending'),
(2410, 1410, 'Card', 'Success'),
(2411, 1411, 'Card', 'Success'),
(2412, 1412, 'UPI', 'Success'),
(2413, 1413, 'Card', 'Pending'),
(2414, 1414, 'Card', 'Success'),
(2415, 1415, 'COD', 'Success'),
(2416, 1416, 'Card', 'Success'),
(2417, 1417, 'Card', 'Failed'),
(2418, 1418, 'COD', 'Success'),
(2419, 1419, 'UPI', 'Success'),
(2420, 1420, 'Card', 'Pending'),
(2421, 1421, 'Card', 'Success'),
(2422, 1422, 'UPI', 'Success'),
(2423, 1423, 'COD', 'Success'),
(2424, 1424, 'UPI', 'Success'),
(2425, 1425, 'Card', 'Success'),
(2426, 1426, 'COD', 'Success'),
(2427, 1427, 'UPI', 'Failed'),
(2428, 1428, 'COD', 'Success'),
(2429, 1429, 'Card', 'Success'),
(2430, 1430, 'Card', 'Success'),
(2431, 1431, 'UPI', 'Success'),
(2432, 1432, 'UPI', 'Success'),
(2433, 1433, 'Card', 'Pending'),
(2434, 1434, 'Card', 'Success'),
(2435, 1435, 'Card', 'Failed'),
(2436, 1436, 'COD', 'Success'),
(2437, 1437, 'UPI', 'Success'),
(2438, 1438, 'COD', 'Success'),
(2439, 1439, 'COD', 'Success'),
(2440, 1440, 'Card', 'Success'),
(2441, 1441, 'UPI', 'Pending'),
(2442, 1442, 'COD', 'Success'),
(2443, 1443, 'Card', 'Success'),
(2444, 1444, 'COD', 'Success'),
(2445, 1445, 'Card', 'Success'),
(2446, 1446, 'COD', 'Success'),
(2447, 1447, 'UPI', 'Success'),
(2448, 1448, 'Card', 'Success'),
(2449, 1449, 'UPI', 'Success'),
(2450, 1450, 'COD', 'Success'),
(2451, 1451, 'COD', 'Success'),
(2452, 1452, 'Card', 'Success'),
(2453, 1453, 'UPI', 'Success'),
(2454, 1454, 'UPI', 'Success'),
(2455, 1455, 'UPI', 'Success'),
(2456, 1456, 'UPI', 'Success'),
(2457, 1457, 'COD', 'Success'),
(2458, 1458, 'UPI', 'Success'),
(2459, 1459, 'Card', 'Success'),
(2460, 1460, 'COD', 'Failed'),
(2461, 1461, 'UPI', 'Success'),
(2462, 1462, 'COD', 'Pending'),
(2463, 1463, 'Card', 'Failed'),
(2464, 1464, 'COD', 'Success'),
(2465, 1465, 'UPI', 'Failed'),
(2466, 1466, 'Card', 'Success'),
(2467, 1467, 'UPI', 'Pending'),
(2468, 1468, 'UPI', 'Success'),
(2469, 1469, 'UPI', 'Success'),
(2470, 1470, 'Card', 'Success'),
(2471, 1471, 'Card', 'Success'),
(2472, 1472, 'UPI', 'Success'),
(2473, 1473, 'COD', 'Pending'),
(2474, 1474, 'Card', 'Success'),
(2475, 1475, 'Card', 'Success'),
(2476, 1476, 'UPI', 'Failed'),
(2477, 1477, 'UPI', 'Success'),
(2478, 1478, 'UPI', 'Success'),
(2479, 1479, 'Card', 'Success'),
(2480, 1480, 'UPI', 'Success'),
(2481, 1481, 'COD', 'Success'),
(2482, 1482, 'Card', 'Success'),
(2483, 1483, 'UPI', 'Success'),
(2484, 1484, 'Card', 'Success'),
(2485, 1485, 'UPI', 'Success'),
(2486, 1486, 'COD', 'Success'),
(2487, 1487, 'UPI', 'Success'),
(2488, 1488, 'UPI', 'Success'),
(2489, 1489, 'UPI', 'Success'),
(2490, 1490, 'COD', 'Success'),
(2491, 1491, 'UPI', 'Success'),
(2492, 1492, 'Card', 'Pending'),
(2493, 1493, 'UPI', 'Success'),
(2494, 1494, 'UPI', 'Success'),
(2495, 1495, 'Card', 'Success'),
(2496, 1496, 'COD', 'Success'),
(2497, 1497, 'UPI', 'Pending'),
(2498, 1498, 'UPI', 'Success'),
(2499, 1499, 'UPI', 'Success'),
(2500, 1500, 'UPI', 'Failed'),
(2501, 1501, 'Card', 'Success'),
(2502, 1502, 'Card', 'Success'),
(2503, 1503, 'UPI', 'Success'),
(2504, 1504, 'UPI', 'Failed'),
(2505, 1505, 'COD', 'Failed');

INSERT INTO payments (payment_id, order_id, payment_method, payment_status) VALUES
(2506, 1506, 'COD', 'Success'),
(2507, 1507, 'UPI', 'Failed'),
(2508, 1508, 'Card', 'Success'),
(2509, 1509, 'UPI', 'Success'),
(2510, 1510, 'UPI', 'Success'),
(2511, 1511, 'Card', 'Failed'),
(2512, 1512, 'Card', 'Failed'),
(2513, 1513, 'COD', 'Success'),
(2514, 1514, 'COD', 'Pending'),
(2515, 1515, 'COD', 'Pending'),
(2516, 1516, 'UPI', 'Failed'),
(2517, 1517, 'UPI', 'Pending'),
(2518, 1518, 'COD', 'Success'),
(2519, 1519, 'UPI', 'Success'),
(2520, 1520, 'Card', 'Success'),
(2521, 1521, 'COD', 'Success'),
(2522, 1522, 'COD', 'Success'),
(2523, 1523, 'Card', 'Failed'),
(2524, 1524, 'UPI', 'Success'),
(2525, 1525, 'UPI', 'Success'),
(2526, 1526, 'Card', 'Success'),
(2527, 1527, 'COD', 'Success'),
(2528, 1528, 'UPI', 'Success'),
(2529, 1529, 'COD', 'Failed'),
(2530, 1530, 'UPI', 'Success'),
(2531, 1531, 'COD', 'Success'),
(2532, 1532, 'COD', 'Success'),
(2533, 1533, 'UPI', 'Success'),
(2534, 1534, 'UPI', 'Pending'),
(2535, 1535, 'Card', 'Success'),
(2536, 1536, 'UPI', 'Success'),
(2537, 1537, 'UPI', 'Pending'),
(2538, 1538, 'COD', 'Success'),
(2539, 1539, 'UPI', 'Pending'),
(2540, 1540, 'UPI', 'Success'),
(2541, 1541, 'UPI', 'Pending'),
(2542, 1542, 'UPI', 'Failed'),
(2543, 1543, 'COD', 'Success'),
(2544, 1544, 'UPI', 'Success'),
(2545, 1545, 'COD', 'Success'),
(2546, 1546, 'Card', 'Success'),
(2547, 1547, 'COD', 'Success'),
(2548, 1548, 'Card', 'Failed'),
(2549, 1549, 'Card', 'Failed'),
(2550, 1550, 'UPI', 'Success'),
(2551, 1551, 'UPI', 'Failed'),
(2552, 1552, 'UPI', 'Failed'),
(2553, 1553, 'UPI', 'Success'),
(2554, 1554, 'Card', 'Success'),
(2555, 1555, 'UPI', 'Failed'),
(2556, 1556, 'Card', 'Success'),
(2557, 1557, 'UPI', 'Success'),
(2558, 1558, 'UPI', 'Success'),
(2559, 1559, 'Card', 'Success'),
(2560, 1560, 'COD', 'Success'),
(2561, 1561, 'UPI', 'Failed'),
(2562, 1562, 'UPI', 'Success'),
(2563, 1563, 'COD', 'Success'),
(2564, 1564, 'COD', 'Success'),
(2565, 1565, 'COD', 'Success'),
(2566, 1566, 'Card', 'Success'),
(2567, 1567, 'COD', 'Success'),
(2568, 1568, 'Card', 'Success'),
(2569, 1569, 'UPI', 'Success'),
(2570, 1570, 'Card', 'Success'),
(2571, 1571, 'UPI', 'Failed'),
(2572, 1572, 'Card', 'Success'),
(2573, 1573, 'UPI', 'Success'),
(2574, 1574, 'UPI', 'Success'),
(2575, 1575, 'Card', 'Success'),
(2576, 1576, 'COD', 'Success'),
(2577, 1577, 'UPI', 'Success'),
(2578, 1578, 'Card', 'Success'),
(2579, 1579, 'UPI', 'Success'),
(2580, 1580, 'UPI', 'Failed'),
(2581, 1581, 'UPI', 'Success'),
(2582, 1582, 'UPI', 'Success'),
(2583, 1583, 'UPI', 'Success'),
(2584, 1584, 'UPI', 'Success'),
(2585, 1585, 'COD', 'Success'),
(2586, 1586, 'Card', 'Success'),
(2587, 1587, 'UPI', 'Success'),
(2588, 1588, 'UPI', 'Failed'),
(2589, 1589, 'Card', 'Success'),
(2590, 1590, 'UPI', 'Success'),
(2591, 1591, 'Card', 'Failed'),
(2592, 1592, 'COD', 'Success'),
(2593, 1593, 'COD', 'Success'),
(2594, 1594, 'UPI', 'Success'),
(2595, 1595, 'UPI', 'Success'),
(2596, 1596, 'COD', 'Pending'),
(2597, 1597, 'Card', 'Success'),
(2598, 1598, 'COD', 'Success'),
(2599, 1599, 'UPI', 'Success'),
(2600, 1600, 'UPI', 'Success'),
(2601, 1601, 'Card', 'Success'),
(2602, 1602, 'COD', 'Failed'),
(2603, 1603, 'UPI', 'Pending'),
(2604, 1604, 'COD', 'Failed'),
(2605, 1605, 'UPI', 'Failed');
GO

-- ============================================================
--  SECTION 6 : VERIFY ROW COUNTS
-- ============================================================
SELECT 'customers'   AS tbl, COUNT(*) AS total FROM customers   UNION ALL
SELECT 'products',            COUNT(*)          FROM products    UNION ALL
SELECT 'orders',              COUNT(*)          FROM orders      UNION ALL
SELECT 'order_items',         COUNT(*)          FROM order_items UNION ALL
SELECT 'payments',            COUNT(*)          FROM payments;
GO

-- --------------------------
-- SECTION 4: QUICK VERIFICATION QUERIES
-- --------------------------

select count(customer_id) as no_of_customers from customers;
select count(order_id) as no_of_orders from orders;
select count(product_id)  as no_of_products from products;
select count(order_item_id) as no_of_order_list from order_items;
select count(payment_id) as no_of_paymen from payments;

--CHECK FOREIGN KEY INTERGRITY
SELECT c.customer_id,o.order_id 
from customers c join orders o on c.customer_id=o.customer_id; --customers --.orders 

SELECT p.payment_id,o.order_id 
from payments p join orders o on p.order_id=o.order_id;

--check orphan records
select * from orders o 
left join customers c on o.customer_id=c.customer_id
where c.customer_id is NULL;

-- ==========================
-- Foundational Queries
-- ==========================

--1. List all payments made VIA UPI

SELECT * FROM payments
where payment_method='UPI';

--2.Count total number of products per category

SELECT COUNT(product_id) as no_ofproducts,category from products
group by category;

--3. List all failed payments with their order details

 SELECT * FROM orders o 
 join payments p on o.order_id=p.order_id
 where payment_status='Failed';

 --4. Total Items sold per category

 select p.category,sum(oi.quantity) as items_sold_category 
 from order_items oi join products p on oi.product_id=p.product_id
 group by p.category
 order by items_sold_category desc;

 -- =========================
 -- Multi Table Joins & Aggregation
 -- =========================

 -- 5. Revenue Collected by payment methods

 select p.payment_method,sum(o.amount) as total_revenue_method
 from payments p join orders o on p.order_id=o.order_id
 group by p.payment_method
 order by total_revenue_method desc;

 --6.TOP 10 products by revenue generation

select  p.product_id,p.product_name,sum(oi.quantity*p.price) as product_revenue,p.category,
row_number() over( order by sum(oi.quantity*p.price)  desc) as row_number
from order_items oi join products p  on  oi.product_id=p.product_id
join orders o on oi.order_id=o.order_id
where o.status='Completed'
group by p.product_id,p.product_name,p.category;

--7. Revenue contribution by product category

select p.category,sum(oi.quantity*p.price) as revenue
from order_items oi join products p on oi.product_id=p.product_id
join orders o on o.order_id=oi.order_id
where o.status='Completed'
group by p.category
order by revenue desc;


--8.Payment Failure rate by city

select c.city,count(p.payment_id) as total_no_of_orders,
count(case when p.payment_status='Failed' then 1 end) as no_of_failed_orders,
cast(count( case when p.payment_status='Failed' then 1 end)* 100/
count(p.payment_id) as decimal(10,2)) as failure_Rate
from payments p 
join orders o on p.order_id=o.order_id
join customers c on o.customer_id=c.customer_id
group by c.city
order by failure_Rate desc;


--9.Average Basket Size (items per order) by membership
 
with avg_basket_size as (select c.membership,o.order_id,count(oi.order_item_id) as items_in_order
from customers c join orders o on c.customer_id=o.customer_id
join order_items oi  on o.order_id=oi.order_id
group by c.membership,o.order_id)

select membership,
cast(avg(cast(items_in_order as decimal(10,2))) as decimal(10,2)) as avg_basket
from avg_basket_size
group by membership
order by avg_basket asc;

--10.Revenue lost due to Failed/Refunded Payments
--Logic: Sum of amount linked to Failed Payments

select sum(o.amount) as revenue_of_failed_orders
from payments p join orders o on p.order_id=o.order_id
where p.payment_status='Failed'
group by p.payment_status;

--11.Payment method preference by customer city      


--12.Revenue Generated Per Product

select p.product_id,p.product_name,sum(oi.quantity*price) as revenue_per_product
from order_items oi join products p on oi.product_id=p.product_id
join orders o on oi.order_id=o.order_id
group by p.product_id,p.product_name
order by revenue_per_product desc;

--13.Categorize Memebers based on their membership type
select membership from customers;

select name,
case 
when membership='Gold' then 'Premium Customer'
when membership='Silver' then 'Regular Customer'
when membership='None' then 'Occasional Customer'
end as customer_type
from customers;


---------------------------------------
-- CTA PROJECT INTERVIEW TYPE QUESTIONS 
--   MOCK QUESTIONS (35 QUESTIONS)  ---
---------------------------------------

-- ROUND 1: BASIC CORE SQL QUERIES(10 QUESTIONS)

--1.List all customers from "Mumbai" with gold membership

select*from customers
where city='Mumbai' and membership='Gold';

--2.Find the total number of orders placed in 2024

select count(order_id) as no_of_orders from orders 
where year(order_date)=2024;

--3.Show all products priced above 5000 sorted highest to lowest

select product_name,price from products
where price>5000
order by price desc;

--4. Find all orders that are pending  or cancelled

select*from orders
where status IN('Pending','Cancelled');

--5.Count how many members belong to each membership type

select count(customer_id) as mem_cnt,membership from customers 
group by membership;

--6.Find single most expensive order placed

select top 1 order_id,amount from orders 
order by amount desc;


--7.List all the customers who placed orders from Ahmedabad, Surat and Vadodra

select*from customers
where city IN( 'Ahmedabad','Surat','Vadodra');

--8.Find all orders placed in november & december

select*from orders 
where month(order_date) IN (11,12)
order by order_date;

--9.Show the average order value for completed orders

select avg(amount) as AOV from orders
where status='Completed';

--10.List the products the belong to Electronics or Sports Category,sorted by price

select product_name,price,category from products 
where category in ('Electronics','Sports')
order by price;

-- ROUND 2 INTERMEDIATE SQL QUERIES (12 Questions)


--11.Total Revenue generated by City(completed Orders)

select c.city,sum(o.amount) as total_revenue from 
customers c join orders o on c.customer_id=o.customer_id
where o.status='Completed'
group by c.city
order by total_revenue desc;

--12.Find customers who placed more than 5 orders

select c.name,count(o.order_id) as order_count from
customers c join orders o on c.customer_id=o.customer_id
group by c.name
having count(o.order_id)>5

--13.Payment method split- count and percentgae of Payment method

 select payment_method,count(payment_method) as count_per_payment_method , 
 cast(count(payment_method)*100/sum(count(*)) over() as decimal(10,2)) as percentage_share
 from payments
 group by payment_method

 --14. Find Customers who never placed an order

 select c.name,o.order_id from 
 customers c join orders o on c.customer_id=o.customer_id
 where o.order_id is null
 order by c.customer_id;

 --15.Top 5 best products by quantity sold

 select top 5 p.product_name,count(oi.quantity) as quantity_sold
 from products p join order_items oi on p.product_id=oi.product_id
 group by p.product_name
 order by quantity_sold desc;
 

 --16.Average Order Value by membershipp type- comparision of all tiers

 select c.membership as tier,cast(avg(o.amount) as decimal(10,2)) as avg_Tier_orderamount from 
 customers c join orders o on c.customer_id=o.customer_id
 group by c.membership

 --17.Monthly revenue for 2024

 select datename(month,order_date) as month_name,sum(amount) as monthly_revenue
 from orders
 where year(order_date) in (2024)
 group by datename(month,order_date),month(order_date)
 order by month(order_date);

 --18.Cancellation Rate per city- which city cancels the most

 select c.city,count(o.status) as failed_orders , cast(count(o.status)*100/sum(count(*)) over () as decimal(10,2)) as failure_rate
 from customers c join orders o on c.customer_id=o.customer_id
 where status in('Cancelled')
 group by c.city
 order by failed_orders desc;
 
 --19.Find second highest order amount without using top 2

with second_highest_order_amount as 
(select customer_id,order_id,amount,
dense_rank() over(order by amount desc) as rnk
from orders )

select customer_id,order_id,amount,rnk
from second_highest_order_amount
where rnk=2;

--20. Which product category generates highest per units sold 

select top 1 p.product_name,p.category,sum(oi.quantity) as quantities_sold,sum(p.price) as revenue_units_sold
from products p join order_items oi on p.product_id=oi.product_id
group by p.product_name,p.category
order by revenue_units_sold desc;

--21.Select customers whose average spending is more that average order value

select c.name,sum(o.amount) as total_customer_spending 
from customers c join orders o on c.customer_id=o.customer_id
group by c.name,c.customer_id
having sum(o.amount)>(
   select cast(avg(amount) as decimal(10,2)) as avg_orderamount from orders
   );
 
 --22.Full order details- customer name, order date, product names, quantity and payment method

 select c.name, o.order_date,p.product_name,oi.quantity,pp.payment_method from 
 customers c join orders o on c.customer_id=o.customer_id
 join  order_items oi on o.order_id=oi.order_id
 join products p on oi.product_id=p.product_id
 join payments pp on o.order_id=pp.order_id;


 --Round 3  SQL ADVANCES QUERIES ( 8 QUESTIONS)

--23.Rank customers by their total spend- calculate their dense rank and percentile

with spending_listing as (
select c.name,sum(o.amount) as total_spent,
dense_rank() over(order by sum(o.amount) desc) as spent_rnk
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_id,c.name
),

RankingStats as(
select *,max(spent_rnk) over() as max_rnk from
spending_listing 
)

select name,total_spent,spent_rnk,
CAST((1-(spent_rnk - 1.0) / max_rnk) * 100 AS DECIMAL(10,2)) AS spend_percentile, -- the bottom-up logic
cast((spent_rnk-1.0)/(max_rnk-1.0)*100 as decimal(10,2)) as spent_percentiletopdown -- the top down logic
from RankingStats
order by spent_rnk ;

--24. Month over Month revenue growth percentage from each month 

WITH MonthlyRevenue AS (
    SELECT 
        MONTH(order_date) AS MonthNumber, -- Added this to keep the sort order
        DATENAME(MONTH, order_date) AS months, 
        SUM(amount) AS monthly_Revenue
    FROM orders 
    GROUP BY MONTH(order_date), DATENAME(MONTH, order_date)
)
SELECT 
    months,
    monthly_Revenue,
    LAG(monthly_Revenue) OVER (ORDER BY MonthNumber) AS Previous_Month_Revenue,
    -- Fixed the Parentheses: (Current - Prev) / Prev * 100
    CAST(
        (monthly_Revenue - LAG(monthly_Revenue) OVER (ORDER BY MonthNumber)) 
        / NULLIF(LAG(monthly_Revenue) OVER (ORDER BY MonthNumber), 0) -- Added NULLIF to prevent "Divide by Zero" error
        * 100 
    AS DECIMAL(10,2)) AS MoM_Growth_Percentage
FROM MonthlyRevenue
ORDER BY MonthNumber;

 -- 25. Running Cumulative Revenue 
-- Goal: Show how revenue builds up month by month (Rolling Total)
WITH MonthlyRev AS (
    SELECT 
        MONTH(order_date) as MonthNum,
        DATENAME(MONTH, order_date) as MonthName,
        SUM(amount) as Revenue
    FROM orders
    GROUP BY MONTH(order_date), DATENAME(MONTH, order_date)
)
SELECT 
    MonthName,
    Revenue,
    SUM(Revenue) OVER (ORDER BY MonthNum) AS Cumulative_Revenue
FROM MonthlyRev
ORDER BY MonthNum;

--26. For each customer, show their first order day,last order day , day between first and last 

select c.customer_id,c.name,
min(o.order_date) as first_order_date,
max(o.order_date) as latest_order_date,
datediff(day,min(o.order_date),max(o.order_date)) as duration
from customers c join orders o on c.customer_id=o.customer_id
group by c.name,c.customer_id
order by duration desc;

--27.For each order show the previous order amount by the customer 

SELECT 
    c.name,
    o.order_id,
    o.order_date,
    o.amount AS current_order_amount,
    -- Using LAG to peek at the previous row within the customer's partition
    LAG(o.amount) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS previous_order_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY c.name, o.order_date;

--28. Find the customers who placed an order in 2024 not in 2025

select c.name,c.customer_id
from customers c join orders o on c.customer_id=o.customer_id
where year(o.order_date)=2024 and year(o.order_date) !=2025
group by c.name,c.customer_id;

--29.3 month rolling average revenue -- smooth out seasonal spikes

WITH MonthlyRevenue AS (
    SELECT 
        MONTH(order_date) AS MonthNum,
        DATENAME(MONTH, order_date) AS MonthName,
        SUM(amount) AS TotalRevenue
    FROM orders
    GROUP BY MONTH(order_date), DATENAME(MONTH, order_date)
)
SELECT 
    MonthName,
    TotalRevenue,
    -- Using AVG with a frame specification to look back 2 rows plus the current row
    AVG(TotalRevenue) OVER (
        ORDER BY MonthNum 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Rolling_Avg_3_Month
FROM MonthlyRevenue
ORDER BY MonthNum;

--30. Identify the top product in each category

with product_revenue as (
   select p.product_name,p.category,sum(p.price*oi.quantity) as product_Revenue,
   dense_rank() over(partition by p.category order by sum(p.price*oi.quantity)desc) as rnk
   from products p join order_items oi on p.product_id=oi.product_id
   group by p.product_name,p.category

)

select product_name,category,
Product_revenue
from product_revenue 
where rnk=1
group by Product_Revenue,product_name,category;

-- Round 4 Expert Level Queries

--31. Full RFM Scoring with business segment labels 

WITH customer_analysis AS (
    SELECT 
        c.name,
        c.customer_id,
        -- Correct Recency: Days since the absolute last order in the dataset
        DATEDIFF(day, MAX(o.order_date), (SELECT MAX(order_date) FROM orders)) AS recency,
        COUNT(o.order_id) AS frequency,
        SUM(o.amount) AS monetary
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status = 'Completed'
    GROUP BY c.name, c.customer_id
),
RFM_scores AS (
    SELECT 
        customer_id,
        -- R_score: Lower recency (days) = Higher Score (5)
        NTILE(5) OVER(ORDER BY recency DESC) AS R_score,
        NTILE(5) OVER(ORDER BY frequency DESC) AS F_score,
        NTILE(5) OVER(ORDER BY monetary DESC) AS M_score
    FROM customer_analysis
) 
SELECT 
    c.name,
    c.recency,
    c.frequency,
    c.monetary,
    r.R_score,
    r.F_score,
    r.M_score,
    CASE 
        WHEN R_score >= 4 AND F_score >= 4 AND M_score >= 4 THEN 'Champions'
        WHEN R_score >= 4 AND F_score >= 2 THEN 'Loyalists'
        WHEN R_score <= 2 AND F_score >= 4 THEN 'At Risk - Can''t Lose'
        WHEN R_score <= 2 AND F_score <= 2 THEN 'Hibernating'
        ELSE 'Regular'
    END AS customer_segment
FROM RFM_scores r 
JOIN customer_analysis c ON r.customer_id = c.customer_id
ORDER BY R_score DESC, F_score DESC;


--32.Year over Year comparision - 2023 vs 2024 vs 2025 side by side

WITH Yearly_Stats AS (
    SELECT 
        YEAR(order_date) AS order_year,
        SUM(amount) AS yearly_revenue,
        COUNT(order_id) AS total_orders,
        CAST(AVG(amount) AS DECIMAL(10,2)) AS aov
    FROM orders
    WHERE status = 'Completed'
    GROUP BY YEAR(order_date)
)
SELECT 
    order_year,
    yearly_revenue,
    -- Pulling the previous year's revenue using LAG
    LAG(yearly_revenue) OVER (ORDER BY order_year) AS prev_year_revenue,
    -- Calculating YoY Growth %
    CAST(
        (yearly_revenue - LAG(yearly_revenue) OVER (ORDER BY order_year)) 
        * 100.0 / NULLIF(LAG(yearly_revenue) OVER (ORDER BY order_year), 0) 
    AS DECIMAL(10,2)) AS yoy_growth_pct,
    aov,
    total_orders
FROM Yearly_Stats
ORDER BY order_year;

-- 33. Expert Level: Customer Cohort Retention Analysis
-- Goal: See what % of customers acquired in a specific year returned in following years
WITH Acquisition_Year AS (
    -- Step 1: Find the first year for every customer
    SELECT 
        customer_id, 
        MIN(YEAR(order_date)) AS first_year
    FROM orders
    GROUP BY customer_id
),
Returning_Customers AS (
    -- Step 2: Get unique years each customer placed an order
    SELECT DISTINCT 
        customer_id, 
        YEAR(order_date) AS active_year
    FROM orders
)
SELECT 
    a.first_year AS cohort_year,
    COUNT(DISTINCT a.customer_id) AS total_acquired,
    -- Retention in 2024
    CAST(COUNT(DISTINCT CASE WHEN r.active_year = 2024 THEN r.customer_id END) * 100.0 / 
         COUNT(DISTINCT a.customer_id) AS DECIMAL(10,2)) AS retention_rate_2024_pct,
    -- Retention in 2025
    CAST(COUNT(DISTINCT CASE WHEN r.active_year = 2025 THEN r.customer_id END) * 100.0 / 
         COUNT(DISTINCT a.customer_id) AS DECIMAL(10,2)) AS retention_rate_2025_pct
FROM Acquisition_Year a
LEFT JOIN Returning_Customers r ON a.customer_id = r.customer_id 
      AND r.active_year > a.first_year -- Only count years AFTER they were acquired
GROUP BY a.first_year
ORDER BY a.first_year;

-- 34. Expert Level: Payment Leakage & Recovery Report
-- Goal: Identify revenue lost to failures by city/method and estimate recovery value
-- 34. Expert Level: Payment Leakage & Recovery Report (FIXED)
WITH Payment_Audit AS (
    SELECT 
        c.city,
        p.payment_method,
        SUM(o.amount) AS total_attempted_revenue,
        -- CHECK: Does your table use 'Success', 'Completed', or 'Paid'? 
        -- Using 'Success' here as it's the most common partner to 'Failed'
        SUM(CASE WHEN p.payment_status IN ('Success', 'Completed') THEN o.amount ELSE 0 END) AS successful_revenue,
        SUM(CASE WHEN p.payment_status = 'Failed' THEN o.amount ELSE 0 END) AS failed_revenue,
        COUNT(p.payment_id) AS total_transactions
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.city, p.payment_method
)
SELECT 
    city,
    payment_method,
    total_attempted_revenue,
    successful_revenue,
    failed_revenue,
    CAST((failed_revenue * 100.0) / NULLIF(total_attempted_revenue, 0) AS DECIMAL(10,2)) AS leakage_pct,
    CAST(failed_revenue * 0.50 AS DECIMAL(10,2)) AS estimated_recovery_value
FROM Payment_Audit
WHERE total_attempted_revenue > 0
ORDER BY failed_revenue DESC;

-- 35. Final Expert Level: Master Customer Health Scorecard
-- Integrating your CustomerStats logic with Payment and Product depth.
WITH CustomerStats AS (
    SELECT 
        c.customer_id,
        c.name,
        c.city,
        SUM(o.amount) AS Raw_revenue,
        COUNT(o.order_id) AS total_orders,
        DATEDIFF(day, MIN(o.order_date), MAX(o.order_date)) AS active_days,
        -- Global Max Date subquery to fix the previous 'more than 1 value' error
        DATEDIFF(day, MAX(o.order_date), (SELECT MAX(order_date) FROM orders)) AS recency
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name, c.city
),
PaymentStats AS (
    SELECT 
        o.customer_id,
        CAST(SUM(CASE WHEN p.payment_status IN ('Success', 'Completed') THEN 1 ELSE 0 END) * 100.0 / 
             NULLIF(COUNT(p.payment_id), 0) AS DECIMAL(10,2)) AS payment_success_rate,
        SUM(CASE WHEN p.payment_status = 'Failed' THEN o.amount ELSE 0 END) AS leaked_revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY o.customer_id
),
ProductStats AS (
    SELECT 
        o.customer_id,
        COUNT(DISTINCT p.category) AS category_diversity
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY o.customer_id
)
SELECT 
    cs.name,
    cs.city,
    cs.Raw_revenue AS ltv,
    cs.total_orders,
    cs.active_days AS tenure,
    cs.recency,
    ps.payment_success_rate,
    ps.leaked_revenue AS recovery_potential,
    pts.category_diversity,
    -- The Health Label logic based on your integrated stats
    CASE 
        WHEN cs.recency <= 30 AND ps.payment_success_rate >= 90 AND cs.Raw_revenue > 50000 THEN 'Platinum Member'
        WHEN cs.recency > 90 AND cs.Raw_revenue > 30000 THEN 'At Risk / Churning'
        WHEN ps.payment_success_rate < 50 THEN 'High Friction'
        ELSE 'Regular'
    END AS health_status
FROM CustomerStats cs
LEFT JOIN PaymentStats ps ON cs.customer_id = ps.customer_id
LEFT JOIN ProductStats pts ON cs.customer_id = pts.customer_id
ORDER BY cs.Raw_revenue DESC;