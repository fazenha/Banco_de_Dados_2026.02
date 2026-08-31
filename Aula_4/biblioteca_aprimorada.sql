-- 1. CRIA O SCHEMA (BANCO)
CREATE SCHEMA biblioteca;

-- 2. SELECIONA O SCHEMA
USE biblioteca;

-- 3. TABELA CURSO (Base para o usuário)
CREATE TABLE curso (
    pk_curso_id INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    turno VARCHAR(50) NOT NULL, -- Ex: Matutino, Noturno
    PRIMARY KEY (pk_curso_id)
);

-- 4. TABELA EDITORA (Base para o livro)
CREATE TABLE editora (
    pk_editora_id INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    PRIMARY KEY (pk_editora_id)
);

-- 5. TABELA USUARIO (Agora vinculada a um Curso)
CREATE TABLE usuario (
    pk_usuario_id INT AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    fk_curso_id INT NOT NULL, -- Chave Estrangeira do Curso
    PRIMARY KEY (pk_usuario_id),
    FOREIGN KEY (fk_curso_id) REFERENCES curso(pk_curso_id)
);

-- 6. TABELA LIVRO (Vinculada a uma Editora)
CREATE TABLE livro (
    pk_livro_id INT AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(200) NOT NULL,
    fk_editora_id INT NOT NULL, -- Chave Estrangeira da Editora
    PRIMARY KEY (pk_livro_id),
    FOREIGN KEY (fk_editora_id) REFERENCES editora (pk_editora_id)
);

-- 7. TABELA INTERMEDIÁRIA (Histórico de Empréstimos com Chave Composta)
CREATE TABLE livro_has_usuario (
    fk_livro_id INT NOT NULL,
    fk_usuario_id INT NOT NULL,
    data_retirada DATE NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    
    FOREIGN KEY (fk_livro_id) REFERENCES livro(pk_livro_id),
    FOREIGN KEY (fk_usuario_id) REFERENCES usuario(pk_usuario_id),
    
    -- Chave Primária Composta de 3 campos
    PRIMARY KEY (fk_livro_id, fk_usuario_id)
);

-- 8. CRIA AS CONSTRAINTS PARA AS CHAVES ESTRANGEIRAS
ALTER TABLE usuario ADD CONSTRAINT fk_curso_id FOREIGN KEY (fk_curso_id) REFERENCES curso(pk_curso_id);
ALTER TABLE livro ADD CONSTRAINT fk_editora_id FOREIGN KEY (fk_editora_id) REFERENCES editora(pk_editora_id);
ALTER TABLE livro_has_usuario ADD CONSTRAINT fk_livro_id FOREIGN KEY (fk_livro_id) REFERENCES livro(pk_livro_id);
ALTER TABLE livro_has_usuario ADD CONSTRAINT fk_usuario_id FOREIGN KEY (fk_usuario_id) REFERENCES usuario(pk_usuario_id);

-- 9. ADICIONA NOVAS COLUNAS ÀS TABELAS
ALTER TABLE editora ADD COLUMN ano INT NOT NULL CHECK (ano > 0);
ALTER TABLE editora ADD COLUMN isbn INT NOT NULL;

-- 10. REMOVER COLUNAS DAS TABELAS
-- ALTER TABLE editora DROP COLUMN isbn; 



