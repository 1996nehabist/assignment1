use ats;
select * from city_table;
# 1st question
#Query all columns for all American cities in the CITY table with populations larger than 100000.

select * from city_table
where countrycode="USA" and population>100000;

# 2nd question
#Query the NAME field for all American cities in the CITY table with populations larger than 120000.

select name from city_table
where countrycode="USA" and population>120000;

#3rd question
#Query all columns (attributes) for every row in the CITY table.

select * from city_table;

#4th question
#Query all columns for a city in CITY with the ID 1661.

select * from city_table
where id=1661;

#5th question
#Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

select * from city_table
where countrycode="JPN";

#6th question
#Query the names of all the Japanese cities in the CITY table.

select name from city_table
where countrycode="JPN";

########################################################################

select * from stationdata;
desc stationdata;

#7th question
#Query a list of CITY and STATE from the STATION table.

select city, state from stationdata;

#8th question
#Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

select distinct city from stationdata
where mod(id,2)=0
order by city;

#9th question
#Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

select count(city)-count(distinct city) from stationdata;

#10th question
#Query the two cities in STATION with the shortest and longest CITY names, as well as their
#respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
#largest city, choose the one that comes first when ordered alphabetically.

select city, length(city) as len_city from stationdata
order by length(city) asc, city asc limit 1;

select city, length(city) as len_city from stationdata
order by length(city) desc, city desc limit 1;


#11th question
#Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

select distinct city from stationdata
where substring(city,1,1) in ('a','e','i','o','u')
order by city;

#12th question
#Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

select distinct city from stationdata
where substring(reverse(city),1,1) in ('a','e','i','o','u')
order by reverse(city);

#13th question
#Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

select city from stationdata
where substring(city,1,1) not in ('a','e','i','o','u')
order by city;

#14th question
#Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.

select distinct city from stationdata
where substring(reverse(city),1,1) not in ('a','e','i','o','u')
order by reverse(city);

# 15th question
#Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

select distinct city from stationdata
where substring(reverse(city),1,1) not in ('a','e','i','o','u') 
or substring(city,1,1) not in ('a','e','i','o','u')
order by reverse(city);

#16th question
#Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.

select distinct city from stationdata
where substring(reverse(city),1,1) not in ('a','e','i','o','u') 
and substring(city,1,1) not in ('a','e','i','o','u')
order by reverse(city);

#17th question
#Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.

create table product(
product_id integer,
product_name varchar(30),
unit_price integer,
primary key(product_id)
);

insert into product values
(1, 'S8', 1000),
(2, 'G4', 800),
(3, 'iPhone', 1400);

create table sales(
seller_id int,
product_id int,
buyer_id int,
sale_date date,
quantity int,
price int,
foreign key(product_id) references product(product_id)
);

insert into sales values 
(1, 1, 1, '2019-01-21', 2, 2000),
(1, 2, 2, '2019-02-17', 1, 800),
(2, 2, 3, '2019-06-02', 1, 800),
(3, 3, 4, '2019-05-13', 2, 2800);
    
select s.product_id, p.product_name
from sales s, product p
where s.product_id = p.product_id
group by s.product_id, p.product_name
having min(s.sale_date) >= '2019-01-01' 
    and max(s.sale_date) <= '2019-03-31';


#18th question
#Write an SQL query to find all the authors that viewed at least one of their own articles.
#Return the result table sorted by id in ascending order.

create table views(
article_id int,
author_id int,
viewer_id int,
view_date date
);

insert into views values
(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21');

select distinct author_id from views
where author_id = viewer_id;

#19th question
#Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.


create table delivery(
delivery_id int,
customer_id int,
order_date date,
customer_pref_delivery_date date,
primary key(delivery_id)
);

insert into delivery values
(1, 1, '2019-08-01', '2019-08-02'),
(2, 5, '2019-08-02', '2019-08-02'),
(3, 1, '2019-08-11', '2019-08-11'),
(4, 3, '2019-08-24', '2019-08-26'),
(5, 4, '2019-08-21', '2019-08-22'),
(6, 2, '2019-08-11', '2019-08-13');

select round((select count(*) from delivery 
where order_date = customer_pref_delivery_date)/count(*)*100,2) 
as immediate_percentage from delivery;


#20th question
#Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
#Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.

create table ads(
ad_id int,
user_id int,
action enum('Clicked', 'Viewed', 'Ignored'),
primary key (ad_id, user_id) 
);

insert into ads values
(1, 1, 'Clicked'),
(2, 2, 'Clicked'),
(3, 3, 'Viewed'),
(5, 5, 'Ignored'),
(1, 7, 'Ignored'),
(2, 7, 'Viewed'),
(3, 5, 'Clicked'),
(1, 4, 'Viewed'),
(2, 11, 'Viewed'),
(1, 2, 'Clicked');


select ad_id,
round(avg(
case 
when action='Clicked' then 1 
when action='viewed' then 0 
else null 
end
)*100,2) as ctr
from ads
group by ad_id;



#21 question
#Write an SQL query to find the team size of each of the employees.

create table employee(
employee_id int,
team_id int,
primary key (employee_id)
);

insert into employee values
(1, 8),
(2, 8),
(3, 8),
(4, 7),
(5, 9),
(6, 9);

select e.employee_id, (select count(team_id) from Employee where e.team_id = team_id) as team_size
from Employee e;

#22 question
#Write an SQL query to find the type of weather in each country for November 2019.

create table countries(
country_id int,
country_name varchar(30),
primary key (country_id)
);

create table weather(
country_id int,
weather_state int,
day date,
primary key (country_id, day)
);

insert into countries values
(2, 'USA'),
(3, 'Australia'),
(7, 'Peru'),
(5, 'China'),
(8, 'Morocco'),
(9, 'Spain');

insert into weather values
(2, 15, '2019-11-01'),
(2, 12, '2019-10-28'),
(2, 12, '2019-10-27'),
(3, -2, '2019-11-10'),
(3, 0, '2019-11-11'),
(3, 3, '2019-11-12'),
(5, 16, '2019-11-07'),
(5, 18, '2019-11-09'),
(5, 21, '2019-11-23'),
(7, 25, '2019-11-28'),
(7, 22, '2019-12-01'),
(7, 20, '2019-12-02'),
(8, 25, '2019-11-05'),
(8, 27, '2019-11-15'),
(8, 31, '2019-11-25'),
(9, 7, '2019-10-23'),
(9, 3, '2019-12-23');

/*Write an SQL query to find the type of weather in each country for November 2019.
The type of weather is:
● Cold if the average weather_state is less than or equal 15,
● Hot if the average weather_state is greater than or equal to 25, and
● Warm otherwise.*/

select c.country_name, 
case 
when avg(weather_state) <= 15 then 'Cold' 
when avg(weather_state) >= 25 then 'Hot' 
else 'Warm' 
end as weather_state 
from countries c 
left join weather w on c.country_id = w.country_id 
where month(day) = 11 
group by c.country_name;


#23 questuion 
#Write an SQL query to find the average selling price for each product. average_price should be
#rounded to 2 decimal places.

create table Prices
(product_id int,
start_date date,
end_date date,
price int,
primary key(product_id, start_date, end_date)
);

create table unit_sold
(product_id int,
purchase_date date,
units int);

insert into prices values
(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20',15),
(2, '2019-02-21', '2019-03-31',30);

insert into unit_sold values
(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);

select  p.product_id, round((sum(u.units*p.price))/sum(u.units),2) as total
from unit_sold u, prices p
where p.product_id=u.product_id and 
u.purchase_date >= p.start_date 
and u.purchase_date <= p.end_date
group by p.product_id;


#24 question
#Write an SQL query to report the first login date for each player.

create table activity(
player_id int,
device_id int,
event_date date,
games_played int,
primary key(player_id, event_date)
);

insert into activity values
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

select player_id, min(event_date) as first_login
from activity
group by player_id;

#25 question
#Write an SQL query to report the device that is first logged in for each player.

select player_id, device_id
from activity
where (player_id ,event_date) in 
(select player_id, min(event_date) 
from activity
group by player_id);


#26 question
#Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
#and their amount.



create table products(
product_id int,
product_name varchar(30),
product_category varchar(30),
primary key (product_id)
);

create table orders(
product_id int,
order_date date,
unit int,
foreign key (product_id) references products(product_id)
);

insert into products values
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'),
(4, 'Lenovo', 'Laptop'),
(5, 'Leetcode Kit', 'T-shirt');

insert into orders values
(1, '2020-02-05', 60),
(1, '2020-02-10', 70),
(2, '2020-01-18', 30),
(2, '2020-02-11', 80),
(3, '2020-02-17', 2),
(3, '2020-02-24', 3),
(4, '2020-03-01', 20),
(4, '2020-03-04', 30),
(4, '2020-03-04', 60),
(5, '2020-02-25', 50),
(5, '2020-02-27', 50),
(5, '2020-03-01', 50);

select p.product_name, sum(o.unit) as unit
from products p, orders o
where p.product_id = o.product_id
and month(o.order_date)=02
group by p.product_name
having sum(unit)>=100;

#27 question 
#Write an SQL query to find the users who have valid emails.
#A valid e-mail has a prefix name and a domain where:
# The prefix name is a string that may contain letters (upper or lower case), digits, underscore
#'_', period '.', and/or dash '-'. The prefix name must start with a letter.
# The domain is '@leetcode.com'.

create table users(
user_id int,
`name` varchar(20),
mail varchar(30),
primary key (user_id)
);

insert into users values
(1, 'Winston', 'winston@leetcode.com'),
(2, 'Jonathan', 'jonathanisgreat'),
(3, 'Annabelle', 'bella-@leetcode.com'),
(4, 'Sally', 'sally.come@leetcode.com'),
(5, 'Marwan', 'quarz#2020@leetcode.com'),
(6, 'David', 'david69@gmail.com'),
(7, 'Shapiro', '.shapo@leetcode.com');

select user_id, `name`, mail
from users
where mail regexp "^[a-zA-Z][a-zA-Z0-9\_\.\/\-]*@leetcode.com";

#28 QUESTION
#Write an SQL query to report the customer_id and customer_name of customers who have spent at
#least $100 in each month of June and July 2020.
drop table if exists customers;
create table customers (
customer_id int,
customer_name varchar(20),
country varchar(30),
primary key(customer_id)
);

drop table if exists products;
create table products
(
product_id int,
customer_name varchar(20),
price int,
primary key(product_id)
);

drop table if exists orders; 
 create table orders(
 order_id int,
customer_id int,
product_id int,
order_date date,
quantity int);

insert into customers values
(1, 'Winston', 'USA'),
(2, 'Jonathan', 'Peru'),
(3, 'Moustafa', 'Egypt');

insert into products values
(10, 'LC Phone', 300),
(20, 'LC T-Shirt', 10),
(30, 'LC Book', 45),
(40, 'LC Keychain', 2);

insert into orders values
(1, 1, 10, '2020-06-10', 1),
(2, 1, 20, '2020-07-01', 1),
(3, 1, 30, '2020-07-08', 2),
(4, 2, 10, '2020-06-15', 2),
(5, 2, 40, '2020-07-01', 10),
(6, 3, 20, '2020-06-24', 2),
(7, 3, 30, '2020-06-25', 2),
(9, 3, 30, '2020-05-08', 3);

select o.customer_id, c.customer_name 
from customers c, products p, orders o
where o.customer_id=c.customer_id
and o.product_id=p.product_id
group by o.customer_id
having 
(
sum(case when month(o.order_date)=06 then o.quantity*p.price else 0 end)>=100 
and
sum(case when month(o.order_date)=07 then o.quantity*p.price else 0 end)>=100 
);


# 29 question
# Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
drop table if exists tvprogram ;
create table tvprogram
(
program_date date,
content_id int,
channel varchar(30),
primary key(program_date, content_id)
);
drop table if exists content ;
create table content(
content_id int,
title varchar(30),
Kids_content enum('Y', 'N'),
content_type varchar(20),
primary key(content_id)
);

insert into tvprogram values
('2020-06-10 08:00', 1, 'LC-Channel'),
('2020-05-11 12:00', 2, 'LC-Channel'),
('2020-05-12 12:00', 3, 'LC-Channel'),
('2020-05-13 14:00', 4, 'Disney Channel'),
('2020-06-18 14:00', 4, 'Disney Channel'),
('2020-07-15 16:00', 5, 'Disney Channel');


insert into content values
('1', 'Leetcode Movie' ,'N', 'Movies'),
('2', 'Alg. for Kids' ,'Y', 'Series'),
('3', 'Database Sols' ,'N', 'Series'),
('4', 'Aladdin' ,'Y', 'Movies'),
('5','Cinderella' ,'Y', 'Movies');

select distinct c.title from content c, tvprogram t
where c.content_id = t.content_id
and
c.kids_content='Y'
and
c.content_type="movies"
and 
(month(t.program_date), year(t.program_date))<=(06, 2020);

#30 question
#Write an SQL query to find the npv of each query of the Queries table.
drop table if exists npv;
create table npv
(
id int,
`year` int,
npv int,
primary key (id, year)
);
drop table if exists queries;
create table queries(
id int,
`year` int,
primary key (id, year)
);

insert into npv values
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

insert into queries values
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

select q.id, q.year, ifnull(n.npv,0) as npv
from queries as q
left join npv as n
on (q.id, q.year) = (n.id, n.year);


#31 question
#Write an SQL query to find the npv of each query of the Queries table.

select q.id, q.`year`, ifnull(n.npv, 0) as npv
from queries q 
left join npv as n 
on (q.id=n.id and q.`year`=n.`year`);

#32 question
#Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
#show null.
drop table if exists employees;
create table employees
(id int,
`name` varchar(25),
primary key (id)
);
drop table if exists employeeuni;
create table employeeuni
(id int,
unique_id int,
primary key(id, unique_id)
);

insert into employees values
(1, 'Alice'),
(7, 'Bob'),
(11, 'Meir'),
(90, 'Winston'),
(3, 'Jonathan');

insert into employeeuni values
(3, 1),
(11, 2),
(90, 3);

select ifnull(u.unique_id, 'null') as unique_id,e.name
from employees e
left join employeeuni as u
on e.id=u.id;


#33 question
#Write an SQL query to report the distance travelled by each user.
drop table if exists user;
create table user
(id int,
`name` varchar(20),
primary key(id)
);
drop table if exists rides;
create table rides
(id int,
user_id int,
distance int,
primary key(id)
);

insert into user values
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alex'),
(4, 'Donald'),
(7, 'Lee'),
(13, 'Jonathan'),
(19, 'Elvis');

insert into rides values
(1, 1, 120),
(2, 2, 317),
(3, 3, 222),
(4, 7, 100),
(5, 13, 312),
(6, 19, 50),
(7, 7, 120),
(8, 19, 400),
(9, 7, 230);

select u.`name`, sum(ifnull(r.distance, 0)) as travelled_distance
from rides r
right join user as u
on r.user_id = u.id
group by `name`
order by travelled_distance DESC, `name` ASC;

#34 question
#Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
drop table if exists products ;
create table products(
product_id int,
product_name varchar(30),
product_category varchar(30),
primary key (product_id)
);
drop table if exists orders ;
create table orders(
product_id int,
order_date date,
unit int,
foreign key (product_id) references products(product_id)
);

insert into products values
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'),
(4, 'Lenovo', 'Laptop'),
(5, 'Leetcode Kit', 'T-shirt');

insert into orders values
(1, '2020-02-05', 60),
(1, '2020-02-10', 70),
(2, '2020-01-18', 30),
(2, '2020-02-11', 80),
(3, '2020-02-17', 2),
(3, '2020-02-24', 3),
(4, '2020-03-01', 20),
(4, '2020-03-04', 30),
(4, '2020-03-04', 60),
(5, '2020-02-25', 50),
(5, '2020-02-27', 50),
(5, '2020-03-01', 50);

select p.product_name, sum(o.unit) as unit
from orders o,  products p
where p.product_id=o.product_id
and month(o.order_date)=02
group by p.product_id
having  sum(o.unit)>=100;

# 35 question
/*Write an SQL query to:
● Find the name of the user who has rated the greatest number of movies. In case of a tie,
return the lexicographically smaller user name.
● Find the movie name with the highest average rating in February 2020. In case of a tie, return
the lexicographically smaller movie name.*/

drop table if exists users ;
create table users
(user_id int,
`name` varchar(20),
primary key(user_id));

insert into users values
(1, 'Daniel'),
(2, 'Monica'),
(3, 'Maria'),
(4, 'James');


drop table if exists movies ;
create table movies(
movie_id int,
title varchar(30),
primary key(movie_id));

insert into movies values
(1, 'Avengers'),
(2, 'Frozen 2'),
(3, 'Joker');

drop table if exists movierating ;
create table movierating(
movie_id int,
user_id int,
rating int,
created_at date,
primary key(movie_id, user_id));

insert into movierating values
(1, 1, 3, '2020-01-12'),
(1, 2, 4, '2020-02-11'),
(1, 3, 2, '2020-02-12'),
(1, 4, 1, '2020-01-01'),
(2, 1, 5, '2020-02-17'),
(2, 2, 2, '2020-02-01'),
(2, 3, 2, '2020-03-01'),
(3, 1, 3, '2020-02-22'),
(3, 2, 4, '2020-02-25');


select results
from (
  select u.`name` as results
  from MovieRating mr
  join users u on mr.user_id = u.user_id
  group by u.`name`
  order by count(mr.rating) desc, `name`
  limit 1 
  ) as ratings
union all
select results 
from (
  select m.title as results
  from MovieRating mr2
  join Movies m on mr2.movie_id = m.movie_id 
  where DATE_FORMAT(mr2.created_at, "%Y-%m") = '2020-02'
  group by m.title
  order by avg(mr2.rating) desc, m.title 
  limit 1
) as movie_ratings;

#36 question
#Write an SQL query to report the distance travelled by each user.

drop table if exists users;
create table users(
id int,
`name` varchar(30),
primary key(id)
);
insert into users values
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alex'),
(4, 'Donald'),
(7, 'Lee'),
(13, 'Jonathan'),
(19, 'Elvis');


drop table if exists rides;
create table rides
(id int,
user_id int,
distance int,
primary key(id)
);


insert into rides values
(1, 1, 120),
(2, 2, 317),
(3, 3, 222),
(4, 7, 100),
(5, 13, 312),
(6, 19, 50),
(7, 7, 120),
(8, 19, 400),
(9, 7, 230);

select u.`name`, sum(ifnull(r.distance,0)) as travelled_distance
from rides r
right join users u on u.id = r.user_id
group by u.`name`
order by travelled_distance desc, u.`name` asc;

#37 question
#Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
#show null.
drop table if exists employees;
create table employees
(id int,
`name` varchar(25),
primary key (id)
);
drop table if exists employeeuni;
create table employeeuni
(id int,
unique_id int,
primary key(id, unique_id)
);

insert into employees values
(1, 'Alice'),
(7, 'Bob'),
(11, 'Meir'),
(90, 'Winston'),
(3, 'Jonathan');

insert into employeeuni values
(3, 1),
(11, 2),
(90, 3);

select ifnull(u.unique_id, 'null') as unique_id,e.name
from employees e
left join employeeuni as u
on e.id=u.id;


# 38 question
#Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exist.

drop table if exists departments;
create table departments(
id int,
`name` varchar(30),
primary key(id)
);

insert into departments values
(1, 'Electrical Engineering'),
(7, 'Computer Engineering'),
(13, 'Business Administration');

drop table if exists students;
create table students(
id int,
`name` varchar(30),
department_id int,
primary key(id));

insert into students values
(23, 'Alice', 1),
(1, 'Bob', 7),
(5, 'Jennifer', 13),
(2, 'John', 14),
(4, 'Jasmine', 77),
(3, 'Steve', 74),
(6, 'Luis', 1),
(8, 'Jonathan', 7),
(7, 'Daiana', 33),
(11, 'Madelynn', 1);

select id, `name` from students 
where department_id not in (select id from departments );



#39 question
/*Write an SQL query to report the number of calls and the total call duration between each pair of
distinct persons (person1, person2) where person1 < person2.*/

drop table if exists calls;
create table calls(
from_id int,
to_id int,
duration int);

insert into calls values
(1, 2, 59),
(2, 1, 11),
(1, 3, 20),
(3, 4, 100),
(3, 4, 200),
(3, 4, 200),
(4, 3, 499);

select from_id as person1, to_id as person2, 
count(duration) as call_count, sum(duration) as total_duration 
from  (
select * from calls
union all
select to_id, from_id, duration from calls
) as t1
where from_id<to_id
group by person1, person2;

#40 questuion 
#Write an SQL query to find the average selling price for each product. average_price should be
#rounded to 2 decimal places.
drop table if exists prices;
create table Prices
(product_id int,
start_date date,
end_date date,
price int,
primary key(product_id, start_date, end_date)
);


drop table if exists unit_sold;
create table unit_sold
(product_id int,
purchase_date date,
units int);

insert into prices values
(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20',15),
(2, '2019-02-21', '2019-03-31',30);

insert into unit_sold values
(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);

select  p.product_id, round((sum(u.units*p.price))/sum(u.units),2) as total
from unit_sold u, prices p
where p.product_id=u.product_id and 
u.purchase_date >= p.start_date 
and u.purchase_date <= p.end_date
group by p.product_id;


#41 question
#Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse.


drop table if exists warehouse;
create table warehouse(
`name` varchar(20),
product_id int,
units int,
primary key(`name`, product_id));

insert into warehouse values
('LCHouse1', 1, 1),
('LCHouse1', 2, 10),
('LCHouse1', 3, 5),
('LCHouse2', 1, 2),
('LCHouse2', 2, 2),
('LCHouse3', 4, 1);

drop table if exists products;
create table products (
product_id int,
product_name varchar(30),
Width int,
`Length` int,
Height int,
primary key(product_id));

insert into products values
(1, 'LC-TV', 5, 50, 40),
(2, 'LC-KeyChain', 5, 5, 5),
(3, 'LC-Phone', 2, 10, 10),
(4, 'LC-T-Shirt', 4, 10, 20);

select w.`name` as warehouse_name, 
sum((p.width*p.`length`*p.height)*w.units) as volume
from warehouse w, products p
where p.product_id=w.product_id
group by w.`name`;

#42 question
#Write an SQL query to report the difference between the number of apples and oranges sold each day.

drop table if exists sales;
create table sales (
sale_date date,
fruit enum("apples","oranges"),
sold_num int,
primary key(sale_date, fruit));

insert into sales values
('2020-05-01', 'apples', 10),
('2020-05-01', 'oranges', 8),
('2020-05-02', 'apples', 15),
('2020-05-02', 'oranges', 15),
('2020-05-03', 'apples', 20),
('2020-05-03', 'oranges', 0),
('2020-05-04', 'apples', 15),
('2020-05-04', 'oranges', 16);

select sale_date, 
sum( case when fruit='apples' then sold_num
          when fruit='oranges' then -sold_num end) as difference
from sales
group by sale_date;

#43 question
/*Write an SQL query to report the fraction of players that logged in again on the day after the day they
first logged in, rounded to 2 decimal places. In other words, you need to count the number of players
that logged in for at least two consecutive days starting from their first login date, then divide that
number by the total number of players.
*/
drop table if exists activity;

create table activity(
player_id int,
device_id int,
event_date date,
games_played int,
primary key(player_id, event_date)
);

insert into activity values
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

select round(t.player_id/(select count(distinct player_id) from activity),2) as fraction 
from (
select distinct player_id, 
datediff(event_date, lead(event_date, 1) over(partition by player_id order by event_date)) as diff 
from activity ) as t 
where diff = -1;


#44 question
#Write an SQL query to report the managers with at least five direct reports.

drop table if exists employee;
Create table Employee (
     Id int, 
     `Name` varchar(255), 
     Department varchar(255), 
     ManagerId int);

insert into Employee values
('101', 'John', 'A', null),
('102', 'Dan', 'A', '101'),
('103', 'James', 'A', '101'),
('104', 'Amy', 'A', '101'),
('105', 'Anne', 'A', '101'),
('106', 'Ron', 'B', '101');

select a.name 
from employee a 
inner join employee b on (a.id = b.managerid) 
group by a.name 
having count(distinct b.id) >= 5;


#45 question
/*Write an SQL query to report the respective department name and number of students majoring in
each department for all departments in the Department table (even ones with no current students).
Return the result table ordered by student_number in descending order. In case of a tie, order them by
dept_name alphabetically.
*/

drop table if exists student;
create table student(
student_id int,
student_name varchar(20),
gender varchar(10),
dept_id int,
primary key(student_id),
foreign key (dept_id) references department(dept_id)
);

insert into student values
(1, 'Jack', 'M', 1),
(2, 'Jane', 'F', 1),
(3, 'Mark', 'M', 2);

drop table if exists department;
create table department(
dept_id int,
dept_name varchar(20),
primary key (dept_id));
 
insert into department values
(1, 'Engineering'),
(2, 'Science'),
(3, 'Law');

SELECT dept_name, COUNT(student_id) student_number
FROM Department d LEFT JOIN Student s
ON s.dept_id = d.dept_id
GROUP BY d.dept_id
ORDER BY student_number DESC, dept_name;

#46 question
/*Write an SQL query to report the customer ids from the Customer table that bought all the products in
the Product table.
*/
drop table if exists customer;
create table Customer(
customer_id int, 
product_key int);

insert into Customer values
(1,5),
(2,6),
(3,5),
(3,6),
(1,6);

drop table if exists product;
create table Product(product_key int);
insert into Product
values
(5),
(6);
select a.customer_id from
(select customer_id, count(distinct product_key) as num
from Customer
group by customer_id) a
where a.num = (select count(distinct product_key) from Product);


#47 question
/*Write an SQL query that reports the most experienced employees in each project. In case of a tie,
report all employees with the maximum number of experience years.
*/

drop table if exists project;
create table Project
(
project_id integer,
employee_id integer,
primary key (project_id, employee_id)
);

drop table if exists employee;
create table Employee
(
employee_id integer,
`name` varchar(30),
experience_years integer,
primary key(employee_id)
);

insert into Project
values
(1,1),
(1,2),
(1,3),
(2,1),
(2,4);


insert into Employee values
(1,'khaled',3),
(2,'ali',2),
(3,'john',3),
(4,'doe',2);

select project_id, employee_id
from Project
join Employee
using (employee_id)
where (project_id, experience_years) in (
    select project_id, max(experience_years)
    from Project
    join Employee
    using (employee_id)
    group by project_id);
    

#48 question
/*Write an SQL query that reports the books that have sold less than 10 copies in the last year,
excluding books that have been available for less than one month from today. Assume today is
2019-06-23.
*/

drop table if exists books;
create table books(
book_id int,
`name` varchar(30),
available_from date,
primary key(book_id));

drop table if exists orders;
create table orders (
order_id int,
book_id int,
quantity int,
dispatch_date date,
primary key(order_id),
foreign key (book_id) references books(book_id));

insert into books values
(1, "Kalila And Demna", '2010-01-01'),
(2, "28 Letters" ,'2012-05-12'),
(3, "The Hobbit", '2019-06-10'),
(4, "13 Reasons Why", '2019-06-01'),
(5, "The Hunger Games", '2008-09-21');

insert into orders values
(1, 1, 2, '2018-07-26'),
(2, 1, 1, '2018-11-05'),
(3, 3, 8, '2019-06-11'),
( 4, 4, 6, '2019-06-05'),
( 5, 4, 5, '2019-06-20'),
( 6, 5, 9, '2009-02-02'),
( 7, 5, 8, '2010-04-13');

SELECT DISTINCT b.book_id, b.name
FROM books b 
WHERE available_from < '2019-05-23'
AND book_id NOT IN
(SELECT book_id
 FROM orders 
 WHERE dispatch_date > '2018-06-23'
 GROUP BY book_id
 HAVING SUM(quantity) >= 10);
 
 
 #49 question
 /*Write a SQL query to find the highest grade with its corresponding course for each student. In case of
a tie, you should find the course with the smallest course_id.
 */
drop table if exists enrollments;
create table enrollments (
student_id int,
course_id int,
grade int,
primary key(student_id, course_id));

insert into enrollments values
(2, 2, 95),
(2, 3, 95),
(1, 1, 90),
(1, 2, 99),
(3, 1, 80),
(3, 2, 75),
(3, 3, 82);

select student_id, min(course_id) as course_id, grade
from Enrollments
where (student_id, grade) in 
    (select student_id, max(grade)
    from Enrollments
    group by student_id)
group by student_id, grade
order by student_id asc;


#50 question
/*Each row is a record of a finished match between two different teams.
Teams host_team and guest_team are represented by their IDs in the Teams table (team_id), and they
scored host_goals and guest_goals goals, respectively.

The winner in each group is the player who scored the maximum total points within the group. In the
case of a tie, the lowest player_id wins.
Write an SQL query to find the winner in each group.
*/

drop table if exists players;
create table players(
player_id int,
group_id int,
primary key(player_id));

drop table if exists matches;
create table matches(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into players values
(15, 1),
(25, 1),
(30, 1),
(45, 1),
(10, 2),
(35, 2),
(50, 2),
(20, 3),
(40, 3);

insert into matches values
(1, 15, 45, 3, 0),
(2, 30, 25, 1, 2),
(3, 30, 15, 2, 0),
(4, 40, 20, 5, 2),
(5, 35, 50, 1, 1);

select t2.group_id, t2.player_id from 
( select t1.group_id, t1.player_id, dense_rank() over(partition by group_id 
order by score desc, player_id) as r 
from ( select p.*, 
case when p.player_id = m.first_player then m.first_score 
when p.player_id = m.second_player then m.second_score end 
as score from Players p, Matches m 
where player_id in (first_player, second_player) ) t1 ) t2 where r = 1;







