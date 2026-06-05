# Análisis de ventas — Northwind Database

## Descripción
Análisis exploratorio de una base de datos de ventas usando SQL puro.
El objetivo es responder preguntas de negocio concretas sobre productos,
clientes, empleados y tendencias temporales.

## Dataset
Northwind Database (SQLite version) — disponible en [jpwhite4/northwind-SQLite](https://github.com/jpwhite4/northwind-SQLite3)

## Herramientas
- SQLite / DB Browser
- VS Code

## Preguntas respondidas
1. ¿Cuáles son los 10 productos más vendidos por cantidad?
2. ¿Qué clientes generaron más ingresos totales?
3. ¿Qué empleado procesó más órdenes?
4. ¿Cuál es el precio promedio e ingreso promedio por categoría?
5. ¿Qué países tienen mayor volumen de compras?
6. ¿Cómo evolucionaron las ventas mes a mes?
7. ¿Qué clientes compraron por encima del promedio? ¿Qué porcentaje representa cada categoría?

## Conceptos aplicados
- JOINs múltiples entre tablas
- Funciones de agregación: SUM, COUNT, AVG
- Métricas calculadas: Quantity * UnitPrice
- Análisis temporal con strftime
- Subqueries dentro de HAVING
- Participación porcentual con subquery escalar

## Notas sobre los datos
Se detectaron registros corruptos en la tabla Customers
(CompanyName = 'IT', CustomerID = 'Val2' y 'VALON').
Fueron filtrados porque todos sus campos contenían datos inválidos,
no solo el nombre. Esta decisión está documentada en los comentarios
del archivo .sql.
