USE DB_OTIMIZA
GO

--HABILITANDO ESTATISCAS DE INFORMACAO
--Faz o SQL Server exibir informações referentes 
--à quantidade de atividade em disco gerada pelas instruções Transact-SQL.
SET STATISTICS io ON
--Exibe o número de milissegundos necessários para analisar, compilar e executar cada instrução.
SET STATISTICS time ON
GO


--ATIVAR PLANO DE EXECUÇÃO E SALVAR
--EXEMPLO DEMONSTRAÇÃO

--EXEMPLO 1 - CONSULTA SEM INDICE
SELECT a.CustomerID,a.FirstName,a.LastName
  FROM PESSOAS a where LastName = 'White';
GO
--EXEMPLO 2 - CONSULTA SEM INDICE COM JOIN 

SELECT A.CustomerID,A.FirstName,B.SalesOrderNumber,B.SubTotal,B.TaxAmt,B.TotalDue  
      FROM PESSOAS A
 INNER JOIN PEDIDO_MESTRE B
  ON A.CustomerID=B.CustomerID
WHERE A.BusinessEntityID='11091'

--EXEMPLO 3 - CONSULTA SEM INDICE COM JOIN  E COM ORDER BY 
--EXEC sp_updatestats; 
SELECT A.BusinessEntityID,A.FirstName,B.SalesOrderNumber,B.SubTotal,B.TaxAmt,B.TotalDue  
   FROM PESSOAS A
 INNER JOIN PEDIDO_MESTRE B
	ON A.CustomerID=B.CustomerID
WHERE B.DueDate BETWEEN '2012-01-01' AND '2012-31-12'
--ORDER BY A.FirstName

--EXEMPLO 4 - CONSULTA SEM INDICE COM JOIN  E AGREGACAO

SELECT    A.CustomerID,
          A.FirstName,
          SUM(B.SubTotal)SubTotal,
		  SUM(B.TaxAmt)TaxAmt,
          SUM(B.TotalDue)TotalDue 

FROM PESSOAS A
 INNER JOIN PEDIDO_MESTRE B
  ON A.CustomerID=B.CustomerID
WHERE A.BusinessEntityID IN ('11091','11003')
GROUP BY A.CustomerID,A.FirstName


----EXEMPLO 5 - CONSULTA SEM INDICE COM JOIN 4 TABELAS AGREGADO

SELECT    A.CustomerID,
          A.FirstName,
          C.ProductID,
		  D.Name,
		  SUM(C.OrderQty) OrderQty,
		  SUM(C.UnitPrice)UnitPrice,
		  SUM(C.UnitPriceDiscount)UnitPriceDiscount,
		  SUM(C.OrderQty*C.UnitPrice) AS TOTAL
		  FROM PESSOAS A
 INNER JOIN PEDIDO_MESTRE B
  ON A.CustomerID=B.CustomerID
  INNER JOIN PEDIDO_DETALHE C
  ON B.SalesOrderID=C.SalesOrderID
  INNER JOIN PRODUTOS D
  ON C.ProductID=D.ProductID
WHERE B.DueDate BETWEEN '2012-01-01' AND '2012-31-12'
GROUP BY A.CustomerID,A.FirstName,C.ProductID,D.Name
--ORDER BY A.CustomerID






