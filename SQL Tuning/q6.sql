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

-- 6. List the names of students who have taken all courses offered by department v8 (deptId).
/*
SELECT name FROM Student,
	(SELECT studId
	FROM Transcript
		WHERE crsCode IN
		(SELECT crsCode FROM Course WHERE deptId = @v8 AND crsCode IN (SELECT crsCode FROM Teaching))
		GROUP BY studId
		HAVING COUNT(*) = 
			(SELECT COUNT(*) FROM Course WHERE deptId = @v8 AND crsCode IN (SELECT crsCode FROM Teaching))) as alias
WHERE id = alias.studId;
*/


create unique index unique_stud on Student(id,name);
create index index_course on Course(crsCode,deptId);
with course_cte as(
	SELECT crsCode FROM Course WHERE deptId = @v8 AND crsCode IN (SELECT crsCode FROM Teaching)
)

	SELECT name FROM Student where id in
		(SELECT studId
		FROM Transcript
			WHERE crsCode IN
			(select crsCode from crs_cte)
		GROUP BY studId
			HAVING COUNT(*) = (select count(*) from crs_cte))
			

-- What was the bottleneck? - Try to avoid subqueries and use JOIN instead.
-- 		1) Select from Teaching table is redundant as there are no courses in Course table that don't exists in Teaching table.
-- 		2) There is no need to check deptId = @v8 condition two times in subqueries on Course table. 

WITH v8_courses AS (
	SELECT crsCode 
    FROM Course 
    WHERE deptId = @v8
)
SELECT s.name
FROM Student AS s, Transcript AS t, v8_courses AS v8c
WHERE t.studId = s.id
AND v8c.crsCode = t.crsCode
GROUP BY s.name
HAVING COUNT(*) = (SELECT COUNT(*) FROM v8_courses);

