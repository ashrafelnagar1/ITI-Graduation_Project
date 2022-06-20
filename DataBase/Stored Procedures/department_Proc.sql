--Proc select Department
create proc selectdept @dept_id int
with encryption
as
select * 
from Department
where dept_id=@dept_id

--test
exec selectdept 2


--Proc insert Department
create proc insertdept @dept_id int , @dept_name varchar(50) , @branch varchar(50)
with encryption
as
begin try
if @dept_id not in(select dept_id from Department where dept_id = @dept_id )
begin
insert into Department
values(@dept_id,@dept_name,@branch)
end
else
select 'Duplicated Department' 
end try
begin catch
		select 'error'
end catch

--test
exec insertdept 9,'Data Analyst' ,'Smart'

--Proc Delete Department
create proc delete_depart @dept_id int
with encryption
as
begin try
if @dept_id in (select dept_id from Department where dept_id=@dept_id)
begin
delete from Department
where 
dept_id=@dept_id
end
else
select 'Not Found'
end try
begin catch
		select 'error'
end catch

--test 
exec delete_depart 2


--Proc Update Department
create proc update_dept @dept_id int , @dept_name varchar (50) ,@branch varchar(50)
with encryption
as
begin try
if @dept_id in (select dept_id from Department where dept_id=@dept_id)
begin
update Department
set dept_name=@Dept_Name,dept_id=@dept_id ,branch=@branch
where dept_id=@dept_id
end
else
select 'Not Found'
end try
begin catch
		select 'error'
end catch

--test 
exec update_dept 19 ,'security' ,'Smart'
