$mysqlExe = "C:\Program Files\MariaDB 10.11\bin\mysql.exe"
$sqlFile = "D:\app ideas\MentalBreak\insert_multiclass_master.sql"
Get-Content $sqlFile | & $mysqlExe -uroot -p1 -D peq
