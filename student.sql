CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker (
    WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT(15),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);

INSERT INTO Worker 
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) 
VALUES 
(1001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
(1002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
(1003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
(1004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
(1005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
(1006, 'Vipul', 'Kumar', 200000, '14-06-11 09.00.00', 'Account'),
(1007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
(1008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');

INSERT INTO Worker 
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) 
VALUES 
(1009, 'ABC', 'XYZ', 700000, '18-02-20 09.00.00', 'HR');

SELECT * FROM Worker;

-- update
update Worker set FIRST_NAME="Sneha", SALARY=90000 where WORKER_ID=1009;

-- update multiple rows
-- set sql_safe_updates=0;
-- update Worker set DEPARTMENT='emp';

-- delete
delete from Worker where WORKER_ID=1009;



CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT(10),
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) 
VALUES 
(1001, 5000, '16-02-20'),
(1002, 3000, '16-06-11'),
(1003, 4000, '16-02-20'),
(1001, 4500, '16-02-20'),
(1002, 3500, '16-06-11');

SELECT * FROM Bonus;

CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) 
VALUES 
(1001, 'Manager', '2016-02-20 00:00:00'),
(1002, 'Executive', '2016-06-11 00:00:00'),
(1008, 'Executive', '2016-05-11 00:00:00'),
(1005, 'Manager', '2016-02-20 00:00:00'),
(1004, 'Asst. Manager', '2016-06-11 00:00:00'),
(1007, 'Executive', '2016-06-11 00:00:00'),
(1006, 'Lead', '2016-06-11 00:00:00'),
(1003, 'Lead', '2016-06-11 00:00:00');

SELECT * FROM Title;


select FIRST_NAME,SALARY from Worker;

select lcase('KASHISH');

select * FROM Worker where SALARY>100000;

SELECT * FROM Worker WHERE DEPARTMENT='HR';

-- SALARY 80K TO 3LAKHS
select * FROM Worker where SALARY between 80000 AND 300000;

-- REDUCE OR STMTS-- 
-- HR,ADMIN WORKING

SELECT * FROM Worker WHERE DEPARTMENT='HR' OR DEPARTMENT='Admin';

-- --BETTER WAY :IN
SELECT * FROM Worker WHERE DEPARTMENT IN('HR','Admin');

-- NOT KEYWORD
SELECT * FROM Worker WHERE DEPARTMENT NOT IN('HR','Admin');

-- IS NULL-- 
SELECT * FROM Worker WHERE DEPARTMENT IS NULL;

-- WILDCARD
SELECT * FROM Worker WHERE FIRST_NAME LIKE '_i%';

-- ORDER BY(SORTING)
SELECT * FROM Worker order by SALARY DESC;

-- DISTINCT VALUES
SELECT DISTINCT DEPARTMENT FROM Worker;

-- GROUP BY
SELECT DEPARTMENT ,COUNT(DEPARTMENT) FROM Worker GROUP BY DEPARTMENT;

-- AVG SALARY PER DEPT
SELECT DEPARTMENT ,AVG(SALARY) FROM Worker GROUP BY DEPARTMENT;

-- MIN SALARY PER DEPT
SELECT DEPARTMENT ,MIN(SALARY) FROM Worker GROUP BY DEPARTMENT;

-- TOTAL SALARY PER DEPT
SELECT DEPARTMENT, SUM(SALARY) FROM Worker GROUP BY DEPARTMENT;

-- GROUP BY HAVING(WITH MORE THAN 2 EMP)
SELECT DEPARTMENT ,COUNT(DEPARTMENT) FROM Worker GROUP BY DEPARTMENT HAVING COUNT(DEPARTMENT)>2;

create table ACCOUNT(
ID int primary key,
NAME varchar(255) unique,
BAL INT ,
constraint ACC_BAL_CHK check(BAL>10000));

INSERT INTO ACCOUNT(ID,NAME,BAL)
VALUES (1,'ABC',20000);

INSERT INTO ACCOUNT(ID,NAME,BAL)
VALUES (2,'AC',9000);

DROP TABLE ACCOUNT;

create table ACCOUNT(
ID int primary key,
NAME varchar(255) unique,
BAL INT NOT NULL default 100);

select * FROM ACCOUNT;

INSERT INTO ACCOUNT(ID,NAME)
VALUES (1,'ABC');

INSERT INTO ACCOUNT(ID,NAME)
VALUES (2,'AC');

INSERT INTO ACCOUNT(ID,NAME,BAL)
VALUES (18,'JJ',9999);

INSERT INTO ACCOUNT(ID,NAME,BAL)
VALUES (29,'HHC',8989);

-- ADD NEW COL
alter table ACCOUNT ADD INTEREST float NOT NULL default 0;

-- MODIFY DTYPE
ALTER TABLE ACCOUNT modify INTEREST INT NOT NULL default 0;

-- DESCRIBE TABLE
desc ACCOUNT;

-- RENAME COLUMN
ALTER TABLE ACCOUNT change column INTEREST SAVINGS  float NOT NULL default 0;

-- DROP COLUMN
ALTER TABLE ACCOUNT DROP column SAVINGS;

-- RENAME TABLE
ALTER TABLE ACCOUNT RENAME TO ACC_DETAILS;

-- customer and order

create table Customer(
id int primary key,
cname varchar(50),
address varchar(555),
gender char(2),
city varchar(50),
pincode int
);

insert into Customer values
(111,"ram das","108 area","M","vizag",9090),
(121,"shyam das","104 area","M","vizag",9090),
(131,"krishna das","101 area","M","vizag",9090),
(141,"gauranga das","112 area","M","vizag",9090),
(151,"nitai das","199 area","M","vizag",9090);

replace into Customer(id,city) values(121,'abc');
replace into Customer(id,city) values(999,'abc');
replace into Customer set id=900,cname='sahoo',city='utah';



CREATE TABLE Orders(
id int primary key,
del_date date,
cust_id int,
foreign key(cust_id) references Customer(id) on delete set null
);

insert into Orders values
(101,"2020-09-22",111),
(104,"2020-07-22",111);

select * from Customer;
select * from Orders;

delete from Customer where id=111;

-- SQL PRACTICE QUESTIONS --

-- 1.FETCH FIRST NAME FROM WORKER USING ALIAS AS WORKER_NAME
select FIRST_NAME as WORKER_NAME from Worker;

-- 2.FETCH FIRST NAME FROM WORKER in UPPER CASE
select upper(first_name) from Worker;

-- 3.fetch unique values of dept from Worker
select distinct department from worker;

-- 4.first 3 characters of fname from worker
select substring(FIRST_NAME,1,3) as WORKER_NAME from Worker;

-- 5.find postion of 'b' in fname col of amitabh from worker
select instr(first_name,'b') from worker where first_name='Amitabh'; 

-- 6.first name of worker after removes white spaces from right side
select rtrim(first_name) from worker;

-- 7.first name of worker after removes white spaces from left side
select ltrim(first_name) from worker;

-- 8.fetch unique values of dept from Worker and its length
select distinct department,length(department) from worker;

-- 9.FETCH FIRST NAME FROM WORKER in replace 'a' with 'A'
select replace(first_name,'a','A') from worker;

-- 10. fname and lname from worker into a col comp_name and a space must separate them
select concat(first_name,' ',last_name) as complete_name from worker;

-- 11.print all worker details from worker order by fname asc
select first_name from worker order by first_name asc;

-- 12.print all worker details from worker order by fname asc and dept desc
select first_name,department from worker order by first_name asc,department desc;

-- 13. print details of workers with fname as 'vipul' and 'satish' from worker table;
select * from worker where first_name in ('vipul','satish');

-- 14. print details of workers not with fname as 'vipul' and 'satish' from worker table;
select * from worker where first_name not in ('vipul','satish');

-- 15.print details of worker with dept name as admin;
select * from worker where department='admin';
select * from worker where department like'admin%';

-- 16.workers details fname contains 'a'
select * from worker where first_name like "%a%";

-- 17.workers details fname ends with 'a'
select * from worker where first_name like "%a";

-- 18.workers details fname ends with 'h' and contains 6 alphabets
select * from worker where first_name like "_____h";

-- 19. details of worker whose sal lies between 100000 & 500000
select * from worker where salary between 100000 and 500000;

-- 20. workers joined in feb 2014
select * from worker where year(joining_date)=2014 and month(joining_date)=02; 

-- 21. count of workers in dept admin;
select department,count(department) from worker where department='admin';
select count(department) as admin_count from worker group by department having department ="admin";

-- 22.worker full name with salary between >=50000 and <=100000
select concat(first_name," ",last_name) from worker
where salary between 50000 and 100000;

-- 23. no.of workers from each dept in desc order
select department, count(worker_id) from worker group by department order by  count(department)  desc;

-- 24.deatails of employee who are also managers
select w.* from worker as w inner join title as t on w.worker_id=t.worker_ref_id where t.worker_title="manager";

-- 25. fetch no(more than 1) of same titles in org of differnt types
select worker_title,count(*) from title group by worker_title having count(*)>1;

-- 26.write to show only odd rows from table
select * from worker where mod(worker_id,2)!=0;

-- 27.write to show only even rows from table
select * from worker where mod(worker_id,2)=0;

-- 28. To clone a new table from another table
create table worker_clone like worker;
insert into worker_clone select * from worker;
select * from worker_clone; 

-- 29.fetch intersecting records of two tables
select worker.* from worker inner join worker_clone using(worker_id);

-- 30. show records of one table that another table do not have(MINUS)
select worker.* from worker left join worker_clone using (worker_id) where worker_clone.worker_id is null;

-- 31. show current date and time
select curdate();
select now();

-- 32. show top n records(n=5) order by desc sal
select first_name,salary from worker order by salary desc limit 5;

-- 33.find nth highest sal(n=5)
 select first_name,salary from worker order by salary desc limit 4,1;
 
 -- 34.find nth highest sal(n=5) without limit keyword
 select first_name,salary from worker w1
 where 4=(
 select count(distinct(w2.salary))
 from worker w2
 where w2.salary>=w1.salary
 );
 
 -- 35.fetch list of emp with same sal
 select w1.* from worker w1,worker w2 where w1.salary=w2.salary and w1.worker_id !=w2.worker_id;
 
 -- 36.fetch 2nd highest salary using sub-query
 select max(salary) from worker 
 where salary not in (select max(salary) from worker);
 
 -- 37.show one row twice in res from a table
 select * from worker
 union all
 select * from worker order by worker_id;
 
 -- 38.worker who did not get bonus
 select worker_id,first_name from worker where worker_id not in(select worker_ref_id from bonus);
 
 -- 39. fetcch 50% records from table
 select * from worker where worker_id <=(select count(worker_id)/2 from worker);

-- 40.fetch dept having <4 people
select department,count(department) as dept_count from worker group by(department) having dept_count<4;

-- 41.all dept along with no of people in it
select department,count(department) as dept_count from worker group by(department);

-- 42.show last record
select * from worker where worker_id =(select max(worker_id) from worker);

-- 42.show first record
select * from worker where worker_id =(select min(worker_id) from worker);

-- 43.last 5 records
(select * from worker order by worker_id desc limit 5) order by worker_id;

-- 44. emp details max sal from each dept
select w.department,w.first_name,w.salary from 
(select department,max(salary) as maxsal from worker group by department) as temp
inner join worker as w on temp.department=w.department and temp.maxsal=w.salary;















