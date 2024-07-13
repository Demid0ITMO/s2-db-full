Query
-
```postgresql
EXPLAIN (ANALYSE)
    SELECT TYPES.НАИМЕНОВАНИЕ, VED.ДАТА FROM Н_ТИПЫ_ВЕДОМОСТЕЙ AS TYPES
    RIGHT JOIN Н_ВЕДОМОСТИ AS VED ON VED.ВЕД_ИД = TYPES.ИД
    WHERE TYPES.НАИМЕНОВАНИЕ = 'Экзаменационный лист' AND VED.ИД = 1457443 AND VED.ИД < 1250972;
```

Indexes
- 
- btree для VED.ИД
- hash для TYPES.НАИМЕНОВАНИЕ

Execution plan
- 
```
    VED					TYPES
    соединение(VED.ВЕД_ИД = TYPES.ИД)
    выборка(TYPES.НАИМЕНОВАНИЕ = 'Экзаменационный лист')
    выборка(VED.ИД < 1250972)
    выборка(VED.ИД = 1457443)
    проекция(TYPES.НАИМЕНОВАНИЕ, VED.ДАТА)
```

Query output
-
```
Nested Loop  (cost=0.42..9.49 rows=1 width=426) (actual time=0.015..0.015 rows=0 loops=1)
   Join Filter: (types."ИД" = ved."ВЕД_ИД")
   ->  Seq Scan on "Н_ТИПЫ_ВЕДОМОСТЕЙ" types  (cost=0.00..1.04 rows=1 width=422) (actual time=0.010..0.011 rows=1 loops=1)
         Filter: (("НАИМЕНОВАНИЕ")::text = 'Экзаменационный лист'::text)
         Rows Removed by Filter: 2
   ->  Index Scan using "ВЕД_PK" on "Н_ВЕДОМОСТИ" ved  (cost=0.42..8.44 rows=1 width=12) (actual time=0.003..0.003 rows=0 loops=1)
         Index Cond: (("ИД" < 1250972) AND ("ИД" = 1457443))
 Planning Time: 0.143 ms
 Execution Time: 0.038 ms
```