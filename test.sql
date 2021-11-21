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