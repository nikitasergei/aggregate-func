
create table public.Departments
(
	Id serial not null primary key,
	Financing money not null check (Financing >= 0.00::money) default 0.0,
	Name varchar(100) not null unique check (Name <> N''),
	Faculty_id int not null
);

create table Faculties
(
	Id serial not null primary key,
	Name varchar(100) not null unique check (Name <> N'')
);

create table Groups
(
	Id serial not null primary key,
	Name varchar(100) not null unique check (Name <> N''),
	Year int not null check (Year between 1 and 5),
	Department_id int not null
);

create table Groups_lectures
(
	Id serial not null  primary key,
	Day_of_week int not null check (Day_of_week between 1 and 7),
	Group_id int not null,
	Lecture_id int not null
);

create table Lectures
(
	Id serial not null primary key,
	Lecture_room varchar(100) not null check (Lecture_room <> N''),
	Subject_id int not null,
	Teacher_id int not null
);

create table Subjects
(
	Id serial not null primary key,
	Name varchar(100) not null unique check (Name <> N'')
);


create table Teachers
(
	Id serial not null primary key,
	Name varchar(100) not null check (Name <> N''),
	Salary money not null check (Salary > 0.00::money),
	Surname varchar(100) not null check (Surname <> N'')
);

alter table Departments
add foreign key (Faculty_id) references Faculties(Id);

alter table Groups
add foreign key (Department_id) references Departments (Id);

alter table Groups_lectures
add foreign key (Group_id) references Groups(Id);

alter table Groups_lectures
add foreign key (Lecture_id) references Lectures(Id);

alter table Lectures
add foreign key (Subject_id) references Subjects(Id);

alter table Lectures
add foreign key (Teacher_id) references Teachers(Id);