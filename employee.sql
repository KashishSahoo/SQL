CREATE DATABASE OFFICE;
USE OFFICE;

-- Create the Employee table first, as it's referenced by others
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    Age INT,
    emailID VARCHAR(100),
    PhoneNo VARCHAR(20), 
    City VARCHAR(50)
);

-- Insert data into the Employee table
INSERT INTO Employee (id, fname, lname, Age, emailID, PhoneNo, City) VALUES
(1, 'Aman', 'Proto', 32, 'aman@gmail.com', '898', 'Delhi'),
(2, 'Yagya', 'Narayan', 44, 'yagya@gmail.com', '222', 'Palam'),
(3, 'Rahul', 'BD', 22, 'rahul@gmail.com', '444', 'Kolkata'),
(4, 'Jatin', 'Hermit', 31, 'jatin@gmail.com', '666', 'Raipur'),
(5, 'PK', 'Pandey', 21, 'pk@gmail.com', '555', 'Jaipur');

-- Create the Client table
CREATE TABLE Client (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    Age INT,
    emailID VARCHAR(100),
    PhoneNo VARCHAR(20),
    City VARCHAR(50),
    empId INT, -- Foreign Key to Employee.id
    FOREIGN KEY (empId) REFERENCES Employee(id)
);

-- Insert data into the Client table
INSERT INTO Client (id, first_name, last_name, Age, emailID, PhoneNo, City, empId) VALUES
(1, 'Mac', 'Rogers', 47, 'mac@hotmail.com', '333', 'Kolkata', 3),
(2, 'Max', 'Poirier', 27, 'max@gmail.com', '222', 'Kolkata', 3),
(3, 'Peter', 'Jain', 24, 'peter@abc.com', '111', 'Delhi', 1),
(4, 'Sushant', 'Aggarwal', 23, 'sushant@yahoo.com', '45454', 'Hyderabad', 5),
(5, 'Pratap', 'Singh', 38, 'p@xyz.com', '77767', 'Mumbai', 2);

-- Create the Project table
CREATE TABLE Project (
    id INT PRIMARY KEY,
    empId INT,     -- Foreign Key to Employee.id
    name VARCHAR(50),
    startdate DATE,
    clientID INT,  -- Foreign Key to Client.id
    FOREIGN KEY (empId) REFERENCES Employee(id),
    FOREIGN KEY (clientID) REFERENCES Client(id)
);

-- Insert data into the Project table
INSERT INTO Project (id, empId, name, startdate, clientID) VALUES
(1, 1, 'A', '2021-04-21', 3),
(2, 2, 'B', '2021-03-12', 1),
(3, 3, 'C', '2021-01-16', 5), 
(4, 3, 'D', '2021-04-27', 2),
(5, 5, 'E', '2021-05-01', 4); 

select * from  Employee;
select * from  Client;
select * from  Project;

-- inner join
-- Enlist all emp ids,names along with project allocated to them
select e.id ,e.fname ,e.lname ,p.id ,p.name from employee as e
inner join project as p on e.id=p.empId;

select e.id ,e.fname ,e.lname ,p.id ,p.name from employee as e,
project as p where e.id=p.empId;

-- fetch out all emp ids and their contact detail who have been working from jaipur with client name working in hyderabad
select e.id,e.emailId,e.phoneNo,c.first_name,c.last_name from Employee as e
inner join client as c on e.id=c.empId where e.city='Jaipur' and c.City='Hyderabad';

-- LEFT JOIN
-- Fetch out each project allocated to each employee
select * from Employee as e 
left join Project as p on e.id=p.empId; 

-- RIGHT JOIN
-- Fetch out all projects along with employee's name and email
select p.id,p.name,e.fname,e.lname,e.emailId from Employee as e
right join Project as p
on e.id=p.empId;

-- CROSS JOIN
-- List out all combinations possible for emp name and proj that can exist
select e.fname,e.lname,p.id,p.name from Employee as e
cross join Project as p;

-- SET OPEARATIONS
CREATE TABLE Dept1 (
    empid INT,
    name VARCHAR(10),
    role VARCHAR(20)
);

CREATE TABLE Dept2 (
    empid INT,
    name VARCHAR(10),
    role VARCHAR(20)
);
-- Inserting into Dept1
INSERT INTO Dept1 (empid, name, role) VALUES 
(1, 'A', 'engineer'),
(2, 'B', 'salesman'),
(3, 'C', 'manager'),
(4, 'D', 'salesman'),
(5, 'E', 'engineer');

-- Inserting into Dept2
INSERT INTO Dept2 (empid, name, role) VALUES 
(3, 'C', 'manager'),
(6, 'F', 'marketing'),
(7, 'G', 'salesman');

-- List out all employees in company
select * from Dept1
union
select * from Dept2;

-- List out all employees in all depts working as salesman
select * from Dept1 where role='salesman'
union
select * from Dept2 where role='salesman';

-- List out all employees working in both depts (intersect)
select Dept1.* from Dept1
inner join
Dept2 using(empId);

-- List out all employees working in both dept1 but not in dept2 (minus)
select Dept1.* from Dept1
left join
Dept2 using(empId)
where Dept2.empId is null;

-- SUB QUERIES
-- Employees with age>30
select * from Employee where age in (select age from Employee where age>30);

-- Employees details working in more than one proj
select * from Employee where id in(
select empId from project group by empId having count(empId)>1); 


-- single value subquery
-- emp with age greater than  avg(age)
select * from Employee where age>(select avg(age) from Employee);

-- select max age person whose first name contains 'a'
select max(age) from(select * from Employee where fname like '%a') as temp;

-- corelated subquery
-- find 3rd oldest emp

select * from Employee e1
where 3=(
select count(e2.age)
from Employee e2
where e2.age>=e1.age
);

-- VIEW-- 
-- creating views
create view custom_view as select fname,age from Employee;

-- viewing from view
select * from custom_view;

-- drop view
drop view if exists custom_view; 

-- altering the view
alter view custom_view as select fname,lname,age,city from Employee;