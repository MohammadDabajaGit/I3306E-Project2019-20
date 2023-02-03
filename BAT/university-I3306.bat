set LAB=C:\Users\hp\I3306E-Project2019-20
set DBApp=university
set USER=root
set PASSWORD=root

mysql -u%USER% -p%PASSWORD% mysql < %LAB%\SQL\%DBApp%_create_database.sql 2>> %LAB%\LOG\%DBApp%_create_database.log >> %LAB%\LOG\%DBApp%_create_database.log
mysql -u%USER% -p%PASSWORD% mysql < %LAB%\SQL\%DBApp%_create_user_grant_privilages.sql 2>> %LAB%\LOG\%DBApp%_create_user_grant_privilages.log >> %LAB%\LOG\%DBApp%_create_user_grant_privilages.log
mysql -u%USER% -p%PASSWORD% mysql < %LAB%\SQL\%DBApp%_create_table.sql 2>> %LAB%\LOG\%DBApp%_create_table.log >> %LAB%\LOG\%DBApp%_create_table.log
mysql -u%USER% -p%PASSWORD% mysql < %LAB%\SQL\%DBApp%_create_trigger.sql 2>> %LAB%\LOG\%DBApp%_create_trigger.log >> %LAB%\LOG\%DBApp%_create_trigger.log
