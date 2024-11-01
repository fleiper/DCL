CREATE DATABASE BD_EXPORTA;
USE BD_EXPORTA;

CREATE TABLE DEPARTAMENTO(
ID INT PRIMARY KEY auto_increment NOT NULL,
NOME VARCHAR (50),
LOCALIZACAO VARCHAR(50),
ORCAMENTO DECIMAL (10,2)
);


insert into DEPARTAMENTO (NOME,LOCALIZACAO,ORCAMENTO)
VALUES  ("TI", "MALDIVAS", 5000.00),
("RH", "IGUAPE", 2000.00),
("ADM", "ILHA DE BEÉM", 100.00),
("SEGURANÇA", "CARIBE", 10000.00);

SELECT * FROM DEPARTAMENTO
INTO OUTFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.cvs"
FIELDS TERMINATED BY ',' ENCLOSED BY """"
LINES TERMINATED BY "\n";

####o meu funcionou mas quero deixar ele presente
SHOW VARIABLES LIKE 'secure_file_prv';

delete from DEPARTAMENTO WHERE ID = 4;

#Importa arquivo .cvs exportado
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.cvs'
INTO TABLE DEPARTAMENTO
FIELDS TERMINATED BY ',' ENCLOSED BY """"
LINES TERMINATED BY "\n";

START TRANSACTION ;

UPDATE DEPARTAMENTO SET ORCAMENTO = ORCAMENTO + 1000.00 WHERE NOME = 'TI';
UPDATE DEPARTAMENTO SET ORCAMENTO = ORCAMENTO + 1000.00 WHERE NOME = 'RH';

COMMIT;
#===========================================================================
START TRANSACTION ;

UPDATE DEPARTAMENTO SET ORCAMENTO = ORCAMENTO + 1000.00 WHERE NOME = 'TI';
UPDATE DEPARTAMENTO SET ORCAMENTO = ORCAMENTO + 1000.00 WHERE NOME = 'RH';

ROLLBACK;
#===========================================================================

start transaction;
UPDATE DEPARTAMENTO SET ORCAMENTO = ORCAMENTO + 7000.00 WHERE NOME = 'Segurança';
Savepoint ajuste_parcial;

UPDATE DEPARTAMENTO SET ORCAMENTO = ORCAMENTO + 2000.00 WHERE NOME = 'ADM';

rollback to ajuste_parcial;