$ErrorActionPreference = "Stop"

$dbName = "peq"
$dbUser = "root"
$dbPass = "1"
$dbHost = "127.0.0.1"
$dbPort = "3306"
$mysqlExe = "C:\Program Files\MariaDB 10.11\bin\mysql.exe"

$sqlDir = "D:\app ideas\MentalBreak\peqsourcecode-main\utils\sql\svn"
if (-not (Test-Path $sqlDir)) {
    $sqlDir = "D:\app ideas\MentalBreak\peqsourcecode-main\utils\sql"
}
if (-not (Test-Path $sqlDir)) {
    $sqlDir = "D:\app ideas\MentalBreak\peqsourcecode-main"
}

$sqlFiles = Get-ChildItem -Path $sqlDir -Filter *.sql -Recurse | Where-Object { $_.Length -gt 0 } | Sort-Object Name

$batchSize = 50
$batchCount = 0
$totalFiles = $sqlFiles.Count

Write-Host "Found $totalFiles SQL files to source from $sqlDir"

for ($i = 0; $i -lt $totalFiles; $i += $batchSize) {
    $batchCount++
    $end = [Math]::Min($i + $batchSize, $totalFiles)
    $batch = $sqlFiles[$i..($end - 1)]
    Write-Host "Executing batch $batchCount ($($batch.Count) files, $($i+1)-$end of $totalFiles)..."

    # Concatenate all SQL file contents into a single temp file
    $tempSql = "D:\app ideas\MentalBreak\source_batch.sql"
    $content = ""
    foreach ($f in $batch) {
        $content += Get-Content $f.FullName -Raw -ErrorAction SilentlyContinue
        $content += "`n"
    }
    [System.IO.File]::WriteAllText($tempSql, $content)

    # Pipe the concatenated SQL to mysql
    $process = Start-Process -FilePath $mysqlExe `
        -ArgumentList "-u$dbUser", "-p$dbPass", "-h$dbHost", "-P$dbPort", $dbName `
        -RedirectStandardInput $tempSql `
        -NoNewWindow -Wait -PassThru

    if ($process.ExitCode -ne 0) {
        Write-Host "Warning: Batch $batchCount exited with code $($process.ExitCode)"
    }

    Start-Sleep -Seconds 1
}

Write-Host "Database sourcing complete."
