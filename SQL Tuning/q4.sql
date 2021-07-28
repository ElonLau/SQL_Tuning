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

-- 4. List the names of students who have taken a course taught by professor v5 (name).
/*
SELECT name FROM Student,
	(SELECT studId FROM Transcript,
		(SELECT crsCode, semester FROM Professor
			JOIN Teaching
			WHERE Professor.name = @v5 AND Professor.id = Teaching.profId) as alias1
	WHERE Transcript.crsCode = alias1.crsCode AND Transcript.semester = alias1.semester) as alias2
WHERE Student.id = alias2.studId;
*/

-- Drag out the inner query to become a temporary table
-- Produced same results but no nested joins existed. The nested joins in the previous query takes longer time to process. 
-- Temporary table runs faster than common table expression (CTE)

CREATE TEMPORARY TABLE alias1
	SELECT crsCode, semester
	FROM Professor
	JOIN Teaching
	WHERE Professor.name = @v5
	AND Professor.id = Teaching.profId;

SELECT name FROM Student WHERE id IN(
    SELECT studId FROM Transcript,
    (SELECT crsCode, semester FROM alias1) as alias2
WHERE Transcript.crsCode = alias2.crsCode AND Transcript.semester = alias2.semester);

