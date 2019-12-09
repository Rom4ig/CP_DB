use KP

drop table tech
drop table garage
drop table cars
drop table users

create table cars(
[Id]		  int primary key identity (0, 1)	not null,
[Brend]		  nvarchar(40)						not null,
[Model]		  nvarchar(40)						not null,
[Cost]		  money								not null,
[Year]		  int								null,
[Color]		  nvarchar(50)						null,
[Type]		  nvarchar(40)						null,
[Count]		  int								not null,
[Img]		  varbinary(max)						null
)

create table users(
[Id]			int primary key	identity (0, 1)	not null,
[login]			nvarchar(50)	unique			not null,
[password]		nvarchar(max)					not null,
[balance]		money  default (0)				not null
)

create table garage(
[Id]			int primary key	IDENTITY (0, 1)						not null,
[user_id]		int foreign key references users (Id)				not null,
[car_id]		int foreign key references Cars (Id)				not null
)

create table tech(
[Id]			int primary key	identity (0, 1)						not null,
[Car_id]		int foreign key references Garage (Id)				not null,
[Type]			nvarchar(50)										not null,
[Date]			date												null,
[Cost]			money												null
)
