create table department
	(dept_name		varchar(20), 
	 building		varchar(15), 
	 budget		        numeric(12,2) check (budget > 0),
	 primary key (dept_name)
	);

create table course
	(course_id		varchar(8), 
	 title			varchar(50), 
	 dept_name		varchar(20),
	 credits		numeric(2,0) check (credits > 0),
	 primary key (course_id),
	 foreign key (dept_name) references department
		on delete set null
	);

create table instructor
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 salary			numeric(8,2) check (salary > 29000),
	 primary key (ID),
	 foreign key (dept_name) references department
		on delete set null
	);

create table teaches
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 primary key (ID, course_id),
	 foreign key (course_id) references course
		on delete cascade,
	 foreign key (ID) references instructor
		on delete cascade
	);

create table student
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 tot_cred		numeric(3,0) check (tot_cred >= 0),
	 primary key (ID),
	 foreign key (dept_name) references department
		on delete set null
	);

create table takes
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		        varchar(2),
	 primary key (ID, course_id),
	 foreign key (course_id) references course
		on delete cascade,
	 foreign key (ID) references student
		on delete cascade
	);

insert into department values ('Biology', 'Watson', '90000');
insert into department values ('Comp. Sci.', 'Taylor', '100000');
insert into department values ('Elec. Eng.', 'Taylor', '85000');
insert into department values ('Finance', 'Painter', '120000');
insert into department values ('History', 'Painter', '50000');
insert into department values ('Music', 'Packard', '80000');
insert into department values ('Physics', 'Watson', '70000');

insert into course values ('BIO-101', 'Intro. to Biology', 'Biology', '4');
insert into course values ('BIO-301', 'Genetics', 'Biology', '4');
insert into course values ('BIO-399', 'Computational Biology', 'Biology', '3');
insert into course values ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4');
insert into course values ('CS-190', 'Game Design', 'Comp. Sci.', '4');
insert into course values ('CS-315', 'Robotics', 'Comp. Sci.', '3');
insert into course values ('CS-319', 'Image Processing', 'Comp. Sci.', '3');
insert into course values ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');
insert into course values ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3');
insert into course values ('FIN-201', 'Investment Banking', 'Finance', '3');
insert into course values ('HIS-351', 'World History', 'History', '3');
insert into course values ('MU-199', 'Music Video Production', 'Music', '3');
insert into course values ('PHY-101', 'Physical Principles', 'Physics', '4');

insert into instructor values ('10101', 'Srinivasan', 'Comp. Sci.', '65000');
insert into instructor values ('12121', 'Wu', 'Finance', '90000');
insert into instructor values ('15151', 'Mozart', 'Music', '40000');
insert into instructor values ('22222', 'Einstein', 'Physics', '95000');
insert into instructor values ('32343', 'El Said', 'History', '60000');
insert into instructor values ('33456', 'Gold', 'Physics', '87000');
insert into instructor values ('45565', 'Katz', 'Comp. Sci.', '75000');
insert into instructor values ('58583', 'Califieri', 'History', '62000');
insert into instructor values ('76543', 'Singh', 'Finance', '80000');
insert into instructor values ('76766', 'Crick', 'Biology', '72000');
insert into instructor values ('83821', 'Brandt', 'Comp. Sci.', '92000');
insert into instructor values ('98345', 'Kim', 'Elec. Eng.', '80000');

insert into teaches values ('10101', 'CS-101', '1', 'Fall', '2009');
insert into teaches values ('10101', 'CS-315', '1', 'Spring', '2010');
insert into teaches values ('10101', 'CS-347', '1', 'Fall', '2009');
insert into teaches values ('12121', 'FIN-201', '1', 'Spring', '2010');
insert into teaches values ('15151', 'MU-199', '1', 'Spring', '2010');
insert into teaches values ('22222', 'PHY-101', '1', 'Fall', '2009');
insert into teaches values ('32343', 'HIS-351', '1', 'Spring', '2010');
insert into teaches values ('45565', 'CS-101', '1', 'Spring', '2010');
insert into teaches values ('45565', 'CS-319', '1', 'Spring', '2010');
insert into teaches values ('76766', 'BIO-101', '1', 'Summer', '2009');
insert into teaches values ('76766', 'BIO-301', '1', 'Summer', '2010');
insert into teaches values ('83821', 'CS-190', '1', 'Spring', '2009');
insert into teaches values ('83821', 'CS-190', '2', 'Spring', '2009');
insert into teaches values ('83821', 'CS-319', '2', 'Spring', '2010');
insert into teaches values ('98345', 'EE-181', '1', 'Spring', '2009');

insert into student values ('00128', 'Zhang', 'Comp. Sci.', '102');
insert into student values ('12345', 'Shankar', 'Comp. Sci.', '32');
insert into student values ('19991', 'Brandt', 'History', '80');
insert into student values ('23121', 'Chavez', 'Finance', '110');
insert into student values ('44553', 'Peltier', 'Physics', '56');
insert into student values ('45678', 'Levy', 'Physics', '46');
insert into student values ('54321', 'Williams', 'Comp. Sci.', '54');
insert into student values ('55739', 'Sanchez', 'Music', '38');
insert into student values ('70557', 'Snow', 'Physics', '0');
insert into student values ('76543', 'Brown', 'Comp. Sci.', '58');
insert into student values ('76653', 'Aoi', 'Elec. Eng.', '60');
insert into student values ('98765', 'Bourikas', 'Elec. Eng.', '98');
insert into student values ('98988', 'Tanaka', 'Biology', '120');

insert into takes values ('00128', 'CS-101', '1', 'Fall', '2009', 'A');
insert into takes values ('00128', 'CS-347', '1', 'Fall', '2009', 'A-');
insert into takes values ('12345', 'CS-101', '1', 'Fall', '2009', 'C');
insert into takes values ('12345', 'CS-190', '2', 'Spring', '2009', 'A');
insert into takes values ('12345', 'CS-315', '1', 'Spring', '2010', 'A');
insert into takes values ('12345', 'CS-347', '1', 'Fall', '2009', 'A');
insert into takes values ('19991', 'HIS-351', '1', 'Spring', '2010', 'B');
insert into takes values ('23121', 'FIN-201', '1', 'Spring', '2010', 'C+');
insert into takes values ('44553', 'PHY-101', '1', 'Fall', '2009', 'B-');
insert into takes values ('45678', 'CS-101', '1', 'Fall', '2009', 'F');
insert into takes values ('45678', 'CS-101', '1', 'Spring', '2010', 'B+');
insert into takes values ('45678', 'CS-319', '1', 'Spring', '2010', 'B');
insert into takes values ('54321', 'CS-101', '1', 'Fall', '2009', 'A-');
insert into takes values ('54321', 'CS-190', '2', 'Spring', '2009', 'B+');
insert into takes values ('55739', 'MU-199', '1', 'Spring', '2010', 'A-');
insert into takes values ('76543', 'CS-101', '1', 'Fall', '2009', 'A');
insert into takes values ('76543', 'CS-319', '2', 'Spring', '2010', 'A');
insert into takes values ('76653', 'EE-181', '1', 'Spring', '2009', 'C');
insert into takes values ('98765', 'CS-101', '1', 'Fall', '2009', 'C-');
insert into takes values ('98765', 'CS-315', '1', 'Spring', '2010', 'B');
insert into takes values ('98988', 'BIO-101', '1', 'Summer', '2009', 'A');
insert into takes values ('98988', 'BIO-301', '1', 'Summer', '2010', null);

select * from department;
select * from instructor;
select * from student;
select * from course;
select * from takes;
select * from teaches;