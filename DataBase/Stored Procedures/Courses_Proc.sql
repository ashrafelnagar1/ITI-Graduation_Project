--proc select course
create proc SelectCourse @crs_id int
with encryption
as
select *
from Course
where Crs_id=@crs_id

--test
exec selectcourse 1

--Proc insert course
Create proc InsertCourse @crs_id int , @crs_name varchar(50) , @hours int
with encryption
as
begin try
if Not Exists (select crs_id from Course where Crs_id=@crs_id )
begin
insert into Course
values(@crs_id,@crs_name,@hours)
end
else
select 'Duplicated Course' 
end try
begin catch
		select 'Error'
end catch

--test 
exec insertcourse 18,'sql' ,200

--Proc Delete Course
Create proc DeleteCourse @crs_id int
with encryption
as
	begin try
	if exists (select crs_id from Course where Crs_id=@crs_id)
		begin
			delete from Course where 
			Crs_id=@crs_id   
		end
	else
		select 'Course Not Found'
	end try
	begin catch
		select 'ERROR'
	end catch
--test 
exec deletecourse 18

--Proc update Course
Create proc UpdateCourse @crs_id int , @crs_name varchar (50) ,@hours int
with encryption
as
begin try
if @crs_id = (select crs_id from Course where Crs_id=@crs_id)
begin
update Course
set crs_name=@crs_name,crs_id=@crs_id ,Hours=@hours
where crs_id=@crs_id
end
else
select 'Course Not Found'
end try
begin catch
		select 'Error'
end catch


--test
exec updatecourse 1,'Testing',160
