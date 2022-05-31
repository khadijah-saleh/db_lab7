use Company


---1.Use Try … Catch with any query and in catch print the 
--@@Error value and Error message.
begin try
	insert into Emp values('10','kokoy', 'mohammed',5000,'5')
 end try
 begin catch 
raiserror('invalied Error',16,1)
 end catch
 go
 ----------------------------------------------------------

 create table Projecteaudit(
id int primary key identity(1,1),
action varchar(150),
madeIn datetime default getdate()
)

go

alter table Project
add  IsDeleted bit default  0

go
create  trigger tr_tblProject_forInsernt 
on Project
instead of delete
as
 begin
	declare @id varchar(10)
	select @id= id from Deleted
	if @id =(select id from Project where id= @id)
	begin
		update Project
		set IsDeleted =1
		where id = @id
		insert into Projecteaudit(action )values('Project  '+@id+' is updated instead of being deleted by '+SUSER_NAME())
	end
	else
	begin
		raiserror('in vaild id',16,1)
	end
 end
 go
 select * from Projecteaudit
 go 

 delete 
 Project where id=1
 
 go

 create view vActiveProjects
 as
 select pro_no as Vid , pro_name as VprojectName , budget as VBudget ,IsDeleted 
 from Project
 where IsDeleted = 0
 
 go

 select * from vActiveProjects









