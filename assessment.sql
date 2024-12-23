CREATE TABLE Customers (CustomerID SERIAL PRIMARY KEY, CustomerName VARCHAR);
CREATE TABLE Products (ProductID SERIAL PRIMARY KEY, ProductName VARCHAR, Category VARCHAR);
 CREATE TABLE Orders (OrderID SERIAL PRIMARY KEY, CustomerID INT, OrderDate DATE, FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID));
CREATE TABLE Sales (SaleID SERIAL PRIMARY KEY, ProductID INT, OrderID INT, Quantity INT, Sales FLOAT, FOREIGN KEY (ProductID) REFERENCES Products(ProductID), FOREIGN KEY (OrderID) REFERENCES Orders(OrderID));




COPY Sales_data FROM 'C/sales.csv' DELIMITER ',' CSV HEADER;

COPY Orders_data FROM 'C:/orders.csv' DELIMITER ',' CSV HEADER;

COPY Products_data FROM 'C:/product_.csv' DELIMITER ',' CSV HEADER;

COPY Customers_data FROM 'C:/custosmers.csv' DELIMITER ',' CSV HEADER;


SELECT EXTRACT(MONTH FROM OrderDate) AS Month, SUM(Sales) AS TotalSales
FROM Orders
JOIN Sales ON Orders.OrderID = Sales.OrderID
GROUP BY Month
ORDER BY Month;


SELECT CustomerID, SUM(Sales) AS Revenue, RANK() OVER (ORDER BY SUM(Sales) DESC) AS Rank
FROM Sales
GROUP BY CustomerID;
