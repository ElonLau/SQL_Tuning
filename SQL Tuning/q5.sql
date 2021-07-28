USE springboardopt;

-- -------------------------------------
SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- unique indexing improves query searching performance. The original select statement does not
-- have indexing. 

/*
'1', 'PRIMARY', 'Course', NULL, 'ALL', NULL, NULL, NULL, NULL, '100', '10.00', 'Using where'
'1', 'PRIMARY', 'Transcript', NULL, 'index', 'unique_transcript', 'unique_transcript', '1028', NULL, '100', '10.00', 'Using where; Using index; Using join buffer (hash join)'
'1', 'PRIMARY', 'Student', NULL, 'eq_ref', 'PRIMARY,id', 'PRIMARY', '4', 'springboardopt.Transcript.studId', '1', '100.00', 'Using where'
'3', 'DEPENDENT SUBQUERY', 'Transcript', NULL, 'ref_or_null', 'unique_transcript', 'unique_transcript', '5', 'func', '2', '100.00', 'Using where; Using index; Full scan on NULL key'
'3', 'DEPENDENT SUBQUERY', 'Course', NULL, 'ALL', NULL, NULL, NULL, NULL, '100', '1.00', 'Using where; Using join buffer (hash join)'
*/

create unique index uni_stud on Student(id,name);
create index indexing_course on Course(crsCode,deptId);
create unique index uni_transcript on Transcript(studId,crsCode,semester);
-- 5. List the names of students who have taken a course from department v6 (deptId), but not v7.
 SELECT * FROM Student,
	(SELECT studId FROM Transcript, Course WHERE deptId = @v6 AND Course.crsCode = Transcript.crsCode
	AND studId NOT IN
	(SELECT studId FROM Transcript, Course WHERE deptId = @v7 AND Course.crsCode = Transcript.crsCode)) as alias
WHERE Student.id = alias.studId;
 
 /*
 explain SELECT * FROM Student,
	(SELECT studId FROM Transcript, Course WHERE deptId = @v6 AND Course.crsCode = Transcript.crsCode
	AND studId NOT IN
	(SELECT studId FROM Transcript, Course WHERE deptId = @v7 AND Course.crsCode = Transcript.crsCode)) as alias
WHERE Student.id = alias.studId;
*/
