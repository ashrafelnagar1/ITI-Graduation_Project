--proc insert topic 
Alter proc InsertTopic @Crs_id int ,@top_name varchar(100)
with encryption
as
begin try
if @Crs_id = (select @Crs_id from course where crs_id=@Crs_id)
begin 
insert into Topic (topic_id,topic_name,crs_id)
values((select max(topic_id)+1 from Topic),@top_name,@crs_id)
end
else
select ' This course is not found'
end try
begin catch
 select 'Error'
end catch

--test
exec InsertTopic 1,'Trigger'


--proc select topic
create proc SelectTopic @top_id int
with encryption
as
begin try
select * from Topic
where Topic_Id=@top_id
end try
begin catch
select 'ERROR'
end catch

--test
exec selecttopic 3

--proc delete topic
create proc deletetopic @top_id int
with encryption
as
begin try
if @top_id = (select Topic_Id from Topic where Topic_Id=@top_id)
begin
delete from Topic
where 
Topic_Id=@top_id
end
else
select 'Not Found'
end try
begin catch
select 'ERROR'
end catch

--test
exec deletetopic 58

--proc update topic
Alter proc UpdateTopic @top_id int ,  @crs_id int,@top_name varchar(50) 
with encryption
as
begin try
	 if @crs_id = (select crs_id from Course where Crs_id=@crs_id)
	 begin
		if @top_id = (select topic_id from Topic where topic_id=@top_id)
		begin
		 update Topic 
		 set topic_name = @top_name
		 Where crs_id = @crs_id and topic_id = @top_id
		 end
		 else select 'This Topic Not Found'
		 end
		 else select 'This Course Not Found'
		 
end try
begin catch
select 'ERROR'
end catch


--test
exec updatetopic 1,888888 ,'Mapping' 