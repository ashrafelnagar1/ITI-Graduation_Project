--Select 
Alter proc Select_St_Answer_Exam @st_id int ,@exam_id int
as
begin try
if @st_id = (Select St_id from Student where St_id=@st_id)
begin
  if @exam_id = (select Exam_id from Exam where Exam_id=@exam_id)
  begin
   if @st_id in (Select St_id from St_Exam where St_id=@st_id and Exam_id=@exam_id )
   begin
     Select q.Question,St_Q_answer , qc.Choice
	 from St_Exam s
	 join Question q
	 on q.qestion_id =s.Question_id
	 join Q_choice qc
	 on qc.Q_ID = q.Qestion_id
	 where s.St_id=@st_id
	 and Exam_id=@exam_id
	 and St_Q_answer=qc.Choice_num


   end
   else
     select'This Student not assigned to this exam'
  end
  else
    select 'No exam found with this id'
end
else
  select 'No student found with this id'
end try
begin catch
  select 'Error'
end catch

--test
exec Select_St_Answer_Exam 1,1009




--Delete
Alter proc Delete_St_Exam @st_id int , @exam_id int
as
begin try
if @st_id = (Select St_id from Student where St_id=@st_id)
begin
  if @exam_id = (select Exam_id from Exam where Exam_id=@exam_id)
  begin
   if @st_id in (Select St_id from St_Exam where St_id=@st_id and Exam_id=@exam_id )
   begin
    delete from St_Exam
	where st_id=@st_id and
	Exam_id=@exam_id
	end
   else
     select'This Student not assigned to this exam'
  end
  else
    select 'No exam found with this id'
end
else
  select 'No student found with this id'
end try
begin catch
 select 'Error'
end catch

--test
exec Delete_St_Exam 7,1010


--update
create proc Update_St_Exam @st_id int , @exam_id int ,@Q_id int , @st_Q_Answer int
as
begin try
if @st_id = (Select St_id from Student where St_id=@st_id)
begin
  if @exam_id = (select Exam_id from Exam where Exam_id=@exam_id)
  begin
   if @st_id in (Select St_id from St_Exam where St_id=@st_id and Exam_id=@exam_id )
   begin 
     if @Q_id = (select Qestion_id from Question where Qestion_id=@Q_id)
	 begin
	    if @Q_id = (select Question_id from St_Exam where St_id=@st_id and Exam_id=@exam_id and Question_id=@Q_id)
		  begin 
		   if @st_Q_Answer in (Select Choice_num from Q_Choice where Q_ID=@Q_id and Choice_num=@st_Q_Answer) 
	      begin
		   update St_Exam
		   set St_Q_answer=@st_Q_Answer
		   where St_id=@st_id and  Question_id=@Q_id
		   and Exam_id=@exam_id
			end
	    else 
	   select 'This choice not applicable'
		  end
		  else
		   select ' This question not found in this exam'
	    
	 end
	 else
	  select 'This Question not found yet'
   
   end
   else 
    select'This Student not assigned to this exam'
  end
  else
    select 'No exam found with this id'
end
else
  select 'No student found with this id'
end try
begin catch
  select 'Error' 
end catch

--test
exec Update_St_Exam 1,1011,7,1

--insert
Alter proc Insert_St_Q_Grade @st_id int , @exam_id int , @Q_id int 
as
begin try
if @st_id = (Select St_id from Student where St_id=@st_id)
begin
  if @exam_id = (select Exam_id from Exam where Exam_id=@exam_id)
  begin
   if @st_id in (Select St_id from St_Exam where St_id=@st_id and Exam_id=@exam_id )
   begin 
     if @Q_id = (select Qestion_id from Question where Qestion_id=@Q_id)
	 begin
	    if @Q_id = (select Question_id from St_Exam where St_id=@st_id and Exam_id=@exam_id and Question_id=@Q_id)
		  begin 
				declare @answer_id int
				set @answer_id = (select Right_Answer_id from question where Qestion_id=@q_id)
				if @answer_id = (select St_Q_answer from St_Exam where St_id=@st_id and Exam_id=@exam_id and Question_id=@Q_id)
				begin
				  update St_Exam
				  set St_Q_grade=2
				  where St_id=@st_id and
				  Exam_id=@exam_id
				  and Question_id=@Q_id
				end
				else
				begin
				 update St_Exam
				  set St_Q_grade=0
				  where St_id=@st_id and
				  Exam_id=@exam_id
				  and Question_id=@Q_id
				end 
				
		  end
		  else
		   select ' This question not found in this exam'
	    
	 end
	 else
	  select 'This Question not found yet'
   
   end
   else 
    select'This Student not assigned to this exam'
  end
  else
    select 'No exam found with this id'
end
else
  select 'No student found with this id'
end try
begin catch
  select 'Error' 
end catch


--test
exec Insert_St_Q_Grade 1,1011,32
exec Insert_St_Q_Grade 1,1011,33
exec Insert_St_Q_Grade 1,1011,34
exec Insert_St_Q_Grade 1,1011,4
exec Insert_St_Q_Grade 1,1011,35
exec Insert_St_Q_Grade 1,1011,39
exec Insert_St_Q_Grade 1,1011,6
exec Insert_St_Q_Grade 1,1011,7
exec Insert_St_Q_Grade 1,1011,8
exec Insert_St_Q_Grade 1,1011,40


