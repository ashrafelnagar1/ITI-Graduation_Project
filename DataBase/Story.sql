
exec Generate_Exam 1,5,5

exec Exam_St_answer 1,1009,5,1
go
exec Exam_St_answer 1,1009,1,2
go
exec Exam_St_answer 1,1009,31,1
go
exec Exam_St_answer 1,1009,35,2
go
exec Exam_St_answer 1,1009,38,1
go
exec Exam_St_answer 1,1009,39,2
go
exec Exam_St_answer 1,1009,40,1
go
exec Exam_St_answer 1,1009,7,2
go
exec Exam_St_answer 1,1009,10,2
go
exec Exam_St_answer 1,1009,32,2

exec Exam_Correction 1,1009



exec Exam_Crs_Grade 1,1009,32



select Exam_id , q.Qestion_id , q.Question, q.Right_Answer_id, c.Choice
			from Exam_questions eq, question q , Q_Choice c
			where eq.Q_id= q.Qestion_id 
			and q.Qestion_id= c.Q_ID and  Exam_id = 1009 and q.Right_Answer_id=c.Choice_num
			order by q.Qestion_id
