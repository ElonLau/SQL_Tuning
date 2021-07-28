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

-- 1. List the name of the student with id equal to v1 (id).
-- explain SELECT name FROM Student WHERE id = @v1;
-- explain analyze SELECT name FROM Student WHERE id = @v1;

    /*'''-> SELECT name FROM Student WHERE id = @v1 \G ;
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: Student
   partitions: NULL
         type: ALL
possible_keys: NULL
          key: NULL
      key_len: NULL
          ref: NULL
         rows: 400
     filtered: 10.00
        Extra: Using where
1 row in set, 1 warning (0.00 sec)'''*/

-- previously, all 400 rows were scanned. Added primary key id to improve efficiency. 

Alter table Student ADD Primary KEY(id);
SELECT name FROM Student WHERE id = @v1;