Alter proc get_questions @exam_id int
as
select Exam_id , q.Qestion_id , q.Question, q.Right_Answer_id, c.Choice
			from Exam_questions eq, question q , Q_Choice c
			where eq.Q_id= q.Qestion_id 
			and q.Qestion_id= c.Q_ID and  Exam_id = @exam_id 
			order by q.Qestion_id

