create database facttable;
use facttable;

drop database facttable;


create table product_category(
[category id] int primary key,
[category type] varchar(255));

select * from product_category;
drop table product_category;

INSERT INTO dbo.product_category ([category id], [category type])
   SELECT cat.[category id], cat.[category type]
     FROM shopifyee.dbo.product_category as cat where ([category id] = cat.[category id]);



create table shop(
[shop id] int primary key,
[name] varchar(255),
seller_name varchar(255),
contact_no varchar(255),
[password] varchar(255),
[address] varchar(255));

select * from shop;
drop table shop;

INSERT INTO dbo.shop([shop id], [name], seller_name, contact_no, [password], [address])
   SELECT s.[shop id], s.[name], s.seller_name, s.contact_no, s.[password], s.[address]
     FROM shopifyee.dbo.shop as s where([shop id] = s.[shop id]);
     

create table customer(
[customer id] int primary key,
[name] varchar(255) not null,
[email] varchar(255) not null,
[password] varchar(255) not null,
[phone no] varchar(255) not null,
[address] varchar(255) not null,
[cart no] int not null unique
);
select * from customer;
drop table customer;

INSERT INTO dbo.customer ([customer id], [name], [email], [password], [phone no], [address], [cart no])
SELECT cust.[customer id], cust.[name], cust.[email], cust.[password], cust.[phone no], cust.[address], cust.[cart id]
FROM shopifyee.dbo.customer as cust 
where ([customer id] = cust.[customer id]);

create table product(
[product id] int not null primary key,
[product name] varchar(255) not null,
[quantity] int not null,
price int not null);

select * from product;
drop table product;

insert into dbo.product([product id] , [product name], [quantity], price)
select pro.[product id], pro.[product name], pro.[Totalquantity], p.price from shopifyee.dbo.product as pro 
inner join shopifyee.dbo.price as p on p.[product id] = pro.[product id];



create table [payment method](
[payment id] int primary key ,
[payment method] varchar(255) not null);

select * from [payment method];
drop table [payment method];

insert into dbo.[payment method] ([payment id], [payment method]) 
select pay.[payment id], pay.[payment method] from shopifyee.dbo.[payment methods] as pay
where ([payment id] = pay.[payment id]);


create table [order](
[order id] int primary key ,
order_type varchar(255) not null
);
drop table [order];
select * from [order];

insert into dbo.[order]([order id]  , order_type)
select [order no],  order_type from shopifyee.dbo.[orders] ;

create table [O_Date](
DateID int  primary key not null,
[order Date] date not null,
D_day varchar(255) not null,
D_month varchar(255) not null,
D_year varchar(255) not null
);
drop table O_Date;
select * from O_Date;

insert into dbo.[O_Date](DateID, [order Date],D_year,D_month, D_day  )
select O.DateID,  O.[OrderDate],DATENAME(yyyy, O.[OrderDate] )as yearDate, DATENAME(month, O.[OrderDate]) as monthDate,   DateName(WEEKDAY , O.[OrderDate]) as daydate   
from shopifyee.dbo.[O_Date] as O 



create table delivery(
[delivery ID] int primary key not null,
[delivery reserve days] int not null,
order_shipVia varchar(255) not null);

select * from delivery;
drop table delivery;

insert into dbo.[delivery]([delivery ID] , [delivery reserve days], order_shipVia)
select [delivery ID], [delivery reserve days], order_shipVia from shopifyee.dbo.delivery;






create table fact(
[category id] int foreign key references product_category([category id]),
[shop id] int foreign key references shop([shop id]),
[product id] int foreign key references [product]([product id]),
[customer id] int foreign key references [customer]([customer id]),
[payment id] int foreign key references [payment method]([payment id]),
[order id] int foreign key references [order]([order id]) ,
[delivery id] int foreign key references [delivery]([delivery ID]),
DateID int foreign key references [O_Date](DateID),
[order Qty] int not null,
[rating] int not null,
[delivery reserve days] int not null,
);
select * from fact;
drop table fact;
 

insert into dbo.fact ([category id], [shop id], [product id], [customer id],  [payment id], [order id], [delivery id], DateID,
[order Qty], [rating] , [delivery reserve days])


select cat.[category id], sh.[shop id],  p.[product id], cust.[customer id], pay.[payment id], o.[order no], d.[delivery id], da.DateID,
o.orderQty,  sh.rating , d.[delivery reserve days] from shopifyee.dbo.orders as o join shopifyee.dbo.delivery as d on o.[order no] = d.[order id]
join shopifyee.dbo.[O_Date] as da on da.[DateID] = o.DateID
join shopifyee.dbo.shop as sh on sh.[shop id] = d.[shop id] join shopifyee.dbo.product_category as cat on sh.product_category = cat.[category id]
join shopifyee.dbo.customer as cust on  cust.[customer id] = o.[customer id] 
join shopifyee.dbo.product as p on p.[product id] = o.[product id] join shopifyee.dbo.[payment methods] as pay on pay.[payment id] = o.[payment id]
group by cat.[category id], sh.[shop id],  p.[product id], cust.[customer id], pay.[payment id], o.[order no], d.[delivery id], da.DateID,
o.orderQty,  sh.rating , d.[delivery reserve days];


