--Login
Alter proc CheckData @user_name Varchar(50) , @Password int
with encryption
as
begin try
 if @user_name in (select St_username from St_Login where St_username=@user_name)
   begin
     if @Password in (select St_password from St_Login where St_username=@user_name)
	  begin
	  Select 'Welcome in Our App  Hope To Do well in Exam'
	   end
     else
	 select 'Invalid Password'
	 end
 else	
select 'Invalid user name'
end try
begin catch
 Select'Error'
end catch

--test
exec CheckData 'iti1',01234567

--delete Credential
create proc DeleteData @user_name varchar(50) 
with encryption
as
begin try
 if @user_name in (select St_username from St_Login where St_username=@user_name)
  begin
   delete from St_Login
   where St_username=@user_name
   end
 else
   select'This Username Not Found'
end try
begin catch
 select'Error'
end catch

--test
exec DeleteData 'iti0'

--Insert Data
create proc InsertData @st_id int , @user_name varchar(50) , @password int
with encryption
as
begin try
if exists (Select st_id from Student where st_id=@st_id)
  begin
    if @user_name not in (select St_username from St_Login where St_username=@user_name)
	  begin
		insert into St_Login(St_id,St_username,St_password)
		values (@st_id ,@user_name , @password)
		end
     else 
	 select 'This User name already exist For This Student'
  end
else
  select 'Not Exist Student'
end try
begin catch
 select'Error'
end catch

--test
exec InsertData  1005,'Snicki',12300003


--UpdatePassword


--test
create Proc UpdateData @st_id int ,@user_name varchar(50) , @password int  
with encryption
as
begin try
 if @st_id in (Select St_id from Student where St_id = @st_id)
  begin
    if @user_name in (Select st_username from St_Login where St_id=@st_id )
	  begin
		update St_Login
		set St_password=@password 
		where St_id=@st_id and St_username=@user_name
       end
    else
     select 'User name Not found'
  end
 else
  select 'This id not found'
end try
begin catch
  select'Error'
end catch
exec UpdateData 16,'iti16',1711197511


--Select
create Proc GetStudentCredentils @id int
with encryption
as
begin try
 if @id in (select st_id from Student where St_id =@id )
   begin
     select * from st_login
	 where St_id=@id
   end
else
 select 'No student with this id '
end try
begin catch
 select 'error'
end catch


--test
exec GetStudentCredentils 15
