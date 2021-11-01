object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 487
  Width = 486
  object ADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.15.0;Data Source=C:\My_projects\cou' +
      'rsework\db.accdb;Persist Security Info=False'
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
      '    WHERE Journal.subject_id = 2'
      '  ) AS j'
      '  RIGHT JOIN ('
      '    SELECT'
      '      Users.id AS id,'
      '      Users.surname as surname,'
      '      Users.name AS name,'
      '      Users.patronymic AS patronymic'
      '    FROM Users'
      '    INNER JOIN Groups ON Users.group_id = Groups.id'
      '    WHERE Groups.id = 2'
      '    ORDER BY Users.id'
      '  ) AS u ON j.user_id = u.id'
      'GROUP BY u.surname '
      'PIVOT j.date;')
    Left = 112
    Top = 24
  end
  object DataSourceMain: TDataSource
    DataSet = ADOQueryMain
    Left = 288
    Top = 16
  end
  object ADOTableGroups: TADOTable
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'Groups'
    Left = 112
    Top = 80
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
    Left = 288
    Top = 72
  end
  object DataSourceSubjects: TDataSource
    DataSet = ADOTableSubjects
    Left = 288
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
    Left = 288
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
    Left = 288
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
    Left = 288
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
    Left = 288
    Top = 408
  end
end
