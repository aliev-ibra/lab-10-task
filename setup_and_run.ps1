$ErrorActionPreference = "Stop"

$toolsDir = Join-Path $PSScriptRoot "tools"
if (!(Test-Path $toolsDir)) { New-Item -ItemType Directory -Path $toolsDir | Out-Null }

# --- Maven Setup ---
$mavenVersion = "3.9.12"
$mavenDirName = "apache-maven-$mavenVersion"
$mavenDir = Join-Path $toolsDir $mavenDirName
$mavenZip = Join-Path $toolsDir "maven.zip"
$mavenUrl = "https://dlcdn.apache.org/maven/maven-3/$mavenVersion/binaries/apache-maven-$mavenVersion-bin.zip"

if (!(Test-Path $mavenDir)) {
    Write-Host "Downloading Maven $mavenVersion..."
    Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip
    Write-Host "Extracting Maven..."
    Expand-Archive -Path $mavenZip -DestinationPath $toolsDir -Force
    Remove-Item $mavenZip -ErrorAction SilentlyContinue
}

# --- JDK Setup ---
$jdkUrl = "https://api.adoptium.net/v3/binary/latest/21/ga/windows/x64/jdk/hotspot/normal/eclipse?project=jdk"
$jdkZip = Join-Path $toolsDir "jdk.zip"

# Check if JDK is already extracted
$existingJdk = Get-ChildItem $toolsDir -Directory -Filter "jdk-*" | Select-Object -First 1

if (-not $existingJdk) {
    if (!(Test-Path $jdkZip) -or (Get-Item $jdkZip).Length -lt 1000000) {
        Write-Host "Downloading OpenJDK 21..."
        Invoke-WebRequest -Uri $jdkUrl -OutFile $jdkZip
    }
    
    Write-Host "Extracting JDK (this may take a moment)..."
    Expand-Archive -Path $jdkZip -DestinationPath $toolsDir -Force
    
    # Verify extraction
    $existingJdk = Get-ChildItem $toolsDir -Directory -Filter "jdk-*" | Select-Object -First 1
    if (-not $existingJdk) {
        Write-Error "JDK extraction failed. Please check $jdkZip"
    }
}

Write-Host "Tools are set up."
Write-Host "JDK: $($existingJdk.FullName)"
Write-Host "Maven: $mavenDir"

# --- Run Application ---
Write-Host "`nUse 'mvnw.cmd' to run commands in the future."
Write-Host "Example: .\mvnw.cmd clean spring-boot:run"

Write-Host "`nRunning application now..."
& "$PSScriptRoot\mvnw.cmd" clean spring-boot:run