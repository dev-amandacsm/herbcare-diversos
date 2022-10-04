/*---------------------------------------------------------------
DDL SCRIPT - CRIACAO DAS TABELAS E CONSTRAINTS DO BANCO DE DADOS
-----------------------------------------------------------------*/

/* Criando o Banco de Dados */
CREATE DATABASE db_herbcare;
USE db_herbcare;

/* Criando a Tabela de Estados */
CREATE TABLE tb_Estado(
cd_Estado INT NOT NULL AUTO_INCREMENT,
nm_Estado VARCHAR(45) NOT NULL,
sg_Estado VARCHAR(2) NOT NULL,
CONSTRAINT pk_tb_Estado PRIMARY KEY(cd_Estado),
CONSTRAINT uc_nm_Estado UNIQUE(nm_Estado),
CONSTRAINT uc_sg_Estado UNIQUE(sg_Estado));

/* Criando a Tabela de Cidades */
CREATE TABLE tb_Cidade(
cd_Cidade INT NOT NULL AUTO_INCREMENT,
nm_Cidade VARCHAR(75) NOT NULL,
cd_Estado INT NOT NULL,
CONSTRAINT pk_tb_Cidade PRIMARY KEY(cd_Cidade),
CONSTRAINT uc_nm_Cidade UNIQUE(nm_Cidade),
CONSTRAINT fk_tb_Cidade_tb_Estado FOREIGN KEY(cd_Estado) REFERENCES tb_Estado(cd_Estado));

/* Criando a Tabela de Bairros */
CREATE TABLE tb_Bairro(
cd_Bairro INT NOT NULL AUTO_INCREMENT,
nm_Bairro VARCHAR(75) NOT NULL,
cd_Cidade INT NOT NULL,
cd_Estado INT NOT NULL,
CONSTRAINT pk_tb_Bairro PRIMARY KEY(cd_Bairro),
CONSTRAINT uc_nm_Bairro UNIQUE(nm_Bairro),
CONSTRAINT fk_tb_Bairro_tb_Cidade FOREIGN KEY(cd_Cidade) REFERENCES tb_Cidade(cd_Cidade),
CONSTRAINT fk_tb_Bairro_tb_Estado FOREIGN KEY(cd_Estado) REFERENCES tb_Estado(cd_Estado));

/* Criando a Tabela de Usuários */
CREATE TABLE tb_Usuario(
cd_Usuario INT NOT NULL AUTO_INCREMENT,
nm_Usuario VARCHAR(45) NOT NULL,
ds_Login VARCHAR(45) NOT NULL,
ds_Senha VARCHAR(45) NOT NULL,
cd_Estado INT NOT NULL,
cd_Cidade INT NOT NULL,
cd_Bairro INT NOT NULL,
ds_Logradouro VARCHAR(45) NOT NULL,
ds_Complemento VARCHAR(45),
CONSTRAINT pk_tb_Usuario PRIMARY KEY(cd_Usuario),
CONSTRAINT uc_ds_Login UNIQUE(ds_Login),
CONSTRAINT fk_tb_Usuario_tb_Bairro FOREIGN KEY(cd_Bairro) REFERENCES tb_Bairro(cd_Bairro),
CONSTRAINT fk_tb_Usuario_tb_Cidade FOREIGN KEY(cd_Cidade) REFERENCES tb_Cidade(cd_Cidade),
CONSTRAINT fk_tb_Usuario_tb_Estado FOREIGN KEY(cd_Estado) REFERENCES tb_Estado(cd_Estado));

/* Criando a Tabela de Categorias de Plantas */
CREATE TABLE tb_Categoria(
cd_Categoria INT NOT NULL,
nm_Categoria VARCHAR(45) NOT NULL,
ds_Categoria TINYTEXT,
CONSTRAINT pk_tb_Categoria PRIMARY KEY(cd_Categoria),
CONSTRAINT uc_nm_Categoria UNIQUE(nm_Categoria));

/* Criando a Tabela de Plantas */
CREATE TABLE tb_Planta(
cd_Planta INT NOT NULL AUTO_INCREMENT,
cd_Categoria INT NOT NULL,
nm_Popular VARCHAR(45) NOT NULL,
nm_Cientifico VARCHAR(45) NOT NULL,
ds_Receita TINYTEXT NOT NULL,
CONSTRAINT pk_tb_Planta PRIMARY KEY(cd_Planta),
CONSTRAINT uc_nm_Popular UNIQUE(nm_Popular),
CONSTRAINT uc_nm_Cientifico UNIQUE(nm_Cientifico),
CONSTRAINT fk_tb_Planta_tb_Categoria FOREIGN KEY(cd_Categoria) REFERENCES tb_Categoria(cd_Categoria));

/* Criando Tabela de Restrições */
CREATE TABLE tb_Restricao(
cd_Restricao INT NOT NULL AUTO_INCREMENT,
nm_Grupo VARCHAR(45) NOT NULL,
CONSTRAINT pk_tb_Restricao PRIMARY KEY(cd_Restricao),
CONSTRAINT uc_nm_Grupo UNIQUE(nm_Grupo));

/*Criando Tabela de Restrições da Planta */
CREATE TABLE tb_PlantaRestricao(
cd_PlantaRestricao INT NOT NULL AUTO_INCREMENT,
cd_Planta INT NOT NULL,
cd_Restricao INT NOT NULL,
CONSTRAINT pk_tb_PlantaRestricao PRIMARY KEY(cd_PlantaRestricao),
CONSTRAINT fk_tb_PlantaRestricao_tb_Planta FOREIGN KEY(cd_Planta) REFERENCES tb_Planta(cd_Planta),
CONSTRAINT fk_tb_PlantaRestricao_tb_Restricao FOREIGN KEY(cd_Restricao) REFERENCES tb_Restricao(cd_Restricao));

/* Criando a Tabela de Sintomas */
CREATE TABLE tb_Sintoma(
cd_Sintoma INT NOT NULL AUTO_INCREMENT,
nm_Sintoma VARCHAR(45) NOT NULL,
CONSTRAINT pk_tb_Sintoma PRIMARY KEY(cd_Sintoma),
CONSTRAINT uc_nm_Sintoma UNIQUE(nm_Sintoma));

/* Criando a Tabela de Sintomas da Planta */
CREATE TABLE tb_PlantaSintoma(
cd_PlantaSintoma INT NOT NULL AUTO_INCREMENT,
cd_Planta INT NOT NULL,
cd_Sintoma INT NOT NULL,
CONSTRAINT pk_tb_PlantaSintoma PRIMARY KEY(cd_PlantaSintoma),
CONSTRAINT fk_tb_PlantaSintoma_tb_Planta FOREIGN KEY(cd_Planta) REFERENCES tb_Planta(cd_Planta),
CONSTRAINT fk_tb_PlantaSintoma_tb_Sintoma FOREIGN KEY(cd_Sintoma) REFERENCES tb_Sintoma(cd_Sintoma));

/* Criando a Tabela de Favoritos (plantas favoritas do usuário) */
CREATE TABLE tb_Favorito(
cd_Favorito INT NOT NULL AUTO_INCREMENT,
cd_Usuario INT NOT NULL,
cd_Planta INT NOT NULL,
dt_Acao DATE NOT NULL,
CONSTRAINT pk_tb_Favorito PRIMARY KEY(cd_Favorito),
CONSTRAINT fk_tb_Favorito_tb_Usuario FOREIGN KEY(cd_Usuario) REFERENCES tb_Usuario(cd_Usuario),
CONSTRAINT fk_tb_Favorito_tb_Planta FOREIGN KEY(cd_Planta) REFERENCES tb_Planta(cd_Planta));
