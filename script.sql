CREATE DATABASE ProductionDB;
GO

USE ProductionDB;
GO

CREATE SCHEMA Production;
GO

CREATE TABLE Production.ProductCategory
(
	ProductCategoryID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(100) NOT NULL,
	ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Production.Product
(
	ProductID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(100) NOT NULL,
	DefaultPrice DECIMAL(10,2) NOT NULL,
	ListPrice DECIMAL(10,2) NOT NULL,
	ModifiedDate DATETIME DEFAULT GETDATE(),
	ProductCategoryID INT NOT NULL,
	FOREIGN KEY (ProductCategoryID) REFERENCES Production.ProductCategory(ProductCategoryID),
);
GO

CREATE TABLE Production.ProductInventory
(
	ProductID INT NOT NULL,
	Quantity INT NOT NULL,
	ModifiedDate DATETIME DEFAULT GETDATE(),
	PRIMARY KEY (ProductID),
	FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID) ON DELETE CASCADE
);
GO

INSERT INTO Production.ProductCategory(Name)
VALUES ('Clothing'), ('Electronics'), ('Furniture');
GO

INSERT INTO Production.Product(Name, DefaultPrice, ListPrice, ProductCategoryID)
VALUES
('Mountain Bike Socks', 8.00, 12.00, 1),
('ACER Monitor 240hz', 1800.00, 2100.00, 2),
('G29 Driving Force', 1800.00, 2500.00, 2),
('GEFORCE RTX 2060', 1800.00, 2400.00, 2),
('Ducky One 2 Mini Keyboard', 1000.00, 1400.00, 2),
('G PRO Logitech Wireless', 400.00, 600.00, 2),
('Industrial Table', 300.00, 650.00, 3);
GO

INSERT INTO Production.ProductInventory(ProductID, Quantity)
VALUES
(1, 50), 
(2, 50),   
(3, 50),
(4, 50),   
(5, 50),  
(6, 50),   
(7, 50);   
GO

SELECT 
	p.Name AS NameProduct,
	pc.Name AS NameCategory,
	pi.Quantity AS QuantityInInventory
FROM 
	Production.Product p
JOIN
	Production.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
JOIN
	Production.ProductInventory pi ON p.ProductID = pi.ProductID;

	SELECT * FROM Production.ProductCategory;

DELETE FROM Production.Product 
	WHERE ProductCategoryID = (
	SELECT
		ProductCategoryID
	FROM
		Production.ProductCategory
	WHERE 
		Name = 'Clothing'
);

CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	Title NVARCHAR(10),
	FirstName NVARCHAR(50) NOT NULL,
	MiddleInitial CHAR(1),
	LastName NVARCHAR(50) NOT NULL
);

INSERT INTO Customer (Title, FirstName, MiddleInitial, LastName) VALUES
	('Mr','Alexandre','','Tavano'),('Mr','Willian','C','Pereira'),('Mr','Michael','B','Jordan'),('Mr','LeBron','','James')
	;

SELECT 
	CustomerID,
	Title,
	FirstName,
	MiddleInitial,
	LastName,
	CASE 
		WHEN Title IS NULL THEN ''
		ELSE Title + ' '
	END +
	FirstName + ' ' +
	CASE
		WHEN MiddleInitial IS NULL THEN ''
		ELSE MiddleInitial + '. '
	END +
	LastName AS FullName
FROM Customer
GROUP BY
	CustomerID, Title, FirstName, MiddleInitial, LastName;