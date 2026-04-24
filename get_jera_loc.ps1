$mysqlExe = "C:\Program Files\MariaDB 10.11\bin\mysql.exe"
$query = "SELECT n.id, n.name, s.x, s.y, s.z, s.heading FROM npc_types n JOIN spawnentry se ON n.id = se.npcID JOIN spawn2 s ON se.spawngroupID = s.spawngroupID WHERE s.zone = 'poknowledge' AND n.name LIKE '%Jera%';"
& $mysqlExe -uroot -p1 -D peq -e $query > "D:\app ideas\MentalBreak\jera_loc.txt"
