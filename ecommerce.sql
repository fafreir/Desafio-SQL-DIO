create database ecommerce;
use ecommerce;

create table ident(
 idident int,
 nameident varchar(4),
 primary key(idident)
);

create table peoplecompany(
    idpeoplecompany int not null auto_increment,
    idident int not null,
    primary key(idpeoplecompany),
    register varchar(15) unique,
    constraint fk_ident foreign key(idident) references ident(idident)
);

create table clients(
	idClient int auto_increment,
    primary key(idClient),
    Fname varchar(10),
    Mname varchar(15),
    Lname varchar(20),
    cpfN int(1) unique ,
    Address varchar(100),
    constraint fk_cpf_client foreign key(idClient) references peoplecompany(idpeoplecompany)
);

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(50) not null,
    classification_kids bool default false,
    category enum('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliacao float default 0,
    size varchar(10)
);

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    payment enum('Dinheiro','Débito','Crédito','Pix','Boleto') default 'Débito',
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
    on update cascade
);

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstractName varchar(255),
    cnpjcpf int(1) unique,
    location varchar(255),
    contact varchar(11)not null,
    constraint cpf_cnpj_seller foreign key(idSeller) references peoplecompany(idpeoplecompany)
);

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ int(1) unique,
    contact varchar(11) not null,
    constraint fk_cnpj_supplier foreign key(idSupplier) references peoplecompany(idpeoplecompany)
);

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
    primary key(idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key(idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key(idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key(idLstorage) references productStorage(idProdStorage)
);

create table deliverProduct(
	idDProduct int auto_increment,
    idProduct int,
    codigo varchar(20) unique,
    statusDeliver enum('Em analise', 'A caminho', 'Entregue') default 'Em analise',
    primary key(idDProduct),
    constraint fk_deliver_prod foreign key (idProduct) references product(idProduct)
    );
    
insert into ident (idident, nameident) values
(1,'cpf'),
(2,'cnpj');

insert into peoplecompany(idident, register) values 
(1, '14785296312'),
(1, '14985296312'),
(2, '1498529631211'),
(2, '1498529631233'),
(2, '1498533631733'),
(1, '14995256332'),
(1, '39335389885'),
(2, '1234567890012'),
(1, '11122233356'),
(1, '12389689817'),
(2, '478596325121');

insert into clients(Fname, Mname, Lname, cpfN, Address) values
('Maria', 'Alice', 'Freire', 1, 'Rua das Orquideas'),
('Francisco', 'Norato', 'Silva', 3, 'Rua das Canarias'),
('Fernanda', 'Uiraki', 'Tinkasati', 6, 'Avenida das Rosas'),
('Mariana', 'Godoi', 'Maraven', 11, 'Avenida Forever Young'),
('João', 'Jansen', 'Junior', 7, 'Praça das Alameda');

insert into product (Pname, classification_kids, category, avaliacao, size) values
('Fone de ouvido',false, 'Eletronico','4',null),  
('Barbie Elsa',true,'Brinquedos',4,null),
('Body Cartners',true,'Vestimenta','5',null),
('Microfone Vedo - Youtuber',false,'Eletronico','4',null),
('Sofa retrátil',false,'Móveis','3','3x57x80'),
('Farinha de arroz',false,'Alimentos','2',null),
('Fire Stick Amazon',false,'Eletronico','3',null);

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, payment) values
(1,default,'compra via aplicativo', null,default),
(2,default,'compra via aplicativo',50,'Pix'),
(3,'Confirmado',null,null,'Dinheiro'),
(4,default,'compra via web site',150,'Credito');

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
(7,1,2,'Sem estoque'),
(6,3,1,default),
(4,4,1,default);

insert into productStorage (storageLocation, quantity) values
('Rio de Janeiro',1000),
('Bahia',500),
('São Paulo',10),
('Minas Gerais',100),
('São Paulo',10),
('Brasilia',60);

insert into storageLocation(idLproduct, idLstorage, location) values
(6,2,'RJ'),
(7,6,'GO');

insert into supplier(SocialName, CNPJ, contact) values
('Almeida e filhos',5,'21985474'),
('Eletrônicos Silva',8,'21985484'),
('Eletrônicos Valma',9,'21975474');

insert into seller(SocialName, AbstractName, cnpjcpf, location, contact) values
('Tech eletronics',null,10,'Rio de Janeiro',219946287),
('Boutique Durgas',null,9,'Rio de Janeiro',219567895),
('Kids World',null,8,'São Paulo',1198657484);

insert into productSeller (idPseller, idPproduct, prodQuantity) values
(1,3,80),
(2,4,10);

insert into deliverProduct(idProduct, codigo, statusDeliver) values
(2, '123a52b', default),
(6,'bcd525c', 'A caminho'),
(7, 'dab452e','Entregue');

insert into productsupplier(idPsSupplier, idPsProduct, quantity) values
(1,3,6),
(3,3,15);