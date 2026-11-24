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
CREATE TABLE EMPLOYEE (
	EMPLOYEE_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    POSITION VARCHAR(20) NOT NULL,
    SALARY DECIMAL(10,2),
    HIRE_YEAR INT,
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
    STOCK INT NOT NULL DEFAULT 0,
    SUPPLIER_ID INT NOT NULL,
    FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIERS(SUPPLIER_ID)
);

#TABELA_VENDAS
CREATE TABLE SALES (
	SALE_ID INT AUTO_INCREMENT PRIMARY KEY,
    SALE_DATE DATE NOT NULL,
    EMPLOYEE_ID INT NOT NULL,
    CUSTOMER_ID INT NULL,
    ON_CREDIT CHAR(1) DEFAULT 'N',
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID),
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID)
);

#TABELA_ÍTEM_VENDA:
CREATE TABLE SALES_ITEMS(
	ITEM_ID INT AUTO_INCREMENT PRIMARY KEY,
    SALE_ID INT NOT NULL,
    PRODUCT_ID INT NOT NULL,
    QUANTITY INT NOT NULL,
    FOREIGN KEY (SALE_ID) REFERENCES SALES(SALE_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID)
);
    
#TABELA DE VENDA FIADO
CREATE TABLE CREDIT_SALE(
	CREDIT_SALE_ID INT AUTO_INCREMENT PRIMARY KEY,
    SALE_ID INT NOT NULL UNIQUE, # UNIQUE PARA QUE EXISTA NO MÁXIMO UMA VENDA FIADA E UM LANÇAMENTO
    PAYMENT_DATE DATE NULL,
    FOREIGN KEY (SALE_ID) REFERENCES SALES(SALE_ID)
);
    
#CAIXA
CREATE TABLE CASH_REGISTER (
	TRANSACTION_ID INT AUTO_INCREMENT PRIMARY KEY,
    SALE_ID INT NULL UNIQUE, # UNIQUE PARA QUE EXISTA NO MÁXIMO UMA VENDA FIADA E UM LANÇAMENTO
    TRANSACTION_DATE DATE NOT NULL,
    TRANSACTION_TYPE ENUM('ENTRADA', 'SAIDA') NOT NULL,
    AMOUNT DECIMAL(10,2)NOT NULL,
    DESCRIPTION VARCHAR(200),
    FOREIGN KEY (SALE_ID) REFERENCES SALES(SALE_ID)
);    
    
#INFORMAÇÕES_ENUNCIADO
#VENDEDORES:

#(NOME, CARGO, SALARIO, ANO DE ADMISSÃO, HORARIO DE TRABALHO)
INSERT INTO EMPLOYEE (NAME, POSITION, SALARY, HIRE_YEAR, WORK_SHIFT) VALUES
	('ADONIS_GREGA', 'VENDEDOR', 1834.45, 2025, 'FULL_DAY'),
    ('APOLO_GOD', 'VENDEDOR', 1900.03, 2022, 'FULL_DAY'),
    ('ARTEMIS_SISTER', 'GERENTE', 2300.00, 2024, 'FULL_DAY');
    
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

#VENDAS À VISTA (ON_CREDIT = 'N') - SALE_ID 1 a 78 (06/03/2026 a 31/03/2026) -- PRODUTO QUANTIDADE | FUNCIONÁRIO | CLIENTE
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
    
#VENDAS FIADAS (ON_CREDIT = 'S') - SALE_ID 79 a 128 (05/01/2026 a 31/03/2026) -- PRODUTO QUANTIDADE | FUNCIONARIO | CLIENTE
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
    
    
#ITENS DAS VENDAS - ID VENDAS, ID PRODUTOS ,  QUANTIDADE VENDIDA -- PRODUTO | DATA DA VENDA
INSERT INTO SALES_ITEMS (SALE_ID, PRODUCT_ID, QUANTITY) VALUES
    (1, 14, 6),  -- Azeitona | 2026-03-06
    (2, 15, 10),  -- Queijo coalho | 2026-03-06
    (3, 16, 5),  -- Linguiça calabresa | 2026-03-06
    (4, 17, 18),  -- Pão com mortadela | 2026-03-07
    (5, 18, 15),  -- Sardinha | 2026-03-07
    (6, 19, 10),  -- Caldo de mocotó | 2026-03-07
    (7, 20, 8),  -- Dobradinha | 2026-03-08
    (8, 21, 15),  -- Caldinho de feijão | 2026-03-08
    (9, 22, 30),  -- Refrigerante | 2026-03-08
    (10, 23, 15),  -- Água tônica | 2026-03-09
    (11, 25, 5),  -- Isqueiro | 2026-03-09
    (12, 26, 15),  -- Fósforo | 2026-03-09
    (13, 27, 20),  -- Paçoca | 2026-03-10
    (14, 28, 80),  -- Chiclete | 2026-03-10
    (15, 29, 12),  -- Conhaque | 2026-03-10
    (16, 1, 45),  -- Cerveja | 2026-03-11
    (17, 6, 28),  -- Coxinha | 2026-03-11
    (18, 2, 55),  -- Cachaça | 2026-03-11
    (19, 3, 22),  -- Ovo rosa | 2026-03-12
    (20, 4, 20),  -- Espetinho | 2026-03-12
    (21, 5, 15),  -- Bolinho de carne | 2026-03-12
    (22, 7, 12),  -- Risoles | 2026-03-13
    (23, 8, 15),  -- Quibe | 2026-03-13
    (24, 9, 18),  -- Empada | 2026-03-13
    (25, 10, 30),  -- Torresmo | 2026-03-14
    (26, 11, 10),  -- Batata frita | 2026-03-14
    (27, 12, 25),  -- Amendoim | 2026-03-14
    (28, 13, 45),  -- Ovo de codorna | 2026-03-15
    (29, 14, 12),  -- Azeitona | 2026-03-15
    (30, 15, 15),  -- Queijo coalho | 2026-03-15
    (31, 16, 8),  -- Linguiça calabresa | 2026-03-16
    (32, 17, 20),  -- Pão com mortadela | 2026-03-16
    (33, 18, 22),  -- Sardinha | 2026-03-16
    (34, 19, 15),  -- Caldo de mocotó | 2026-03-17
    (35, 20, 10),  -- Dobradinha | 2026-03-17
    (36, 21, 20),  -- Caldinho de feijão | 2026-03-17
    (37, 22, 35),  -- Refrigerante | 2026-03-18
    (38, 23, 18),  -- Água tônica | 2026-03-18
    (39, 24, 75),  -- Cigarro | 2026-03-18
    (40, 25, 8),  -- Isqueiro | 2026-03-19
    (41, 26, 20),  -- Fósforo | 2026-03-19
    (42, 27, 30),  -- Paçoca | 2026-03-19
    (43, 28, 110),  -- Chiclete | 2026-03-20
    (44, 29, 15),  -- Conhaque | 2026-03-20
    (45, 30, 40),  -- Café | 2026-03-20
    (46, 1, 55),  -- Cerveja | 2026-03-21
    (47, 6, 32),  -- Coxinha | 2026-03-21
    (48, 2, 65),  -- Cachaça | 2026-03-21
    (49, 3, 28),  -- Ovo rosa | 2026-03-22
    (50, 4, 22),  -- Espetinho | 2026-03-22
    (51, 5, 18),  -- Bolinho de carne | 2026-03-22
    (52, 7, 15),  -- Risoles | 2026-03-23
    (53, 8, 18),  -- Quibe | 2026-03-23
    (54, 9, 25),  -- Empada | 2026-03-23
    (55, 10, 35),  -- Torresmo | 2026-03-24
    (56, 11, 12),  -- Batata frita | 2026-03-24
    (57, 12, 30),  -- Amendoim | 2026-03-24
    (58, 13, 55),  -- Ovo de codorna | 2026-03-25
    (59, 14, 15),  -- Azeitona | 2026-03-25
    (60, 15, 18),  -- Queijo coalho | 2026-03-25
    (61, 16, 10),  -- Linguiça calabresa | 2026-03-26
    (62, 17, 25),  -- Pão com mortadela | 2026-03-26
    (63, 18, 30),  -- Sardinha | 2026-03-26
    (64, 19, 18),  -- Caldo de mocotó | 2026-03-27
    (65, 20, 12),  -- Dobradinha | 2026-03-27
    (66, 21, 25),  -- Caldinho de feijão | 2026-03-27
    (67, 22, 40),  -- Refrigerante | 2026-03-28
    (68, 23, 20),  -- Água tônica | 2026-03-28
    (69, 24, 80),  -- Cigarro | 2026-03-28
    (70, 25, 10),  -- Isqueiro | 2026-03-29
    (71, 26, 25),  -- Fósforo | 2026-03-29
    (72, 27, 35),  -- Paçoca | 2026-03-29
    (73, 28, 120),  -- Chiclete | 2026-03-30
    (74, 29, 18),  -- Conhaque | 2026-03-30
    (75, 30, 45),  -- Café | 2026-03-30
    (76, 1, 60),  -- Cerveja | 2026-03-31
    (77, 6, 35),  -- Coxinha | 2026-03-31
    (78, 2, 70),  -- Cachaça | 2026-03-31
    (79, 2, 10),  -- Cachaça | 2026-01-05
    (80, 1, 6),  -- Cerveja | 2026-01-07
    (81, 24, 10),  -- Cigarro | 2026-01-08
    (82, 10, 5),  -- Torresmo | 2026-01-10
    (83, 29, 4),  -- Conhaque | 2026-01-12
    (84, 17, 4),  -- Pão com mortadela | 2026-01-15
    (85, 19, 3),  -- Caldo de mocotó | 2026-01-18
    (86, 2, 8),  -- Cachaça | 2026-01-20
    (87, 1, 10),  -- Cerveja | 2026-01-22
    (88, 4, 6),  -- Espetinho | 2026-01-25
    (89, 16, 2),  -- Linguiça calabresa | 2026-01-28
    (90, 30, 10),  -- Café | 2026-01-30
    (91, 6, 6),  -- Coxinha | 2026-02-02
    (92, 1, 8),  -- Cerveja | 2026-02-04
    (93, 24, 15),  -- Cigarro | 2026-02-05
    (94, 2, 12),  -- Cachaça | 2026-02-07
    (95, 20, 3),  -- Dobradinha | 2026-02-10
    (96, 5, 5),  -- Bolinho de carne | 2026-02-12
    (97, 15, 4),  -- Queijo coalho | 2026-02-15
    (98, 21, 5),  -- Caldinho de feijão | 2026-02-18
    (99, 1, 12),  -- Cerveja | 2026-02-20
    (100, 29, 6),  -- Conhaque | 2026-02-22
    (101, 3, 10),  -- Ovo rosa | 2026-02-24
    (102, 4, 8),  -- Espetinho | 2026-02-26
    (103, 18, 10),  -- Sardinha | 2026-02-28
    (104, 1, 5),  -- Cerveja | 2026-03-02
    (105, 24, 20),  -- Cigarro | 2026-03-04
    (106, 2, 10),  -- Cachaça | 2026-03-05
    (107, 10, 6),  -- Torresmo | 2026-03-07
    (108, 17, 5),  -- Pão com mortadela | 2026-03-09
    (109, 19, 4),  -- Caldo de mocotó | 2026-03-11
    (110, 6, 8),  -- Coxinha | 2026-03-13
    (111, 1, 10),  -- Cerveja | 2026-03-15
    (112, 16, 3),  -- Linguiça calabresa | 2026-03-17
    (113, 12, 10),  -- Amendoim | 2026-03-19
    (114, 2, 15),  -- Cachaça | 2026-03-21
    (115, 29, 5),  -- Conhaque | 2026-03-22
    (116, 8, 6),  -- Quibe | 2026-03-24
    (117, 11, 2),  -- Batata frita | 2026-03-25
    (118, 30, 12),  -- Café | 2026-03-26
    (119, 24, 12),  -- Cigarro | 2026-03-27
    (120, 1, 8),  -- Cerveja | 2026-03-28
    (121, 27, 15),  -- Paçoca | 2026-03-29
    (122, 28, 50),  -- Chiclete | 2026-03-29
    (123, 2, 20),  -- Cachaça | 2026-03-30
    (124, 9, 10),  -- Empada | 2026-03-30
    (125, 21, 6),  -- Caldinho de feijão | 2026-03-31
    (126, 1, 12),  -- Cerveja | 2026-03-31
    (127, 25, 2),  -- Isqueiro | 2026-03-31
    (128, 29, 4);  -- Conhaque | 2026-03-31

#INSERTS OTIMIZADOS EM IA PARA NÃO DIGITAR TABELAS MAIS DE UMA VEZ:    
    
#APROVEITANDO O REGISTRO DE VENDAS COM O (ON_CREDIT) MARCADO COMO SIM PARA INCLUIR REGISTROS EM CREDIT_SALE:

INSERT INTO CREDIT_SALE (SALE_ID, PAYMENT_DATE)
SELECT SALE_ID, NULL 
FROM SALES 
WHERE ON_CREDIT = 'S';    


#UMA ENTRADA NO CAIXA PARA CADA VENDA À VISTA 
#(ID DE VENDA, DATA DA TRANSAÇÃO, TIPO DE TRANSAÇÃO, QUANTIDADE E DESCRIÇÃO)

INSERT INTO CASH_REGISTER (SALE_ID, TRANSACTION_DATE, TRANSACTION_TYPE, AMOUNT, DESCRIPTION)
SELECT SALES.SALE_ID, SALES.SALE_DATE, 'ENTRADA', SUM(SALES_ITEMS.QUANTITY * PRODUCTS.PRICE), 'VENDA À VISTA'
FROM SALES
JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID
JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID
WHERE SALES.ON_CREDIT = 'N'
GROUP BY SALES.SALE_ID, SALES.SALE_DATE;


#BLOCO 5 - CONSULTAS OBRIGATÓRIAS

#LEGENDA - COMANDOS QUE SE REPETEM NAS CONSULTAS
# /* JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID */ = relaciona as vendas e seus ítens
# /* JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID */ = relaciona cada ítem vendido ao seu produto, para buscar o preço e o custo
# /* JOIN SALES ON SALES.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID */ = relaciona cada funcionário às vendas que ele realizou
# /* JOIN SALES ON SALES.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID */ = relaciona cada cliente às suas compras (vendas sem cliente ficam de fora)
# /* JOIN SALES ON SALES.SALE_ID = CREDIT_SALE.SALE_ID */ = relaciona a venda fiada à venda correspondente, para buscar a data e os ítens
# /* JOIN PRODUCTS ON PRODUCTS.SUPPLIER_ID = SUPPLIERS.SUPPLIER_ID */ = relaciona cada fornecedor aos produtos que ele fornece
# /* SUM(SALES_ITEMS.QUANTITY * PRODUCTS.PRICE) */ = calcula o faturamento: soma quantidade vendida x preço de venda
# /* SUM(SALES_ITEMS.QUANTITY * (PRODUCTS.PRICE - PRODUCTS.UNIT_COST)) */ = calcula o lucro: soma quantidade vendida x (preço de venda - custo)
# /* ROUND(..., 2) */ = arredonda o resultado para 2 casas decimais
# /* WHERE SALES.ON_CREDIT = 'S' */ = filtra somente as vendas fiadas
# /* GROUP BY ... ORDER BY ... DESC LIMIT 1 */ = agrupa por produto, funcionário ou cliente, ordena do maior para o menor e mostra só o primeiro (com ASC mostra o menor)


# 1. FATURAMENTO DO MÊS ATUAL (março/2026) 
	#(PRECISA EXECUTAR A FORMULA: FATURAMENTO (TUDO O QUE FOI VENDIDO NO MÊS) = QUANT DE ITENS VENDIDOS X PREÇO DE VENDA)
    
SELECT ROUND(SUM(SALES_ITEMS.QUANTITY * PRODUCTS.PRICE), 2) AS FATURAMENTO_MARCO FROM SALES -- ROUND ARREDONDA O RESULTADO E O 2 INDICA A QTDE DE CASAS DECIMAIS
	JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID -- O BANCO VAI BUSCAR OS REGISTROS DOS ÍTENS CUJO ID SEJA IGUAL DA TABELA DE VENDAS
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID -- SERVE PARA JUNTAR O ITEM AO PRODUTO PARA PEGAR O PREÇO
	WHERE SALES.SALE_DATE BETWEEN '2026-03-01' AND '2026-03-31'; -- ESSE É O FILTRO PARA TRAZER APENAS AS VENDAS DO MÊS DE MARÇO


# 2. LUCRO DO ÚLTIMO MÊS (março/2026) 
	#LUCRO É TUDO QUE ENTROU (PREÇO) MENOS O CUSTO UNITARIO
    
SELECT ROUND(SUM(SALES_ITEMS.QUANTITY * (PRODUCTS.PRICE - PRODUCTS.UNIT_COST)), 2) AS LUCRO_MARCO FROM SALES
	JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID 
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID
	WHERE SALES.SALE_DATE BETWEEN '2026-03-01' AND '2026-03-31'; 



# 3. LUCRO DOS ÚLTIMOS 3 MESES (janeiro a março/2026)
	#MESMA CONSULTA DO LUCRO DE MARÇO, PORÉM O BETWEEN COM INCLUSÃO DOS MESES JANEIRO E FEVEREIRO

SELECT ROUND(SUM(SALES_ITEMS.QUANTITY * (PRODUCTS.PRICE - PRODUCTS.UNIT_COST)), 2) AS LUCRO_3_MESES FROM SALES
	JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID
	WHERE SALES.SALE_DATE BETWEEN '2026-01-01' AND '2026-03-31';


# 4. PRODUTO MAIS VENDIDO (por quantidade)
	#AGRUPAR POR PRODUTO, SOMANDO AS QUANTIDADES E ORDENANDO DO MAIOR PARA O MENOR FICANDO APENAS COM A PRIMEIRA LINHA

SELECT PRODUCTS.NAME AS PRODUTO, -- APRESENTA A COLUNA DE RESULTADO  COMO PRODUTO
	SUM(SALES_ITEMS.QUANTITY) AS TOTAL_UNID_VENDIDAS FROM SALES_ITEMS -- RESUME AS DUAS LINHAS EM MOSTRAR O NOME DO PRODUTO E SOMAR AS QTDES VENDIDAS DELE
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID -- O COMANDO LIGA A TABELA DE ITENS VENDIDOS COM A TABELA DE PRODUTOS
	GROUP BY PRODUCTS.PRODUCT_ID, PRODUCTS.NAME ORDER BY TOTAL_UNID_VENDIDAS DESC LIMIT 1; -- AGRUPA AS VENDAS DO MESMO PRODUTO ORDENANDO EM DECRESCENTE E TRAZENDO APENAS 1 REGISTRO


# 5. PRODUTO MENOS VENDIDO (por quantidade)
	#MESMO COMANDO ANTERIOR PORÉM SUBSTITUINDO A ORDEM DE DECRESCENTE PARA CRESCENTE

SELECT PRODUCTS.NAME AS PRODUTO,
	SUM(SALES_ITEMS.QUANTITY) AS TOTAL_UNID_VENDIDAS FROM SALES_ITEMS
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID 
	GROUP BY PRODUCTS.PRODUCT_ID, PRODUCTS.NAME ORDER BY TOTAL_UNID_VENDIDAS ASC LIMIT 1; 
    

# 6. FUNCIONÁRIO QUE MAIS VENDEU (em R$)
	#O CALCULO INCLUI SABER QUANTO O FUNCIONÁRIO VENDEU, JUNTA OS REGISTROS DAS TABELAS E AGRUPA A RESPOSTA EM UMA LINHA, ORDENANDO NA SEQUENCIA E APRESENTANDO 1 REGISTRO

SELECT EMPLOYEE.NAME AS FUNCIONARIO,
    ROUND(SUM(SALES_ITEMS.QUANTITY * PRODUCTS.PRICE), 2) AS TOTAL_VENDIDO FROM EMPLOYEE -- AS DUAS LINHAS SELECIONAM O FUNCIONÁRIO E CALCULAM O VALOR VENDIDO
	JOIN SALES       ON SALES.EMPLOYEE_ID   = EMPLOYEE.EMPLOYEE_ID -- RELACIONA O FUNCIONÁRIO E SUAS VENDAS
	JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID -- VENDAS COM RESPECTIVO ITEM
	JOIN PRODUCTS    ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID -- ITEM COM PRODUTO VENDIDO PRA SABER O PREÇO
	GROUP BY EMPLOYEE.EMPLOYEE_ID, EMPLOYEE.NAME ORDER BY TOTAL_VENDIDO DESC LIMIT 1;


# 7. FUNCIONÁRIO QUE MENOS VENDEU (em R$)
	#MESMA COISA DO ANTERIOR COM ORDENAÇÃO ASCENDENTE
    
SELECT EMPLOYEE.NAME AS FUNCIONARIO,
    ROUND(SUM(SALES_ITEMS.QUANTITY * PRODUCTS.PRICE), 2) AS TOTAL_VENDIDO FROM EMPLOYEE 
	JOIN SALES       ON SALES.EMPLOYEE_ID   = EMPLOYEE.EMPLOYEE_ID 
	JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID
	JOIN PRODUCTS    ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID 
	GROUP BY EMPLOYEE.EMPLOYEE_ID, EMPLOYEE.NAME ORDER BY TOTAL_VENDIDO ASC LIMIT 1;
    
    
# 8. PRODUTO COM MAIOR LUCRO (lucro total acumulado do produto)
	#CALCULO DE QUANTO CADA PRODUTO RESULTOU
    
SELECT PRODUCTS.NAME AS PRODUTO,
	ROUND(SUM(SALES_ITEMS.QUANTITY * (PRODUCTS.PRICE - PRODUCTS.UNIT_COST)), 2) AS LUCRO_TOTAL FROM SALES_ITEMS -- MESMO FEITO EM CALCULO DE LUCRO
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID -- JUNTA AS TABELAS IGUAL NO CÁLCULO DE LUCRO
	GROUP BY PRODUCTS.PRODUCT_ID, PRODUCTS.NAME ORDER BY LUCRO_TOTAL DESC LIMIT 1; -- AGRUPA A TABELA DE PRODUTO E ORDENA TRAZENDO O PRIMEIRO RESULTADO


# 9. PRODUTO COM MENOR LUCRO (lucro total acumulado do produto)
	#MESMO CÁLCULO ANTERIOR ALTERANDO A ORDEM DE VISUALIZAÇÃO

SELECT PRODUCTS.NAME AS PRODUTO,
	ROUND(SUM(SALES_ITEMS.QUANTITY * (PRODUCTS.PRICE - PRODUCTS.UNIT_COST)), 2) AS LUCRO_TOTAL FROM SALES_ITEMS
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID 
	GROUP BY PRODUCTS.PRODUCT_ID, PRODUCTS.NAME ORDER BY LUCRO_TOTAL ASC LIMIT 1;
     
    

# 10. TOTAL DE VENDAS POR DIA (em R$)
	#CÁLCULO DAS VENDAS CONSIDERANDO A DATA COMO PARÂMETRO
    
SELECT SALES.SALE_DATE AS DIA, -- SELECIONA A DATA DA VENDA E RENOMEIA COMO DIA
    COUNT(DISTINCT SALES.SALE_ID) AS QTD_VENDAS, -- CONTA QUANTAS VENDAS FORAM FEITAS NO DIA - O DISTINCT CONTA CADA VALOR UMA ÚNICA VEZ IGNORANDO REPETIÇÕES.
    ROUND(SUM(SALES_ITEMS.QUANTITY * PRODUCTS.PRICE), 2) AS TOTAL_DO_DIA FROM SALES
	JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID -- FAZ UMA RELAÇÃO ENTRE A VENDA E OS ÍTENS VENDIDOS
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID -- O MESMO COM O PRODUTO
	GROUP BY SALES.SALE_DATE ORDER BY DIA; -- AGRUPA E ORDENA


# 11. CLIENTE QUE MAIS COMPROU (em R$; "Anônimo" não conta porque não tem cliente)

SELECT CUSTOMERS.NAME AS CLIENTE,
    ROUND(SUM(SALES_ITEMS.QUANTITY * PRODUCTS.PRICE), 2) AS TOTAL_COMPRADO FROM CUSTOMERS
	JOIN SALES ON SALES.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID
	JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID
	GROUP BY CUSTOMERS.CUSTOMER_ID, CUSTOMERS.NAME ORDER BY TOTAL_COMPRADO DESC LIMIT 1;


# 12. QUERY PARA O SEU ZÉ: MARGEM DE LUCRO PERCENTUAL POR PRODUTO
	#PENSEI EM MOSTRAR QUAIS PRODUTOS DÃO MAIS LUCRO PARA AUXILIAR NA TOMADA DE DECISÃO, ASSIM ELE PODE PROPOR PROMOÇÕES ESPORÁDICAS, CAPTAR CLIENTES E MANTER OS ANTIGOS
    
SELECT NAME AS PRODUTO,
    PRICE AS PRECO_VENDA,
    UNIT_COST AS CUSTO,
    ROUND((PRICE - UNIT_COST) / PRICE * 100, 1) AS MARGEM_PERCENTUAL FROM PRODUCTS  -- LUCRO DIVIDIDO PELO PREÇO X 100 PARA CALCULAR PORCENTAGEM
	ORDER BY MARGEM_PERCENTUAL ASC;  -- OS PRODUTOS DE MENOR MARGEM APARECEM PRIMEIRO PARA FICAR VISÍVEL OS QUE NÃO PODE APLICAR O DESCONTO


# 13. QUERY PARA O SEU ZÉ: QUANTO É O CUSTO COM CADA FORNECEDOR
	#ESSA VISUALIZAÇÃO SERVE PARA QUE O SEU ZÉ SAIBA QUEM É SEU MELHOR FORNECEDOR E POSSA NEGOCIAR MELHOR PARA AUMENTAR PRAZO DE PAGAMENTO E SEU LUCRO
    
SELECT SUPPLIERS.NAME AS FORNECEDOR,
    ROUND(SUM(SALES_ITEMS.QUANTITY * PRODUCTS.UNIT_COST), 2) AS CUSTO_TOTAL FROM SUPPLIERS
	JOIN PRODUCTS ON PRODUCTS.SUPPLIER_ID = SUPPLIERS.SUPPLIER_ID
	JOIN SALES_ITEMS ON SALES_ITEMS.PRODUCT_ID = PRODUCTS.PRODUCT_ID
	GROUP BY SUPPLIERS.SUPPLIER_ID, SUPPLIERS.NAME ORDER BY CUSTO_TOTAL DESC;


# 14. CLIENTE QUE MAIS COMPROU FIADO (em R$)

SELECT CUSTOMERS.NAME AS CLIENTE,
    ROUND(SUM(SALES_ITEMS.QUANTITY * PRODUCTS.PRICE), 2) AS TOTAL_FIADO FROM CUSTOMERS
JOIN SALES ON SALES.CUSTOMER_ID   = CUSTOMERS.CUSTOMER_ID
JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID
JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID
WHERE SALES.ON_CREDIT = 'S' GROUP BY CUSTOMERS.CUSTOMER_ID, CUSTOMERS.NAME ORDER BY TOTAL_FIADO DESC LIMIT 1;


# 15. PRODUTO QUE OS CLIENTES MAIS LEVAM SEM PAGAR NA HORA (por quantidade no fiado)

SELECT PRODUCTS.NAME AS PRODUTO,
    SUM(SALES_ITEMS.QUANTITY) AS UNIDADES_FIADAS FROM SALES
	JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID
	WHERE SALES.ON_CREDIT = 'S' GROUP BY PRODUCTS.PRODUCT_ID, PRODUCTS.NAME ORDER BY UNIDADES_FIADAS DESC LIMIT 1;


# 16. QUANTO O BAR DEIXOU DE ARRECADAR EM CADA MÊS
	#O SCRIPT ABAIXO CALCULA PARA CADA MÊS O VALOR TOTAL DE VENDAS A PRAZO QUE NÃO FORAM PAGAS, MOSTRANDO COMO RESULTADO O QUE AINDA TEM EM ABERTO PARA RECEBER

SELECT MONTH(SALES.SALE_DATE) AS MES,   -- COMANDO PARA EXTRAIR O MES DE CADA VENDA: 1 = JANEIRO, 2 = FEVEREIRO, 3 = MARÇO
    ROUND(SUM(SALES_ITEMS.QUANTITY * PRODUCTS.PRICE), 2) AS VALOR_NAO_ARRECADADO FROM CREDIT_SALE -- CALCULO DAS VENDAS QUE NÃO FORAM PAGAS
	JOIN SALES ON SALES.SALE_ID = CREDIT_SALE.SALE_ID -- RELAÇÃO DA VENDA A PRAZO COM A VENDA CORRESPONDENTE
	JOIN SALES_ITEMS ON SALES_ITEMS.SALE_ID = SALES.SALE_ID -- ENCONTRA OS ÍTENS VENDIDOS
	JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = SALES_ITEMS.PRODUCT_ID -- RELACIONA O PREÇO DE CADA PRODUTO
	WHERE CREDIT_SALE.PAYMENT_DATE IS NULL GROUP BY MONTH(SALES.SALE_DATE) ORDER BY MES; -- SE O PAYMENT_DATE ESTIVER PREENCHIDO É VENDA OK, SE É NULA, CONTINUA EM ABERTO

