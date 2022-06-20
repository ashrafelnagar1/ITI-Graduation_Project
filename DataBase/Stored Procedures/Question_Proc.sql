--Select Question
alter Proc SelectQuestions @Crs_id int  
with encryption 
as
begin try
   if @crs_id = (select crs_id from Course where Crs_id=@Crs_id)
     begin
	    if @Crs_id in(select crs_id from Question where crs_id=@Crs_id )
		begin
		  select Question from Question
		  where Crs_id=@Crs_id
		end
		else
		 select 'No Questions assigned to this Course'
	 end
   else
     select 'No Course with this ID'
end try
begin catch
  select'Error'
end catch


--test
Exec SelectQuestions 7


--insertQuestions
alter Proc InsertQuestion @Crs_id int , @Q_type varchar(50) ,@Right_Answer_id int
 , @Q_grade int , @Question varchar(500)
with encryption
as
begin try
  if @crs_id = (select crs_id from Course where Crs_id=@Crs_id)
     begin
	  if @Question not in (select Question from Question where Crs_id=@Crs_id)
	   begin
	     /* if @Right_Answer_id in (select Choice_num from Q_Choice where Choice_num=@Right_Answer_id and */
			insert into Question(Qestion_id,Crs_id,Q_type,Right_Answer_id,Q_grad,Question)
			values ((select max(Qestion_id)+1 from Question), @crs_id ,@Q_type,@Right_Answer_id,@Q_grade,
			@Question)
	   end
	   else 
	    select 'This Question already exist'
	  end
   else
      select 'this course not found yet'
end try
begin catch
  select 'Error'
end catch

--test
exec insertquestion 7,'TF',1,5,'What is Machine Linkedin'

--DeleteQuestion
Alter Proc DeleteQuestion @q_id int 
with encryption 
as
begin try
 if @q_id in (select Qestion_id from Question)
   begin 
     delete from Question
	 where Qestion_id=@q_id
   end
  else
    select 'This question doesnt exist'
end try
begin catch
   select 'Error'
end catch


--test
exec DeleteQuestion 162

--test

Alter proc UpdateQuestion @q_id int , @Crs_id int , @Q_type varchar(20) ,@Right_Answer_id int
 , @Q_grade int , @Question varchar(255)
with encryption
as
begin try 
  if @Crs_id in (select crs_id from course )
   begin 
      if @Crs_id in (select Crs_id from Question)
	    begin
		 if @q_id in (select Qestion_id from Question where Qestion_id=@q_id and Crs_id=@Crs_id)
		   begin 
				  if @Right_Answer_id in (Select Choice_num from Q_Choice where Choice_num=@Right_Answer_id 
				  and Q_ID=@q_id)
				  begin
				 update Question
				 set  Crs_id=@Crs_id , Q_type=@Q_type ,
				 Question=@Question,Q_grad=@Q_grade, Right_Answer_id=@Right_Answer_id
				 where Qestion_id=@q_id
			 end
			 else 
			  select 'You insert invalid Answer Id'
			 end
          else
		     select 'This Question Not Exist'
		end
       else
	      select ' No Questions Assigned to this Course yet'
   end
  else
   select 'No course with this ID'
end try
begin catch
  select 'Error'
end catch


