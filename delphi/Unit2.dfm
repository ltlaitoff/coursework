object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 486
  Width = 707
  object ADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.15.0;User ID=Admin;Data Source=C:\M' +
      'y_projects\coursework\db.accdb;Mode=Share Deny None;Persist Secu' +
      'rity Info=False;Jet OLEDB:System database="";Jet OLEDB:Registry ' +
      'Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=6;J' +
      'et OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk O' +
      'ps=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database' +
      ' Password="";Jet OLEDB:Create System Database=False;Jet OLEDB:En' +
      'crypt Database=False;Jet OLEDB:Don'#39't Copy Locale on Compact=Fals' +
      'e;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=F' +
      'alse;Jet OLEDB:Support Complex Data=False;Jet OLEDB:Bypass UserI' +
      'nfo Validation=False;Jet OLEDB:Limited DB Caching=False;Jet OLED' +
      'B:Bypass ChoiceField Validation=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.ACE.OLEDB.15.0'
    Left = 40
    Top = 48
  end
  object ADOQueryMain: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'TRANSFORM Max(j.mark_id) AS [Max-mark_id]'
      'SELECT u.surname AS fullname'
      'FROM'
      '  ('
      '    SELECT *'
      '    FROM Journal'
      '    WHERE Journal.subject_id = 1'
      '  ) AS j'
      '  RIGHT JOIN ('
      '    SELECT'
      '      Users.id AS id,'
      '      Users.surname as surname,'
      '      Users.name AS name,'
      '      Users.patronymic AS patronymic'
      '    FROM Users'
      '    INNER JOIN Groups ON Users.group_id = Groups.id'
      '    WHERE Groups.id = 1'
      '    ORDER BY Users.id'
      '  ) AS u ON j.user_id = u.id'
      'GROUP BY u.surname '
      'PIVOT j.date;')
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
  object DataSourceGroups: TDataSource
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
      'SELECT s.id, s.name, s.audience, t.surname AS teacher '
      'FROM Subjects AS s '
      'INNER JOIN Teachers AS t ON (t.ID = s.teacher_id) '
      'ORDER BY s.id;')
    Left = 432
    Top = 144
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
    Top = 272
    object ADOQueryTimetableShowdayofweek: TWideMemoField
      FieldName = 'day of week'
      ReadOnly = True
      OnGetText = ADOQueryTimetableShowdayofweekGetText
      BlobType = ftWideMemo
    end
    object ADOQueryTimetableShowpair: TIntegerField
      FieldName = 'pair'
    end
    object ADOQueryTimetableShowgname: TWideStringField
      FieldName = 'g.name'
    end
    object ADOQueryTimetableShowsname: TWideStringField
      FieldName = 's.name'
      Size = 255
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
end
