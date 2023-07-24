--LINKS BTREE
-- https://www.cs.usfca.edu/~galles/visualization/BTree.html
--AJUSTE DE PERFORMANCE


--CRIAR UM BANCO DE DADOS
--DROP DATABASE DB_OTIMIZA
CREATE DATABASE DB_OTIMIZA
GO
--DESLIGANDO ESTATISTICAS
ALTER DATABASE DB_OTIMIZA SET AUTO_CREATE_STATISTICS OFF
GO

USE DB_OTIMIZA


--CARGA DE DADOS ORIGEM ADVENTUREWORS2017
--CRIANDO A TABELA PESSOAS

SELECT A.BusinessEntityID,B.CustomerID,A.PersonType,A.Title,A.FirstName,A.LastName 
        INTO PESSOAS
FROM AdventureWorks2017.Person.Person A
 INNER JOIN AdventureWorks2017.Sales.Customer B
 ON A.BusinessEntityID=B.PersonID

--CRIANDO A TABELA DE PRODUTOS
SELECT a.ProductID,a.Name,a.ProductNumber,a.MakeFlag,a.SafetyStockLevel,a.ReorderPoint,
       a.StandardCost,a.ListPrice,a.Size,a.ProductLine,a.Class,a.Style
     INTO PRODUTOS
FROM AdventureWorks2017.Production.Product a


--CRIANDO TABELAS DE PEDIDO_MESTRE

SELECT A.SalesOrderID,A.OrderDate,A.DueDate,A.ShipDate,A.Status,A.SalesOrderNumber,
       A.PurchaseOrderNumber,A.CustomerID,A.SalesPersonID,A.SubTotal,A.TaxAmt,A.Freight,A.TotalDue
	   INTO PEDIDO_MESTRE
FROM AdventureWorks2017.Sales.SalesOrderHeader A

--CRIANDO TABELAS DE PEDIDO_DETALHE
SELECT a.SalesOrderID,
       a.SalesOrderDetailID,
	   a.OrderQty,
	   a.ProductID,
	   a.UnitPrice,
       a.UnitPriceDiscount,
	   a.LineTotal
	   INTO PEDIDO_DETALHE
FROM AdventureWorks2017.Sales.SalesOrderDetail A

--ANALISANDO AS TABELAS CRIADAS ALT+F1
SELECT * FROM PRODUTOS
SELECT * FROM PESSOAS
SELECT * FROM PEDIDO_MESTRE
SELECT * FROM PEDIDO_DETALHE
SELECT * FROM VENDEDORES
