
--Department Table
Create Table Department(
dept_id int primary key ,
dept_name varchar(50) Not Null , 
branch varchar(50) Not Null ,
Constraint dept_unique unique (dept_name)
)

Alter Table Department 
Add Constraint def_dept 
Default 50 for dept_id
-------------------------------------------------------

--Student Table--
Create Table Student (
St_id int identity(1,1) primary key,
dept_id int,
St_Fname varchar(50),
St_Lname varchar(50),
Gender  char(1),
Social_data varchar(200),
St_Age int,
Constraint c1 foreign key (dept_id) references department (dept_id)
on delete set default on update cascade
)
--------------------------------------------------------------------------

Create Table St_Login
(
St_id int ,
St_username varchar(50) Not Null ,
St_password  varchar(50) Not Null


)