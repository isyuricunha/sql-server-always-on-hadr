SELECT	'public ' +
		case when DATA_TYPE = 'datetime' then
			'DateTime'
		when DATA_TYPE = 'bit' then
			'bool'
		when DATA_TYPE = 'int' then
			'int'
		when DATA_TYPE = 'decimal' then
			'decimal'
		when DATA_TYPE = 'varchar' then
			'string'
		end + ' ' +
		UPPER(LEFT(COLUMN_NAME,1))+SUBSTRING(COLUMN_NAME,2,LEN(COLUMN_NAME))
		+ ' {get; set;}' as propriedade
FROM	INFORMATION_SCHEMA.COLUMNS
WHERE	TABLE_NAME = 'Movimento'