
Create proc select_stds_grade_in_Crs @crs_id int
as
select s.St_Fname+' '+s.St_Lname as 'Student Name' , sc.Crs_grade
from Instructor i 
join Ins_Crs ic
on i.Ins_id = ic.Ins_id
join St_Crs sc 
on ic.Crs_id = sc.Crs_id
join Student s 
on s.St_id =sc.St_id
join Course c 
on c.Crs_id = sc.Crs_id
where c.Crs_id= @crs_id


