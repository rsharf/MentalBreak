SELECT n.id, n.name AS npc_name, s2.zone AS zone_short_name, z.long_name AS zone_name, z.expansion
FROM npc_types n
JOIN spawnentry se ON n.id = se.npcID
JOIN spawngroup sg ON se.spawngroupID = sg.id
JOIN spawn2 s2 ON sg.id = s2.spawngroupID
JOIN zone z ON s2.zone = z.short_name
WHERE n.name LIKE '%fabled%'
AND z.expansion <= 1
GROUP BY n.id, s2.zone
ORDER BY z.expansion, s2.zone, n.name;
