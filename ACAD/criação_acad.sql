CREATE TABLE uni_academica 
(cod_ua smallint not null, nome varchar(100) not null, estado varchar(100), 
 cidade varchar(100), rua varchar(100), cep int,
CONSTRAINT PK_uni_academica PRIMARY KEY (cod_ua))

CREATE TABLE departamento
(cod_dep smallint not null, cod_ua smallint not null, nome varchar(100) not null, estado varchar(100), 
 cidade varchar(100), rua varchar(100), cep int,
CONSTRAINT PK_departamento PRIMARY KEY (cod_dep),
CONSTRAINT FK_departamento_ua FOREIGN KEY (cod_ua) REFERENCES uni_academica ON DELETE NO ACTION ON UPDATE CASCADE)
										 
CREATE TABLE curso
(cod_curso smallint not null, nome varchar(100) not null, estado varchar(100), 
 cidade varchar(100), rua varchar(100), cep int,
CONSTRAINT PK_curso PRIMARY KEY (cod_curso))	
								 
CREATE TABLE disciplina
(cod_disc smallint not null, nome varchar(100) not null, credito smallint not null,
CONSTRAINT PK_disciplina PRIMARY KEY (cod_disc))
									  
CREATE TABLE aluno
(mat_aluno int not null, nome varchar(100) not null, cpf int, rg int, estado varchar(100), 
 cidade varchar(100), rua varchar(100), cep int, cod_curso smallint not null,
CONSTRAINT PK_aluno PRIMARY KEY (mat_aluno),
CONSTRAINT FK_aluno_curso FOREIGN KEY (cod_curso) REFERENCES curso ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT CPF_Unique UNIQUE (cpf),
CONSTRAINT RG_Unique UNIQUE (rg))

CREATE TABLE professor
(mat_prof smallint not null, nome varchar(100) not null, cpf int, rg int,  estado varchar(100),  
 cidade varchar(100), rua varchar(100), cep int, cod_ua_diretor smallint, cod_curso_coord smallint, 
 cod_dep_chefe smallint, lotacao smallint not null, salario float,
CONSTRAINT PK_professor PRIMARY KEY (mat_prof),
CONSTRAINT FK_diretor_ua FOREIGN KEY (cod_ua_diretor) REFERENCES uni_academica ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_chefe_dep FOREIGN KEY (cod_dep_chefe) REFERENCES departamento ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_lotacao_dep FOREIGN KEY (lotacao) REFERENCES departamento ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_coordenador_curso FOREIGN KEY (cod_curso_coord) REFERENCES curso ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT CPFprof_Unique UNIQUE (cpf),
CONSTRAINT RGprof_Unique UNIQUE (rg))							 
									  
CREATE TABLE telefone_ua
(num_fone int not null, cod_ua smallint not null, tipo_fone varchar(100),
CONSTRAINT PK_telefone_ua PRIMARY KEY (num_fone,cod_ua),
CONSTRAINT FK_telefone_ua FOREIGN KEY (cod_ua) REFERENCES uni_academica ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE telefone_dep
(num_fone int not null, cod_dep smallint not null, tipo_fone varchar(100),
CONSTRAINT PK_telefone_dep PRIMARY KEY (num_fone,cod_dep),
CONSTRAINT FK_telefone_dep FOREIGN KEY (cod_dep) REFERENCES departamento ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE dep_curso
(cod_dep smallint not null, cod_curso smallint not null,
CONSTRAINT PK_dep_curso PRIMARY KEY (cod_dep,cod_curso),
CONSTRAINT FK_dep_curso FOREIGN KEY (cod_dep) REFERENCES departamento ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_curso_dep FOREIGN KEY (cod_curso) REFERENCES curso ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE curso_disc
(cod_disc smallint not null, cod_curso smallint not null,
CONSTRAINT PK_curso_disc PRIMARY KEY (cod_disc,cod_curso),
CONSTRAINT FK_curso_disc FOREIGN KEY (cod_disc) REFERENCES disciplina ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_disc_curso FOREIGN KEY (cod_curso) REFERENCES curso ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE prof_disc
(mat_prof smallint not null, cod_disc smallint not null, semestre smallint not null,
CONSTRAINT PK_prof_disc PRIMARY KEY (mat_prof,cod_disc,semestre),
CONSTRAINT FK_prof_disc FOREIGN KEY (mat_prof) REFERENCES professor ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_disc_prof FOREIGN KEY (cod_disc) REFERENCES disciplina ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE aluno_disc
(cod_disc smallint not null, mat_aluno smallint not null, semestre smallint not null, ap1 float, ap2 float, af float,
CONSTRAINT PK_aluno_disc PRIMARY KEY (cod_disc,mat_aluno,semestre),
CONSTRAINT FK_aluno_disc FOREIGN KEY (cod_disc) REFERENCES disciplina ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_disc_aluno FOREIGN KEY (mat_aluno) REFERENCES aluno ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE pre_req
(cod_disc smallint not null, cod_pre_req smallint not null,
CONSTRAINT PK_pre_req PRIMARY KEY (cod_disc,cod_pre_req),
CONSTRAINT FK_disc_pre_req FOREIGN KEY (cod_disc) REFERENCES disciplina ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_pre_req_disc FOREIGN KEY (cod_disc) REFERENCES disciplina ON DELETE NO ACTION ON UPDATE CASCADE)

								  