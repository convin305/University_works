--- (1) To find all instructors in Comp. Sci. dept
select *
from instructor
where dept_name = "Comp. Sci.";

--- (2) To find all instructors in Comp. Sci. dept with salary > 80000
select *
from instructor
where dept_name = "Comp. Sci." and salary > 80000;

--- (3) Find the Cartesian product instructor X teaches
select * from instructor, teaches;

--- (4) Find the names of all instructors who have taught some course and the course_id
select * 
from instructor, teaches
where instructor.id = teaches.id;

--- (5) Find the names of all instructors in the Art  department who have taught some course and the course_id
select * 
from instructor, teaches
where instructor.id = teaches.id and dept_name = "Art";

--- (6) Find the names of all instructors who have a higher salary than some instructor in 'Comp. Sci.'.
select name 
from instructor 
where salary > some (select salary from instructor where dept_name = "Comp. Sci.");

--- (7) Find the names of all instructors whose name includes the substring “dar”.
select name
from instructor
where name LIKE "%dar%";

--- (8) Find the names of all instructors with salary between $90,000 and $100,000

select name
from instructor
where salary between 90000 and 100000;

--- (9) Find courses that ran in Fall 2010 or in Spring 2011

(select course_id
from teaches
where semester = "Fall" and year = 2010)
union
(select course_id
from teaches
where semester = "Spring" and year = 2010);

--- (10) Find courses that ran in Fall 2009 and in Spring 2010

select course_id
from teaches
where semester = "Fall" and year = 2009 and 
		course_id in (select course_id from teaches where semester = "Spring" and year = 2010);

--- (11) Find courses that ran in Fall 2009 and in Spring 2010

select course_id
from teaches
where semester = "Fall" and year = 2009 and 
		course_id not in (select course_id from teaches where semester = "Spring" and year = 2010);

--- (12) Find the average salary of instructors in the Computer Science department 

select avg(salary) "평균급여"
from instructor
where dept_name = 'Comp. Sci.';

--- (13) Find the total number of instructors who teach a course in the Spring 2010 semester

select count(distinct ID)
from teaches
where semester = "Spring" and year = 2010;

--- (14) Find the number of tuples in the course relation

select count(*)
from course ;

--- (15) Find the average salary of instructors in each department

select dept_name, avg(salary)
from instructor
group by dept_name;

--- (16) Find the names and average salaries of all departments whose average salary is greater than 42000

select dept_name, avg(salary)
from instructor
group by dept_name
having avg(salary) > 42000;

--- (19) Name all instructors whose name is neither “Mozart” nor Einstein”

select name
from instructor
where name NOT IN ("Mozart", "Einstein");

--- (20) Find the total number of (distinct) students who have taken course sections taught by the instructor with ID 10101

select count(distinct takes.ID)
from takes, teaches
where takes.course_id = teaches.course_id and teaches.ID=10101;

--- (21) Find names of instructors with salary greater than that of some (at least one) instructor in the Biology department.

select name, salary
from instructor
where salary > (select min(salary) from instructor where dept_name = "Biology");

--- (22) Find the names of all instructors whose salary is greater than the salary of all instructors in the Biology department.

select i.name, i.salary
from instructor i 
where i.salary > (select max(salary) from instructor where dept_name = "Biology");

--- (23) Find all students who have taken all courses offered in the Biology department.

select s.ID
from student s
where s.course_id not exists (( select c.course_id from course c where c.dept_name = "Biology")
					except
					(select t.course_id from takes t where s.ID = t.ID));

--- (24) Find all students who have taken all courses offered in the Biology department.

--- (25) Find all departments with the maximum budget

select dept_name, max(budget)
from department;

--- (26) Delete all instructors from the Finance department

delete 
from instructor
where dept_name = "Finance";

--- (27) Delete all instructors whose salary is less than the average salary of instructors

delete
from instructor i
where i.salary < (select avg(f.salary) from instructor f);

--- (28) Give a 5% salary raise to all instructors

update instructor
set salary = salary * 1.05;

--- (29) Increase salaries of instructors whose salary is over $100,000 by 3%, and all others by a 5% 

update instructor
set salary = case when salary <= 100000 then salary * 1.05
										else salary * 1.03 end ;


---
update instructor
set salary = salary * 1.03
where salary > 100000;

update instructor 
set salary = salary * 1.05
where salary < 100000;

--- (30) Add a new tuple to student  with tot_creds set to null

insert into student values ('44821', 'Sumin', 'Biology', null);