--select
alter proc SelectStudentCourse @st_id int 
with encryption
as
begin try
 if @st_id = (select st_id from Student where st_id=@st_id)
  begin 
    if @st_id in (select st_id from St_Crs where st_id=@st_id)
	  begin
	    select Crs_Name , s.Crs_grade
		from St_Crs s
		join Course c
		on st_id=@st_id 
		and c.Crs_id = s.Crs_id 
	   end
    else 
     select 'This student did not join any course'
    end
 else
   select 'No student with this id'
end try 
begin catch
  select 'Error'
end catch

--test 
Exec SelectStudentCourse 2

--insert
Alter proc InsertStudentCourse @St_id int , @Crs_id int 
with encryption
as
begin try
  if @St_id = (select st_id from Student where st_id=@st_id)
    begin
	   if @Crs_id = (Select crs_id from Course where crs_id=@crs_id)
	     begin 
			if Not exists (select st_id , crs_id from St_Crs where st_id = @St_id and crs_id = @crs_id)
			 begin
				insert into St_Crs
				values (@St_id,@Crs_id,0)
			end
		
		 else select 'This Student signed in this course'
        end
		else
		select 'This Course Not found'
	end
  else select 'This Student id not exist'
end try
begin catch
  select 'Error'
end catch


--test
exec InsertStudentCourse 1, 7


--delete
Create proc DeleteStudntCourse @st_id int , @crs_id int
with encryption
as
begin try
if @st_id = (select st_id from Student where St_id=@st_id)
   begin
     if @st_id in (select st_id from st_crs where St_id=@st_id)
	   begin
	     if @crs_id in (select Crs_id from St_Crs where Crs_id=@crs_id and St_id=@st_id)
		    begin	
		    	delete from St_Crs
			    where St_id=@st_id and
			    Crs_id=@crs_id
            end
		 else
		   select 'This Course not assign for this student'
	  end
	else
	 select 'This student does not have any course'
   end
else
   select 'No student with this id'
end try
begin catch
 select 'Error'
end catch

--test
Exec DeleteStudntCourse 7,88


--update
Create proc UpdateStudentCourse @st_id int , @crs_id int , @crs_grade int
with encryption
as
begin try
if @st_id = (select st_id from Student where St_id=@st_id)
   begin 
     if @st_id in (select st_id from st_crs where St_id=@st_id)
	   begin 
	     if @crs_id in (select crs_id from St_Crs where st_id=@st_id )
		   begin
			  update St_Crs
			  set Crs_grade=@crs_grade
			  where st_id=@st_id and Crs_id=@crs_id
           end
         else
		   select 'This Course Not found for this student'
		end
	  else 
		 select 'This student id not have this course'
    end
else
   select 'this student id not found'
end try
begin catch
 select 'Error'
end catch


--test
exec UpdateStudentCourse 1,8,0
