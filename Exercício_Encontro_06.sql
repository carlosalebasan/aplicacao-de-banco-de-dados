USE DB_T05429_CARLOS_ALEXANDRE;

CREATE TABLE PRODUCT(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(32) NOT NULL,
    CATEGORY VARCHAR (32) NOT NULL,
    PRICE DECIMAL (10,2),
    STOCK INT
);

CREATE TABLE CUSTOMER(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(32) NOT NULL,
    AGE INT,
	CITY VARCHAR(32),
    EMAIL VARCHAR(35)
);

CREATE TABLE ORDER_TABLE(
	ID  INT AUTO_INCREMENT PRIMARY KEY,
    CUSTOMER_NAME VARCHAR (64) NOT NULL,
    PRODUCT_NAME VARCHAR (64) NOT NULL,
    QUANTITY INT NOT NULL,
    TOTAL_VALUE DECIMAL (10, 2)
);

INSERT INTO PRODUCT (NAME, CATEGORY, PRICE, STOCK) VALUES 
	('Notebook Dell Inspiron 15', 'Informática', 3499.90, 15),
	('Mouse Logitech M170', 'Periféricos', 79.90, 120),
	('Teclado Mecânico Redragon Kumara', 'Periféricos', 249.90, 45),
	('Monitor LG 24 Polegadas', 'Monitores', 899.90, 30),
	('HD Externo Seagate 1TB', 'Armazenamento', 329.90, 25);
    
INSERT INTO CUSTOMER (NAME, AGE, CITY, EMAIL) VALUES 
	('João Silva', 28, 'São Paulo', 'joao.silva@gmail.com'),
	('Maria Oliveira', 35, 'Rio de Janeiro', 'maria.oliveira@ftmail.com'),
	('Carlos Santos', 42, 'Belo Horizonte', 'carlos.santos@hotmail.com'),
	('Ana Costa', 25, 'Curitiba', 'ana.costa@gmail.com'),
	('Pedro Almeida', 31, 'Salvador', 'pedro.almeida@bol.com.br');
    
INSERT INTO ORDER_TABLE (CUSTOMER_NAME, PRODUCT_NAME, QUANTITY, TOTAL_VALUE) VALUES
	('João Silva', 'Notebook Dell Inspiron 15', 1, 3499.90),
	('Maria Oliveira', 'Mouse Logitech M170', 2, 159.80),
	('Carlos Santos', 'Monitor LG 24 Polegadas', 1, 899.90),
	('Ana Costa', 'Teclado Mecânico Redragon Kumara', 3, 749.70),
	('Pedro Almeida', 'HD Externo Seagate 1TB', 2, 659.80);

INSERT INTO PRODUCT VALUES
	(NULL,'Smartphone Samsung Galaxy A55', 'Celulares', 1899.90, 40),
	(NULL, 'Fone Bluetooth JBL Tune 520BT', 'Áudio', 249.90, 75),
	(NULL, 'Impressora HP DeskJet 2874', 'Impressoras', 499.90, 20),
	(NULL, 'Smart TV TCL 50 Polegadas', 'Televisores', 2299.90, 12),
	(NULL, 'Cadeira Gamer ThunderX3', 'Móveis', 1349.90, 18);
    
INSERT INTO CUSTOMER VALUES
	(NULL, 'Lucas Ferreira', 24, 'Campinas', 'lucas.ferreira@gmail.com'),
	(NULL, 'Fernanda Rocha', 37, 'Porto Alegre', 'fernanda.rocha@hotmail.com'),
	(NULL, 'Ricardo Nunes', 45, 'Recife', 'ricardo.nunes@bol.com.br'),
	(NULL, 'Juliana Martins', 29, 'Fortaleza', 'juliana.martins@aol.com'),
	(NULL, 'Gabriel Souza', 33, 'Manaus', 'gabriel.souza@gmail.com');
    
INSERT INTO ORDER_TABLE VALUES
	(NULL, 'Lucas Ferreira', 'Fone Bluetooth JBL Tune 520BT', 2, 499.80),
	(NULL, 'Fernanda Rocha', 'Smartphone Samsung Galaxy A55', 1, 1899.90),
	(NULL, 'Ricardo Nunes', 'Smart TV TCL 50 Polegadas', 1, 2299.90),
	(NULL, 'Juliana Martins', 'Impressora HP DeskJet 2874', 3, 1499.70),
	(NULL, 'Gabriel Souza', 'Cadeira Gamer ThunderX3', 2, 2699.80);
    
SELECT * FROM PRODUCT;

SELECT * FROM CUSTOMER;

SELECT * FROM ORDER_TABLE;

SHOW DATABASES;

SELECT * FROM PRODUCT WHERE PRICE > 700.00;

SELECT * FROM CUSTOMER WHERE AGE > 18;

SELECT * FROM ORDER_TABLE WHERE QUANTITY > 2;

SELECT * FROM PRODUCT ORDER BY PRICE DESC;

SELECT * FROM CUSTOMER ORDER BY AGE DESC;

SELECT * FROM PRODUCT LIMIT 5;

SELECT * FROM CUSTOMER LIMIT 5;

SELECT * FROM CUSTOMER WHERE NAME LIKE 'ANA%';

SELECT * FROM CUSTOMER WHERE NAME LIKE '%COSTA';

SELECT * FROM CUSTOMER WHERE NAME LIKE '%AN%';

SELECT * FROM CUSTOMER WHERE NAME LIKE '________martins';
