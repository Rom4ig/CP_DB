exec [dbo].[CheckReg] kek
exec [dbo].[CreateUser] kek, lol
exec [dbo].[Autorize] 78999, 78999
exec [dbo].[AddBalance] 0, 100
exec [dbo].[AddCar] BMW, M4,20, 2008, Black, Cupe, 5, null;
exec [dbo].[AddCar] Mercedes, s200, 30, 2006, Black, Cupe, 2, null;
exec [dbo].[SelectCars]
exec [dbo].[SelectUsers]
exec [dbo].[BuyCar] 0, 0
exec [dbo].[BuyCar] 0, 1
exec [dbo].[SelectCars]
exec [dbo].[SelectUsers]
exec [dbo].[SelectGarage]
exec [dbo].[AddTech] 1, Покраска, '22.11.2019', 105
exec [dbo].[AddTech] 1, 'Замена шин', '22.11.2019', 105
exec [dbo].[SellCar] 0, 1
exec [dbo].[SelectTech]
exec [dbo].[SelectGarageUser] 0

declare @count int;
set @count = 0;
while @count < 100000
begin
exec [dbo].[CreateUser] @count, @count
set @count=@count+1;
end

