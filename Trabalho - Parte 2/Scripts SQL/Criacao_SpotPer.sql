use master
go
IF EXISTS(select * from sys.databases where name='spotper')
DROP DATABASE spotper;
go
---------------CRIAÇÃO DO BANCO---------------
--1Questão e 2Questão

CREATE DATABASE spotper 
ON
	PRIMARY(
		NAME = 'spotper',
		FILENAME= 'C:\FBD\spotper\spotper.mdf',
		SIZE= 5120KB,
		FILEGROWTH= 1024KB
	),

	FILEGROUP spotper_fg01(
		NAME= 'spotper_001',
		FILENAME= 'C:\FBD\spotper\spotper_001.ndf',
		SIZE= 1024KB,
		FILEGROWTH= 30%
	),
	(
		NAME= 'spotper_002',
		FILENAME= 'C:\FBD\spotper\spotper_002.ndf',
		SIZE= 1024KB,
		FILEGROWTH= 15%
	),

	FILEGROUP spotper_fg02(
		NAME= 'spotper_003',
		FILENAME= 'C:\FBD\spotper\spotper_003.ndf',
		SIZE=1024KB,
		FILEGROWTH=1024KB
	)

	LOG ON
	(
		NAME= 'spotper_log',
		FILENAME= 'C:\FBD\spotper\spotper_log.ldf',
		SIZE= 1024KB,
		FILEGROWTH= 10%
	)

---------------TABELAS - FILEGROUPS---------------

---telefones, gravadora, album, tipo_composicao, faixa_interprete, interprete, faixa_compositor, compositor, periodo_musical - spotper_fg01
---playlist, faixa, faixa_playlist - spotper_fg02


---------------CRIAÇÃO DAS TABELAS---------------

---spotper_fg01---
go
USE spotper
go

CREATE TABLE telefones (
						cod_grav int not null,
						telefone varchar(15) not null, 
						CONSTRAINT telefones_pk PRIMARY KEY (telefone,cod_grav)
						) ON spotper_fg01;

CREATE TABLE gravadora (
						cod_grav int not null,
						nome varchar(50) not null,
						site_grav varchar(50),
						rua varchar(50) not null,
						cidade varchar(50) not null,
						pais varchar(50) not null,
						CONSTRAINT gravadora_pk PRIMARY KEY (cod_grav)
						) ON spotper_fg01;

CREATE TABLE album (
					cod_album int not null,
					cod_grav int not null,
					descricao varchar(50) not null,
					preco_compra float not null,
					data_compra datetime not null,
					tipo_compra varchar(10) not null, 
					data_grav date not null,
					CONSTRAINT album_pk PRIMARY KEY (cod_album),
					CONSTRAINT album_data_limite CHECK (data_compra > '01/01/2000'), -- CHECK 1 ALBUM (verificar tipo DATE)
					CONSTRAINT album_tipo_compra CHECK (tipo_compra='cd' or tipo_compra='vinil' or tipo_compra='download') -- CHECK 2 ALBUM  
					) ON spotper_fg01;

CREATE TABLE tipo_composicao (
								id_tipo_comp int not null,
								descricao varchar(50) not null,
								CONSTRAINT tipo_composicao_pk PRIMARY KEY (id_tipo_comp)
								) ON spotper_fg01;

CREATE TABLE faixa_interprete (
								numero_faixa int not null,
								cod_album int not null,
								id_int int not null,
								CONSTRAINT faixa_interprete_pk PRIMARY KEY (id_int,numero_faixa,cod_album)
								) ON spotper_fg01;

CREATE TABLE interprete (
							id_int int not null,
							descricao varchar(50) not null,
							tipo varchar(20) not null,
							CONSTRAINT interprete_pk PRIMARY KEY(id_int)
							) ON spotper_fg01;

CREATE TABLE faixa_compositor (
								numero_faixa int not null,
								cod_album int not null,
								id_comp int not null,
								CONSTRAINT faixa_compositor_pk PRIMARY KEY (id_comp,numero_faixa,cod_album)
								) ON spotper_fg01; 
								
CREATE TABLE compositor (
							id_comp int not null,
							nome varchar(50) not null,
							cidade_nasc varchar(30) not null,
							pais_nasc varchar(30) not null,
							dt_nasc date not null,
							dt_morte date,
							cod_periodo int not null,
							CONSTRAINT compositor_pk PRIMARY KEY (id_comp)
							) ON spotper_fg01;
							
CREATE TABLE periodo_musical (
								cod_periodo int not null,
								intervalo varchar(120) not null,
								descricao varchar(50) not null, 
								CONSTRAINT periodo_musical_pk PRIMARY KEY (cod_periodo),
								CONSTRAINT periodo_musical_descricao CHECK (descricao = 'idade media' or descricao = 'renascenca' or 
																			descricao = 'barroco' or descricao = 'classico' or 
																			descricao = 'romantico' or descricao = 'moderno') -- CHECK 3 PERIODO MUSICAL
								) ON spotper_fg01;

---spotper_fg02---

CREATE TABLE playlist (
						cod_play int not null,
						nome varchar(30) not null,
						dt_criacao datetime default sysdatetime(),
						duracao_exec time not null,
						CONSTRAINT playlist_pk PRIMARY KEY (cod_play)
						) ON spotper_fg02;

CREATE TABLE faixa (
						numero_faixa int not null,
						cod_album int not null,
						id_tipo_comp int not null,
						tipo_grav varchar(20) not null,
						descricao varchar(50) not null,
						tempo_exec_faixa time not null,
						CONSTRAINT faixa_pk PRIMARY KEY NONCLUSTERED (numero_faixa,cod_album),
						CONSTRAINT faixa_tipo_grav CHECK (tipo_grav = 'ADD' or tipo_grav = 'DDD') -- CHECK 4 FAIXA
						) ON spotper_fg02;

CREATE TABLE faixa_playlist (
								cod_play int not null,
								numero_faixa int not null,
								cod_album int not null,
								qntd_tocada int not null,
								ult_vez_tocada datetime,
								CONSTRAINT faixa_playlist_pk PRIMARY KEY (cod_play,numero_faixa,cod_album)
								) ON spotper_fg02;


---------------CRIAÇÃO DAS CHAVES ESTRANGEIRAS---------------

--Tabela telefone
ALTER TABLE telefones ADD CONSTRAINT telefone_gravadora_fk
FOREIGN KEY (cod_grav)
REFERENCES gravadora (cod_grav)
ON DELETE NO ACTION
ON UPDATE CASCADE;

--Tabela album
ALTER TABLE album ADD CONSTRAINT album_gravadora_fk
FOREIGN KEY (cod_grav)
REFERENCES gravadora (cod_grav)
ON DELETE NO ACTION
ON UPDATE CASCADE;

--Tabela faixa_interprete
ALTER TABLE faixa_interprete ADD CONSTRAINT faixa_interprete_faixa_fk
FOREIGN KEY (numero_faixa, cod_album)
REFERENCES faixa (numero_faixa, cod_album)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE faixa_interprete ADD CONSTRAINT faixa_interprete_interprete_fk
FOREIGN KEY (id_int)
REFERENCES interprete (id_int)
ON DELETE NO ACTION
ON UPDATE CASCADE;

--Tabela faixa_compositor
ALTER TABLE faixa_compositor ADD CONSTRAINT faixa_compositor_compositor_fk
FOREIGN KEY (id_comp)
REFERENCES compositor (id_comp)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE faixa_compositor ADD CONSTRAINT faixa_compositor_faixa_fk
FOREIGN KEY (numero_faixa, cod_album)
REFERENCES faixa (numero_faixa, cod_album)
ON DELETE CASCADE
ON UPDATE CASCADE;

--Tabela compositor
ALTER TABLE compositor ADD CONSTRAINT compositor_periodo_musical_fk
FOREIGN KEY (cod_periodo)
REFERENCES periodo_musical (cod_periodo)
ON DELETE NO ACTION
ON UPDATE CASCADE;

--Tabela faixa
ALTER TABLE faixa ADD CONSTRAINT faixa_tipo_composicao_fk
FOREIGN KEY (id_tipo_comp)
REFERENCES tipo_composicao (id_tipo_comp)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE faixa ADD CONSTRAINT faixa_album_fk
FOREIGN KEY (cod_album)
REFERENCES album (cod_album)
ON DELETE CASCADE
ON UPDATE CASCADE;

--Tabela faixa_playlist
ALTER TABLE faixa_playlist ADD CONSTRAINT faixa_playlist_playlist_fk
FOREIGN KEY (cod_play)
REFERENCES playlist (cod_play)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE faixa_playlist ADD CONSTRAINT faixa_playlist_faixa_fk
FOREIGN KEY (numero_faixa, cod_album)
REFERENCES faixa (numero_faixa, cod_album)
ON DELETE CASCADE
ON UPDATE CASCADE;

---------------CRIAÇÃO DOS ÍNDICES---------------
--4Questão

CREATE CLUSTERED INDEX faixa_cod_album_index_clus
ON faixa(cod_album) 
WITH (fillfactor=100, pad_index=on);


CREATE INDEX faixa_id_tipo_comp_index_sec
ON faixa(id_tipo_comp) 
WITH (fillfactor=100, pad_index=on);

---------------CRIAÇÃO DAS TRIGGERS---------------
--3Questão

--a.
GO
CREATE TRIGGER faixa_barroco_gravacao_album_ddd
ON faixa_compositor
AFTER INSERT, UPDATE
AS
IF (EXISTS(select i.numero_faixa
			from inserted i, faixa f, compositor c, periodo_musical pm
			where i.numero_faixa = f.numero_faixa and i.cod_album=f.cod_album and i.id_comp = c.id_comp 
			and c.cod_periodo = pm.cod_periodo and pm.descricao='barroco' and f.tipo_grav!='DDD'))
BEGIN
	RAISERROR('Não é possível adicionar uma faixa do período barroco sem a gravação DDD!!!', 10, 6)
	ROLLBACK TRANSACTION
END;

--b.
GO
CREATE TRIGGER qtd_max_faixa_album
ON faixa
AFTER INSERT
AS
IF( ((select count(*)
	from faixa, inserted
	where faixa.cod_album = inserted.cod_album)+1) > (64)) 

BEGIN
	RAISERROR('Limite máximo de faixas no album atingido!!!', 10, 6)
	ROLLBACK TRANSACTION
END;

--c. já implementada nos ON DELETE CASCADE onde possui REFERENCES faixa


---------------CRIAÇÃO DAS VIEWS---------------
--5Questão

GO
create view view_playlist_albuns(cod_play,playlist, num_album)
with schemabinding
as
	select p.cod_play,p.nome, count_big(*) from dbo.playlist p, dbo.faixa_playlist fp, dbo.faixa f
	where p.cod_play=fp.cod_play and fp.numero_faixa=f.numero_faixa and fp.cod_album=f.cod_album
	group by p.cod_play,p.nome

GO
create unique clustered index i_view_playlist_albuns 
on view_playlist_albuns(cod_play,playlist)

---------------CRIAÇÃO DAS FUNÇÕES---------------
--6Questão

go
create function compositor_albuns(@nome_compositor varchar(50))
returns @albunsTable TABLE
(
	cod_album int not null
)
AS
BEGIN
	insert into @albunsTable
	select a.cod_album
	from album a, faixa_compositor fc, compositor c
	where fc.cod_album = a.cod_album and fc.id_comp=c.id_comp and c.nome like '%'+@nome_compositor+'%'
return
END

---------------CRIAÇÃO DA APLICAÇÃO---------------
--7Questão e 8Questão: Implementação do APP


---------------CONSULTAS SQL---------------
--9Questão

--a.

select a.descricao 
from album a
group by a.cod_album, a.preco_compra, a.descricao
having (a.preco_compra>(select avg(a2.preco_compra) from album a2))

--b.
/*
insert into faixa values(5,4,3,'ADD','Faixa Teste','00:06:02')
insert into faixa values(5,3,2,'DDD','Faixa Teste2','00:02:02')
insert into faixa values(4,3,5,'ADD','Faixa Teste3','00:05:02')
insert into faixa_compositor VALUES(5,4,4)
insert into faixa_compositor VALUES(5,3,4)
insert into faixa_compositor VALUES(4,3,4)
insert into faixa_playlist VALUES(5,5,4,99,'2018-04-12 14:07:00')
insert into faixa_playlist VALUES(1,5,3,89,'2018-04-12 14:18:00')
insert into faixa_playlist VALUES(1,4,4,22,'2018-04-12 14:33:00')
insert into faixa_playlist VALUES(1,4,3,36,'2018-04-12 14:37:00')
*/

select g.nome as 'Nome da Gravadora', count(distinct fp.cod_play) as 'Quantidade de Playlists'
from gravadora g inner join album a on g.cod_grav=a.cod_grav
	 inner join faixa f on a.cod_album = f.cod_album
	 inner join faixa_playlist fp on fp.cod_album = f.cod_album and fp.numero_faixa=f.numero_faixa
	 inner join faixa_compositor fc on f.numero_faixa = fc.numero_faixa and f.cod_album = fc.cod_album
	 inner join compositor c on fc.id_comp = c.id_comp
	 and c.nome='Frank Martin'
group by g.cod_grav, g.nome
having count(fp.cod_play)>=all(select count(fp.cod_play)
from gravadora g inner join album a on g.cod_grav=a.cod_grav
	 inner join faixa f on a.cod_album = f.cod_album
	 inner join faixa_playlist fp on fp.cod_album = f.cod_album and fp.numero_faixa=f.numero_faixa
	 inner join faixa_compositor fc on f.numero_faixa = fc.numero_faixa and f.cod_album = fc.cod_album
	 inner join compositor c on fc.id_comp = c.id_comp
	 and c.nome='Frank Martin'
group by g.cod_grav)

--c.

select c.nome as 'Nome Compositor', count(c.id_comp) as 'Número de Faixas'
from compositor c inner join faixa_compositor fc on c.id_comp=fc.id_comp
	 inner join faixa f on fc.numero_faixa=f.numero_faixa and fc.cod_album=f.cod_album
	 inner join faixa_playlist fp on f.numero_faixa=fp.numero_faixa and f.cod_album=fp.cod_album
group by c.id_comp, c.nome
having count(c.id_comp)>=all(select count(c.id_comp)
from compositor c inner join faixa_compositor fc on c.id_comp=fc.id_comp
	 inner join faixa f on fc.numero_faixa=f.numero_faixa and fc.cod_album=f.cod_album
	 inner join faixa_playlist fp on f.numero_faixa=fp.numero_faixa and f.cod_album=fp.cod_album
group by c.id_comp)

--d.

go
create function funcao_9_d (@codplay_input smallint)
returns	table
as
return(select f2.numero_faixa, f2.cod_album
from playlist p inner join faixa_playlist fp on p.cod_play=fp.cod_play and p.cod_play=@codplay_input
inner join faixa f2 on fp.numero_faixa=f2.numero_faixa and fp.cod_album=f2.cod_album
inner join tipo_composicao tc on tc.id_tipo_comp=f2.id_tipo_comp 
inner join faixa_compositor fc on fc.numero_faixa=f2.numero_faixa and fc.cod_album=f2.cod_album
inner join compositor c on fc.id_comp=c.id_comp
inner join periodo_musical pm on pm.cod_periodo=c.cod_periodo
where (pm.descricao!='classico' or tc.descricao!='concerto'))

go
select p.cod_play,p.nome as 'Playlist', f.numero_faixa,f.descricao as 'Faixa', pm.descricao as 'Período', tc.descricao as 'Tipo Composição', c.nome as 'Nome Compositor'
from playlist p inner join faixa_playlist fp on p.cod_play=fp.cod_play
inner join faixa f on fp.numero_faixa=f.numero_faixa and fp.cod_album=f.cod_album
inner join tipo_composicao tc on tc.id_tipo_comp=f.id_tipo_comp 
inner join faixa_compositor fc on fc.numero_faixa=f.numero_faixa and fc.cod_album=f.cod_album
inner join compositor c on fc.id_comp=c.id_comp
inner join periodo_musical pm on pm.cod_periodo=c.cod_periodo
and not exists(select * from dbo.funcao_9_d(p.cod_play))



