create database student_result_db;
use student_result_db;

create table Students(
Student_ID int primary key auto_increment,
Name varchar(255),
Department varchar(100),
Year int);

create table Subjects(
Subject_ID int primary key auto_increment,
Subject_Name varchar(255),
Credits int );

create table Marks(
Mark_ID int primary key auto_increment,
Student_ID int,
Subject_ID int,
foreign key (Student_ID) references Students(Student_ID),
foreign key (Subject_ID) references Subjects(Subject_ID),
Marks int);

INSERT INTO Students (Name, Department, Year) VALUES 
('John Doe', 'Computer Science', 2025),
('Jane Smith', 'Mechanical Engineering', 2025),
('Emily Johnson', 'Electrical Engineering', 2025),
('Drishya T', 'Chemistry', 2025);

INSERT INTO Subjects (Subject_ID, Subject_Name, Credits) VALUES 
(1,'Data Structures', 3),
(2,'Thermodynamics', 4),
(3,'Circuit Analysis', 3),
(4,'Calculus I', 4);

INSERT INTO Marks (Student_ID, Subject_ID, Marks) VALUES 
(1, 1, 85),
(2, 1, 78),
(3, 1, 38),
(4, 1, 88),

(1, 2, 50),
(2, 2, 75),
(3, 2, 95),
(4, 2, 68),

(1, 3, 80),
(2, 3, 45),
(3, 3, 25),
(4, 3, 66),

(1, 4, 80),
(2, 4, 95),
(3, 4, 35),
(4, 4, 88);

select s.Student_ID, s.Name, sb.Subject_Name, m.Marks
from Students as s
Join Marks as m  on s.Student_ID = m.Student_ID
Join Subjects as sb on m.Subject_ID = sb.Subject_ID
where sb.Subject_ID=1 
order by m.Marks desc limit 3;

select s.Student_ID, s.Name, sb.Subject_Name, m.Marks
from Students as s
Join Marks as m  on s.Student_ID = m.Student_ID
Join Subjects as sb on m.Subject_ID = sb.Subject_ID
where sb.Subject_ID=2
order by m.Marks desc limit 3;

select s.Student_ID, s.Name, sb.Subject_Name, m.Marks
from Students as s
Join Marks as m  on s.Student_ID = m.Student_ID
Join Subjects as sb on m.Subject_ID = sb.Subject_ID
where sb.Subject_ID=3
order by m.Marks desc limit 3;

select s.Student_ID, s.Name, sb.Subject_Name, m.Marks
from Students as s
Join Marks as m  on s.Student_ID = m.Student_ID
Join Subjects as sb on m.Subject_ID = sb.Subject_ID
where sb.Subject_ID=4
order by m.Marks desc limit 3;

select 
Department,
AVG(Marks.Marks) AS Average_marks
From
Students
Inner join Marks ON Students.Student_ID  = Marks.Student_ID
Group By
Department;

SELECT 
    Students.Student_ID,students.Name ,count( *) as fails
FROM 
    Students
INNER JOIN 
    Marks ON Students.Student_ID = Marks.Student_ID
    WHERE  Marks.Marks < 40
    GROUP BY 
    Students.Student_ID
HAVING 
    COUNT(*) > 2;
;
