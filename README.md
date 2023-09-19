# SQL-Server-Examples

Repository with examples of scripts used as needed in day-to-day tasks.

### 01_merge_information_from_tables_and_add_to_a_new_one

Below, tables A and B have information about different CNPJs and company names.
It is necessary to merge the information from both tables into a single one and create a new table C with the combined information.

```sql
DECLARE @tb_A AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))
DECLARE @tb_B AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))
DECLARE @tb_C_temporary AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))

INSERT INTO @tb_A
  VALUES
		('00000000000191', 'COMPANY A01'),
		('00000000000192', 'COMPANY A02'),
		('00000000000193', 'COMPANY A03')

INSERT INTO @tb_B
	VALUES
		('00000000000291', 'COMPANY B01'),
		('00000000000292', 'COMPANY B02'),
		('00000000000293', 'COMPANY B03')

--Inserting the information into a temporary table.
INSERT INTO @tb_C_temporary
  SELECT * FROM (
    SELECT * FROM @tb_A
    UNION
    SELECT * FROM @tb_B
) AS T

--Listing the information added to the temporary table
SELECT * FROM @tb_C_temporary

--Creating a new table in the database with the information from tables A and B
SELECT * INTO createdTableInDatabase FROM (
	SELECT * FROM @tb_A
	UNION
	SELECT * FROM @tb_B
) AS T

--Listing the information added to the table
SELECT * FROM createdTableInDatabase
```

### Result

![image](https://user-images.githubusercontent.com/55838972/67859447-084ffc00-faf2-11e9-8f5c-fe38b5e4a54e.png)

### 02_group_duplicate_records_and_get_the_latest_registration_date

Below are 6 records where there are duplicate CNPJs but with different registration dates.
It is necessary to extract only the CNPJs where the registration date is the latest.

```sql
DECLARE @TB_TABLE AS TABLE (cnpj varchar(20), registrationDate DATE)

INSERT INTO @TB_TABLE
	VALUES
		('00.000.000/0001-11', '01/30/2014'),
		('00.000.000/0001-11', '07/05/2017'),
		('00.000.000/0002-22', '06/07/2011'),
		('00.000.000/0002-22', '06/05/2015'),
		('00.000.000/0003-33', '07/18/2019'),
		('00.000.000/0003-33', '07/08/2019')

SELECT
     cnpj,
     MAX(CONVERT(VARCHAR(10), registrationDate, 101)) as registrationDate
FROM @TB_TABLE
GROUP BY cnpj
ORDER BY registrationDate ASC
```

### Result

![image](https://user-images.githubusercontent.com/55838972/67859731-b22f8880-faf2-11e9-9fd9-bfd3703257ee.png)

### 03_identify_records_that_do_not_exist_in_another_table

Below are two tables, A and B. Table A has 3 records of CNPJs, and Table B has two repeated records from A. It is necessary to identify which CNPJ from table A does not exist in table B.

```sql
DECLARE @tb_CLIENT_A AS TABLE (CNPJ VarChar(14))
DECLARE @tb_CLIENT_B AS TABLE (CNPJ VarChar(14))

INSERT INTO @tb_CLIENT_A
	VALUES  ('00000000000191'),
		('00000000000192'),
		('00000000000193')

INSERT INTO @tb_CLIENT_B
	VALUES  ('00000000000191'),
		('00000000000192')

--Returns the unique CNPJ that does not exist in table B (193)
SELECT * FROM @tb_CLIENT_A
EXCEPT
SELECT * FROM @tb_CLIENT_B

--Will not return records because both CNPJs already exist in table A
SELECT * FROM @tb_CLIENT_B
EXCEPT
SELECT * FROM @tb_CLIENT_A
```

### Result

![image](https://user-images.githubusercontent.com/55838972/67859977-371aa200-faf3-11e9-99ba-13145b8a8cf6.png)
