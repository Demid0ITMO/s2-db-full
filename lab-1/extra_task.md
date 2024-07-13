```postgresql
VIEW HUMAN.NAME, GROUP.NAME, ACTION_DESCRIPTION.DESCRIPTION WHERE ACTION_WITH_GROUP.DESCRIPTION_ID = ACTION_DESCRIPTION.ID
```

Вывести человека, группу и как они взаимодействуют

Запрос:

```postgresql
CREATE VIEW HUMAN_ACTION_WITH_GROUP_V
AS
	SELECT human.name AS Человек, action_description.description AS Что_сделал, "group".name AS С_какой_группой
	FROM human
	JOIN action_description
	ON action_description.human_id = human.id
	JOIN action_with_group
	ON action_with_group.description_id = action_description.id
	JOIN "group"
	ON "group".id = action_with_group.group_id;

```
