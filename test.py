let surname = 'test'
let name = 'test'
let patronymic = 'test'
let email = 'test'
let username = 'test'
let password = 'test'
let groupId = 0

a = 'INSERT INTO Users (surname, name, patronymic, email, username, password, group_id) ' +
  'VALUES ( ' +
    '"' + surname + '", ' + 
    '"' + name + '", ' + 
    '"' + patronymic + '", ' +
    '"' + email + '", ' + 
    '"' + username + '", ' + 
    '"' + password + '", ' + 
    String(groupId) + ' ' +
  ' )'

console.log(a)

INSERT INTO Users (surname, name, patronymic, email, username, password, group_id) 
VALUES ( "test", "test", "test", "test", "test", "test", 0  )

INSERT INTO Users ( surname, name, patronymic, email, username, [password], group_id )
VALUES ("surname", "name", "patronymic", "email", "username", "password", 1);


# a = '''
# +38 (965) 807-15-25
# +38 (940) 209-62-58
# +38 (901) 004-14-16
# +38 (917) 085-66-36
# +38 (931) 929-66-22
# +38 (911) 530-69-53
# +38 (941) 088-73-89
# +38 (929) 448-85-88
# +38 (909) 425-06-72
# +38 (923) 647-38-67
# +38 (959) 637-66-18
# +38 (900) 962-64-26
# +38 (995) 696-54-67
# +38 (967) 781-24-74
# +38 (938) 187-23-18
# +38 (928) 498-73-23
# +38 (946) 910-75-58
# +38 (996) 084-39-62
# +38 (993) 645-01-88
# +38 (994) 668-88-91
# '''

# # for i in a.split('\n'):
# # 	print('+380' + i.replace('+7 ', '').replace('(', '').replace(') ', '').replace('-', ''));


# a = '''
# telephone
# +380958679076
# +380986919161
# +3809658071525
# +3809402096258
# +3809010041416
# +3809170856636
# +3809319296622
# +3809115306953
# +3809410887389
# +3809294488588
# +3809094250672
# +3809236473867
# +3809596376618
# +3809009626426
# +3809956965467
# +3809677812474
# +3809381872318
# +3809284987323
# +3809469107558
# +3809960843962
# +3809936450188
# +3809946688891
# '''

# for i in a.split('\n'):
# 	print(i[0:13])


a = '''
k1y8f
mdij40
AndreySomov727
IgorMalinovskiy932
ElizavetaDemyanchenko852
KonkordiyaIvanova176
IzotKozyrev17
EvgeniyArhipov512
ViolettaAndrianova139
SpartakAstahov612
MargaritaMartynova387
DemyanAhmetzyanov451
DaniilAbramov270
FainaOstrovskaya787
FortunatPokrovskiy868
LeokadiyaBezrukova275
ElizabetUlanova167
YaropolkBezrukov543
DinaRumyantseva215
MilitsaKazakova581
SamsonDobronravov30
ArefiyNektov970
'''

for i in a.split('\n'):
	print(i.lower() + '@gmail.com')



# a = '''
# birthday
# 02.03.1998
# 20.09.1990
# 20.01.1999
# 24.01.1999
# 24.08.1981
# 23.10.1986
# 25.09.1988
# 21.07.1999
# 27.03.1981
# 12.05.1995
# 02.07.1976
# 17.04.1976
# 07.07.1976
# 24.05.1979
# 15.09.1990
# 29.03.1998
# 28.04.1988
# 05.03.1988
# 03.03.1974
# 15.07.1971
# 16.01.1981
# 09.03.1986
# '''

# for i in a.split('\n'):













Лукин  Дональд
Андреев  Кондрат
Тихонов  Павел
Горбунов  Дональд
Соловьёв  Любомир
Исаев  Лукьян
Наумов  Ростислав
Петров  Виктор
Белякова  Яна
Шубина  Руслана