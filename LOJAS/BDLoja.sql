/*CREATE TABLE filiais 
	(cod_filial smallint not null, nome varchar(80) not null, endereco varchar(80), mat_gerente smallint not null
	CONSTRAINT PKFiliais PRIMARY KEY (cod_filial)
	)*/

/*CREATE TABLE vendedor
	(mat_vendedor smallint not null, nome varchar(80),salario float(20), cpf smallint ,
	CONSTRAINT PKVendedor PRIMARY KEY (mat_vendedor),
	CONSTRAINT CPFUnique UNIQUE (cpf),
	CONSTRAINT SalarioMIN CHECK (salario>1000)
	)*/

/*CREATE TABLE fornecedor
	(cod_fornecedor smallint not null,
	CONSTRAINT PKFornecedor PRIMARY KEY (cod_fornecedor))*/

/*CREATE TABLE estoque
	(cod_estoque smallint not null, cod_for smallint not null,
	CONSTRAINT PKEstoque PRIMARY KEY (cod_estoque),
	CONSTRAINT FKEstoque FOREIGN KEY (cod_for) REFERENCES fornecedor ON DELETE CASCADE ON UPDATE CASCADE)*/

/*CREATE TABLE historico
	(coditem smallint not null, mat_vendedor smallint not null, data_hora_venda date not null, qntd smallint not null, pr_venda float not null,
	CONSTRAINT PKHistorico PRIMARY KEY (data_hora_venda,mat_vendedor,coditem),
	CONSTRAINT FKHistoricoVendedor FOREIGN KEY (mat_vendedor) REFERENCES vendedor ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FKHistoricoEstoque FOREIGN KEY (coditem) REFERENCES estoque ON DELETE CASCADE ON UPDATE CASCADE) */

--INSERT INTO fornecedor VALUES(1)
--DELETE FROM fornecedor where id=1
--ALTER TABLE fornecedor ADD nomecontato varchar(80) not null
--INSERT INTO fornecedor VALUES(2,'Fornecedor2')

--ALTER TABLE filiais ADD CONSTRAINT FKFiliaisGerente FOREIGN KEY (mat_gerente) REFERENCES vendedor ON DELETE CASCADE ON UPDATE NO ACTION
--ALTER TABLE vendedor ADD codfil smallint not null

--ALTER TABLE vendedor ADD CONSTRAINT FKVendedorFiliais FOREIGN KEY (codfil) REFERENCES filiais ON DELETE NO ACTION ON UPDATE CASCADE
--ALTER TABLE filiais ADD cnpj smallint  not null, CONSTRAINT CNPJUnique UNIQUE (cnpj)

--INSERT INTO filiais VALUES (1,'filial1','rua 1',null,1234)

--INSERT INTO vendedor VALUES(3,'vendedor3',1400,1234,1)

--DELETE FROM filiais //ERRO POIS TEM ON DELETE NO ACTION

--SELECT * FROM estoque

--insert into estoque values(1, 1, 'Pastelzin', 6, 5)

--insert into estoque select 7, 2, referencia, qtde, pvenda from estoque where cod_estoque = 1

--delete from estoque where cod_estoque = 5

--update estoque set referencia = 'Pastelzao' where cod_estoque = 4

--update estoque set pvenda = pvenda * 1.1 where cod_for = 1

--select cod_estoque,referencia,(pvenda)*1.15 as 'Preço de venda Simulado' from estoque

--ALTER TABLE historico ALTER COLUMN data_hora_venda datetime not null

--select nome as 'Nome do Vendedor',salario as 'Salário Líquido' from vendedor where codfil=1

--insert into historico VALUES(1,1,'10-10-10',3,40)

--select * from vendedor
--select * from filiais


--insert into historico select distinct 1,3,'11-10-12',qntd,40 from historico where coditem=1

--select distinct cod_estoque from estoque,historico where estoque.cod_estoque=historico.coditem

--select * from estoque where referencia like '%in'

--select vendedor.nome, filiais.nome, salario*1.15 as 'Salário Simulado'  from vendedor, filiais where vendedor.codfil=filiais.cod_filial








/* TESTES

SELECT * FROM vendedor

SELECT * FROM fornecedor

SELECT * FROM filiais;

SELECT * FROM vendedor,filiais WHERE mat_vendedor = mat_gerente;

INSERT INTO vendedor VALUES (2,'jarelio',1200,1,1);

INSERT INTO filiais VALUES(3,'filial3','rua verde 3',1,32142);

*/