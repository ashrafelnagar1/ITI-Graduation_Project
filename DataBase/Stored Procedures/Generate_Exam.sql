create proc Generate_Exam @crs_id int , @No_MCQ int , @No_TF int 
as
begin try
if @No_MCQ + @No_TF = 10
begin
if exists (select Crs_id from Course where Crs_id = @crs_id)
begin
insert into Exam (Crs_id,N_MCQ,N_TF)
values(@crs_id,@No_MCQ,@No_TF)

declare @e_id int
set @e_id = (select max(Exam_id) from Exam )


insert into exam_questions (q_id,exam_id)
select top(@No_MCQ) Qestion_id,@e_id
from Question
where Q_type ='MCQ' and Crs_id=@crs_id
order by NEWID()


insert into exam_questions ( q_id,exam_id )
select top(@no_TF) Qestion_id ,@e_id
from Question
where Q_type ='TF' and Crs_id=@crs_id
order by NEWID()

end
else select 'No Course Founded'
end
else select 'No of MCQ and TF must be 10'


end try
begin catch
select 'Error'
end catch



exec Generate_Exam 1,5,5