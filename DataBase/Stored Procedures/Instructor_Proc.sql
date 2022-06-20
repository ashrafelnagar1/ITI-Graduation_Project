--instructor select
Create proc SelectInstructor @ins_id int
with encryption
as 
begin try
select * from instructor 
where Ins_id =@ins_id
end try
begin catch
 select'Error'
end catch

--test
exec SelectInstructor 1

-- delete instructor
create proc DeleteInstructor @ins_id int
with encryption
as
begin try
IF @ins_id in(select ins_id from Instructor where Ins_id=@ins_id)
begin
 Delete from instructor 
 where Ins_id=@ins_id
end
else select 'Instructor Not Found'

end try
begin catch
 select 'Error'
end catch

--test
exec DeleteInstructor 15


--insert instructor
Alter proc InsertInstructor @ins_id int,@dept_id int , @ins_name varchar(50)
with encryption
as
begin try
if Not Exists(select Ins_id from Instructor where Ins_id=@ins_id)
begin

if @dept_id = (select  dept_id from Department where dept_id=@dept_id)
	 begin
			Insert into Instructor (ins_id,ins_name,dept_id)
			values(@Ins_id ,@ins_name ,@dept_id)
	 end
else 
begin
select 'Department ID is not exist'
end
end 
else Select 'This Instructor ID already found'
end try
begin catch
 select'Error'
end catch

--test
exec InsertInstructor 100,1,'Ahmed'


-- Update instructor
create proc updateInstrutor @ins_id int , @ins_name varchar(50) , @dept_id int
with encryption
as
begin try
if @dept_id =(select dept_id from department where dept_id=@dept_id)
 begin
  if @ins_id =(select ins_id from instructor where Ins_id=@ins_id )
   begin
    update instructor 
    set Dept_id=@dept_id , ins_name=@ins_name 
    where Ins_id=@ins_id
	end
  else
  begin
   select'This instructor id not found'
   end
   end
else
   select 'Department not exist'
end try
begin catch
 select'Error'
end catch


--test
exec updateInstrutor 1,'Ahmed Essam' , 95
