Alter proc Exam_St_answer @st_id int , @exam_id int , @Q_id int ,@St_answer int
as
begin try
if @st_id in (select St_id from student )
begin
  if @st_id in (select st_id from St_Crs,Exam where St_Crs.Crs_id=Exam.Crs_id and Exam_id=@exam_id)
  begin
   if @exam_id in (select exam_id from Exam)
   begin
     if @exam_id in (select exam_id from Exam_Questions where exam_id=@exam_id and Q_id=@Q_id)
	 begin
	 if @Q_id in (Select Qestion_id from question)
	 begin 
	    if @Q_id in (Select Q_id from Exam_Questions where Exam_id=@exam_id)
		begin
		  if @St_answer in (Select Choice_num from Q_Choice where Q_ID=@Q_id and Choice_num=@St_answer)
		  begin
			 
			insert into St_Exam( St_id,Exam_id,Question_id,Exam_date,St_Q_grade,St_Q_answer)
		     values (@st_id , @exam_id,@Q_id,getdate(),NULL,@St_answer)
		  end
		  else select 'Not applicable Choice'
		end
		else
		 select 'Question not found in this Exam' 
	 end
	 else
	  Select'This Question not found '
	 end
	 else
	  select 'This Exam not has Questions yet'
   end
   else
    select'This Exam not Found'
  end
  else
   select 'This Student Cant access this exam because he not assigned to this course'
end
else
select 'This Student id not found'
end try
begin catch
 select'Error'
end catch



exec Exam_St_answer 1,1011,32,1
go
exec Exam_St_answer 1,1011,33,2
go
exec Exam_St_answer 1,1011,34,1
go
exec Exam_St_answer 1,1011,4,2
go
exec Exam_St_answer 1,1011,35,1
go
exec Exam_St_answer 1,1011,39,2
go
exec Exam_St_answer 1,1011,6,1
go
exec Exam_St_answer 1,1011,7,2
go
exec Exam_St_answer 1,1011,8,2
go
exec Exam_St_answer 1,1011,40,2