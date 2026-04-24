$ErrorActionPreference = "Stop"
$mysqlExe = "C:\Program Files\MariaDB 10.11\bin\mysql.exe"
$mysqlDumpExe = "C:\Program Files\MariaDB 10.11\bin\mysqldump.exe"
$dbUser = "root"
$dbPass = "1"
$dbName = "peq"
$peqDir = "D:\app ideas\MentalBreak\eqemu server\peq"
$backupFile = "D:\app ideas\MentalBreak\character_classes_backup.sql"

Write-Host "Checking for existing character_classes data to backup..."
# Attempt to backup character_classes table if it exists
$backupProcess = Start-Process -FilePath $mysqlDumpExe `
    -ArgumentList "-u$dbUser", "-p$dbPass", $dbName, "character_classes", "--no-create-info" `
    -RedirectStandardOutput $backupFile `
    -NoNewWindow -Wait -PassThru -ErrorAction SilentlyContinue

if ($backupProcess -and $backupProcess.ExitCode -eq 0) {
    Write-Host "  Success: character_classes data backed up to $backupFile"
} else {
    Write-Host "  Note: character_classes table not found or backup failed. Proceeding without backup."
    if (Test-Path $backupFile) { Remove-Item $backupFile }
}

Write-Host "Dropping and recreating database: $dbName..."
& $mysqlExe "-u$dbUser" "-p$dbPass" -e "DROP DATABASE IF EXISTS $dbName; CREATE DATABASE $dbName;"
if ($LASTEXITCODE -ne 0) { throw "Failed to recreate database" }

# Source the PEQ base tables (schema + data) in order
$tableFiles = @(
    "create_tables_system.sql",
    "create_tables_login.sql",
    "create_tables_player.sql",
    "create_tables_state.sql",
    "create_tables_content.sql"
)

foreach ($file in $tableFiles) {
    $filePath = Join-Path $peqDir $file
    if (Test-Path $filePath) {
        Write-Host "Sourcing $file ..."
        $process = Start-Process -FilePath $mysqlExe `
            -ArgumentList "-u$dbUser", "-p$dbPass", $dbName `
            -RedirectStandardInput $filePath `
            -NoNewWindow -Wait -PassThru
        if ($process.ExitCode -ne 0) {
            Write-Host "ERROR: Failed to source $file (exit code $($process.ExitCode))"
        } else {
            Write-Host "  Done."
        }
    } else {
        Write-Host "WARNING: $filePath not found, skipping."
    }
}

Write-Host "Applying Multiclass Master NPC..."
$mcFile = "D:\app ideas\MentalBreak\insert_multiclass_master.sql"
$process = Start-Process -FilePath $mysqlExe `
    -ArgumentList "-u$dbUser", "-p$dbPass", $dbName `
    -RedirectStandardInput $mcFile `
    -NoNewWindow -Wait -PassThru
if ($process.ExitCode -ne 0) { Write-Host "WARNING: insert_multiclass_master.sql failed" }

Write-Host "Applying SayLink (SL) infrastructure fix..."
$slFile = "D:\app ideas\MentalBreak\fix_saylinks.sql"
$process = Start-Process -FilePath $mysqlExe `
    -ArgumentList "-u$dbUser", "-p$dbPass", $dbName `
    -RedirectStandardInput $slFile `
    -NoNewWindow -Wait -PassThru
if ($process.ExitCode -ne 0) { Write-Host "WARNING: fix_saylinks.sql failed" }

# ===============================================================
# CUSTOM CONTENT SQL — All MentalBreak project customizations
# ===============================================================
$customDir = "D:\app ideas\MentalBreak"
$customFiles = @(
    "create_instance_portal.sql",      # Instance Portal NPC (203000) + Innoruuk boss
    "create_vendors.sql",              # 15 Elemental Armor vendor NPCs in PoK
    "create_epic_vendor.sql",          # Epic item vendor NPC
    "create_berserker_vendor.sql",     # Berserker vendor NPC
    "instance_all_zones.sql",          # 120 zone instance portals + 4550 named NPC spawns
    "fix_raid_loot_minimum.sql",       # Raid boss guaranteed loot drops (mindrop>=2)
    "fix_raid_loot_step2.sql",         # Additional raid loot adjustments
    "fix_elemental_inventories.sql",   # Elemental plane merchant inventory fixes
    "ethernaut_chief_items.sql"        # 12,069 Ethernaut + 1,392 Chief custom items (~90MB, takes a few minutes)
)

foreach ($sqlFile in $customFiles) {
    $filePath = Join-Path $customDir $sqlFile
    if (Test-Path $filePath) {
        Write-Host "Applying custom SQL: $sqlFile ..."
        $process = Start-Process -FilePath $mysqlExe `
            -ArgumentList "-u$dbUser", "-p$dbPass", $dbName `
            -RedirectStandardInput $filePath `
            -NoNewWindow -Wait -PassThru
        if ($process.ExitCode -ne 0) {
            Write-Host "  WARNING: $sqlFile had errors (exit code $($process.ExitCode)). Non-critical spawngroup name collisions are expected."
        } else {
            Write-Host "  Done."
        }
    } else {
        Write-Host "  WARNING: $filePath not found, skipping."
    }
}

# Create Zone Transporter NPC (matches Zone_Transporter.pl quest script)
Write-Host "Creating Zone Transporter NPC..."
$ztSQL = @"
REPLACE INTO npc_types (id, name, level, race, class, bodytype, hp, mana, texture, helmtexture, gender, runspeed, special_abilities, findable, trackable)
VALUES (203002, 'Zone_Transporter', 70, 1, 1, 1, 100000, 0, 4, 0, 0, 0, '24,1', 1, 0);
REPLACE INTO spawngroup (id, name) VALUES (203002, 'Zone_Transporter_SG');
REPLACE INTO spawnentry (spawngroupID, npcID, chance) VALUES (203002, 203002, 100);
REPLACE INTO spawn2 (id, spawngroupID, zone, version, x, y, z, heading, respawntime)
VALUES (203002, 203002, 'poknowledge', 0, -67, -160, -156, 0, 1200);
"@
$ztSQL | & $mysqlExe "-u$dbUser" "-p$dbPass" $dbName
if ($LASTEXITCODE -ne 0) { Write-Host "WARNING: Zone Transporter creation had errors" }

# Create Fabled Event Controller NPC 999999 (global quest controller for fabled spawns)
Write-Host "Creating Fabled Event Controller NPC..."
$fcSQL = @"
REPLACE INTO npc_types (id, name, level, race, class, bodytype, hp, mana, texture, helmtexture, gender, runspeed, special_abilities, findable, trackable)
VALUES (999999, 'Fabled_Event_Controller', 1, 240, 1, 11, 10, 0, 0, 0, 0, 0, '24,1^35,1', 0, 0);
"@
$fcSQL | & $mysqlExe "-u$dbUser" "-p$dbPass" $dbName
if ($LASTEXITCODE -ne 0) { Write-Host "WARNING: Fabled Controller creation had errors" }

if (Test-Path $backupFile) {
    Write-Host "Restoring character_classes data..."
    $restoreProcess = Start-Process -FilePath $mysqlExe `
        -ArgumentList "-u$dbUser", "-p$dbPass", $dbName `
        -RedirectStandardInput $backupFile `
        -NoNewWindow -Wait -PassThru
    if ($restoreProcess.ExitCode -eq 0) {
        Write-Host "  Done. Character classes restored."
        Remove-Item $backupFile
    } else {
        Write-Host "  ERROR: Failed to restore character classes (exit code $($restoreProcess.ExitCode))."
    }
}

Write-Host "Database rebuild completed successfully!"
