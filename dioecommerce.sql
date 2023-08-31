-- criação de um banco de dados para um ecommerce dio
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table cliente(
		idCliente int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique (CPF)
);

-- criação de um banco de dados para um ecommerce dio
-- criar tabela produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        category enum('eletronico', 'vestimenta', 'brinquedo', 'alimentos') not null,
        avaliacao float default 0,
        size varchar(10)
);

-- criar tabela pagamento
create table payment(
		idClient int,
        id_payment int,
        typePayment enum('boleto', 'cartão', 'dois cartões'),
        limitAvailable float,
        primary key(idClient, id_payment)
);


-- criar tabela pedido
drop table orders;
create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('cancelado', 'confirmado', 'em processamento') default 'em processamento',
        orderDescription varchar(255),
        sendValue float default 0,
        paymentCash boolean default false,
		constraint fk_order_client foreign key (idOrderClient) references cliente(id)
			on update cascade
            on delete set null
);
desc orders;

-- criar tabela estoque
create table productStorage(
		idProdStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
);

-- criar tabela fornecedor
create table supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

-- criar tabela vendedor
create table seller(
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15) not null,
        CPF char(9),
        location varchar(255),
        contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);

-- criar tabela produto do vendedor
create table productSeller(
		idPseller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key(idPseller, idPproduct),
        constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
        constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

-- criar tabela ordem do produto
create table productOrder(
		idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum('disponivel', 'sem estoque') default 'disponivel',
        primary key(idPOproduct, idPOorder),
        constraint fk_product_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_product_product foreign key (idPOorder) references orders(idOrder)
);


-- criar tabela local de estocagem
create table storageLocation(
		idLproduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key(idProduct, idLsstorage),
        constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
        constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- criar tabela fornecedor
create table productSupllier(
		idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key(idPsSupplier, idPsProduct),
        constraint fk_product_supplier foreign key (idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

desc productSupllier;

show tables;

show databases;
use information_schema;
show tables;
desc referetial_constraints;
select * from referetial_constraints where constraint_schema = 'ecommerce';








