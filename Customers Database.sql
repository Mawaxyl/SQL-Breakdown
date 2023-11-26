Create Database Customers;

Create Table Customer
(
	FirstName varchar(50),
	LastName varchar(50),
	Age int
);

insert into Customer (FirstName, LastName, Age) Values ('Justice', 'Charles-Godfrey', 43);
insert into Customer (FirstName, LastName, Age) Values ('Chuks', 'Nzeadibe', 30);
insert into Customer (FirstName, LastName, Age) Values ('Sadiq', 'Maruf', 35);
insert into Customer (FirstName, LastName, Age) Values ('Tessy', 'Onuh', 33);
insert into Customer (FirstName, LastName, Age) Values ('Chinedu', 'Omanukwe', 17);
insert into Customer (FirstName, LastName, Age) Values ('Mukthar', 'Abdulwaheed', 87);

Select * From Customer;

Select FirstName, LastName, Age
From Customer;

Select FirstName, LastName, Age
From Customer
Where FirstName = 'Chuks';

Select FirstName, LastName, Age
From Customer
Where FirstName = 'Chuks'
and LastName = 'Nzeadibe';

insert into Customer (FirstName, LastName, Age) Values ('Justice', 'Tunde1', 43);
insert into Customer (FirstName, LastName, Age) Values ('Justice', 'Tunde2', 30);
insert into Customer (FirstName, LastName, Age) Values ('Justice', 'Tunde3', 35);
insert into Customer (FirstName, LastName, Age) Values ('Justice', 'Tunde4', 33);
insert into Customer (FirstName, LastName, Age) Values ('Justice', 'Tunde5', 17);
insert into Customer (FirstName, LastName, Age) Values ('Justice', 'Tunde6', 87);

Select * From Customer;

Select FirstName, LastName, Age
From Customer
Where FirstName = 'Justice'
and LastName like 'Tunde1';

Select FirstName, LastName, Age
From Customer
Where FirstName = 'Justice'
and LastName like 'Tunde_';

-- Update 
Update Customer
Set Age = 20
Where FirstName = 'Tessy'
and LastName = 'Onuh';

Select FirstName, LastName, Age
From Customer
Where FirstName like 'C%';
-- and LastName like 'Tunde_';

insert into Customer (FirstName, LastName, Age) Values ('Tayo', 'Tunde', 43);
insert into Customer (FirstName, LastName, Age) Values ('Tayo', 'Tunde', 30);
insert into Customer (FirstName, LastName, Age) Values ('Tayo', 'Tunde', 35);
insert into Customer (FirstName, LastName, Age) Values ('Tayo', 'Tunde', 33);
insert into Customer (FirstName, LastName, Age) Values ('Chika', 'Sola', 17);
insert into Customer (FirstName, LastName, Age) Values ('Kika', 'Sola', 87);

Select FirstName, LastName, Age
From Customer
Where LastName like '%a';

Select FirstName, LastName, Age
From Customer
Where FirstName like '%ay%';

Alter Table Customer
add City varchar(50);

Update Customer
Set City = 'New York'
where FirstName = 'Sadiq';

Select * From Customer;

Update Customer
Set City = 'Venice', Age = 33
where FirstName = 'Chuks';

Delete Customer
where FirstName = 'Justice'
and LastName = 'Tunde2';

-- Classwork

Drop Table Customer;

Create Table Customer
(
	id int primary key identity(1,1),
	FirstName varchar(50),
	LastName varchar(50),
	Age int,
	City varchar(50)
);

insert into Customer (FirstName, LastName, Age, City) Values ('Justice', 'Charles-Godfrey', 43, 'London');
insert into Customer (FirstName, LastName, Age, City) Values ('Chuks', 'Nzeadibe', 30, 'Budapest');
insert into Customer (FirstName, LastName, Age, City) Values ('Sadiq', 'Maruf', 35, 'Ottawa');
insert into Customer (FirstName, LastName, Age, City) Values ('Tessy', 'Onuh', 33, 'Singapore');
insert into Customer (FirstName, LastName, Age, City) Values ('Chinedu', 'Omanukwe', 17, 'Berlin');

Select * From Customer;

Create Table Products(
	id int primary key identity(1,1),
	ProductName varchar(50)
);

Alter Table Products
add Price Float;

insert into Products (ProductName, Price) Values ('DELL',  45.8);
insert into Products (ProductName, Price) Values ('HP', 100.5);
insert into Products (ProductName, Price) Values ('Apple', 150.10);
insert into Products (ProductName, Price) Values ('Toshiba', 112);
insert into Products (ProductName, Price) Values ('Acer', 90.8);

Select * From Products;

Create Table Orders
(
	OrderId int primary key identity(1,1),
	OrderDate DateTime,
	CustomerID int,
	ProductID int
);

insert into Orders (OrderDate, CustomerID, ProductID) Values ('2023-12-30', 5, 2);
insert into Orders (OrderDate, CustomerID, ProductID) Values (GETDATE(), 5, 4);
insert into Orders (OrderDate, CustomerID, ProductID) Values (GETDATE(), 5, 5);
insert into Orders (OrderDate, CustomerID, ProductID) Values (GETDATE(), 5, 3);
insert into Orders (OrderDate, CustomerID, ProductID) Values (GETDATE(), 5, 5);
insert into Orders (OrderDate, CustomerID, ProductID) Values (GETDATE(), 5, 1);

-- Drop Table Orders;

Select * From Orders;
Select * From Customer;
Select * From Products;

Alter Table Orders
Add Constraint Order_key Foreign Key (CustomerID) references Customer(Id);

Alter Table Orders
Add Constraint Product_key Foreign Key (CustomerID) references Products(Id);

-- Get All the Product Name and Price on Orders Table
Select * From Orders
Inner Join Products on Orders.ProductID = Products.id;

Select count(ProductName)  No_of_Products
From Products;

-- Using Alias
Select * From Orders as o
Inner Join Products as p on o.ProductID = p.id;

-- OR
Select * From Orders o
Inner Join Products p on o.ProductID = p.id;

Select p.ProductName, o.OrderDate
From Orders o
Inner Join Products p on o.ProductID = p.id;

-- Get All the Product Name, Price, and all details from Customers Table that relates to Orders Table
Select o.*, p.*, c.* 
From Orders o
Inner Join Products p on o.ProductID = p.id
Inner Join Customer c on o.CustomerID = c.id;

-- Sum
Select sum(p.Price) 
From Orders o
Inner Join Products p on o.ProductID = p.id
Inner Join Customer c on o.CustomerID = c.id;

-- OR Better
Select sum(p.Price) as Price_Total
From Orders o
Inner Join Products p on o.ProductID = p.id
Inner Join Customer c on o.CustomerID = c.id;

-- Product a particular customers bought
Select c.LastName, p.Price, p.ProductName
From Orders o
Inner Join Products p on o.ProductID = p.id
Inner Join Customer c on o.CustomerID = c.id
Where c.FirstName = 'Sadiq';

-- Each Customer Total of all product bought
Select c.FirstName,  sum(p.Price) as Total --, p.ProductName
From Orders o
Inner Join Products p on o.ProductID = p.id
Inner Join Customer c on o.CustomerID = c.id
-- Where c.FirstName = 'Sadiq'
Group By c.FirstName --, p.ProductName;

-- 
Select c.FirstName, p.ProductName, sum(p.Price)--, p.ProductName
From Orders o
Inner Join Products p on o.ProductID = p.id
Inner Join Customer c on o.CustomerID = c.id
-- Where c.FirstName = 'Sadiq'
Group By c.FirstName, p.ProductName;

-- Adding more rows to Product Table and Customer
-- Customer
insert into Customer (FirstName, LastName, Age, City) Values ('Toyo', 'Taofeeq', 43, 'London');
insert into Customer (FirstName, LastName, Age, City) Values ('Bayo', 'Ola', 30, 'Budapest');
insert into Customer (FirstName, LastName, Age, City) Values ('Sade', 'Pano', 35, 'Ottawa');
insert into Customer (FirstName, LastName, Age, City) Values ('Kareem', 'Sunday', 33, 'Singapore');
insert into Customer (FirstName, LastName, Age, City) Values ('Basit', 'Jaye', 17, 'Berlin');

-- Products
insert into Products (ProductName, Price) Values ('Lenovo', 110.10);
insert into Products (ProductName, Price) Values ('Asus', 125);
insert into Products (ProductName, Price) Values ('Samsung', 190.8);

Select * From Customer;
Select * From Products;

-- Left Join
SELECT p.*, o.*
FROM Products p
LEFT JOIN Orders o
ON o.ProductID = p.id

-- Right Join
SELECT p.ProductName, o.*
FROM Orders o
RIGHT JOIN Products p
ON o.ProductID = p.id

-- Cross Join
SELECT p.ProductName, o.*
FROM Orders o
CROSS JOIN Products p
-- ON o.ProductID = p.id

-- FULL OUTER JOIN
SELECT p.ProductName, o.*
FROM Orders o
FULL OUTER JOIN Products p
ON o.ProductID = p.id


Select o.*, p.*, c.* 
From Orders o
Inner Join Products p on o.ProductID = p.id
Inner Join Customer c on o.CustomerID = c.id;

-- where clause
SELECT FirstName, LastName
FROM Customer
WHERE City = 'London';

SELECT FirstName, LastName, City
FROM customer
WHERE City != 'Germany'

SELECT *
FROM Products
WHERE ProductName = 'Apple'
    AND Price >= 80; 

SELECT *
FROM Products
WHERE Price Between 30 and 100;

-- Order By Clause
SELECT ProductName, Price
FROM Products
ORDER BY Price DESC; -- Default is Ascending order, or you specify DESC i.e descending

Select COUNT(*), MIN(Price), MAX(Price), AVG(Price), 
	SUM(Price), VAR(Price), STDEV(Price)
From Products;

Create Table Cars
(
	FirstName varchar(50),
	LastName varchar(50),
	CarType varchar(50),
	Color varchar(50),
	Price int,
	Quantity int 
);

--Drop Table Cars;

insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Chuks', 'Obaro', 'Toyota', 'Red', 50000, 2);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Sadiq', 'Seyi', 'Lexus', 'Black', 90000, 3);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Tessy', 'Eni', 'Toyota', 'Red', 70000, 1);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Chinedu', 'Motun', 'Honda', 'White', 30000, 2);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Justice', 'Seun', 'Toyota', 'Black', 100000, 3);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Mukthar', 'Olakunle', 'Tesla', 'White', 150000, 2);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Chuks', 'Obaro', 'BMW', 'Red', 450000, 2);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Sadiq', 'Seyi', 'Audi', 'Black', 770000, 3);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Tessy', 'Eni', 'Benz', 'Black', 230000, 1);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Chinedu', 'Motun', 'Volkswagen', 'White', 30000, 2);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Justice', 'Seun', 'Tesla', 'Black', 150000, 3);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Mukthar', 'Olakunle', 'Rolls-Royce', 'Blue', 150000, 4);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Chuks', 'Obaro', 'Toyota', 'Blue', 50000, 2);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Sadiq', 'Seyi', 'Lexus', 'Red', 90000, 3);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Tessy', 'Eni', 'Toyota', 'White', 70000, 2);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Chinedu', 'Motun', 'Honda', 'Black', 30000, 4);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Justice', 'Seun', 'Toyota', 'Black', 100000, 3);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Mukthar', 'Olakunle', 'Tesla', 'White', 150000, 2);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Chuks', 'Obaro', 'Toyota', 'Red', 50000, 2);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Sadiq', 'Seyi', 'Lexus', 'Black', 90000, 3);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Tessy', 'Eni', 'Toyota', 'Red', 70000, 1);
insert into Cars(FirstName, LastName, CarType, Color, Price, Quantity) Values ('Chinedu', 'Motun', 'Honda', 'White', 30000, 6);

Select * From Cars;

-- Group By
SELECT count(*), CarType
FROM Cars
Group By CarType;

-- Having
SELECT count(*) Cars_Count, CarType
FROM Cars
Group By CarType
Having count(*) > 1;

SELECT FirstName, count(*) Total_Cars_Owned, max(Price) Owned_Cars_Total_Cost
FROM Cars
Group By FirstName
Having max(Price) > 50000;

Select FirstName, CarType
From Cars
where FirstName = 'Mukthar'

Select Distinct(Color)
From Cars;


-- Operator
-- UNION
SELECT FirstName, CarType, Price, Color
FROM Cars
Where CarType = 'Toyota'
Union
SELECT FirstName, CarType, Price, Color
FROM Cars
Where Color = 'Black'

-- UNION All
SELECT FirstName, CarType, Price, Color
FROM Cars
Where CarType = 'Toyota'
Union All
SELECT FirstName, CarType, Price, Color
FROM Cars
Where Color = 'Black'

-- Intersect 
SELECT FirstName, CarType, Price, Color
FROM Cars
Where CarType = 'Toyota'
Intersect 
SELECT FirstName, CarType, Price, Color
FROM Cars
Where Color = 'Black';

-- Minus (It's Except on SSMS)
SELECT FirstName, CarType, Price, Color
FROM Cars
Where CarType = 'Toyota'
Except
SELECT FirstName, CarType, Price, Color
FROM Cars
Where Color = 'Black'
Order By FirstName;





-- Subquery
Select * From Cars

Select FirstName, LastName, (Select AVG(Price) From Cars)
From Cars

-- average number of car quantity per person per car type

Select FirstName, CarType, COUNT(Quantity) AS Car_Quantity
From Cars
Group by FirstName, CarType;


Select FirstName, AVG(Car_Quantity) Average_Cars_Owned FROM
	(Select FirstName, CarType, COUNT(Quantity) AS Car_Quantity
	From Cars
	Group by FirstName, CarType) sub
Group By FirstName;

Select * FROM
	(Select FirstName, CarType, COUNT(Quantity) AS Car_Quantity
	From Cars
	Group by FirstName, CarType) sub 





-- Single Row SubQuery
UPDATE Cars
SET LastName =(SELECT FirstName
		From Cars
		WHERE Quantity=6)
WHERE CarType='Honda';


Select *
From Cars;

SELECT FirstName, LastName, CarType
FROM Cars
WHERE Color = (SELECT Color FROM Cars WHERE CarType = 'Rolls-Royce');



-- Multiple Rows Subquery
SELECT *
FROM Cars
WHERE Color IN (SELECT Color FROM Cars WHERE CarType LIKE 'Te%');

SELECT CarType, Color
FROM Cars
WHERE Color IN (SELECT Color FROM Cars WHERE CarType LIKE 'Te%');

SELECT *
FROM Cars
WHERE CarType IN (SELECT CarType FROM Cars WHERE CarType LIKE 'T%');
---------------------

SELECT FirstName, LastName, CarType, Color, Price
FROM Cars
WHERE Price < ALL (SELECT Price
					FROM Cars
					WHERE CarType= 'Rolls-Royce')
AND Color IN (SELECT Color
				FROM Cars
				where CarType= 'Volkswagen');




