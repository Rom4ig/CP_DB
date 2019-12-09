--=================================
--Registration
--=================================
IF OBJECT_ID('[dbo].[CreateUser]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CreateUser] 
END 
go
create procedure [dbo].[CreateUser]
(
@login nvarchar(50),
@password nvarchar(max)	
) 
as begin
begin try
insert into [dbo].[users] (login, password)
values (@login, @password);
end try
begin catch
print error_message()
end catch
end;
--=================================
--Autorize
--=================================
IF OBJECT_ID('[dbo].[Autorize]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Autorize] 
END 
go
create procedure [dbo].[Autorize]
(
@login nvarchar(50),
@password nvarchar(max)	
) 
as begin
begin try
select * from [dbo].users where login=@login and password=@password
end try
begin catch
print error_message()
end catch
end;
--=================================
--Add car
--=================================
IF OBJECT_ID('[dbo].[AddCar]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[AddCar] 
END 
go
create procedure [dbo].[AddCar]
(
@Brend nvarchar(40),
@Model nvarchar(40),
@Cost money,
@Year int,
@Color nvarchar(50),
@Type nvarchar(40),
@Count int,
@Img varbinary(max)
) 
as begin
begin try
insert into [dbo].[cars] (Brend, Model, Cost, Year, Color, Type, Count, Img)
values (@Brend, @Model, @Cost, @Year, @Color, @Type, @Count, @Img);
end try
begin catch
print error_message()
 --rollback;
end catch
end;
--=================================
--Add Balance
--=================================
IF OBJECT_ID('[dbo].[AddBalance]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[AddBalance] 
END 
go
create procedure [dbo].[AddBalance]
(
@user int,
@money money
) 
as begin
begin try

update [dbo].[users]
set balance=balance+@money
where Id=@user
end try
begin catch
print error_message()
end catch
end;
--=================================
--Sell Car
--=================================
IF OBJECT_ID('[dbo].[SellCar]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SellCar] 
END 
go
create procedure [dbo].[SellCar]
(
@user int,
@garage int
) 
as begin
begin try
declare @money money;
if ((select count(*) from [dbo].garage where Id=@garage)=1)
begin
delete Tech where car_id = @garage;
select @money=cars.Cost from garage INNER JOIN cars ON garage.car_id = cars.Id
where garage.Id=@garage;
delete Garage where Id=@garage;
update [dbo].[users]
set balance=balance+@money
where Id=@user;
end
else
begin
print 'Error garageID'
end
end try
begin catch
print error_message()
end catch
end;
--=================================
--Buy Car
--=================================
IF OBJECT_ID('[dbo].[BuyCar]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[BuyCar] 
END 
go
create procedure [dbo].[BuyCar]
(
@user int,
@car int
) 
as begin
begin try
declare @cost money, @balance money, @count int;
select @cost=Cost, @count=Count from Cars 
where Id=@car;
if(@count>0) begin
insert into [dbo].[garage] (car_id, user_id)
values (@car, @user);
update [dbo].[cars]
set Count = Count-1
where Id=@car;
select @balance=balance from users
where Id=@user;
if (@cost>@balance)
begin
print 'Not enough money'
end
else
begin
update [dbo].[users]
set balance=balance-@cost
where Id=@user
print 'Buy success'
end
end
end try
begin catch
print error_message()
end catch
end;
--=================================
--Buy Car
--=================================
IF OBJECT_ID('[dbo].[ChangeCounts]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ChangeCounts] 
END 
go
create procedure [dbo].[ChangeCounts]
(
@car int,
@count int
) 
as begin
begin try
update [dbo].cars 
set Count=@count
where Id = @car;
end try
begin catch
print error_message()
end catch
end;
--=================================
--Add Tech
--=================================
IF OBJECT_ID('[dbo].[AddTech]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[AddTech] 
END 
go
create procedure [dbo].[AddTech]
(
@car int,
@type nvarchar(50),
@date date,
@cost money
) 
as begin
begin try
insert into [dbo].[tech] (Car_id, Type, Date, Cost)
values (@car, @type, @date, @cost);
end try
begin catch
print error_message()
end catch
end;
--=================================
--Select * from users
--=================================
IF OBJECT_ID('[dbo].[SelectUsers]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectUsers] 
END 
go
create procedure [dbo].[SelectUsers]
as begin
begin try
select * from [dbo].[users]
end try
begin catch
print error_message()
end catch
end;
--=================================
--Select * from cars
--=================================
IF OBJECT_ID('[dbo].[SelectCars]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectCars] 
END 
go
create procedure [dbo].[SelectCars]
as begin
begin try
Select Id[Cd], Brend[Марка], Model[Модель], Cost[Стоимость], Year[Год выпуска], Color[Цвет], Type[Тип], Count[Наличие] from [dbo].[Cars]
end try
begin catch
print error_message()
end catch
end;--=================================
--Select * from tech
--=================================
IF OBJECT_ID('[dbo].[SelectTech]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectTech] 
END 
go
create procedure [dbo].[SelectTech]
as begin
begin try
select * from [dbo].[tech]
end try
begin catch
print error_message()
end catch
end;
--=================================
--Select * from garage
--=================================
IF OBJECT_ID('[dbo].[SelectGarage]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectGarage] 
END 
go
create procedure [dbo].[SelectGarage]
as begin
begin try
select * from [dbo].[garage]
end try
begin catch
print error_message()
end catch
end;
--=================================
--Select * carsusers
--=================================
IF OBJECT_ID('[dbo].[SelectGarageUser]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectGarageUser] 
END 
go
create procedure [dbo].[SelectGarageUser](
@user int
)
as begin
begin try
Select cars.Id[Cd], garage.Id[Id], cars.Brend[Марка], cars.Model[Модель], cars.Year[Год выпуска], cars.Color[Цвет], cars.Type[Тип], Cars.Cost[Стоимость в автосалоне] FROM [dbo].[cars] Inner join [dbo].[garage] on cars.Id = garage.car_id Where garage.user_id = @user
end try
begin catch
print error_message()
end catch
end;
--=================================
--Select * TechCar
--=================================
IF OBJECT_ID('[dbo].[SelectTechCar]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectTechCar] 
END 
go
create procedure [dbo].[SelectTechCar](
@car int
)
as begin
begin try
SELECT Tech.Id, cars.Brend[Марка], cars.Model[Модель], cars.Year[Год выпуска], tech.Type[Тип], tech.Date[Дата], tech.Cost[Стоимость]
FROM cars INNER JOIN
	 garage ON cars.Id = garage.car_id INNER JOIN
	 tech ON garage.Id = tech.Car_id
where tech.Car_id = @car
end try
begin catch
print error_message()
end catch
end;
--=================================
--Check registration
--=================================
IF OBJECT_ID('[dbo].[CheckReg]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CheckReg] 
END 
go
create procedure [dbo].[CheckReg](
@login nvarchar(50)
)
as begin
begin try
select Id from [dbo].[users]
where login = @login
end try
begin catch
print error_message()
end catch
end;
--=================================
--Check balance
--=================================
IF OBJECT_ID('[dbo].[CheckBalance]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CheckBalance] 
END 
go
create procedure [dbo].[CheckBalance](
@id int
)
as begin
begin try
select balance from [dbo].[users]
where id = @id
end try
begin catch
print error_message()
end catch
end;
--=================================
--Select Login
--=================================
IF OBJECT_ID('[dbo].[SelectLogin]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectLogin] 
END 
go
create procedure [dbo].[SelectLogin](
@id int
)
as begin
begin try
select login from [dbo].[users]
where id = @id
end try
begin catch
print error_message()
end catch
end;
--=================================
--Select Img
--=================================
IF OBJECT_ID('[dbo].[SelectImg]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectImg] 
END 
go
create procedure [dbo].[SelectImg](
@car int
)
as begin
begin try
select Img from [dbo].[cars]
where id = @car
end try
begin catch
print error_message()
end catch
end;
--=================================
--Select CarName
--=================================
IF OBJECT_ID('[dbo].[SelectCarName]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SelectCarName] 
END 
go
create procedure [dbo].[SelectCarName](
@car int
)
as begin
begin try
select Brend, Model from [dbo].[cars]
where id = @car
end try
begin catch
print error_message()
end catch
end;
--=================================
--Change CarCount
--=================================
IF OBJECT_ID('[dbo].[ChangeCarCount]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ChangeCarCount] 
END 
go
create procedure [dbo].[ChangeCarCount](
@car int,
@count int
)
as begin
begin try
update [dbo].[cars]
set Count=@count
where Id=@car;
end try
begin catch
print error_message()
end catch
end;
--=================================
--Delete Tech
--=================================
IF OBJECT_ID('[dbo].[DeleteTech]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteTech] 
END 
go
create procedure [dbo].[DeleteTech](
@tech int
)
as begin
begin try
delete [dbo].[tech]
where Id=@tech;
end try
begin catch
print error_message()
end catch
end;
--=================================
--Export XML
--=================================

IF OBJECT_ID('[dbo].[ExportC]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ExportC] 
END 
go
create PROCEDURE [dbo].[ExportC] 
AS 
	SELECT [Brend], [Model], [Cost], [Year], [Color], [Type], [Count]
	 FROM [dbo].[cars]
	FOR XML PATH('Car'), ROOT('Cars');
--=================================
--Import XML
--=================================

IF OBJECT_ID('[dbo].[ImportC]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ImportC] 
END 
go
create PROCEDURE ImportC
@xml XML = NULL
AS
Select  @xml  = 
CONVERT(XML,bulkcolumn,2) FROM OPENROWSET(BULK 'C:\Users\Roman\Desktop\5sem\CourseProject\cars.xml',SINGLE_BLOB) AS X
SET ARITHABORT ON
Insert into [dbo].[cars]
        (
          [Brend], [Model], [Cost], [Year], [Color], [Type], [Count]
        )
    Select 
        
        P.value('Brend[1]', 'nvarchar(40)') AS [Brend],
        P.value('Model[1]', 'nvarchar(40)') AS [Model],
		P.value('Cost[1]', 'money') AS [Cost],
        P.value('Year[1]', 'int') AS [Year],
		P.value('Color[1]', 'nvarchar(50)') AS [Color],
        P.value('Type[1]', 'nvarchar(40)') AS [Type],
		P.value('Count[1]', 'int') AS [Count]
       
    From @xml.nodes('/Cars/Car') PropertyFeed(P) 
--=================================
--FindCarBy Brend
--=================================
IF OBJECT_ID('[dbo].[FindCarByBrend]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[FindCarByBrend] 
END 
go
create procedure [dbo].[FindCarByBrend](
@find nvarchar(50)
)
as begin
begin try
select Id[Cd], Brend[Марка], Model[Модель], Cost[Стоимость], Year[Год выпуска], Color[Цвет], Type[Тип], Count[Наличие] from [dbo].[Cars]
where Brend like @find+'%'
end try
begin catch
print error_message()
end catch
end;
--=================================
--FindCarBy Model
--=================================
IF OBJECT_ID('[dbo].[FindCarByModel]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[FindCarByModel] 
END 
go
create procedure [dbo].[FindCarByModel](
@find nvarchar(50)
)
as begin
begin try
select Id[Cd], Brend[Марка], Model[Модель], Cost[Стоимость], Year[Год выпуска], Color[Цвет], Type[Тип], Count[Наличие] from [dbo].[Cars]
where Model like @find+'%'
end try
begin catch
print error_message()
end catch
end;
--=================================
--FindCarBy Year
--=================================
IF OBJECT_ID('[dbo].[FindCarByYear]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[FindCarByYear] 
END 
go
create procedure [dbo].[FindCarByYear](
@find int
)
as begin
begin try
select Id[Cd], Brend[Марка], Model[Модель], Cost[Стоимость], Year[Год выпуска], Color[Цвет], Type[Тип], Count[Наличие] from [dbo].[Cars]
where Year = @find
end try
begin catch
print error_message()
end catch
end;
--=================================
--FindCarBy Color
--=================================
IF OBJECT_ID('[dbo].[FindCarByColor]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[FindCarByColor] 
END 
go
create procedure [dbo].[FindCarByColor](
@find nvarchar(50)
)
as begin
begin try
select Id[Cd], Brend[Марка], Model[Модель], Cost[Стоимость], Year[Год выпуска], Color[Цвет], Type[Тип], Count[Наличие] from [dbo].[Cars]
where Color like @find+'%'
end try
begin catch
print error_message()
end catch
end;
--=================================
--FindCarBy Type
--=================================
IF OBJECT_ID('[dbo].[FindCarByType]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[FindCarByType] 
END 
go
create procedure [dbo].[FindCarByType](
@find nvarchar(50)
)
as begin
begin try
select Id[Cd], Brend[Марка], Model[Модель], Cost[Стоимость], Year[Год выпуска], Color[Цвет], Type[Тип], Count[Наличие] from [dbo].[Cars]
where Type like @find+'%'
end try
begin catch
print error_message()
end catch
end;