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

-- 2. List the names of students with id in the range of v2 (id) to v3 (inclusive).

  Alter table Student ADD index(id,name);

-- All 400 rows were being scanned without using any index
-- indexing on the id , name columns. indexing enforces the queries to run faster

-- explain SELECT name FROM Student WHERE id BETWEEN @v2 AND @v3;
SELECT name FROM Student WHERE id BETWEEN @v2 AND @v3;

