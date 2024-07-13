Query
-
```postgresql
EXPLAIN ANALYSE 
    SELECT peoples.ФАМИЛИЯ, edu.ЧЛВК_ИД, st.ИД FROM Н_ЛЮДИ AS peoples 
        JOIN Н_ОБУЧЕНИЯ AS edu ON edu.ЧЛВК_ИД = peoples.ИД
        JOIN Н_УЧЕНИКИ AS st ON st.ЧЛВК_ИД = edu.ЧЛВК_ИД
    WHERE peoples.ИМЯ > 'Николай' AND edu.НЗК::int > 933232;
```

Indexes
- 
- btree для peoples.ИМЯ
- btree для edu.НЗК


Execution plan
- 
```
edu				peoples
соединение(edu.ЧЛВК_ИД = peoples.ИД)
выборка(peoples.ИМЯ > 'Николай')
выборка(edu.НЗК::int > 933232)
	|			st
соединение(st.ЧЛВК_ИД = edu.ЧЛВК_ИД)
проекция(peoples.ФАМИЛИЯ, edu.ЧЛВК_ИД, st.ИД)
```

Query output
-
```
Nested Loop  (cost=178.47..998.44 rows=1748 width=24) (actual time=2.788..5.465 rows=1462 loops=1)
   ->  Hash Join  (cost=178.19..327.45 rows=372 width=24) (actual time=2.776..3.798 rows=255 loops=1)
         Hash Cond: (edu."ЧЛВК_ИД" = peoples."ИД")
         ->  Seq Scan on "Н_ОБУЧЕНИЯ" edu  (cost=0.00..144.87 rows=1674 width=4) (actual time=0.013..0.851 rows=1044 loops=1)
               Filter: (("НЗК")::integer > 933232)
               Rows Removed by Filter: 3977
         ->  Hash  (cost=163.97..163.97 rows=1137 width=20) (actual time=2.754..2.754 rows=1141 loops=1)
               Buckets: 2048  Batches: 1  Memory Usage: 77kB
               ->  Seq Scan on "Н_ЛЮДИ" peoples  (cost=0.00..163.97 rows=1137 width=20) (actual time=0.007..2.551 rows=1141 loops=1)
                     Filter: (("ИМЯ")::text > 'Николай'::text)
                     Rows Removed by Filter: 3977
   ->  Index Scan using "УЧЕН_ОБУЧ_FK_I" on "Н_УЧЕНИКИ" st  (cost=0.29..1.75 rows=5 width=8) (actual time=0.002..0.005 rows=6 loops=255)
         Index Cond: ("ЧЛВК_ИД" = edu."ЧЛВК_ИД")
 Planning Time: 0.663 ms
 Execution Time: 5.592 ms
```