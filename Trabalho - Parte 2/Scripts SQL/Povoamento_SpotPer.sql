use spotper;
--use master;
GO
INSERT INTO gravadora VALUES 
(1, 'AB Records', 'www.abrecords.com', 'rua ab', 'Cidade X', 'Pa�s Y'),
(2, 'Line Records', 'www.linerecords.com.br', 'RUA GENERAL GUSTAVO CORDEIRO DE FARIAS', 'Cidade X', 'Pa�s Y'),
(3, 'LGK Music', 'lgkmusic.com.br', 'teste LGK', 'Cidade X', 'Pa�s Y'),
(4, 'MK Music', 'www.mkmusic.com.br', 'Rua gotemburgo', 'Cidade X', 'Pa�s Y'),
(5, 'SONY', 'www.sonymusic.com.br', 'Rua da sony', 'Cidade X', 'Pa�s Y'),
(6, 'WARNER', 'www.wmg.com/', 'Rua da warner', 'Cidade X', 'Pa�s Y'),
(7, 'Som Livre', 'www.somlivre.com/', ' ', 'Cidade X', 'Pa�s Y'),
(8, 'Digital music', 'www.digitalmusic.com', 'rua digital music', 'Cidade X', 'Pa�s Y'),
(9, 'Laborat�rio Fantasma', 'site fantasma', 'Rua 447', 'Cidade X', 'Pa�s Y'),
(10, 'Indie Records', 'indie site', 'Rua indie', 'Cidade X', 'Pa�s Y'),
(11, 'Gospel Records', 'gospel records site', 'rua gospel', 'Cidade X', 'Pa�s Y'),
(12, 'Band Music', 'Band site', 'Rua band', 'Cidade X', 'Pa�s Y');

GO
INSERT INTO telefones VALUES
(1, '85996182019'),
(2, '85996182019'),
(3, '85996182019'),
(4, '85996182019'),
(5, '85996182019');

GO
INSERT INTO periodo_musical VALUES
(1, 'entre os s�culos V e XV', 'idade media'),
(2, 'entre o s�culo XIV e o s�culo XVI', 'renascenca'),
(3, 'entre o final do s�culo XVI e meados do s�culo XVIII', 'barroco'),
(4, 'VI - IV a. C.', 'classico'),
(5, 'Final do s�culo XVIII e grande parte do s�culo XIX', 'romantico'),
(6, '1453 indo at� 1789', 'moderno');

GO
INSERT INTO interprete VALUES
(20, 'Xuxa', 'SOLO'),
(1, 'Kades Singers', 'Coral'),
(2, 'Lexa', 'SOLO'),
(3, 'Anitta', 'SOLO'),
(4, 'Linkin Park', 'Banda'),
(5, 'Melim', 'Trio'),
(6, 'Henrique & Juliano', 'Dupla');

GO
INSERT INTO album VALUES
(1, 1, 'Hybrid theory', 29.00, '30/11/2018' ,'download', '01/06/2000'),
(2, 2, 'Super Nova', 35.00, '30/12/2012' ,'download', '01/02/2001'),
(3, 3, 'Lua Azul', 20.00, '10/10/2008' ,'download', '01/06/2005'),
(4, 4, 'Revolu��o', 80.00, '09/12/2015' ,'download', '01/04/2010'),
(5, 5, 'Sonar', 99.00, '01/02/2003' ,'download', '02/03/2002'),
(6, 6, 'Whaleship', 59.00, '27/05/2004' ,'download', '27/05/1992');

GO
INSERT INTO tipo_composicao VALUES
(1, 'sinfonia'),
(2, '�pera'),
(3, 'sonata'),
(4, 'concerto'),
(5, 'single');

GO
INSERT INTO compositor VALUES
(1, 'Linkin Park', 'Agoura Hills', 'Estados Unidos', '1996','' , 1),
(2, 'Arcangelo Corelli', 'Fusignano', 'Roma', '17/02/1653','08/01/1713' , 2),
(3, 'Marc-Antoine Charpentier', 'Paris', 'Fran�a', '02/04/1643','24/02/1704' , 3),
(4, 'Frank Martin', 'Genebra', 'Sui�a', '15/07/1890','21/09/1974' , 4),
(5, 'Thomas Ad�s', 'Londres', 'Inglaterra', '01/03/1972','' , 5);

GO
INSERT INTO faixa VALUES
(1, 1, 1,'DDD','Largado �s Tra�as', '00:02:03'),
(2, 2, 2,'ADD','Apelido Carinhoso', '00:03:04'),
(3, 3, 3,'DDD','Quem Ensinou Fui Eu', '00:04:05'),
(4, 4, 4,'ADD','Bu� Bu� Bu�', '00:05:06'),
(5, 5, 5,'DDD','Mais Amor e Menos Drama', '00:07:08'),

(1, 2, 2,'ADD','Z� da reca�da', '00:01:02'),
(2, 3, 3,'DDD','In my feelings', '01:00:00'),
(3, 4, 4,'ADD','Super-homem chora', '02:03:04'),
(4, 5, 5,'DDD','New rules', '01:05:06'),
(5, 1, 1,'ADD','Reggae in ro�a', '10:07:08'),

(1, 3, 5,'DDD','Deixe-me ir', '04:02:03'),
(2, 4, 4,'DDD','N�o fala n�o pra mim', '00:09:04'),
(3, 5, 3,'ADD','Filho do mato', '00:01:05'),
(4, 1, 2,'ADD','Havana', '00:02:06'),
(5, 2, 1,'DDD','Perfect', '00:03:02');

GO
insert into faixa_compositor VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5);

GO
INSERT INTO faixa_interprete VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5);

GO
INSERT INTO playlist (cod_play,nome,duracao_exec)VALUES
(1,'Playlist da Sofr�ncia', '00:00:00'),
(2,'Playlist do Sono', '00:00:00'),
(3,'Playlist do Fim de Semestre', '00:00:00'),
(4,'Playlist da Supera��o', '00:00:00'),
(5,'Playlist do Gado', '00:00:00');

GO
INSERT INTO faixa_playlist VALUES
(1,1,1,10,'03/12/2018'),
(2,2,2,12,'02/12/2018'),
(3,3,4,8,'01/12/2018'),
(4,4,4,3,'10/11/2018'),
(5,5,5,6,'09/11/2018'),
(1,5,2,22,'08/11/2018'),
(2,4,1,90,'02/07/2018'),
(3,3,5,102,'05/05/2018'),
(4,2,4,77,'27/02/2018'),
(5,1,3,66,'29/04/2018');
