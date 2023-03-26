create database shopifyee;
use shopifyee;

drop database shopifyee;

create table product_category(
[category id] int primary key,
[category type] varchar(255));

select * from product_category;
drop table product_category

BULK INSERT product_category
FROM 'P:\Comsats Degree\DWH\project\category.csv'
with (
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n');



create table shop(
[shop id] int primary key,
[name] varchar(255),
seller_name varchar(255),
contact_no varchar(255),
password varchar(255),
address varchar(255),
rating int not null,
product_category int foreign key references product_category([category id]));

select * from shop;
drop table shop;

BULK INSERT shop
FROM 'P:\Comsats Degree\DWH\project\shop.csv'
with (
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n');


create table customer(
[customer id] int primary key,
[name] varchar(255) not null,
[email] varchar(255) not null,
[password] varchar(255) not null,
[phone no] varchar(255) not null,
[address] varchar(255) not null,
[cart id] int unique identity(1,1) not null);

select * from customer;
drop table customer;

BULK INSERT customer
FROM 'P:\Comsats Degree\DWH\project\customer.csv'
with (
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n');

create table product(
[product id] int not null primary key,
[product name] varchar(255) not null,
[Totalquantity] int not null,
product_category int foreign key references product_category([category id]));

select * from product;
drop table product;

BULK INSERT product
FROM 'P:\Comsats Degree\DWH\project\product.csv'
with (
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n');

create table price(
[product id] int foreign key references product([product id]),
price float not null);

select * from price;
drop table price;

BULK INSERT price
FROM 'P:\Comsats Degree\DWH\project\price.csv'
with (
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n');

create table [payment methods](
[payment id] int primary key ,
[payment method] varchar(255) not null);

select * from [payment methods];
drop table [payment methods];

BULK INSERT [payment methods]
FROM 'P:\Comsats Degree\DWH\project\payment.csv'
with (
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n');


create table [O_Date](
DateID int primary key ,
OrderDate date,
);

drop table O_Date;
select * from O_Date

BULK INSERT [O_Date]
FROM 'P:\Comsats Degree\DWH\project\orders.csv'
with (
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n');

 



create table [orders](
[order no] int primary key,
[customer id] int foreign key references customer([customer id]),
[product id] int foreign key references product([product id]),
[payment id] int foreign key references [payment methods]([payment id]),
DateID int foreign key references [O_Date](DateID),
orderQty int not null,
order_type varchar(255) not null
);

select * from [orders];
drop table [orders];

BULK INSERT [orders]
FROM 'P:\Comsats Degree\DWH\project\order.csv'
with (
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n');

create table delivery(
[delivery ID] int primary key not null,
[order id] int foreign key references [orders]([order no]),
[shop id] int foreign key references [shop]([shop id]),
[delivery reserve days] int not null,
order_shipVia varchar(255) not null
);

select * from delivery;
drop table delivery;

BULK INSERT delivery
FROM 'P:\Comsats Degree\DWH\project\delivery.csv'
with (
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n');

