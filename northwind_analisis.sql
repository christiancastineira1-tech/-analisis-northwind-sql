-- ============================================
-- Análisis de ventas - Northwind Database
-- Herramienta: DB Browser (SQLite)
-- Autor: Christian Castiñeira
-- ============================================


-- 1. Top 10 productos más vendidos por cantidad
SELECT ProductName, SUM(Quantity) AS total_vendido
FROM [Order Details]
JOIN Products ON [Order Details].ProductID = Products.ProductID
GROUP BY ProductName
ORDER BY total_vendido DESC
LIMIT 10;


-- 2. Clientes con más ingresos totales
-- Nota: se detectaron y filtraron registros corruptos (CompanyName = 'IT')
-- El registro fue excluido porque todos sus campos contenían datos inválidos
SELECT Customers.CompanyName AS Cliente, SUM(Quantity * UnitPrice) AS Ingresos_Totales
FROM [Order Details]
JOIN Orders ON [Order Details].OrderID = Orders.OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.CompanyName != 'IT'
GROUP BY Customers.CompanyName
ORDER BY Ingresos_Totales DESC
LIMIT 10;


-- 3. Empleado con más órdenes procesadas
SELECT Employees.FirstName, Employees.LastName,
       COUNT(Orders.OrderID) AS total_ordenes
FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Orders.EmployeeID
ORDER BY total_ordenes DESC;


-- 4. Precio promedio e ingreso promedio por categoría
SELECT CategoryName AS Categoría,
       AVG(c.UnitPrice) AS Precio_Promedio,
       AVG(Quantity * c.UnitPrice) AS Ingreso_Promedio_Por_Orden
FROM Products a
JOIN Categories b ON a.CategoryID = b.CategoryID
JOIN [Order Details] c ON a.ProductID = c.ProductID
GROUP BY CategoryName;


-- 5. Países con mayor volumen de compras
SELECT a.Country AS Pais, SUM(c.Quantity) AS Volumen_Total
FROM Customers a
JOIN Orders b ON a.CustomerID = b.CustomerID
JOIN [Order Details] c ON b.OrderID = c.OrderID
WHERE a.Country IS NOT NULL AND a.Country != ''
GROUP BY a.Country
ORDER BY Volumen_Total DESC
LIMIT 10;


-- 6. Evolución mensual de ventas
SELECT strftime('%Y-%m', OrderDate) AS Mes, 
       SUM(Quantity * UnitPrice) AS Ventas_Por_Mes
FROM Orders a
JOIN [Order Details] b ON a.OrderID = b.OrderID
GROUP BY strftime('%Y-%m', OrderDate)
ORDER BY Mes ASC;


-- 7a. Clientes que compraron por encima del promedio general
SELECT CompanyName, SUM(Quantity * UnitPrice) AS Total_Compras
FROM Customers a
JOIN Orders b ON a.CustomerID = b.CustomerID
JOIN [Order Details] c ON b.OrderID = c.OrderID
WHERE CompanyName != 'IT'
GROUP BY CompanyName
HAVING SUM(Quantity * UnitPrice) > (
    SELECT AVG(Quantity * UnitPrice)
    FROM Customers a
    JOIN Orders b ON a.CustomerID = b.CustomerID
    JOIN [Order Details] c ON b.OrderID = c.OrderID
)
ORDER BY Total_Compras DESC;


-- 7b. Participación porcentual de ventas por categoría
SELECT CategoryName AS Categoría,
       ROUND(SUM(Quantity * c.UnitPrice) * 100.0 / (
           SELECT SUM(Quantity * c.UnitPrice)
           FROM Categories a
           JOIN Products b ON a.CategoryID = b.CategoryID
           JOIN [Order Details] c ON b.ProductID = c.ProductID
       ), 2) AS Porcentaje_Del_Total
FROM Categories a
JOIN Products b ON a.CategoryID = b.CategoryID
JOIN [Order Details] c ON b.ProductID = c.ProductID
GROUP BY CategoryName
ORDER BY Porcentaje_Del_Total DESC;