drop database railway_reservation_system;

create database railway_reservation_system;

use railway_reservation_system;


create table USER(user_id int primary key,
first_name varchar(50),
last_name varchar(50),
gender char,age int,mobile_no varchar(50),
email varchar(50),
city varchar(50),
state varchar(50),
pincode varchar(20),
_password varchar(50),
security_ques varchar(50),
security_ans varchar(50));

create table TRAIN(train_no int primary key,
train_name varchar(50),
arrival_time time,departure_time time,
availability_ofseats char,
date date);

create table STATION(station_no int ,
name varchar(50),
arrival_time time,
train_no int,
primary key(station_no,train_no),
constraint foreign key(train_no) references TRAIN(train_no));

create table TRAIN_STATUS(train_no int primary key,
b_seats1 int, 
b_seats2 int,
a_seats1 int,
a_seats2 int,
w_seats1 int,
w_seats2 int,
fare1 float,
fare2 float);

create table TICKET(id int primary key,
user_id int,
status char,
no_of_passengers int,
train_no int,
constraint foreign key(user_id) references USER(user_id),
constraint foreign key(train_no) references TRAIN(train_no));

create table PASSENGERS( passenger_id int primary key,
age int,
gender char,
user_id int,
reservation_status char,
seat_number varchar(5),
name varchar(50),
ticket_id int,
constraint foreign key(user_id) references USER(user_id),
constraint foreign key(ticket_id) references TICKET(id));



create table  STARTS( train_no int primary key,
station_no int,
constraint foreign key(train_no) references TRAIN(train_no),
constraint foreign key(station_no) references STATION(station_no));

create table STOPS_AT( train_no int,
station_no int,
constraint foreign key(train_no) references TRAIN(train_no),
constraint foreign key(station_no) references STATION(station_no));

create table  REACHES(train_no int,
station_no int,
time time,
constraint foreign key(train_no) references TRAIN(train_no),
constraint foreign key(station_no) references STATION(station_no));

create table BOOKS( user_id int,
id int,
constraint foreign key(user_id) references USER(user_id),constraint foreign key(id) references TICKET(id));

create table CANCEL(user_id int,
id int,
passenger_id int,
constraint foreign key(id) references TICKET(id),
constraint foreign key(passenger_id) references PASSENGERS(passenger_id),
constraint foreign key(user_id) references USER(user_id));





insert into USER(user_id,first_name,last_name,gender,age,mobile_no,email,city,state,pincode,_password,security_ques,security_ans)
values(1701,'ahmed','atef','M',34,'01146429473','ahmed@gmail.com','cairo','','520001','12345@#','favourite_colour','red'),
(1702,'ali','mohamed','M',45,'01146429477','ali@gmail.com','alexandria','12345','522004',' I2@#345','favouritc_car','bmw'),
( 1703,'noha','ahmed','F',20,'01146429479','noha@gmail.com','aswan','1345','522004','0987hii','favourite_game','pubg');


insert into TRAIN(train_no,train_name,arrival_time,departure_time,availability_ofseats,date) 
values(12711,'express','12:05','12:20','y',20220410),
(12315,'spanish','12:30','12:45','n',20220410);

insert into STATION(station_no,name,arrival_time,train_no) 
values(111,'aswan','05:00',12711),
(222,'cairo','16:00',12315);


insert into TRAIN_STATUS(train_no,b_seats1,b_seats2,a_seats1,a_seats2,w_seats1,w_seats2,fare1,fare2) 
values(12711,10,4,0,1,1,0,100,450),
(12315,10,5,0,0,2,1,300,600);


insert into TICKET(id,user_id,status,no_of_passengers,train_no) 
values(4001,1701 ,'y',1,12711)
,(4002,1702,'n',1,12315);


insert into PASSENGERS(passenger_id,age,gender,user_id,reservation_status,seat_number,name,ticket_id)
 values(5001,45,'M', 1701,'y' ,'B6-45','ahmed',4001 ),
 (5002,54,'f',1703,'n','B3-21','noha',4002);
 
 
 insert into STARTS(train_no,station_no)
 values(12711,111),( 12315,222);
 
 insert into STOPS_AT(train_no,station_no) values(12711,222),(12315,111);
 
  insert into REACHES(train_no,station_no,time)
 values(12711,222,'15:00'), (12315,111,'16:00');
 
 insert into BOOKS(user_id,id) values( 1701,4001),(1702,4002);
 
 insert into CANCEL(user_id,id,passenger_id) values(1701,4001,5001);



-- 1-print details of passenger travelling under ticket_no 4001 

select *  from passengers where ticket_id like 4001;

-- 2-display time at which train no----- reaches sation no ---
select r.* ,s.name
from reaches r,station s
where r.station_no=s.station_no;

-- 3- display details of all those users who canclcd tickets for train no	12711
select u.*
from user u, cancel c,ticket t
where c.user_id=u.user_id and c.id=t.id and t.train_no like 12711;


-- 4- display passenger details for train express
select p.*
from passengers p,train l,ticket t
where l.train_no=t.train_no and t.id=p.ticket_id and l.train_name like 'express';


-- 5- display details of all those passengers whose status is yes for train no 12711

select t.*
from ticket t
where t.status like 'y' and train_no=12711;









