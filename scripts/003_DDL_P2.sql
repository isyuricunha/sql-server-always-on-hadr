--DDL CRIANDO TABELA
use AULA_DDL;
GO
CREATE TABLE colaborador   
(      
		matricula INT IDENTITY(1,1) not null,
		--matricula INT IDENTITY(1,1) not null primary key,
	    nome      VARCHAR(50) NOT NULL,      
		sobrenome VARCHAR(50) NOT NULL,      
		endereco  VARCHAR(50),      
		cidade    VARCHAR(50),      
		pais      VARCHAR(25),      
		data_nasc DATE not null check(data_nasc<getdate()),
		data_cadastro datetime default getdate(),
		situacao char(1) default('A') -- ATIVO
		);

--DDL CRIANDO TABELA COM CHAVE ESTRANGEIRA
CREATE TABLE salario   
(      
	matricula INT PRIMARY KEY NOT NULL,      
	salario   DECIMAL(10, 2) NOT NULL check (salario>0)
    FOREIGN KEY(matricula) REFERENCES colaborador(matricula)
  ) ;
--CORRINGO ERRO PRA CRIAR A TABELA SALARIO
--DDL PARA ADICIONAR CHAVE PRIMARIA NA TAB colaborador
  ALTER TABLE colaborador ADD PRIMARY KEY (MATRICULA);

--DDL CRIACAO DE TABELA COM CHAVE PRIMARIA
CREATE TABLE audit_salario   
	(  
		transacao int identity(1,1)NOT NULL PRIMARY KEY,    
		matricula  INT NOT NULL,      
		data_trans DATETIME NOT NULL,      
		sal_antigo DECIMAL(10, 2),      
		sal_novo   DECIMAL(10, 2), 
		Usuario    varchar(20)not null   
		);

 -- ADD CHAVE ESTRANGEIRA

ALTER TABLE audit_salario
ADD FOREIGN KEY (matricula) REFERENCES colaborador(matricula); 

--TENTANDO EXCLUIR A TABELAS COLABORADOR 
DROP TABLE colaborador;

--DDL CRIACAO DE INDEX
 CREATE INDEX ix_func1 ON colaborador(data_nasc);
 CREATE INDEX ix_func2 ON colaborador(cidade,pais);

 