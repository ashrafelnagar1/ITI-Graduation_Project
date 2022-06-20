create proc Exam_Correction @st_id int , @exam_id int
as
begin try
declare @crs_id int 
set @crs_id = (select e.Crs_id from Exam e join St_Crs sc on e.Crs_id = sc.Crs_id and St_id=@st_id and e.Exam_id=@exam_id )

DECLARE @grade int
SELECT  @grade = count(SE.question_id) 
FROM St_Exam SE JOIN Question Q ON SE.Question_id = Q.Qestion_id
WHERE  St_id = @st_id AND Exam_id = @exam_id AND SE.St_Q_answer = Q.Right_Answer_id

update St_Crs
set Crs_grade = @grade * 2
where St_id = @st_id 
and Crs_id=@crs_id
end try
begin catch
  select 'Error'
end catch



exec Exam_Correction 1 ,1011



