--DOWNLOAD ADVENTURE WORKS
https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak
--REFERENCIAS
--FRAGMENTAÇÃO ENTRE 5 E 30 APLICAR REORGANIZE
--FRAGMENTAÇÃO MAIOR QUE 30 APLICAR REBUILD
--REORGANIZAR INDICES
USE AdventureWorks2017
SELECT '1' TEMPO,
c.[name] as 'Schema',
b.[name] as 'Tabela',
d.[name] as 'Indice',
a.avg_fragmentation_in_percent as PCT_Frag,
a.page_count as 'Paginas'
--INSERINDO EM TABELA TEMPORARIO
INTO #ANALISE_IX
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS a
INNER JOIN sys.tables b 
     on b.[object_id] = a.[object_id]
INNER JOIN sys.schemas c 
     on b.[schema_id] = c.[schema_id]
INNER JOIN sys.indexes AS d 
     ON d.[object_id] = a.[object_id]
	AND a.index_id = d.index_id
WHERE a.database_id = DB_ID()
AND a.avg_fragmentation_in_percent >5
AND d.[name]  IS NOT NULL
ORDER BY a.avg_fragmentation_in_percent desc

--VERIFICANDO DADOS DA TEMPO
SELECT * FROM #ANALISE_IX


--GERANDO DDL PARA RECONSTRUIR OU REORGANIZAR INDICES
SELECT 
c.[name] as 'Schema',
b.[name] as 'Tabela',
d.[name] as 'Index',
a.avg_fragmentation_in_percent as PCT_Frag,
a.page_count as 'Paginas',

--GERADNDO DDL
CASE WHEN a.avg_fragmentation_in_percent >5 
          and a.avg_fragmentation_in_percent<30
THEN  'ALTER INDEX '+d.[name]+' ON '+c.[name]+'.'+b.[name]+' REORGANIZE' 
   WHEN a.avg_fragmentation_in_percent >=30 
 THEN 'ALTER INDEX '+d.[name]+' ON '+c.[name]+'.'+b.[name]+' REBUILD' 
 ELSE ' ' END COMANDO
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS a
INNER JOIN sys.tables b 
     on b.[object_id] = a.[object_id]
INNER JOIN sys.schemas c 
     on b.[schema_id] = c.[schema_id]
INNER JOIN sys.indexes AS d 
     ON d.[object_id] = a.[object_id]
	AND a.index_id = d.index_id
WHERE a.database_id = DB_ID()
AND a.avg_fragmentation_in_percent >5
AND d.[name]  IS NOT NULL
ORDER BY a.avg_fragmentation_in_percent desc

--APLICANDO DDL PARA REBUILD OU REORGANIZE
ALTER INDEX PK_EmployeePayHistory_BusinessEntityID_RateChangeDate ON HumanResources.EmployeePayHistory REBUILD
ALTER INDEX PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate ON Sales.SalesPersonQuotaHistory REBUILD
ALTER INDEX AK_Product_ProductNumber ON Production.Product REBUILD
ALTER INDEX AK_Product_rowguid ON Production.Product REBUILD
ALTER INDEX AK_SpecialOfferProduct_rowguid ON Sales.SpecialOfferProduct REBUILD
ALTER INDEX PK_StateProvince_StateProvinceID ON Person.StateProvince REBUILD
ALTER INDEX IX_Store_SalesPersonID ON Sales.Store REBUILD
ALTER INDEX PK_ProductProductPhoto_ProductID_ProductPhotoID ON Production.ProductProductPhoto REBUILD
ALTER INDEX PK_ProductReview_ProductReviewID ON Production.ProductReview REBUILD
ALTER INDEX IX_ProductVendor_UnitMeasureCode ON Purchasing.ProductVendor REBUILD
ALTER INDEX PK_Vendor_BusinessEntityID ON Purchasing.Vendor REBUILD
ALTER INDEX PK_CountryRegion_CountryRegionCode ON Person.CountryRegion REBUILD
ALTER INDEX AK_CountryRegion_Name ON Person.CountryRegion REBUILD
ALTER INDEX AK_Employee_NationalIDNumber ON HumanResources.Employee REBUILD
ALTER INDEX PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID ON HumanResources.EmployeeDepartmentHistory REBUILD
ALTER INDEX PK_ProductListPriceHistory_ProductID_StartDate ON Production.ProductListPriceHistory REBUILD
ALTER INDEX PK_SpecialOfferProduct_SpecialOfferID_ProductID ON Sales.SpecialOfferProduct REBUILD
ALTER INDEX PK_ProductCostHistory_ProductID_StartDate ON Production.ProductCostHistory REBUILD
ALTER INDEX AK_ProductDescription_rowguid ON Production.ProductDescription REBUILD
ALTER INDEX IX_ProductReview_ProductID_Name ON Production.ProductReview REBUILD
ALTER INDEX AK_Store_rowguid ON Sales.Store REBUILD
ALTER INDEX AK_Employee_LoginID ON HumanResources.Employee REBUILD
ALTER INDEX IX_BusinessEntityContact_PersonID ON Person.BusinessEntityContact REBUILD
ALTER INDEX IX_BusinessEntityContact_ContactTypeID ON Person.BusinessEntityContact REBUILD
ALTER INDEX AK_BusinessEntityContact_rowguid ON Person.BusinessEntityContact REORGANIZE
ALTER INDEX AK_Product_Name ON Production.Product REORGANIZE
ALTER INDEX PK_DatabaseLog_DatabaseLogID ON dbo.DatabaseLog REORGANIZE
ALTER INDEX PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID ON Production.ProductModelProductDescriptionCulture REORGANIZE
ALTER INDEX PK_ProductVendor_ProductID_BusinessEntityID ON Purchasing.ProductVendor REORGANIZE
ALTER INDEX PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID ON Person.BusinessEntityContact REORGANIZE
ALTER INDEX PK_ProductInventory_ProductID_LocationID ON Production.ProductInventory REORGANIZE
ALTER INDEX IX_PurchaseOrderHeader_VendorID ON Purchasing.PurchaseOrderHeader REORGANIZE
ALTER INDEX IX_PurchaseOrderHeader_EmployeeID ON Purchasing.PurchaseOrderHeader REORGANIZE
ALTER INDEX IX_WorkOrder_ProductID ON Production.WorkOrder REORGANIZE
ALTER INDEX PK_BillOfMaterials_BillOfMaterialsID ON Production.BillOfMaterials REORGANIZE
ALTER INDEX IX_WorkOrderRouting_ProductID ON Production.WorkOrderRouting REORGANIZE
ALTER INDEX IX_BillOfMaterials_UnitMeasureCode ON Production.BillOfMaterials REORGANIZE
ALTER INDEX IX_TransactionHistoryArchive_ProductID ON Production.TransactionHistoryArchive REORGANIZE
ALTER INDEX PK_JobCandidate_JobCandidateID ON HumanResources.JobCandidate REORGANIZE
ALTER INDEX PK_Product_ProductID ON Production.Product REORGANIZE
ALTER INDEX IX_TransactionHistory_ProductID ON Production.TransactionHistory REORGANIZE
ALTER INDEX IX_Person_LastName_FirstName_MiddleName ON Person.Person REORGANIZE
ALTER INDEX IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID ON Production.TransactionHistoryArchive REORGANIZE
--GERANDO INFORMAÇÃO DA FRAGMENTAÇÃO APÓS REBUILD OU REORGANIZE

--INSERINDO EM TABELA TEMPORARIO
--DROP TABLE #ANALISE_IX
INSERT INTO #ANALISE_IX
SELECT '2' AS TEMPO,
c.[name] as 'Schema',
b.[name] as 'Tabela',
d.[name] as 'indice',
a.avg_fragmentation_in_percent as PCT_Frag,
a.page_count as 'Paginas'

FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS a
INNER JOIN sys.tables b 
     on b.[object_id] = a.[object_id]
INNER JOIN sys.schemas c 
     on b.[schema_id] = c.[schema_id]
INNER JOIN sys.indexes AS d 
     ON d.[object_id] = a.[object_id]
	AND a.index_id = d.index_id
WHERE a.database_id = DB_ID()
AND a.avg_fragmentation_in_percent >5
AND d.[name]  IS NOT NULL
ORDER BY a.avg_fragmentation_in_percent desc

--COMPARANDO ANTES E DEPOIS
--SELECT * FROM #ANALISE_IX
WITH ANTES (tempo, tabela, indice,pct)
as (select a.tempo,a.tabela,a.indice, a.Pct_frag from #ANALISE_IX a
		where a.tempo='1'),
DEPOIS (tempo, tabela, indice,pct)
as (select a.tempo,a.tabela,a.indice, a.Pct_frag from #ANALISE_IX a
		where a.tempo='2')

SELECT A.TABELA, A.indice,A.PCT,B.PCT,ISNULL((B.PCT/A.PCT),100) AS REDUCAO
FROM ANTES A
LEFT JOIN DEPOIS B
ON A.TABELA=B.TABELA
AND A.indice=B.indice

--ELIMINANDO A TABELA TEMP
DROP TABLE #ANALISE_IX

