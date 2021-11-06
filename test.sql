TRANSFORM Max(j.mark_id) AS [Max-mark_id]
SELECT u.surname AS fullname
FROM
  (
    SELECT *
    FROM Journal
    WHERE Journal.subject_id = 2
  ) AS j
  RIGHT JOIN (
    SELECT
      Users.id AS id,
      Users.surname as surname,
      Users.name AS name,
      Users.patronymic AS patronymic
    FROM Users
    INNER JOIN Groups ON Users.group_id = Groups.id
    WHERE Groups.id = 2
    ORDER BY Users.id
  ) AS u ON j.user_id = u.id
GROUP BY u.surname 
PIVOT j.date;


'TRANSFORM Max(j.mark_id) AS [Max-mark_id] '
+ 'SELECT (u.surname & ' ' & u.name & ' ' & u.patronymic) AS fullname '
+ 'FROM '
+ '  ( '
+ '    SELECT * '
+ '    FROM Journal '
+ '    WHERE Journal.subject_id = ' + subject_id + ' '
+ '  ) AS j '
+ '  RIGHT JOIN ( '
+ '    SELECT '
+ '      Users.id AS id, '
+ '      Users.surname as surname, '
+ '      Users.name AS name, '
+ '      Users.patronymic AS patronymic '
+ '    FROM Users '
+ '    INNER JOIN Groups ON Users.group_id = Groups.id '
+ '    WHERE Groups.id = ' + groups_id + ' '
+ '    ORDER BY Users.id '
+ '  ) AS u ON j.user_id = u.id '
+ 'GROUP BY fullname  '
+ 'PIVOT j.date; ';


UPDATE Journal
SET
  mark_id = 9
WHERE
user_id = 
subject_id = 
date = DateValue("");

UPDATE Journal
SET
  mark_id = 9
WHERE
user_id = 1 AND
subject_id = 1 AND
date = DateValue("08.10.2021");