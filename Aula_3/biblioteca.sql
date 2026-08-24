-- -----------------------------------------------------
-- CRIAR BANCO 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS biblioteca DEFAULT CHARACTER SET utf8;
USE biblioteca;

-- -----------------------------------------------------
-- CRIAR TABELA LIVRO
-- -----------------------------------------------------
CREATE TABLE livro (
  pk_livro_id INT NOT NULL,
  titulo VARCHAR(200) NOT NULL,
  autor VARCHAR(120) NOT NULL,
  PRIMARY KEY (pk_livro_id)
);

-- -----------------------------------------------------
-- CRIAR TABELA USUÁRIO
-- -----------------------------------------------------
CREATE TABLE usuario (
  pk_usuario_id INT NOT NULL,
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL,
  PRIMARY KEY (pk_usuario_id)
);

-- -----------------------------------------------------
-- CRIAR TABELA LIVRO_HAS_USUARIO 
-- -----------------------------------------------------
CREATE TABLE livro_has_usuario (
  pk_livro_has_usuario_id INT NOT NULL,
  fk_livro_id INT NOT NULL,
  fk_usuario_id INT NOT NULL,
  data_retirada DATE NOT NULL,
  data_prevista_devolucao DATE NOT NULL,
  PRIMARY KEY (pk_livro_has_usuario_id),
  CONSTRAINT fk_livro_id FOREIGN KEY (fk_livro_id) REFERENCES livro(pk_livro_id),
  CONSTRAINT fk_usuario_id  FOREIGN KEY (fk_usuario_id) REFERENCES usuario(pk_usuario_id)
);
  

