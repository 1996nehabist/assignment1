create database ATS;
use ATS;
create table if not exists AI_tools(
id integer,
technology varchar(30)
);

insert into ai_tools values
(1, 'data science'),
(1, 'python'),
(1,'mysql'),
(1,'tableau'),
(1,'R'),
(2,'mysql'),
(2,'R'),
(2,'power BI'),
(3,'R'), (3,'python'),(3,'C'),(3,'data science'),
(3,'mysql'), (4,'R'), (4,'C');

select id from ai_tools  
where technology in ("data science","python","mysql")
group by id
having count(distinct technology)=3;


create table if not exists product_info(
product_id integer,
product_name varchar(30)
);

create table if not exists product_info_likes(
user_id integer,
product_id integer,
likes_date date
);

insert into product_info values
(100, "blog"),
(101, "youtube"),
(102,"education"),
(103, "instagram");

insert into product_info_likes values
(1, 100, '2023-08-19'),
(2, 100, '2023-08-18'),
(3, 101, '2023-08-17'),
(4, 100, '2023-08-18'),
(5, 102, '2023-08-19'),
(6, 102, '2023-08-17'),
(7, 100, '2023-08-18');

select product_id from product_info
where product_id not in 
(select product_id from product_info_likes);
