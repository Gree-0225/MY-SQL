create database Employee_db;
use Employee_db;
create table Employee(
 employee_id int primary key AUTO_INCREMENT,
 employee_name varchar(255),
 department varchar(100),
 position varchar(100),
 hire_date date,
 base_salary decimal(10,2));

create table Attendance(
attendance_id int primary key AUTO_INCREMENT,
employee_id int,
foreign key (employee_id) references Employee(employee_id),
attendance_date date,
status ENUM('present','absent','leave'));

create table Salaries(
salary_id int primary key AUTO_INCREMENT,
employee_id int,
foreign key (employee_id) references Employee(employee_id),
base_salary decimal(10,2),
bonus decimal(10,2),
deductions decimal(10,2),
month varchar(20),
year int);

create table Payroll(
payroll_id int primary key AUTO_INCREMENT,
employee_id int,
foreign key (employee_id) references Employee(employee_id),
total_salary decimal(10,2),
payment_date date);

INSERT INTO Employee (employee_name, department, position, hire_date, base_salary)
VALUES 
    ('Alice Johnson', 'Finance', 'Accountant', '2020-03-15', 55000.00),
    ('Bob Smith', 'IT', 'Software Engineer', '2021-06-01', 75000.00),
    ('Carol White', 'HR', 'HR Manager', '2019-11-20', 62000.00),
    ('David Lee', 'IT', 'DevOps Engineer', '2022-01-10', 70000.00),
    ('Emily Davis', 'Marketing', 'Marketing Specialist', '2023-05-05', 50000.00);

INSERT INTO Attendance (employee_id, attendance_date, status)
VALUES
    (1, '2025-09-28', 'present'),
    (2, '2025-09-28', 'present'),
    (3, '2025-09-28', 'leave'),
    (4, '2025-09-28', 'absent'),
    (5, '2025-09-28', 'present');
INSERT INTO Attendance (employee_id, attendance_date, status)
VALUES   
    (1, '2025-09-29', 'present'),
    (2, '2025-09-29', 'absent'),
    (3, '2025-09-29', 'present'),
    (4, '2025-09-29', 'present'),
    (5, '2025-09-29', 'leave');
    
INSERT INTO Attendance (employee_id, attendance_date, status)
VALUES   
    (1, '2025-09-30', 'present'),
    (2, '2025-09-30', 'absent'),
    (3, '2025-09-30', 'present'),
    (4, '2025-09-30', 'present'),
    (5, '2025-09-30', 'leave');
    
INSERT INTO Salaries (employee_id, base_salary, bonus, deductions, month, year)
VALUES
    (1, 55000.00, 2000.00, 500.00, 'September', 2025),
    (2, 75000.00, 5000.00, 1000.00, 'September', 2025),
    (3, 62000.00, 2500.00, 700.00, 'September', 2025),
    (4, 70000.00, 3000.00, 800.00, 'September', 2025),
    (5, 50000.00, 1500.00, 300.00, 'September', 2025);
    
INSERT INTO Payroll (employee_id, total_salary, payment_date)
VALUES
    (1, 55000.00 + 2000.00 - 500.00, '2025-09-30'),
    (2, 75000.00 + 5000.00 - 1000.00, '2025-09-30'),
    (3, 62000.00 + 2500.00 - 700.00, '2025-09-30'),
    (4, 70000.00 + 3000.00 - 800.00, '2025-09-30'),
    (5, 50000.00 + 1500.00 - 300.00, '2025-09-30');
    
select * from Employee;
insert into Employee(employee_name, department, position, hire_date, base_salary)
value ('Vijay Singh','IT','Python Developer','2018-02-05','60000');

update employee
set department = 'operations'
where employee_id =3;

update salaries
set base_salary = 58000
where employee_id=5 and month ='September' and year=2025;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM Attendance
WHERE employee_id = 1;

INSERT INTO Attendance (employee_id, attendance_date, status)
VALUE  
(1, '2025-09-29', 'present');
    
select employee_id, attendance_date, status
from Attendance;

select employee_id, attendance_date, status
from Attendance
where attendance_date = '2025-09-28';

select employee_id, base_salary, bonus, deductions,base_salary+bonus-deductions AS 'final_salary'
from Salaries;

ALTER TABLE Salaries
ADD final_salary DECIMAL(10, 2);

update Salaries
SET bonus = 2500.00,
    deductions = 600.00,
    final_salary = base_salary + 2500.00 - 600.00
    WHERE employee_id = 1 AND month = 'September' AND year = 2025;

select * from employee;
select * from payroll;

SELECT employee_name,total_salary,payment_date
FROM employee
INNER JOIN payroll
ON employee.employee_id = payroll.employee_id; 

SELECT e.employee_id, e.employee_name, s.base_salary, s.bonus, s.deductions, s.base_salary+s.bonus-s.deductions AS 'final_salary'
from employee as e
INNER JOIN salaries as s
ON e.employee_id = s.employee_id; 

select *
FROM employee as e
INNER JOIN attendance as a ON e.employee_id = a.employee_id
INNER JOIN salaries as s ON a.employee_id = s.employee_id
INNER JOIN payroll as p ON s.employee_id = p.employee_id;

SELECT 
    e.employee_id,
    e.employee_name,
    a.attendance_date,
    a.status,
    s.base_salary,
    s.bonus,
    p.payment_date,
    p.total_salary
FROM employee AS e
INNER JOIN attendance AS a ON e.employee_id = a.employee_id
INNER JOIN salaries AS s ON e.employee_id = s.employee_id
INNER JOIN payroll AS p ON e.employee_id = p.employee_id;