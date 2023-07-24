--Descobrindo Quantas DMV´s seu SQL Server tem

SELECT a.name, a.type_desc
FROM SYS.all_objects a
WHERE NAME LIKE ('dm%')
order by a.name

--Group by 
SELECT a.type_desc, COUNT(*) as QTD
FROM SYS.all_objects a
WHERE NAME LIKE ('dm%')
group by a.type_desc

--Group by ROLLUP
SELECT ISNULL(SUBSTRING(a.name,1,CHARINDEX('_',a.name,4)-1),'Total') MOME, COUNT(*) QTD
FROM SYS.all_objects a
WHERE NAME LIKE ('dm%')
group by SUBSTRING(a.name,1,CHARINDEX('_',a.name,4)-1) with rollup
order by 1 asc
