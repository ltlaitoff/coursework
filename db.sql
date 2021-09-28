CREATE TABLE User_Type (
  ID int SERIAL PRIMARY KEY,
  type varchar(255) NOT NULL
);

CREATE TABLE Users (
  ID int SERIAL PRIMARY KEY,
  surname varchar(255) NOT NULL ,
  name varchar(255) NOT NULL,
  patronymic varchar(255) NOT NULL,
  birthday DATE NOT NULL,
  telephone varchar(15) NOT NULL,
  email varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  user_type int NOT NULL
);


INSERT INTO Users
VALUES (value1, value2, value3, ...);

-- SELECT * 
-- FROM Users
-- WHERE Users.user_type = (
--   SELECT ID
--   FROM User_Type
--   WHERE type = 'Teacher'
--   )
