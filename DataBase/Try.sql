Alter proc Exam_Crs_Grade @st_id int , @exam_id int , @q_id int 
as
--begin try
--declare @answer_id int
--set @answer_id = (select Right_Answer_id from question where Qestion_id=@q_id)
--if @answer_id in (select St_Q_answer from St_Exam where St_id=@st_id and Exam_id=@exam_id )
--begin
--  update St_Exam
  --set St_Q_grade=2
  --where St_id=@st_id and
  --Exam_id=@exam_id
--end
--else
--begin
 --update St_Exam
  --set St_Q_grade=0
  --where St_id=@st_id and
  --Exam_id=@exam_id
--end 





declare @crs_id int 
set @crs_id = (select e.Crs_id from Exam e join St_Crs sc on e.Crs_id = sc.Crs_id and St_id=@st_id and e.Exam_id=@exam_id )

declare @grade int 
set @grade = (select sum(St_Q_grade) from St_Exam where St_id = @st_id and exam_id =@exam_id )
update St_Crs
set Crs_grade = @grade
where St_id = @st_id 
and Crs_id=@crs_id
--end try
--begin catch
  --select 'Error'
--end catch

-- (Must)exam_corr 2,1006


exec Exam_Crs_Grade 2,1006,64
go
exec Exam_Crs_Grade 2,1006,66
go
exec Exam_Crs_Grade 2,1006,67
go
exec Exam_Crs_Grade 2,1006,68
go
exec Exam_Crs_Grade 2,1006,62
go
exec Exam_Crs_Grade 2,1006,73
go
exec Exam_Crs_Grade 2,1006,74
go
exec Exam_Crs_Grade 2,1006,78
go
exec Exam_Crs_Grade 2,1006,79



