$sql = Get-Content "D:\app ideas\MentalBreak\insert_multiclass_master.sql" -Raw
& "C:\Program Files\MariaDB 10.11\bin\mysql.exe" -uroot -p1 -D peq -e $sql
