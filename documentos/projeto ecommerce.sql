DROP TABLE IF EXISTS tb_addresses;

create TABLE tb_addresses (
  idaddress serial not null,
  idperson integer NOT NULL,
  desaddress varchar(128) NOT NULL,
  descomplement varchar(32) DEFAULT NULL,
  descity varchar(32) NOT NULL,
  desstate varchar(32) NOT NULL,
  descountry varchar(32) NOT NULL,
  nrzipcode integer NOT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_addresses_pk PRIMARY KEY (idaddress),
  CONSTRAINT fk_addresses_persons FOREIGN KEY (idperson) REFERENCES tb_persons (idperson) ON DELETE NO ACTION ON UPDATE NO ACTION


 
);

DROP TABLE IF EXISTS tb_carts;

CREATE TABLE tb_carts (
  idcart integer NOT NULL,
  dessessionid varchar(64) NOT NULL,
  iduser integer DEFAULT NULL,
  idaddress integer DEFAULT NULL,
  vlfreight decimal(10,2) DEFAULT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_carts_pk PRIMARY KEY (idcart),
  CONSTRAINT fk_carts_addresses FOREIGN KEY (idaddress) REFERENCES tb_addresses (idaddress) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_carts_users FOREIGN KEY (iduser) REFERENCES tb_users (iduser) ON DELETE NO ACTION ON UPDATE NO ACTION
  
);

DROP TABLE IF EXISTS tb_cartsproducts;

CREATE TABLE tb_cartsproducts (
  idcartproduct serial NOT NULL,
  idcart integer NOT NULL,
  idproduct integer NOT NULL,
  dtremoved timestamp NOT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_cartsproducts_pk PRIMARY KEY (idcartproduct),
  CONSTRAINT fk_cartsproducts_carts FOREIGN KEY (idcart) REFERENCES tb_carts (idcart) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_cartsproducts_products FOREIGN KEY (idproduct) REFERENCES tb_products (idproduct) ON DELETE NO ACTION ON UPDATE NO ACTION
  );
  
 
DROP TABLE IF EXISTS tb_categories;

CREATE TABLE tb_categories (
  idcategory serial NOT NULL ,
  descategory varchar(32) NOT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_categories_pk PRIMARY KEY (idcategory)
);


DROP TABLE IF EXISTS tb_orders;

CREATE TABLE tb_orders (
  idorder serial NOT NULL ,
  idcart integer NOT NULL,
  iduser integer NOT NULL,
  idstatus integer NOT NULL,
  vltotal decimal(10,2) NOT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_orders_pk PRIMARY KEY (idorder),
  CONSTRAINT fk_orders_carts FOREIGN KEY (idcart) REFERENCES tb_carts (idcart) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_orders_ordersstatus FOREIGN KEY (idstatus) REFERENCES tb_ordersstatus (idstatus) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_orders_users FOREIGN KEY (iduser) REFERENCES tb_users (iduser) ON DELETE NO ACTION ON UPDATE NO ACTION
  );
 
 
DROP TABLE IF EXISTS tb_ordersstatus;

CREATE TABLE tb_ordersstatus (
  idstatus serial NOT NULL ,
  desstatus varchar(32) NOT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_ordersstatus_pk PRIMARY KEY (idstatus)
);
INSERT INTO tb_ordersstatus VALUES (1,'Em Aberto','2017-03-13 03:00:00'),(2,'Aguardando Pagamento','2017-03-13 03:00:00'),(3,'Pago','2017-03-13 03:00:00'),(4,'Entregue','2017-03-13 03:00:00');
  

DROP TABLE IF EXISTS tb_persons;

CREATE TABLE tb_persons (
  idperson serial NOT NULL,
  desperson varchar(64) NOT NULL,
  desemail varchar(128) DEFAULT NULL,
  nrphone integer DEFAULT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_persons_pk PRIMARY KEY (idperson)
);
INSERT INTO tb_persons VALUES (1,'JoÃ£o Rangel','admin@hcode.com.br',2147483647,'2017-03-01 03:00:00'),(7,'Suporte','suporte@hcode.com.br',1112345678,'2017-03-15 16:10:27');




DROP TABLE IF EXISTS tb_products;

CREATE TABLE tb_products (
  idproduct serial NOT NULL,
  desproduct varchar(64) NOT NULL,
  vlprice decimal(10,2) NOT NULL,
  vlwidth decimal(10,2) NOT NULL,
  vlheight decimal(10,2) NOT NULL,
  vllength decimal(10,2) NOT NULL,
  vlweight decimal(10,2) NOT NULL,
  desurl varchar(128) NOT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_products_pk PRIMARY KEY (idproduct)
);
INSERT INTO tb_products VALUES (1,'Smartphone Android 7.0',999.95,75.00,151.00,80.00,167.00,'smartphone-android-7.0','2017-03-13 03:00:00'),(2,'SmartTV LED 4K',3925.99,917.00,596.00,288.00,8600.00,'smarttv-led-4k','2017-03-13 03:00:00'),(3,'Notebook 14\" 4GB 1TB',1949.99,345.00,23.00,30.00,2000.00,'notebook-14-4gb-1tb','2017-03-13 03:00:00');





DROP TABLE IF EXISTS tb_productscategories;

CREATE TABLE tb_productscategories (
  idcategory integer NOT NULL,
  idproduct integer NOT NULL,
  constraint tb_productscategories_pk PRIMARY KEY (idcategory, idproduct),
  CONSTRAINT fk_productscategories_categories FOREIGN KEY (idcategory) REFERENCES tb_categories (idcategory) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_productscategories_products FOREIGN KEY (idproduct) REFERENCES tb_products (idproduct) ON DELETE NO ACTION ON UPDATE NO ACTION
 );
 
 
DROP TABLE IF EXISTS tb_users;

CREATE TABLE tb_users (
  iduser serial NOT NULL,
  idperson integer NOT NULL,
  deslogin varchar(64) NOT NULL,
  despassword varchar(256) NOT NULL,
  inadmin smallint NOT NULL DEFAULT '0',
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_users_pk PRIMARY KEY (iduser),
  CONSTRAINT fk_users_persons FOREIGN KEY (idperson) REFERENCES tb_persons (idperson) ON DELETE NO ACTION ON UPDATE NO ACTION
  
);
INSERT INTO tb_users VALUES (1,1,'admin','$2y$12$YlooCyNvyTji8bPRcrfNfOKnVMmZA9ViM2A3IpFjmrpIbp5ovNmga',1,'2017-03-13 03:00:00'),(7,7,'suporte','$2y$12$HFjgUm/mk1RzTy4ZkJaZBe0Mc/BA2hQyoUckvm.lFa6TesjtNpiMe',1,'2017-03-15 16:10:27');






DROP TABLE IF EXISTS tb_userslogs;

CREATE TABLE tb_userslogs (
  idlog serial NOT NULL ,
  iduser integer NOT NULL,
  deslog varchar(128) NOT NULL,
  desip varchar(45) NOT NULL,
  desuseragent varchar(128) NOT NULL,
  dessessionid varchar(64) NOT NULL,
  desurl varchar(128) NOT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_userslogs_pk PRIMARY KEY (idlog),
  CONSTRAINT fk_userslogs_users FOREIGN KEY (iduser) REFERENCES tb_users (iduser) ON DELETE NO ACTION ON UPDATE NO ACTION
);
 

DROP TABLE IF EXISTS tb_userspasswordsrecoveries;

CREATE TABLE tb_userspasswordsrecoveries (
  idrecovery serial NOT NULL,
  iduser integer NOT NULL,
  desip varchar(45) NOT NULL,
  dtrecovery timestamp DEFAULT NULL,
  dtregister timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  constraint tb_userspasswordsrecoveries_pk PRIMARY KEY (idrecovery),
  CONSTRAINT fk_userspasswordsrecoveries_users FOREIGN KEY (iduser) REFERENCES tb_users (iduser) ON DELETE NO ACTION ON UPDATE NO ACTION
);
INSERT INTO tb_userspasswordsrecoveries VALUES (1,7,'127.0.0.1',NULL,'2017-03-15 16:10:59'),(2,7,'127.0.0.1','2017-03-15 13:33:45','2017-03-15 16:11:18'),(3,7,'127.0.0.1','2017-03-15 13:37:35','2017-03-15 16:37:12');


