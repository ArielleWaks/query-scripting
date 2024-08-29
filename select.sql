SELECT COUNT(*) FROM Employees;

SELECT * FROM Orders
LEFT JOIN Employees ON Orders.EmployeeID=Employees.EmployeeID;

SELECT * FROM Orders
LEFT JOIN OrderDetails ON Orders.OrderID=OrderDetails.OrderID
LEFT JOIN Products ON OrderDetails.ProductID=Products.ProductID;


SELECT (Price*Quantity) AS Revenue, * FROM (
    SELECT * FROM OrderDetails
             LEFT JOIN Orders ON OrderDetails.OrderID=Orders.OrderID
              ) AS ODFull
LEFT JOIN Products ON ODFull.ProductID=Products.ProductID;



SELECT (Quantity*Price),  FROM OrderDetails
LEFT JOIN Products ON OrderDetails.ProductID=Products.ProductID;


SELECT (Price*Quantity) AS Revenue, * FROM Orders, OrderDetails, Products
WHERE OrderDetails.ProductID=Products.ProductID
AND OrderDetails.OrderID=Orders.OrderID;

-- Returns revenue generated by each employee in order of most revenue
SELECT SUM(Price*Quantity) AS Revenue, EmployeeID FROM Orders, OrderDetails, Products
WHERE OrderDetails.ProductID=Products.ProductID
  AND OrderDetails.OrderID=Orders.OrderID
GROUP BY EmployeeID
ORDER BY SUM(Price*Quantity) DESC;

--  Which employee generated the most revenue?
SELECT TOP 1 SUM(Price*Quantity) AS Revenue, EmployeeID FROM Orders, OrderDetails, Products
WHERE OrderDetails.ProductID=Products.ProductID
  AND OrderDetails.OrderID=Orders.OrderID
GROUP BY EmployeeID
ORDER BY SUM(Price*Quantity) DESC;

SELECT * FROM Employees
WHERE EmployeeID = (
    SELECT TOP 1 EmployeeID FROM Orders, OrderDetails, Products
    WHERE OrderDetails.ProductID=Products.ProductID
      AND OrderDetails.OrderID=Orders.OrderID
    GROUP BY EmployeeID
    ORDER BY SUM(Price*Quantity) DESC
);

--  Which employ generated the least revenue?
SELECT TOP 1 SUM(Price*Quantity) AS Revenue, EmployeeID FROM Orders, OrderDetails, Products
WHERE OrderDetails.ProductID=Products.ProductID
  AND OrderDetails.OrderID=Orders.OrderID
GROUP BY EmployeeID
ORDER BY SUM(Price*Quantity) ASC;

-- SELECT CONCAT(CAST(Employees.FirstName AS varchar), ' ', CAST(Employees.LastName AS varchar)) AS FullName, * FROM Employees;


SELECT SUM(Price*Quantity) AS Revenue, EmployeeID FROM Orders, OrderDetails, Products
WHERE OrderDetails.ProductID=Products.ProductID
  AND OrderDetails.OrderID=Orders.OrderID
GROUP BY EmployeeID
ORDER BY SUM(Price*Quantity) DESC;

-- number of different products per order
SELECT COUNT(*) AS DistinctProducts, OrderID FROM OrderDetails
GROUP BY OrderID;

SELECT * FROM OrderDetails
INNER JOIN Orders ON OrderDetails.OrderID=Orders.OrderID;

-- employees who shipped the same item more than once?
SELECT Orders.EmployeeID, OrderDetails.ProductID, COUNT(OrderDetails.ProductId) AS ProductCount FROM Orders
INNER JOIN OrderDetails ON Orders.OrderID=OrderDetails.OrderID
GROUP BY Orders.EmployeeID, OrderDetails.ProductID
HAVING COUNT(OrderDetails.ProductId) > 1

-- number of employees who shipped the same item more than once?
SELECT COUNT(DISTINCT Orders.EmployeeID) FROM Orders
INNER JOIN OrderDetails ON Orders.OrderID=OrderDetails.OrderID
GROUP BY Orders.EmployeeID, OrderDetails.ProductID
HAVING COUNT(OrderDetails.ProductId) > 1;

-- Which employ created the most orders?
SELECT TOP 1 EmployeeID, COUNT(OrderID) AS OrderCount FROM Orders
GROUP BY EmployeeID
ORDER BY COUNT(OrderID) DESC;

-- How many customers are in the EU?
SELECT COUNT(*) FROM Customers
WHERE Country IN ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czechia', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden');

-- How many employs work for the company?
SELECT COUNT(*) AS NumberOfEmployees FROM Employees;

-- How many shipments had to travel to another country?
SELECT Suppliers.Country AS Origin, Customers.Country AS Destination FROM Suppliers
INNER JOIN Products ON Suppliers.SupplierID = Products.SupplierID
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID


-- How many shipments had to travel to another country?
SELECT COUNT(*) AS NumberOfShipments
FROM Suppliers, Products, OrderDetails, Orders, Customers
WHERE Suppliers.SupplierID = Products.SupplierID
  AND Products.ProductID = OrderDetails.ProductID
  AND OrderDetails.OrderID = Orders.OrderID
  AND Orders.CustomerID = Customers.CustomerID
  AND Suppliers.Country = Customers.Country;

-- How many unique products were purchased?
SELECT Count(DISTINCT ProductID) FROM OrderDetails;

-- Table with products per category
SELECT Categories.CategoryID, COUNT(*) AS NumberOfProducts FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryID;

-- Table with frequency of product categories purchased
SELECT Categories.CategoryID, COUNT(*) AS FrequencyOrdered FROM OrderDetails
INNER JOIN Products on OrderDetails.ProductID = Products.ProductID
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryID;

SELECT Categories.CategoryID, COUNT(*) AS FrequencyOrdered
FROM OrderDetails, Products, Categories
WHERE OrderDetails.ProductID = Products.ProductID
  AND Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryID;

-- Produce and confection products
SELECT ProductName
FROM Products
WHERE CategoryID IN (
    SELECT CategoryID FROM Categories
    WHERE CategoryName = 'Produce'
    OR CategoryName = 'Confections'
    );

-- correlated subquery
SELECT CustomerName
From Customers C
WHERE EXISTS(
    SELECT *
    FROM Orders O
    WHERE O.CustomerID = C.CustomerID
    AND O.OrderDate > 1996-12-11
);

-- order count per customer
SELECT CustomerName,
   (SELECT COUNT(*) FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID)
    AS OrderCount
FROM Customers;