--select student
create proc GetstudentData @student_id int
with encryption
as
begin try
Select *
from Student 
where St_id=@student_id
end try
begin catch
 select 'ERROR'
end catch

--test
exec GetstudentData 6

--proc delete student
alter proc deleteStudent @student_id int
with encryption
as
begin try
if @student_id in (select st_id from Student where st_id=@student_id)
   begin
	delete from Student where 
	st_id=@student_id   
   end 
else 
select 'Student Not Found'    
end try
begin catch
 select 'Error'
end catch


--test
exec deleteStudent 1002

-- proc insert student
Create proc insertSudent @dept_id int , @st_fname varchar(50) , @st_lname varchar(50) ,
@Age int , @social varchar(255) ,  @gender char(1)
with encryption
as
begin try
if @dept_id in (select dept_id from Department where dept_id=@dept_id)
 begin
  insert into Student (St_id,dept_id,St_Fname,St_Lname,Gender,Social_data,St_Age)
  values((select max(st_id)+1 from Student) ,@dept_id,@st_fname,@st_lname,@gender,@social,@Age)
 end
else
 select 'No Department found'
end try
begin catch
 select 'Error'
end catch

--test
exec insertSudent 5,'Ahmed','Fouad',27,'Snickro.com','m'


--Proc Update Student
create proc UpdateStudent  @std_id int,@dept_id int , @st_fname varchar(50) , @st_lname varchar(50) ,
@Age int , @social varchar(255) ,  @gender char(1)
with encryption
as
begin try
 if exists (select St_id from Student where St_id = @std_id)
 begin
		if @dept_id in (select dept_id from Department where dept_id =@dept_id)
		 begin
			update Student 
			set dept_id = @dept_id , St_Fname=@st_fname , st_lname=@st_lname,
			St_Age=@age , Social_data=@social,Gender=@gender
			WHERE St_id = @std_id
		end
		else select 'Department Not Found'
end
else select 'Student Not Found'			
end try
begin catch
select 'Error'
end catch

exec updateStudent 1,1,'Ashraf','Elnagar',22,'https://www.linkedin.com/in/ashraf-elnagar/','M'

