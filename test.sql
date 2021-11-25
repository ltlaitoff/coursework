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


TRANSFORM Max(j.mark_id) AS [Max-mark_id] 
+ SELECT (u.surname &   & u.name &   & u.patronymic) AS fullname 
+ FROM 
+   ( 
+     SELECT * 
+     FROM Journal 
+     WHERE Journal.subject_id =  + subject_id +  
+   ) AS j 
+   RIGHT JOIN ( 
+     SELECT 
+       Users.id AS id, 
+       Users.surname as surname, 
+       Users.name AS name, 
+       Users.patronymic AS patronymic 
+     FROM Users 
+     INNER JOIN Groups ON Users.group_id = Groups.id 
+     WHERE Groups.id =  + groups_id +  
+     ORDER BY Users.id 
+   ) AS u ON j.user_id = u.id 
+ GROUP BY fullname  
+ PIVOT j.date; ;


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



INSERT INTO Users (surname, name, patronymic, email, username, password, group_id)
VALUES ( 
  "surname",
  "name",
  "patronymic",
  "email",
  "username",
  "password",
  1
);

UPDATE Users
SET
  surname = "1",
  name = "1",
  patronymic = "1",
  email = "1",
  username = "1",
  password = "1",
  group_id = 1
WHERE id = 102


let id = 102;
let groupId = 1;
let surname = "2";
let name = "2";
let patronymic = "2";
let email = "2";
let username = "2";
let password = "2";

let a = 'UPDATE Users ' +
'SET '+
  'surname = "' + surname + '", ' +
  'name = "' + name + '", ' +
  'patronymic= "' + patronymic + '", ' +
  'email = "' + email + '", ' +
  'username = "' + username + '", ' +
  'password = "' + password + '", ' +
  'group_id = ' + String(groupId) + ' ' +
'WHERE ' +
  'id = ' + String(id);

console.log(a);

UPDATE
  Users
SET
  surname = "2",
  name = "2",
  patronymic = "2",
  email = "2",
  username = "2",
  password = "2",
  group_id = 1
WHERE
  id = 102

UPDATE
  Users
SET
  surname = "1",
  name = "1",
  patronymic = "1",
  email = "1",
  username = "1",
  password = "1",
  group_id = 1
WHERE
  id = 102

UPDATE Users SET surname = "2", name = "2", patronymic= "2", email = "2", username = "2", password = "5", group_id = 1 WHERE id = 102;





SELECT
  u.surname AS fullname
FROM
  (
    SELECT
      *
    FROM
      Journal
    WHERE
      Journal.subject_id = 1
  ) AS j
RIGHT JOIN (
  SELECT
    Users.id AS id,
    Users.surname as surname,
    Users.name AS name,
    Users.patronymic AS patronymic
  FROM
    Users
    INNER JOIN Groups ON Users.group_id = Groups.id
  WHERE
    Groups.id = 1
  ORDER BY
    Users.id
) AS u ON j.user_id = u.id



SELECT Timetable.day_of_week
FROM Timetable, Subjects, Groups
WHERE (
  Subjects.id = Timetable.subject_id AND 
  Groups.id = Timetable.group_id AND
  Groups.id = 1 AND
  Subjects.id = 1
)

SELECT *
FROM Timetable_get_group_subject, dates
WHERE (Timetable_get_group_subject.day_of_week = (WEEKDAY(dates.firs) + 1))

SELECT test.firs, test.mark_id, u.surname
FROM test
LEFT JOIN select_users AS u ON u.id = test.user_id

UNION

SELECT test.firs, test.mark_id, u.surname
FROM test
RIGHT JOIN select_users AS u ON u.id = test.user_id


----------------------------------------------------------------
SELECT dates.firs
FROM
  (
    SELECT Timetable.day_of_week
    FROM Timetable, Subjects, Groups
    WHERE (
      Subjects.id = Timetable.subject_id AND
      Groups.id = Timetable.group_id AND 
      Subjects.id = 1 AND
      Groups.id = 1
  )) AS Timetable_get_group_subject,
  (
    SELECT DateValue("1.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("2.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("3.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("4.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("5.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("6.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("7.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("8.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("9.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("10.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("11.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("12.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("13.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("14.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("15.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("16.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("17.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("18.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("19.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("20.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("21.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("22.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("23.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("24.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("25.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("26.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("27.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("28.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("29.10.2021") AS firs FROM Teachers UNION
    SELECT DateValue("30.10.2021") AS firs FROM Teachers UNION 
    SELECT DateValue("31.10.2021") AS firs FROM Teachers
  ) AS dates
WHERE
  Timetable_get_group_subject.day_of_week = ( Weekday(dates.firs) - 1 )
ORDER BY
  dates.firs;


SELECT u.surname AS fullname, j.mark_id, j.date
FROM 
  (
    SELECT *
    FROM Journal
    WHERE (
      Journal.subject_id = 1 AND 
      Journal.date BETWEEN DateValue("01.10.2021") AND DateValue("31.10.2021")
    )
  ) AS j 
RIGHT JOIN (
  SELECT
    Users.id AS id,
    Users.surname as surname,
    Users.name AS name,
    Users.patronymic AS patronymic
  FROM Users
  INNER JOIN Groups ON Users.group_id = Groups.id
  WHERE Groups.id = 1
  ORDER BY Users.id
) AS u ON j.user_id = u.id


TRANSFORM Max(m.mark) AS [Max-mark]
SELECT t.fullname
FROM (
  SELECT testing1.*, testing3.firs
  FROM (
    SELECT u.surname AS fullname, j.mark_id, j.date
    FROM 
      (
        SELECT *
        FROM Journal
        WHERE (
          Journal.subject_id = 3 AND 
          Journal.date BETWEEN DateValue("01.10.2021") AND DateValue("31.10.2021")
        )
      ) AS j 
    RIGHT JOIN (
      SELECT
        Users.id AS id,
        Users.surname as surname,
        Users.name AS name,
        Users.patronymic AS patronymic
      FROM Users
      INNER JOIN Groups ON Users.group_id = Groups.id
      WHERE Groups.id = 3
      ORDER BY Users.id
    ) AS u ON j.user_id = u.id) AS testing1
  RIGHT JOIN (
    SELECT dates.firs
  FROM
    (
      SELECT Timetable.day_of_week
      FROM Timetable, Subjects, Groups
      WHERE (
        Subjects.id = Timetable.subject_id AND
        Groups.id = Timetable.group_id AND 
        Subjects.id = 3 AND
        Groups.id = 3
    )) AS Timetable_get_group_subject,
    (
      SELECT DateValue("1.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("2.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("3.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("4.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("5.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("6.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("7.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("8.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("9.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("10.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("11.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("12.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("13.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("14.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("15.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("16.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("17.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("18.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("19.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("20.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("21.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("22.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("23.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("24.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("25.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("26.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("27.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("28.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("29.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("30.10.2021") AS firs FROM Teachers UNION 
      SELECT DateValue("31.10.2021") AS firs FROM Teachers
    ) AS dates
  WHERE
    Timetable_get_group_subject.day_of_week = ( Weekday(dates.firs) - 1 )
  ORDER BY
    dates.firs
  ) AS testing3 ON testing1.date = testing3.firs

  UNION

  SELECT testing1.*, testing3.firs
  FROM (
    SELECT u.surname AS fullname, j.mark_id, j.date
    FROM 
      (
        SELECT *
        FROM Journal
        WHERE (
          Journal.subject_id = 3 AND 
          Journal.date BETWEEN DateValue("01.10.2021") AND DateValue("31.10.2021")
        )
      ) AS j 
    RIGHT JOIN (
      SELECT
        Users.id AS id,
        Users.surname as surname,
        Users.name AS name,
        Users.patronymic AS patronymic
      FROM Users
      INNER JOIN Groups ON Users.group_id = Groups.id
      WHERE Groups.id = 3
      ORDER BY Users.id
    ) AS u ON j.user_id = u.id) AS testing1
  LEFT JOIN (
    SELECT dates.firs
  FROM
    (
      SELECT Timetable.day_of_week
      FROM Timetable, Subjects, Groups
      WHERE (
        Subjects.id = Timetable.subject_id AND
        Groups.id = Timetable.group_id AND 
        Subjects.id = 3 AND
        Groups.id = 3
    )) AS Timetable_get_group_subject,
    (
      SELECT DateValue("1.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("2.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("3.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("4.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("5.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("6.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("7.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("8.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("9.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("10.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("11.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("12.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("13.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("14.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("15.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("16.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("17.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("18.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("19.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("20.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("21.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("22.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("23.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("24.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("25.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("26.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("27.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("28.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("29.10.2021") AS firs FROM Teachers UNION
      SELECT DateValue("30.10.2021") AS firs FROM Teachers UNION 
      SELECT DateValue("31.10.2021") AS firs FROM Teachers
    ) AS dates
  WHERE
    Timetable_get_group_subject.day_of_week = ( Weekday(dates.firs) - 1 )
  ORDER BY
    dates.firs
  ) AS testing3 ON testing1.date = testing3.firs
) AS t
LEFT JOIN Marks AS m ON t.mark_id = m.id 
WHERE t.fullname = '' 
GROUP BY t.fullname 
PIVOT t.firs;


TRANSFORM Max(m.mark) AS mark
SELECT t.fullname
FROM (
  SELECT testing1.fullname, IIf(testing1.date = testing3.firs, testing1.mark_id, Null) AS mark_id, testing3.firs
  FROM (
    SELECT u.surname AS fullname, j.mark_id, j.date
    FROM 
      (
        SELECT *
        FROM Journal
        WHERE (
          Journal.subject_id = 3 AND 
          Journal.date BETWEEN DateValue("01.10.2021") AND DateValue("31.10.2021")
        )
      ) AS j 
    RIGHT JOIN (
      SELECT
        Users.id AS id,
        Users.surname as surname,
        Users.name AS name,
        Users.patronymic AS patronymic
      FROM Users
      INNER JOIN Groups ON Users.group_id = Groups.id
      WHERE Groups.id = 3
      ORDER BY Users.id
    ) AS u ON j.user_id = u.id) AS testing1, 
    (
      SELECT dates.firs
      FROM
        (
          SELECT Timetable.day_of_week
          FROM Timetable, Subjects, Groups
          WHERE (
            Subjects.id = Timetable.subject_id AND
            Groups.id = Timetable.group_id AND 
            Subjects.id = 3 AND
            Groups.id = 3
        )) AS Timetable_get_group_subject,
        (
          SELECT DateValue("1.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("2.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("3.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("4.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("5.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("6.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("7.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("8.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("9.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("10.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("11.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("12.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("13.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("14.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("15.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("16.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("17.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("18.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("19.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("20.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("21.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("22.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("23.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("24.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("25.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("26.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("27.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("28.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("29.10.2021") AS firs FROM Teachers UNION
          SELECT DateValue("30.10.2021") AS firs FROM Teachers UNION 
          SELECT DateValue("31.10.2021") AS firs FROM Teachers
        ) AS dates
  WHERE
    Timetable_get_group_subject.day_of_week = ( Weekday(dates.firs) - 1 )
  ORDER BY
    dates.firs
  ) AS testing3
) AS t
LEFT JOIN Marks AS m ON t.mark_id = m.id
GROUP BY t.fullname
PIVOT DAY(t.firs);

'TRANSFORM Max(m.mark) AS [Max-mark_id] '
+ 'SELECT t.fullname '
+ 'FROM (SELECT testing1.fullname, IIf(testing1.date = testing3.firs, testing1.mark_id, Null) AS mark_id, testing3.firs '
+ '  FROM ( '
+ '    SELECT u.surname AS fullname, j.mark_id, j.date '
+ '    FROM  '
+ '      ( '
+ '        SELECT * '
+ '        FROM Journal '
+ '        WHERE ( '
+ '          Journal.subject_id = 3 AND  '
+ '          Journal.date BETWEEN DateValue("01.10.2021") AND DateValue("31.10.2021") '
+ '        ) '
+ '      ) AS j  '
+ '    RIGHT JOIN ( '
+ '      SELECT '
+ '        Users.id AS id, '
+ '        Users.surname as surname, '
+ '        Users.name AS name, '
+ '        Users.patronymic AS patronymic '
+ '      FROM Users '
+ '      INNER JOIN Groups ON Users.group_id = Groups.id '
+ '      WHERE Groups.id = 3 '
+ '      ORDER BY Users.id '
+ '    ) AS u ON j.user_id = u.id) AS testing1,  '
+ '    ( '
+ '      SELECT dates.firs '
+ '      FROM '
+ '        ( '
+ '          SELECT Timetable.day_of_week '
+ '          FROM Timetable, Subjects, Groups '
+ '          WHERE ( '
+ '            Subjects.id = Timetable.subject_id AND '
+ '            Groups.id = Timetable.group_id AND  '
+ '            Subjects.id = 3 AND '
+ '            Groups.id = 3 '
+ '        )) AS Timetable_get_group_subject, '
+ '        ( '
+ '          SELECT DateValue("1.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("2.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("3.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("4.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("5.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("6.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("7.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("8.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("9.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("10.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("11.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("12.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("13.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("14.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("15.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("16.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("17.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("18.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("19.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("20.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("21.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("22.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("23.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("24.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("25.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("26.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("27.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("28.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("29.10.2021") AS firs FROM Teachers UNION '
+ '          SELECT DateValue("30.10.2021") AS firs FROM Teachers UNION  '
+ '          SELECT DateValue("31.10.2021") AS firs FROM Teachers '
+ '        ) AS dates '
+ '  WHERE '
+ '    Timetable_get_group_subject.day_of_week = ( Weekday(dates.firs) - 1 ) '
+ '  ORDER BY '
+ '    dates.firs '
+ '  ) AS testing3 '
+ ') AS t '
+ 'LEFT JOIN Marks AS m ON t.mark_id = m.id '
+ 'GROUP BY t.fullname '
+ 'PIVOT DAY(t.firs)';
