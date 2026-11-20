USE DB_T05429_CARLOS_ALEXANDRE;

#BAR DO ZÉ
/*
O SEU ZÉ PRECISA CONTROLAR:
 ENTRADAS DE DINHEIRO
 SAÍDAS DE DINHEIRO
 CADASTRO DE PRODUTOS
 CONTROLE DE ESTOQUE
 FUNCIONÁRIOS (HORÁRIO, SALÁRIO, ADMISSÃO)
 FORNECEDORES
 VENDAS*/

#TABELA_FUNCIONARIOS:
CREATE TABLE EMPLOYEES (
	EMPLOYEES_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(20) NOT NULL,
    POSITION VARCHAR(20) NOT NULL,
    SALARY DECIMAL(10,2),
    HIRE_YEAR DATE,
    WORK_SHIFT VARCHAR(20)
		CHECK (WORK_SHIFT IN ('DAY', 'NIGHT', 'FULL_DAY'))
	);

#TABELA_CLIENTES:
CREATE TABLE CUSTOMERS (
	CUSTOMER_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL
);

#TABELA_DISTRIBUIDORES:
CREATE TABLE SUPPLIERS (
	SUPPLIER_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL
);

#TABELA_PRODUCTS:
CREATE TABLE PRODUCTS (
	PRODUCT_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    UNIT_COST DECIMAL(10,2) NOT NULL,
    PRICE DECIMAL(10,2) NOT NULL,
    SUPPLIER_ID INT
);

#TABELA_VENDAS
CREATE TABLE SALES (
	SALE_ID INT AUTO_INCREMENT PRIMARY KEY,
    SALE_DATE DATE NOT NULL,
    EMPLOYEE_ID INT NOT NULL,
    CUSTOMER_ID INT NULL,
    ON_CREDIT CHAR(1) DEFAULT 'N'
);

#TABELA_ÍTEM_VENDA:
CREATE TABLE SALES_ITEMS(
	ITEM_ID INT AUTO_INCREMENT PRIMARY KEY,
    SALE_ID INT NOT NULL,
    PRODUCT_ID INT NOT NULL,
    QUANTITY INT NOT NULL        
);
    
#TABELA DE VENDA FIADO
CREATE TABLE CREDIT_SALE(
	CREDIT_SALE_ID INT AUTO_INCREMENT PRIMARY KEY,
    SALE_ID INT NOT NULL,
    PAYMENT_DATE DATE NULL
);
    
#CAIXA
CREATE TABLE CASH_REGISTER (
	TRANSACTION_ID INT AUTO_INCREMENT PRIMARY KEY,
    SALE_ID INT NOT NULL,
    TRANSACTION_DATE DATE NOT NULL,
    TRANSACTION_TYPE ENUM('ENTRADA', 'SAIDA') NOT NULL,
    AMOUNT DECIMAL(10,2)NOT NULL,
    DESCRIPTION VARCHAR(200)
);    
    
#INFORMAÇÕES_ENUNCIADO
#VENDEDORES:

#(NOME, CARGO, SALARIO, ANO DE ADMISSÃO, HORARIO DE TRABALHO)
INSERT INTO EMPLOYEES (NAME, POSITION, SALARY, HIRE_YEAR, WORK_SHIFT) VALUES
	('ADONIS_GREGA', 'VENDEDOR', 1834.45, 2025, 'FULL_DAY'),
    ('APOLO_GOD', 'VENDEDOR', 1834.45, 2024, 'FULL_DAY'),
    ('ARTEMIS_SISTER', 'GERENTE', 1834.45, 2022, 'FULL_DAY');
    
#CLIENTES:

INSERT INTO CUSTOMERS (NAME) VALUES
	('DONA MARIA'),
	('TIAO'),
	('JOAO DO PULO'),
	('ZE DA ESQUINA'),
	('SR. WILSON'),
	('ROBERTO'),
	('CHICO MINEIRO');
    
#FORNECEDORES:
INSERT INTO SUPPLIERS (NAME) VALUES
    ('DISTRIBUIDORA CEVADA PURA'),
    ('ALAMBIQUE VELHO OESTE'),
    ('GRANJA RENASCER'),
    ('FRIGORIFICO BOI GORDO'),
    ('SALGADARIA POPULAR'),
    ('HORTIFRUTI DO CAMPO'),
    ('SNACKS DO CERRADO'),
    ('LATICINIOS DA SERRA'),
    ('PESCADOS DA COSTA'),
    ('TABACARIA OURO NEGRO');
    
#PRODUTOS:
#(NOME, PREÇO DE VENDA, PREÇO DE CUSTO, ESTOQUE FICTÍCIO, ID FORNECEDOR)    
INSERT INTO PRODUCTS (NAME, PRICE, UNIT_COST, STOCK, SUPPLIER_ID) VALUES
	('CERVEJA', 10.00, 6.50,1000, 1),
	('CACHAÇA', 3.00, 1.20, 1000, 2),
	('OVO ROSA', 2.50, 1.10, 1000, 3),
	('ESPETINHO', 8.00, 3.80, 1000, 4),
	('BOLINHO DE CARNE', 6.00, 2.50, 1000, 5),
	('COXINHA', 6.00, 2.50, 1000,5),
	('RISOLES', 6.00, 2.50, 1000, 5),
	('QUIBE', 6.00, 2.50, 1000, 5),
	('EMPADA', 5.00, 2.10, 1000, 5),
	('TORRESMO', 5.00, 1.80, 1000, 4),
	('BATATA FRITA', 20.00, 8.50, 1000, 6),
	('AMENDOIM', 3.00, 1.10, 1000, 7),
	('OVO DE CODORNA', 1.00, 0.40, 1000, 3),
	('AZEITONA', 10.00, 4.20, 1000, 6),
	('QUEIJO COALHO', 7.00, 3.40, 1000, 8),
	('LINGUIÇA CALABRESA', 25.00, 11.00, 1000, 4),
	('PÃO COM MORTADELA', 8.00, 3.20, 1000, 5),
	('SARDINHA', 4.00, 1.70, 1000, 9),
	('CALDO DE MOCOTÓ', 12.00, 5.50, 1000, 4),
	('DOBRADINHA', 15.00, 6.80, 1000, 4),
	('CALDINHO DE FEIJÃO', 10.00, 4.10, 1000, 6),
	('REFRIGERANTE', 5.00, 2.80, 1000, 1),
	('ÁGUA TÔNICA', 6.00, 3.10, 1000, 1),
	('CIGARRO', 1.00, 0.65, 1000, 10),
	('ISQUEIRO', 6.00, 2.90, 1000, 10),
	('FÓSFORO', 1.00, 0.45, 1000, 10),
	('PAÇOCA', 1.50, 0.60, 1000, 7),
	('CHICLETE', 0.50, 0.15, 1000, 7),
	('CONHAQUE', 7.00, 3.90, 1000, 2),
	('CAFÉ', 2.00, 0.80, 1000, 6);

#VENDAS À VISTA (ON_CREDIT = 'N') - SALE_ID 1 a 78 (06/03/2026 a 31/03/2026)
INSERT INTO SALES (SALE_DATE, EMPLOYEE_ID, CUSTOMER_ID, ON_CREDIT) VALUES
    ('2026-03-06', 3, 1, 'N'),  -- Azeitona 6 | Ártemis Sister | Dona Maria
    ('2026-03-06', 1, NULL, 'N'),  -- Queijo coalho 10 | Adônis Grega | Anônimo
    ('2026-03-06', 3, 2, 'N'),  -- Linguiça calabresa 5 | Ártemis Sister | Tião
    ('2026-03-07', 1, NULL, 'N'),  -- Pão com mortadela 18 | Adônis Grega | Anônimo
    ('2026-03-07', 2, 3, 'N'),  -- Sardinha 15 | Apolo God | João do Pulo
    ('2026-03-07', 3, NULL, 'N'),  -- Caldo de mocotó 10 | Ártemis Sister | Anônimo
    ('2026-03-08', 3, 4, 'N'),  -- Dobradinha 8 | Ártemis Sister | Zé da Esquina
    ('2026-03-08', 3, NULL, 'N'),  -- Caldinho de feijão 15 | Ártemis Sister | Anônimo
    ('2026-03-08', 1, 5, 'N'),  -- Refrigerante 30 | Adônis Grega | Sr. Wilson
    ('2026-03-09', 2, NULL, 'N'),  -- Água tônica 15 | Apolo God | Anônimo
    ('2026-03-09', 1, 6, 'N'),  -- Isqueiro 5 | Adônis Grega | Roberto
    ('2026-03-09', 1, NULL, 'N'),  -- Fósforo 15 | Adônis Grega | Anônimo
    ('2026-03-10', 1, 7, 'N'),  -- Paçoca 20 | Adônis Grega | Chico Mineiro
    ('2026-03-10', 2, NULL, 'N'),  -- Chiclete 80 | Apolo God | Anônimo
    ('2026-03-10', 2, 1, 'N'),  -- Conhaque 12 | Apolo God | Dona Maria
    ('2026-03-11', 3, NULL, 'N'),  -- Cerveja 45 | Ártemis Sister | Anônimo
    ('2026-03-11', 1, 2, 'N'),  -- Coxinha 28 | Adônis Grega | Tião
    ('2026-03-11', 2, NULL, 'N'),  -- Cachaça 55 | Apolo God | Anônimo
    ('2026-03-12', 2, 3, 'N'),  -- Ovo rosa 22 | Apolo God | João do Pulo
    ('2026-03-12', 3, NULL, 'N'),  -- Espetinho 20 | Ártemis Sister | Anônimo
    ('2026-03-12', 1, 4, 'N'),  -- Bolinho de carne 15 | Adônis Grega | Zé da Esquina
    ('2026-03-13', 1, NULL, 'N'),  -- Risoles 12 | Adônis Grega | Anônimo
    ('2026-03-13', 1, 5, 'N'),  -- Quibe 15 | Adônis Grega | Sr. Wilson
    ('2026-03-13', 3, NULL, 'N'),  -- Empada 18 | Ártemis Sister | Anônimo
    ('2026-03-14', 2, 6, 'N'),  -- Torresmo 30 | Apolo God | Roberto
    ('2026-03-14', 3, NULL, 'N'),  -- Batata frita 10 | Ártemis Sister | Anônimo
    ('2026-03-14', 1, 7, 'N'),  -- Amendoim 25 | Adônis Grega | Chico Mineiro
    ('2026-03-15', 2, NULL, 'N'),  -- Ovo de codorna 45 | Apolo God | Anônimo
    ('2026-03-15', 3, 1, 'N'),  -- Azeitona 12 | Ártemis Sister | Dona Maria
    ('2026-03-15', 1, NULL, 'N'),  -- Queijo coalho 15 | Adônis Grega | Anônimo
    ('2026-03-16', 3, 2, 'N'),  -- Linguiça calabresa 8 | Ártemis Sister | Tião
    ('2026-03-16', 1, NULL, 'N'),  -- Pão com mortadela 20 | Adônis Grega | Anônimo
    ('2026-03-16', 2, 3, 'N'),  -- Sardinha 22 | Apolo God | João do Pulo
    ('2026-03-17', 3, NULL, 'N'),  -- Caldo de mocotó 15 | Ártemis Sister | Anônimo
    ('2026-03-17', 3, 4, 'N'),  -- Dobradinha 10 | Ártemis Sister | Zé da Esquina
    ('2026-03-17', 3, NULL, 'N'),  -- Caldinho de feijão 20 | Ártemis Sister | Anônimo
    ('2026-03-18', 1, 5, 'N'),  -- Refrigerante 35 | Adônis Grega | Sr. Wilson
    ('2026-03-18', 2, NULL, 'N'),  -- Água tônica 18 | Apolo God | Anônimo
    ('2026-03-18', 2, 6, 'N'),  -- Cigarro 75 | Apolo God | Roberto
    ('2026-03-19', 1, NULL, 'N'),  -- Isqueiro 8 | Adônis Grega | Anônimo
    ('2026-03-19', 1, 7, 'N'),  -- Fósforo 20 | Adônis Grega | Chico Mineiro
    ('2026-03-19', 1, NULL, 'N'),  -- Paçoca 30 | Adônis Grega | Anônimo
    ('2026-03-20', 2, 1, 'N'),  -- Chiclete 110 | Apolo God | Dona Maria
    ('2026-03-20', 2, NULL, 'N'),  -- Conhaque 15 | Apolo God | Anônimo
    ('2026-03-20', 2, 2, 'N'),  -- Café 40 | Apolo God | Tião
    ('2026-03-21', 3, NULL, 'N'),  -- Cerveja 55 | Ártemis Sister | Anônimo
    ('2026-03-21', 1, 3, 'N'),  -- Coxinha 32 | Adônis Grega | João do Pulo
    ('2026-03-21', 2, NULL, 'N'),  -- Cachaça 65 | Apolo God | Anônimo
    ('2026-03-22', 2, 4, 'N'),  -- Ovo rosa 28 | Apolo God | Zé da Esquina
    ('2026-03-22', 3, NULL, 'N'),  -- Espetinho 22 | Ártemis Sister | Anônimo
    ('2026-03-22', 1, 5, 'N'),  -- Bolinho de carne 18 | Adônis Grega | Sr. Wilson
    ('2026-03-23', 1, NULL, 'N'),  -- Risoles 15 | Adônis Grega | Anônimo
    ('2026-03-23', 1, 6, 'N'),  -- Quibe 18 | Adônis Grega | Roberto
    ('2026-03-23', 3, NULL, 'N'),  -- Empada 25 | Ártemis Sister | Anônimo
    ('2026-03-24', 2, 7, 'N'),  -- Torresmo 35 | Apolo God | Chico Mineiro
    ('2026-03-24', 3, NULL, 'N'),  -- Batata frita 12 | Ártemis Sister | Anônimo
    ('2026-03-24', 1, 1, 'N'),  -- Amendoim 30 | Adônis Grega | Dona Maria
    ('2026-03-25', 2, NULL, 'N'),  -- Ovo de codorna 55 | Apolo God | Anônimo
    ('2026-03-25', 3, 2, 'N'),  -- Azeitona 15 | Ártemis Sister | Tião
    ('2026-03-25', 1, NULL, 'N'),  -- Queijo coalho 18 | Adônis Grega | Anônimo
    ('2026-03-26', 3, 3, 'N'),  -- Linguiça calabresa 10 | Ártemis Sister | João do Pulo
    ('2026-03-26', 1, NULL, 'N'),  -- Pão com mortadela 25 | Adônis Grega | Anônimo
    ('2026-03-26', 2, 4, 'N'),  -- Sardinha 30 | Apolo God | Zé da Esquina
    ('2026-03-27', 3, NULL, 'N'),  -- Caldo de mocotó 18 | Ártemis Sister | Anônimo
    ('2026-03-27', 3, 5, 'N'),  -- Dobradinha 12 | Ártemis Sister | Sr. Wilson
    ('2026-03-27', 3, NULL, 'N'),  -- Caldinho de feijão 25 | Ártemis Sister | Anônimo
    ('2026-03-28', 1, 6, 'N'),  -- Refrigerante 40 | Adônis Grega | Roberto
    ('2026-03-28', 2, NULL, 'N'),  -- Água tônica 20 | Apolo God | Anônimo
    ('2026-03-28', 2, 7, 'N'),  -- Cigarro 80 | Apolo God | Chico Mineiro
    ('2026-03-29', 1, NULL, 'N'),  -- Isqueiro 10 | Adônis Grega | Anônimo
    ('2026-03-29', 1, 1, 'N'),  -- Fósforo 25 | Adônis Grega | Dona Maria
    ('2026-03-29', 1, NULL, 'N'),  -- Paçoca 35 | Adônis Grega | Anônimo
    ('2026-03-30', 2, 2, 'N'),  -- Chiclete 120 | Apolo God | Tião
    ('2026-03-30', 2, NULL, 'N'),  -- Conhaque 18 | Apolo God | Anônimo
    ('2026-03-30', 2, 3, 'N'),  -- Café 45 | Apolo God | João do Pulo
    ('2026-03-31', 3, NULL, 'N'),  -- Cerveja 60 | Ártemis Sister | Anônimo
    ('2026-03-31', 1, 4, 'N'),  -- Coxinha 35 | Adônis Grega | Zé da Esquina
    ('2026-03-31', 2, NULL, 'N');  -- Cachaça 70 | Apolo God | Anônimo
    
#VENDAS FIADAS (ON_CREDIT = 'S') - SALE_ID 79 a 128 (05/01/2026 a 31/03/2026)
INSERT INTO SALES (SALE_DATE, EMPLOYEE_ID, CUSTOMER_ID, ON_CREDIT) VALUES
    ('2026-01-05', 2, 4, 'S'),  -- Cachaça 10 | Apolo God | Zé da Esquina
    ('2026-01-07', 3, 3, 'S'),  -- Cerveja 6 | Ártemis Sister | João do Pulo
    ('2026-01-08', 1, 2, 'S'),  -- Cigarro 10 | Adônis Grega | Tião
    ('2026-01-10', 2, 5, 'S'),  -- Torresmo 5 | Apolo God | Sr. Wilson
    ('2026-01-12', 2, 6, 'S'),  -- Conhaque 4 | Apolo God | Roberto
    ('2026-01-15', 1, 7, 'S'),  -- Pão com mortadela 4 | Adônis Grega | Chico Mineiro
    ('2026-01-18', 3, 1, 'S'),  -- Caldo de mocotó 3 | Ártemis Sister | Dona Maria
    ('2026-01-20', 2, 4, 'S'),  -- Cachaça 8 | Apolo God | Zé da Esquina
    ('2026-01-22', 3, 3, 'S'),  -- Cerveja 10 | Ártemis Sister | João do Pulo
    ('2026-01-25', 1, 2, 'S'),  -- Espetinho 6 | Adônis Grega | Tião
    ('2026-01-28', 3, 6, 'S'),  -- Linguiça calabresa 2 | Ártemis Sister | Roberto
    ('2026-01-30', 2, 7, 'S'),  -- Café 10 | Apolo God | Chico Mineiro
    ('2026-02-02', 1, 4, 'S'),  -- Coxinha 6 | Adônis Grega | Zé da Esquina
    ('2026-02-04', 3, 5, 'S'),  -- Cerveja 8 | Ártemis Sister | Sr. Wilson
    ('2026-02-05', 2, 2, 'S'),  -- Cigarro 15 | Apolo God | Tião
    ('2026-02-07', 2, 3, 'S'),  -- Cachaça 12 | Apolo God | João do Pulo
    ('2026-02-10', 3, 6, 'S'),  -- Dobradinha 3 | Ártemis Sister | Roberto
    ('2026-02-12', 1, 1, 'S'),  -- Bolinho de carne 5 | Adônis Grega | Dona Maria
    ('2026-02-15', 1, 7, 'S'),  -- Queijo coalho 4 | Adônis Grega | Chico Mineiro
    ('2026-02-18', 3, 4, 'S'),  -- Caldinho de feijão 5 | Ártemis Sister | Zé da Esquina
    ('2026-02-20', 3, 5, 'S'),  -- Cerveja 12 | Ártemis Sister | Sr. Wilson
    ('2026-02-22', 2, 6, 'S'),  -- Conhaque 6 | Apolo God | Roberto
    ('2026-02-24', 2, 2, 'S'),  -- Ovo rosa 10 | Apolo God | Tião
    ('2026-02-26', 1, 3, 'S'),  -- Espetinho 8 | Adônis Grega | João do Pulo
    ('2026-02-28', 2, 7, 'S'),  -- Sardinha 10 | Apolo God | Chico Mineiro
    ('2026-03-02', 3, 1, 'S'),  -- Cerveja 5 | Ártemis Sister | Dona Maria
    ('2026-03-04', 2, 4, 'S'),  -- Cigarro 20 | Apolo God | Zé da Esquina
    ('2026-03-05', 2, 2, 'S'),  -- Cachaça 10 | Apolo God | Tião
    ('2026-03-07', 2, 5, 'S'),  -- Torresmo 6 | Apolo God | Sr. Wilson
    ('2026-03-09', 1, 6, 'S'),  -- Pão com mortadela 5 | Adônis Grega | Roberto
    ('2026-03-11', 3, 3, 'S'),  -- Caldo de mocotó 4 | Ártemis Sister | João do Pulo
    ('2026-03-13', 1, 7, 'S'),  -- Coxinha 8 | Adônis Grega | Chico Mineiro
    ('2026-03-15', 3, 4, 'S'),  -- Cerveja 10 | Ártemis Sister | Zé da Esquina
    ('2026-03-17', 3, 1, 'S'),  -- Linguiça calabresa 3 | Ártemis Sister | Dona Maria
    ('2026-03-19', 1, 2, 'S'),  -- Amendoim 10 | Adônis Grega | Tião
    ('2026-03-21', 2, 5, 'S'),  -- Cachaça 15 | Apolo God | Sr. Wilson
    ('2026-03-22', 2, 3, 'S'),  -- Conhaque 5 | Apolo God | João do Pulo
    ('2026-03-24', 1, 6, 'S'),  -- Quibe 6 | Adônis Grega | Roberto
    ('2026-03-25', 3, 7, 'S'),  -- Batata frita 2 | Ártemis Sister | Chico Mineiro
    ('2026-03-26', 2, 4, 'S'),  -- Café 12 | Apolo God | Zé da Esquina
    ('2026-03-27', 2, 1, 'S'),  -- Cigarro 12 | Apolo God | Dona Maria
    ('2026-03-28', 3, 2, 'S'),  -- Cerveja 8 | Ártemis Sister | Tião
    ('2026-03-29', 1, 5, 'S'),  -- Paçoca 15 | Adônis Grega | Sr. Wilson
    ('2026-03-29', 2, 6, 'S'),  -- Chiclete 50 | Apolo God | Roberto
    ('2026-03-30', 2, 3, 'S'),  -- Cachaça 20 | Apolo God | João do Pulo
    ('2026-03-30', 1, 7, 'S'),  -- Empada 10 | Adônis Grega | Chico Mineiro
    ('2026-03-31', 3, 4, 'S'),  -- Caldinho de feijão 6 | Ártemis Sister | Zé da Esquina
    ('2026-03-31', 3, 5, 'S'),  -- Cerveja 12 | Ártemis Sister | Sr. Wilson
    ('2026-03-31', 1, 2, 'S'),  -- Isqueiro 2 | Adônis Grega | Tião
    ('2026-03-31', 2, 6, 'S');  -- Conhaque 4 | Apolo God | Roberto
