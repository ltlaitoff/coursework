# coursework
Моя тема: Електронный журнал для оценок.
4-5 таблиц минимум

ТЗ: Нет ТЗ - результат ХЗ
База Данных:
  - Персонал
    - ID, табличний номер
    - Фамилия
    - Имя
    - Отчество
    - Телефон
    - Адрес
    - Дата народження
    - Зарплата
  - Предметы
    - ID
    - Название предмета
  - Аудитории
    - ID
    - Название
  - 



TODO:
### Completed:
- [x] Поддержка добавления оценок только в даты, 
  в которые возможно проведение пары у данной группы согласно рассписанию
- [x] Добавить надпись которая будет показывать дни
- [x] Добавить возможность изменения оценок студента
- [x] Выполнить рефакторинг
- [x] Добавить общий контроллер для добавление/изменения/удаление данных в журнале
### In Progress
- [ ] Пересмотреть надобность обновления массива дней, 
  в которые проводиться тот или иной предмет при добавлении записи в БД
- [ ] Пересмотреть код добавления и удаление записей с журнала
- [ ] Добавить проверки на ИДшники и дату

### No status
- [ ] Переименовать елементы на то, что они делают

- [ ] Добавить возможность удаление оценок у студента
- [ ] Переделать запросы на params
- [ ] Добавление уникального пароля для преподавателей и для администраторов
- [ ] Возможность добавление учеников и учителей
- [ ] Возможность добавление предметов
- [ ] Вывод полного ФИО студентов и учителей

### Bugs:
- [ ] При добавлении нескольких предметов выводиться только один