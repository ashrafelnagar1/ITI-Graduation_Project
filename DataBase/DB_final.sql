--1-Department Table
Create Table Department(
dept_id int primary key ,
dept_name varchar(50) Not Null , 
branch varchar(50) Not Null ,
Constraint dept_unique unique (dept_name)
)

---------------------------------------------------------------------------------
--2- Student Table--
Create Table Student (
St_id int identity(1,1) primary key,
dept_id int default 50 ,
St_Fname varchar(50),
St_Lname varchar(50),
Gender  char(1),
Social_data varchar(200),
St_Age int,
Constraint c1 foreign key (dept_id) references department (dept_id)
on delete set default on update cascade 
)

-------------------------------------------------------------------------------
--3-St_login table
Create Table St_Login
(
St_id int ,
St_username varchar(50) unique Not Null ,
St_password  varchar(50) Not Null,
Constraint pr primary key(St_id,St_username),
Constraint c2 foreign key (St_id) references student(st_id)
on delete Cascade on update cascade ,
Constraint c3 Unique(St_username),
Constraint c4 check (len(st_password) >= 8 )
)

-----------------------------------------------------------------------------------
--4-Course Table
create table Course
(Crs_id int PRIMARY KEY  ,
Crs_Name varchar(50) , Hours int ,
)
-------------------------------------------------------------------------------------
--5-Topic Table
create table Topic (
Topic_Id int primary key,
Crs_Id int not null, 
Topic_name varchar(50) ,
FOREIGN KEY (Crs_Id) REFERENCES Course(Crs_id) on delete cascade on update cascade)
---------------------------------------------------------------------------------
--6-instructor table 
create table Instructor
(Ins_id int ,
Dept_id int default 50,
Ins_name varchar(50) ,
primary key (Ins_id), 
FOREIGN KEY (Dept_id) REFERENCES department (Dept_id) 
on update cascade on delete set default)

Alter Table instructor
Add Constraint instructor_pass check (len(password) >= 8)

--------------------------------------------------------------------------------
--7-Ins_Crs table
create table Ins_Crs(
Ins_id int ,
Crs_id int , 
Evaluation varchar(100) ,
primary key(Ins_id ,Crs_id) ,
FOREIGN KEY (Crs_id) REFERENCES course(Crs_id) on update cascade on delete cascade,
FOREIGN KEY (Ins_id) REFERENCES instructor(Ins_id) on update cascade on delete cascade)
------------------------------------------------------------------------------------
--8-St_course table
create table St_Crs(
St_id int  , 
Crs_id int ,
Crs_grade int ,
primary key (St_id,Crs_id),
FOREIGN KEY (Crs_id) REFERENCES course(Crs_id) 
on update cascade on delete cascade ,
FOREIGN KEY (St_id) REFERENCES Student(St_id) 
on update cascade on delete cascade)
--------------------------------------------------------------------------------------
--9-Exam Table
create table Exam (
Exam_id int identity(1000,1)  ,
Crs_id int , 
N_TF int ,
N_MCQ int ,
primary key(Exam_id),
FOREIGN KEY (Crs_Id) REFERENCES Course(Crs_id) on update cascade on delete cascade,
CONSTRAINT Q_no  CHECK( N_MCQ + N_TF = 10)
)
--------------------------------------------------------------------------------------
--9-Question Table
create table Question
(
Qestion_id int primary key,
Crs_id int not null ,
Q_type varchar(50),
Right_answer_Content varchar (500),--SQL
Right_Ansert_id int ,
Q_grad int,
Question varchar(500),
FOREIGN KEY (Crs_Id) REFERENCES Course(Crs_id) 
on update cascade on delete cascade
)


----------------------------------------------------------------------------

--10-Q_Choice Table
create table Q_Choice(
Choice_num int ,
Q_ID int ,
Choice varchar(20) ,
primary key(Choice_num,Q_ID) ,
FOREIGN KEY (Q_ID) REFERENCES Question(Qestion_id) 
on update cascade on delete cascade)

-----------------------------------------------------------------------------------
--11-St_Exam table
create table St_Exam
( St_id int ,
Exam_id int, 
Exam_Date Date,
Question_id int not null ,
St_Q_grade int , 
St_Q_answer int ,
primary key(St_id , Exam_id , Question_id) ,
FOREIGN KEY (Exam_id) REFERENCES Exam(Exam_id),
FOREIGN KEY (St_id) REFERENCES Student(St_id) 
on update cascade on delete cascade,
FOREIGN KEY (Question_id) REFERENCES Question(Qestion_id) 
on update cascade on delete cascade)

------------------------------------------------------------------------------------







