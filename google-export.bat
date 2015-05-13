@echo OFF
set EXPORTS=C:\Exports
sqlplus -s PSNavigator/PSNavigatorpassword @%EXPORTS%\export-google.sql
exit
