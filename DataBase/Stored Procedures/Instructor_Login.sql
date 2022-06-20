Alter proc CheckData_Ins @Ins_name Varchar(50) , @Password int
with encryption
as
begin try
 if @Ins_name in (select Ins_name from Instructor where Ins_name=@Ins_name)
   begin
     if @Password in (select password from Instructor where password=@Password)
	  begin
	  Select 'Welcome in Our App'
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
exec CheckData_Ins 'Ramy',12345678
