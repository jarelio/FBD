insert into historico VALUES(3,5,40,500,'13-10-10')
insert into vendedor VALUES(5,'jarelio5',1200,21443,5)
insert into filiais VALUES(5,'filal5','rua 5',null,13334)
insert into fornecedor VALUES(4,'fornecedor4','rua 4', 'fortaleza','ce')
insert into estoque VALUES(9,3,'pastelf',10,100,100)
select * from historico ORDER BY 1 desc
select * from estoque
select * from vendedor
select * from filiais
select * from fornecedor

SELECT f.nome as "Nome Fornecedor", v.nome as "Nome Vendedor" 
FROM fornecedor f, estoque e, vendedor v, historico h
WHERE cod_fornecedor=cod_for and cod_estoque=coditem and h.mat_vendedor=v.mat_vendedor ORDER BY 1

SELECT f.nome as "Nome Fornecedor" 
FROM fornecedor f, estoque e, historico h
WHERE cod_fornecedor=cod_for and cod_estoque=coditem GROUP BY f.nome,cod_for HAVING sum(h.qntd)>=all(SELECT sum(h.qntd) 
FROM historico h, fornecedor f, estoque e 
WHERE cod_fornecedor=cod_for and cod_estoque=coditem GROUP BY f.nome,cod_for)

SELECT v.nome as "Nome Vendedor"
FROM vendedor v, filiais f
WHERE v.codfil=f.cod_filial and v.salario>=(SELECT avg(salario) 
FROM vendedor j
WHERE v.codfil = j.codfil)

SELECT v.nome as "Nome Vendedor"
FROM vendedor v, filiais f
WHERE v.codfil=f.cod_filial and v.salario>=(SELECT avg(salario) 
FROM vendedor, filiais
WHERE v.codfil = f.cod_filial)

SELECT f.nome as "Nome Fornecedor", sum(h.qntd)
FROM fornecedor f, estoque e, historico h
WHERE cod_fornecedor=cod_for and cod_estoque=coditem
GROUP BY f.nome,cod_fornecedor ORDER BY 2 desc

SELECT f.nome as "Nome Fornecedor", e.descricao as "Nome Item "
FROM fornecedor f, estoque e, historico h, vendedor v
WHERE cod_fornecedor=cod_for and cod_estoque=coditem and h.mat_vendedor=v.mat_vendedor

SELECT f.nome 
FROM fornecedor f,estoque
WHERE cod_fornecedor=cod_for and cod_estoque=(SELECT cod_estoque
FROM estoque
WHERE NOT EXISTS 
( (SELECT v.mat_vendedor 
   FROM vendedor v)
   EXCEPT
  (SELECT h.mat_vendedor
   FROM historico h
   WHERE estoque.cod_estoque=h.coditem)
))
 
SELECT f.cod_fornecedor
FROM fornecedor f
WHERE NOT EXISTS
( (SELECT e.cod_estoque
   FROM estoque e
   WHERE e.cod_for=f.cod_fornecedor)
   INTERSECT
  (SELECT coditem
   FROM historico)
)

SELECT e.cod_estoque
FROM estoque e
WHERE e.cod_for=3
