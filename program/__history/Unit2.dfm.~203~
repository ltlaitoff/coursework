object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 551
  Width = 990
  object ADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.15.0;User ID=Admin;Data Source=db.a' +
      'ccdb;Mode=Share Deny None;Persist Security Info=False;Jet OLEDB:' +
      'System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database' +
      ' Password="";Jet OLEDB:Engine Type=6;Jet OLEDB:Database Locking ' +
      'Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk' +
      ' Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Cre' +
      'ate System Database=False;Jet OLEDB:Encrypt Database=False;Jet O' +
      'LEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Withou' +
      't Replica Repair=False;Jet OLEDB:SFP=False;Jet OLEDB:Support Com' +
      'plex Data=False;Jet OLEDB:Bypass UserInfo Validation=False;Jet O' +
      'LEDB:Limited DB Caching=False;Jet OLEDB:Bypass ChoiceField Valid' +
      'ation=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.ACE.OLEDB.15.0'
    Left = 40
    Top = 48
  end
  object ADOQueryMain: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      ''
      
        'TRANSFORM Max(IIf(testing1.date=testing3.firs,testing1.mark_id,N' +
        'ull)) AS 123'
      'SELECT testing1.fullname'
      
        'FROM (SELECT (u.surname & " " & u.name) AS fullname, j.mark_id, ' +
        'j.date'
      '    FROM '
      '      ('
      '        SELECT *'
      '        FROM Journal'
      '        WHERE ('
      '          Journal.subject_id = 3 AND '
      
        '          Journal.date BETWEEN DateValue("01.10.2021") AND DateV' +
        'alue("31.10.2021")'
      '        )'
      '      ) AS j '
      '    RIGHT JOIN ('
      '      SELECT'
      '        Users.id AS id,'
      '        Users.surname as surname,'
      '        Users.name AS name,'
      '        Users.patronymic AS patronymic'
      '      FROM Users'
      '      INNER JOIN Groups ON Users.group_id = Groups.id'
      '      WHERE Groups.id = 3'
      '      ORDER BY Users.id'
      '    ) AS u ON j.user_id = u.id)  AS testing1, (SELECT dates.firs'
      '      FROM'
      '        ('
      '          SELECT Timetable.day_of_week'
      '          FROM Timetable, Subjects, Groups'
      '          WHERE ('
      '            Subjects.id = Timetable.subject_id AND'
      '            Groups.id = Timetable.group_id AND '
      '            Subjects.id = 3 AND'
      '            Groups.id = 3'
      '        )) AS Timetable_get_group_subject,'
      '        ('
      
        '          SELECT DateValue("1.10.2021") AS firs FROM Teachers UN' +
        'ION'
      
        '          SELECT DateValue("2.10.2021") AS firs FROM Teachers UN' +
        'ION'
      
        '          SELECT DateValue("3.10.2021") AS firs FROM Teachers UN' +
        'ION'
      
        '          SELECT DateValue("4.10.2021") AS firs FROM Teachers UN' +
        'ION'
      
        '          SELECT DateValue("5.10.2021") AS firs FROM Teachers UN' +
        'ION'
      
        '          SELECT DateValue("6.10.2021") AS firs FROM Teachers UN' +
        'ION'
      
        '          SELECT DateValue("7.10.2021") AS firs FROM Teachers UN' +
        'ION'
      
        '          SELECT DateValue("8.10.2021") AS firs FROM Teachers UN' +
        'ION'
      
        '          SELECT DateValue("9.10.2021") AS firs FROM Teachers UN' +
        'ION'
      
        '          SELECT DateValue("10.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("11.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("12.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("13.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("14.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("15.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("16.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("17.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("18.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("19.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("20.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("21.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("22.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("23.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("24.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("25.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("26.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("27.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("28.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("29.10.2021") AS firs FROM Teachers U' +
        'NION'
      
        '          SELECT DateValue("30.10.2021") AS firs FROM Teachers U' +
        'NION '
      '          SELECT DateValue("31.10.2021") AS firs FROM Teachers'
      '        ) AS dates'
      '  WHERE'
      
        '    Timetable_get_group_subject.day_of_week = ( Weekday(dates.fi' +
        'rs) - 1 )'
      '  ORDER BY'
      '    dates.firs'
      '  )  AS testing3'
      'GROUP BY testing1.fullname'
      'PIVOT DAY(testing3.firs);')
    Left = 112
    Top = 24
  end
  object DataSourceMain: TDataSource
    DataSet = ADOQueryMain
    Left = 264
    Top = 16
  end
  object ADOTableGroups: TADOTable
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'Groups'
    Left = 112
    Top = 80
    object ADOTableGroupsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object ADOTableGroupsname: TWideStringField
      FieldName = 'name'
    end
  end
  object ADOTableSubjects: TADOTable
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'Subjects'
    Left = 112
    Top = 144
  end
  object DataSourceTableGroups: TDataSource
    DataSet = ADOTableGroups
    Left = 264
    Top = 72
  end
  object DataSourceTableSubjects: TDataSource
    DataSet = ADOTableSubjects
    Left = 264
    Top = 136
  end
  object ADOQueryStudentsFromGroup: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '  Users.id AS id,'
      '  Users.surname as surname,'
      '  Users.name AS name,'
      '  Users.patronymic AS patronymic'
      'FROM Users'
      'INNER JOIN Groups ON Users.group_id = Groups.id'
      'WHERE Groups.id = 2'
      'ORDER BY Users.id')
    Left = 112
    Top = 216
  end
  object DataSourceStudentFromGroup: TDataSource
    DataSet = ADOQueryStudentsFromGroup
    Left = 264
    Top = 208
  end
  object ADOQueryAddMarks: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Teachers;')
    Left = 112
    Top = 272
  end
  object DataSourceAddMarks: TDataSource
    DataSet = ADOQueryAddMarks
    Left = 264
    Top = 280
  end
  object ADOTableMarks: TADOTable
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'Marks'
    Left = 112
    Top = 344
  end
  object DataSourceTableMarks: TDataSource
    DataSet = ADOTableMarks
    Left = 264
    Top = 344
  end
  object ADOQueryTimetableGet: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM Timetable'
      'WHERE (group_id = -1) AND (subject_id = -1);')
    Left = 112
    Top = 408
  end
  object DataSourceTimetableGet: TDataSource
    DataSet = ADOQueryTimetableGet
    Left = 264
    Top = 408
  end
  object ADOQuerySubjects: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT s.id, s.name, s.audience, t.surname AS teacher'
      'FROM Subjects AS s'
      'INNER JOIN Teachers AS t ON (t.ID = s.teacher_id);')
    Left = 440
    Top = 24
  end
  object DataSourceSubjects: TDataSource
    DataSet = ADOQuerySubjects
    Left = 568
    Top = 24
  end
  object ADOTableTeachers: TADOTable
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'Teachers'
    Left = 432
    Top = 80
  end
  object DataSourceTableTeachers: TDataSource
    DataSet = ADOTableTeachers
    Left = 568
    Top = 80
  end
  object ADOQuerySubjectsShow: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT s.id, s.name, s.audience, (t.surname & " " & t.name) AS t' +
        'eacher'
      'FROM Subjects AS s'
      'INNER JOIN Teachers AS t ON (t.ID = s.teacher_id)'
      'ORDER BY s.id')
    Left = 432
    Top = 144
    object ADOQuerySubjectsShowid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object ADOQuerySubjectsShowname: TWideStringField
      FieldName = 'name'
      Size = 30
    end
    object ADOQuerySubjectsShowaudience: TIntegerField
      FieldName = 'audience'
    end
    object ADOQuerySubjectsShowteacher: TWideMemoField
      FieldName = 'teacher'
      ReadOnly = True
      OnGetText = getText
      BlobType = ftWideMemo
    end
  end
  object DataSourceSubjectsShow: TDataSource
    DataSet = ADOQuerySubjectsShow
    Left = 568
    Top = 144
  end
  object ADOQueryTimetable: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '  WeekdayName(t.day_of_week) AS [day of week],'
      '  t.pair,'
      '  g.name,'
      '  s.name'
      'FROM'
      '  Timetable AS t,'
      '  Subjects AS s,'
      '  Groups AS g'
      'WHERE'
      '  ('
      '    (t.subject_id = s.id) AND'
      '    (g.id = t.group_id)'
      '  )'
      'ORDER BY'
      '  t.day_of_week,'
      '  g.name,'
      '  t.pair;'
      '  ')
    Left = 432
    Top = 208
  end
  object DataSourceTimetable: TDataSource
    DataSet = ADOQueryTimetable
    Left = 568
    Top = 208
  end
  object ADOQueryTimetableShow: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '  WeekdayName(t.day_of_week) AS [day of week],'
      '  t.pair AS [pair],'
      '  g.name AS [group],'
      '  s.audience AS [audience],'
      '  s.name AS [subject]'
      'FROM'
      '  Timetable AS t,'
      '  Subjects AS s,'
      '  Groups AS g'
      'WHERE'
      '  ('
      '    (t.subject_id = s.id) AND'
      '    (g.id = t.group_id)'
      '  )'
      'ORDER BY'
      '  t.day_of_week,'
      '  g.name,'
      '  t.pair;'
      '  ')
    Left = 432
    Top = 272
    object ADOQueryTimetableShowdayofweek: TWideMemoField
      FieldName = 'day of week'
      ReadOnly = True
      OnGetText = getText
      BlobType = ftWideMemo
    end
    object ADOQueryTimetableShowpair: TIntegerField
      FieldName = 'pair'
    end
    object ADOQueryTimetableShowgroup: TWideStringField
      FieldName = 'group'
    end
    object ADOQueryTimetableShowaudience: TIntegerField
      FieldName = 'audience'
    end
    object ADOQueryTimetableShowsubject: TWideStringField
      FieldName = 'subject'
      Size = 30
    end
  end
  object DataSourceTimetableShow: TDataSource
    DataSet = ADOQueryTimetableShow
    Left = 568
    Top = 272
  end
  object ADOQueryGroupsShow: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM Groups;')
    Left = 432
    Top = 328
  end
  object DataSourceGroupsShow: TDataSource
    AutoEdit = False
    DataSet = ADOQueryGroupsShow
    Left = 568
    Top = 328
  end
  object ADOQueryGroups: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM Groups;')
    Left = 432
    Top = 384
  end
  object DataSourceQueryGroups: TDataSource
    DataSet = ADOQueryGroups
    Left = 568
    Top = 384
  end
  object ADOQueryUsersShow: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT u.id, g.name AS GN, surname, u.name, patronymic, email, u' +
        'sername, password'
      'FROM Users AS u '
      'INNER JOIN Groups AS g ON ((g.id = u.group_id) AND (g.id = 1))'
      'ORDER BY u.id')
    Left = 688
    Top = 24
    object ADOQueryUsersShowid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object ADOQueryUsersShowGN: TWideStringField
      FieldName = 'GN'
      Size = 3
    end
    object ADOQueryUsersShowsurname: TWideStringField
      FieldName = 'surname'
      Size = 15
    end
    object ADOQueryUsersShowname: TWideStringField
      FieldName = 'name'
      Size = 10
    end
    object ADOQueryUsersShowemail: TWideStringField
      FieldName = 'email'
      Size = 30
    end
    object ADOQueryUsersShowpatronymic: TWideStringField
      FieldName = 'patronymic'
      Size = 15
    end
    object ADOQueryUsersShowusername: TWideStringField
      FieldName = 'username'
    end
    object ADOQueryUsersShowpassword: TWideStringField
      FieldName = 'password'
    end
  end
  object DataSourceUsersShow: TDataSource
    DataSet = ADOQueryUsersShow
    Left = 808
    Top = 24
  end
  object ADOQueryUsers: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT u.id, surname, u.name, patronymic, email, username, passw' +
        'ord, g.name AS group_name'
      'FROM Users AS u'
      'INNER JOIN Groups AS g ON g.id = u.group_id'
      'ORDER BY u.id')
    Left = 688
    Top = 88
  end
  object DataSourceUsers: TDataSource
    DataSet = ADOQueryUsers
    Left = 808
    Top = 88
  end
  object ADOQueryTeachersShow: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM Teachers'
      'ORDER BY ID')
    Left = 704
    Top = 160
  end
  object DataSourceTeachersShow: TDataSource
    DataSet = ADOQueryTeachersShow
    Left = 840
    Top = 152
  end
  object ADOQueryTeachers: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM Teachers')
    Left = 704
    Top = 232
  end
  object DataSourceTeachers: TDataSource
    DataSet = ADOQueryTeachers
    Left = 840
    Top = 232
  end
  object ADOQueryAuthorization: TADOQuery
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM Teachers')
    Left = 704
    Top = 288
  end
  object DataSourceAuthorization: TDataSource
    DataSet = ADOQueryAuthorization
    Left = 840
    Top = 288
  end
end
