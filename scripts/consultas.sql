-- PROJETO ADVENTURE WORKS - ANÁLISE DE DADOS
-- Objetivo: Extração de métricas de vendas e comportamento do cliente

/* 
1. Visão Geral de Vendas por Categoria
Este script agrupa o total vendido por categoria de produto para identificar o carro-chefe da empresa.
*/

SELECT 
    cat.Name AS Categoria,
    SUM(det.LineTotal) AS TotalVendido,
    COUNT(det.SalesOrderID) AS QuantidadePedidos
FROM Sales.SalesOrderDetail AS det
JOIN Production.Product AS prod ON det.ProductID = prod.ProductID
JOIN Production.ProductSubcategory AS sub ON prod.ProductSubcategoryID = sub.ProductSubcategoryID
JOIN Production.ProductCategory AS cat ON sub.ProductCategoryID = cat.ProductCategoryID
GROUP BY cat.Name
ORDER BY TotalVendido DESC;

/* 
2. Perfil dos Clientes (Top 10)
Identifica os clientes que geraram maior receita, útil para estratégias de fidelização (CRM).
*/

SELECT TOP 10
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS NomeCliente,
    SUM(h.TotalDue) AS ValorTotalGasto
FROM Sales.Customer AS c
JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader AS h ON c.CustomerID = h.CustomerID
GROUP BY c.CustomerID, p.FirstName, p.LastName
ORDER BY ValorTotalGasto DESC;

/* 
3. Análise Temporal de Vendas
Agrupamento mensal das vendas para identificar sazonalidade e crescimento.
*/

SELECT 
    YEAR(OrderDate) AS Ano,
    MONTH(OrderDate) AS Mes,
    SUM(TotalDue) AS ReceitaMensal
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Ano, Mes;
