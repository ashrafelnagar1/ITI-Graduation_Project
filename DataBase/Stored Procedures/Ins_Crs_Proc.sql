--Select All
create proc SelectInc_Crs 
with encryption
as
begin try
 select * from Ins_Crs
end try
begin catch
 select'Error'
end catch

--test
exec SelectInc_Crs


--Select ins_crs
Alter proc SelectCoursesInstructor @ins_id int
with encryption
as
begin try
 if @ins_id = (select Ins_id from Instructor where Ins_id = @ins_id)
  begin
    if exists (select Ins_id from Ins_Crs where Ins_id= @ins_id)
	  begin 
	  select Ins_id , c.Crs_Name
	  from Ins_Crs i 
	  join Course c
	  on c.Crs_id = i.Crs_id
	  and ins_id = @ins_id
	  end
    else
	  begin
	   select 'This instructor has no Courses yet'
	  end
	  end
 else
   begin
     select 'No Instructor Found with this Id'
   end
end try
begin catch
 select 'Error'
end catch


--test
exec SelectCoursesInstructor 9


--Delete
create proc DeleteCourseInstructor  @ins_id int, @crs_id int 
with encryption 
as
begin try
	if exists (select Ins_id from Ins_Crs where Ins_id=@ins_id and Crs_id=@crs_id )
		begin
			delete from Ins_Crs 
			where Ins_id = @ins_id and Crs_id = @crs_id
		end
	else
		select 'Instructor with this course not found'
	end try
	begin catch
		select 'ERROR'
	end catch

--test
exec DeleteCourseInstructor 1,3

--update
Alter proc UpdateInstructorCourses @ins_id int , @crs_id int , @newCrs_id int 
with encryption
as
begin try 
 if exists (select ins_id from Instructor where Ins_id=@ins_id)
 begin
 if exists (select ins_id from Ins_Crs where Ins_id=@ins_id)
  begin
    if @crs_id in (select Crs_id from Ins_Crs where Ins_id=@ins_id and Crs_id=@crs_id)
	 begin 
	   Update Ins_Crs
	   set Crs_id=@newCrs_id
	   where Ins_id=@ins_id and Crs_id=@crs_id
	 end
    else
	begin 
	 select 'This instrutor not assigned to this Course'
	end
  end
 else
  begin
    Select 'This instructor id not assigned to any course'
   end
   end
   else select 'No Instructor with this ID'
end try
begin catch 
 select'Error'
end catch


--test 
exec UpdateInstructorCourses 1,2,800


--insert 
Alter proc InsertCrs_Ins @ins_id int , @crs_id int , @evaluation varchar(50) ='Not Evaluated'
with encryption 
as
begin try 
 if @ins_id in (select ins_id from Ins_Crs where ins_id=@ins_id and Crs_id=@crs_id )
   begin 
     select 'This Instructor with this course already exist'
   end
 else
   begin
     if @crs_id in(select crs_id from Course where Crs_id=@crs_id)
	   begin
	    insert into Ins_Crs
		values(@ins_id,@crs_id,@evaluation)
	   end
	   else select 'Course Not Found'

   end
end try 
begin catch
 select 'Error'
end catch


--test
exec InsertCrs_Ins 2,88888
