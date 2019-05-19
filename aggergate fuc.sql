--1
select count (*) as numb_of_teachers 
from public.teachers t
where t.id = any (select teacher_id 
				  from public.lectures l  
				  where l.id = any (select lecture_id 
									from public.groups_lectures gl
									where gl.group_id = any (select id 
															 from public.groups g
															 where g.department_id =  (select id 
																					   from public.departments d
																					   where (d."name" like 'Software Development')))));
--2
select count (*) from public.lectures l
where l.teacher_id = (select id from public.teachers t
					  where t.name like 'Dave' AND t.surname like 'McQueen');

--3
select count(*)
from public.lectures l
where l.lecture_room like 'D201';

--4
select distinct l.lecture_room, count (l.subject_id)
from public.lectures l
group by l.lecture_room;

--5


--6
select sum(t.salary)/count(t.id) as avg_teach 
from public.teachers t
where t.id = any(select l.id 
				 from public.lectures l 
				 where l.id = any(select gl.lecture_id 
								  from public.groups_lectures gl
								  where gl.group_id = any(select g.id 
														  from public.groups g
														  where g.department_id = any (select d.id
																					   from public.departments d
																					   where d.faculty_id = (select f.id
																											 from public.faculties f
																											 where f.name like 'Computer Science')))));

--7

--8
select sum(d.financing)/count (d.financing)as avg_of_dep 
from public.departments d;

--9
select t.id, (t.name || ' ' || t.surname) as fio, count (l.subject_id)as count_of_subjects
from public.teachers t join public.lectures l ON l.teacher_id = t.id
group by t.id;

--10
select gl.day_of_week as day, count(gl.lecture_id) as count_of_lectures
from public.groups_lectures gl
group by day;

--11
select lecture_room, count (*)
from (select distinct l.lecture_room as lecture_room, d.name as D_name
	  from public.groups_lectures gl join public.lectures l ON l.id = gl.lecture_id
							   join public.groups g on g.id= gl.group_id
							   join public.departments d on d.id = g.department_id) as tabl1
group by lecture_room

--12		
select name as faculty_name, count (*) as subj_count 
from (select distinct f.name as name, s.name as subj_name
from public.faculties f join public.departments d on d.faculty_id = f.id
						join public.groups g on g.department_id = d.id
						join public.groups_lectures gl on gl.group_id = g.id
						join public.lectures l ON l.id = gl.lecture_id
						join public.subjects s ON s.id = l.subject_id) as tabl
						group by name
	
--13	
select l.lecture_room, l.teacher_id, count (*) as lect_count
from public.lectures l
group by l.lecture_room, l.teacher_id

