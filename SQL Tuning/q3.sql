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

-- 3. List the names of students who have taken course v4 (crsCode).
create unique index unique_transcript on Transcript(studId,crsCode);
-- explain SELECT name FROM Student WHERE id IN (SELECT studId FROM Transcript WHERE crsCode = @v4);
SELECT name FROM Student WHERE id IN (SELECT studId FROM Transcript WHERE crsCode = @v4);

/*
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
'1', 'SIMPLE', '<subquery2>', NULL, 'ALL', NULL, NULL, NULL, NULL, NULL, '100.00', 'Using where'
'1', 'SIMPLE', 'Student', NULL, 'eq_ref', 'PRIMARY,id', 'PRIMARY', '4', '<subquery2>.studId', '1', '100.00', NULL
'2', 'MATERIALIZED', 'Transcript', NULL, 'ALL', NULL, NULL, NULL, NULL, '100', '10.00', 'Using where'
*/
