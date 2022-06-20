--Insert--
Alter Procedure Insert_Exam @Course_id int, @Num_TF int =5, @Num_MCQ int=5
With Encryption 
As
begin try
declare @TotalQ int
SET @TotalQ = @Num_MCQ + @Num_TF
if @Course_id in (Select Crs_id From Course)
	Begin
	 if  @TotalQ <> 10 
	   begin 
	      select 'Please Sure that The Total Number of Questions is 10'
	   end
	 else
		insert into Exam(Crs_id, N_TF, N_MCQ)
		Values(@Course_id, @Num_TF, @Num_MCQ)
	End
else
	begin
		select 'Course is Not Exist!'
	end
end try

begin catch
	Select 'Error'
End catch

GO
--Test--
Execute Insert_Exam 6, 6, 4
----------------------------------------------------
GO

--Select--
create proc Select_Exam @Exam_Id int
with encryption
as 
begin try
if @Exam_id = (select Exam_id from Exam where Exam_id=@Exam_Id)
begin
	select * from Exam
	where Exam_id = @Exam_Id
End
Else 
begin
	Select 'Exam is Not Found'
end
end try
begin catch
 select 'Error'
end catch

GO 
--Test--
Execute Select_Exam 1005
--------------------------------------------------
GO

--Delete--
create proc Delete_Exam @Exam_id int
with encryption
as
begin try
	if @Exam_id =(select Exam_id from Exam where Exam_id=@Exam_id)
	begin
		 Delete from Exam 
		 where Exam_id = @Exam_id
	end
	else 
	begin
		Select 'Exam Not found'
	end
end try
begin catch
 select 'Error'
end catch

--test
exec Delete_Exam 1004
-------------------------------------------------------
GO

--Update--
create proc Update_Exam @Exam_id int, @Crs_id int, @N_TF int, @N_MCQ int 
with encryption
as
begin try
declare @TotalQ int
SET @TotalQ = @N_MCQ + @N_TF
  if @Exam_id = (select Exam_id from Exam where Exam_id=@Exam_id)
   begin
     if @TotalQ <>10
	   begin 
	      select 'Please Sure that The Total Question is 10'
	   end
	 else
	   update Exam
	   set Crs_id = @Crs_id, N_TF = @N_TF, N_MCQ = @N_MCQ 
	   where Exam_id = @Exam_id
   end
   else
   begin
	select'This Exam not found'
   end
end try
begin catch
 select'Error'
end catch


--test
exec Update_Exam 1000, 5, 2, 9


-- select Exams_Course
create proc SelectExamsCourse @crs_id int
as
begin try
if @crs_id = (Select crs_id from Course where crs_id=@crs_id)
begin
	if @crs_id = (select Crs_id from Exam where Crs_id=@crs_id)
		begin
		select *
		from Exam
		where Crs_id=@crs_id
		end
	else
	   select 'No Exams assigned to this Course'
end
else
select 'Invalid Course_iD'
end try
begin catch
 select 'Error'
end catch


--test
exec SelectExamsCourse 1 