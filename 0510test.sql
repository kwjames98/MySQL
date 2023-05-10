create database TEMP;
use TEMP;

CREATE TABLE ORDER_(
 OrderNum INTEGER PRIMARY KEY NOT NULL,
 CustID INTEGER NOT NULL,
 ProductID INTEGER NOT NULL,
 ProductType VARCHAR(20),
 Quantity INTEGER DEFAULT 1,
 UnitPrice DECIMAL(5,2) NOT NULL,
 OrderDate DATETIME
);
INSERT INTO ORDER_ VALUES (1, 11, 101, "Groceries", 5, 2.49, '2019-01-02');
INSERT INTO ORDER_ VALUES (2, 11, 102, "Groceries", 2, 1.49, '2019-02-03');
INSERT INTO ORDER_ VALUES (3, 11, 201, "Electronics", 1, 99.99, '2019-03-11');
INSERT INTO ORDER_ VALUES (4, 22, 201, "Electronics", 2, 99.99, '2019-04-07');
INSERT INTO ORDER_ VALUES (5, 33, 201, "Electronics", 1, 99.99, '2019-05-25');
INSERT INTO ORDER_ VALUES (6, 33, 301, "Home Improvements", 1, 199.9, '2019-07-22');
INSERT INTO ORDER_ VALUES (7, 44, 101, "Groceries", 3, 2.49, '2019-08-15');
INSERT INTO ORDER_ VALUES (8, 44, 301, "Home Improvements", 1, 199.9, '2019-09-04');
INSERT INTO ORDER_ VALUES (9, 55, 101, "Groceries", 10, 2.49, '2019-10-11');
INSERT INTO ORDER_ VALUES (10, 55, 102, "Groceries", 5, 1.49, '2019-10-11');
INSERT INTO ORDER_ VALUES (11, 55, 201, "Electronics", 1, 99.99, '2019-10-11');
INSERT INTO ORDER_ VALUES (12, 55, 301, "Home Improvements", 2, 199.99, '2020-04-02');
INSERT INTO ORDER_ VALUES (13, 55, 301, NULL, 1, 199.99, '2020-04-02');
INSERT INTO ORDER_ VALUES (14, 66, 401, NULL, 1, 199.99, '2020-04-02');

select * from ORDER_;

select max(OrderNum) from ORDER_;
# count function does not count null values
select count(ProductType) from ORDER_;
select count(OrderNum) from ORDER_; 
# distinct conjunction with count function
select count(distinct(ProductType)) from ORDER_;
# Min, Max
# doesn't allow to use aggregate function after select

set SQL_MODE = '';

select ProductID from ORDER_ where UnitPrice = (select max(UnitPrice) from ORDER_);
# having method
select OrderNum, Quantity * UnitPrice as SalesAmount, OrderDate from ORDER_
	having max(OrderDate);
# subquery method
select OrderNum, Quantity * UnitPrice as SalesAmount, OrderDate from ORDER_
	where OrderDate = (select max(OrderDate) from ORDER_);

# SUM function
select ProductType, ProductID, sum(Quantity * UnitPrice) from ORDER_ group by ProductType, ProductID;

# AVG function
select CustID, avg(Quantity * UnitPrice) from ORDER_ group by CustID;

# group by
select CustID, sum(Quantity) from ORDER_ group by CustID;
select CustID, ProductType, sum(Quantity) from ORDER_ group by CustID, ProductType;

# having
select OrderNum, Quantity * UnitPrice as SalesAmount from ORDER_ having SalesAmount > 100; # where not allowed

select ProductType, count(OrderNum) as Frequency from ORDER_ group by ProductType having ProductType = 'Groceries';
select CustID from ORDER_ group by CustID having sum(Quantity) > 5 and sum(Quantity * UnitPrice) > 500;