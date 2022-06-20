-- SelectQChoice
create Proc SelectQ_Choice @Q_id int
AS
begin Try
   if @Q_id = (Select Qestion_id from Question where Qestion_id=@Q_id)
    begin
	 if @Q_id in (Select Q_ID from Q_Choice where q_id = @Q_id )
	  begin
		  Select *
		  from Q_Choice
		  where Q_ID=@Q_id
	  end
	  else
	   select 'There is No Choice for This Question Yet'
	end
   else
    Select 'No Question Found'
End try
Begin Catch 
  select'Error'
End catch

--test 
exec SelectQ_Choice 160

--delete
create proc DeleteQ_choice @q_id int , @choice_id int
as
begin try
 if @q_id = (Select Qestion_id from Question where Qestion_id = @Q_id ) 
   begin
     if @choice_id in (select Choice_num from Q_Choice where Q_ID=@q_id and Choice_num=@choice_id)
	  begin
	    delete from Q_Choice
		where Choice_num=@choice_id and Q_ID=@q_id
	  end
	  else Select 'This Choice Not Exist'
   end
  else 
    select 'This Question Id not exist'
end try
begin catch
  select'Error'
end catch


--test
exec DeleteQ_choice 160,90


---insert
Alter Proc InsertQ_choice  @choice_num int, @choice varchar(500)
as
begin try
--if @Q_id = (select Qestion_id from Question where Qestion_id= @Q_id )
--begin
  if @choice not in (Select choice from Q_Choice where Q_ID=(select MAX(Qestion_id) from Question) and Choice=@choice) 
  begin
	  INSERT INTO Q_Choice(Q_ID,Choice_num,Choice)
	  values( (select MAX(Qestion_id) from Question),@choice_num,@choice )
  end
  else
  select ' This Choice already found to this Question ID'
--end
--else
--select 'No Question with this ID'
end try
begin catch
   select 'Error'
end catch


--test
Exec InsertQ_choice 2,'F'

--
--update
create proc UpdateQ_choice @q_id int , @choice_id int ,@choice varchar(500)
as
begin try
if @Q_id = (select Qestion_id from Question where Qestion_id=@q_id)
begin
 if @q_id in (select Q_ID from Q_Choice where Q_ID=@q_id and Choice_num=@choice_id)
  begin
  if @choice_id in (select Choice_num from Q_Choice where Q_ID=@q_id and Choice_num=@choice_id)
  begin
   if @choice not in (Select choice from Q_Choice where  Q_ID=@q_id and Choice_num=@choice_id and Choice=@choice)
   begin
	   Update Q_Choice
	   set Choice=@choice
	   where Q_ID=@q_id and Choice_num=@choice_id
   end
   else
   select 'This Answer already Exist for this Question'
  end
  else
  select 'No choice Found'
  end
 else
 select 'No choices for this Question'
end
else
select'This Question id not found'
end try
begin catch
  select 'Error'
end catch


--test
Exec UpdateQ_choice 143,1,'T'

