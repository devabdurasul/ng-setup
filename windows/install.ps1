$ErrorActionPreference = "Continue"

Write-Host "Angular & Node.js Installer" -ForegroundColor Cyan
Write-Host "------------------------------------------`n"

if (Get-Command node -ErrorAction SilentlyContinue) {
    Write-Host "Node.js already installed (Version: $(node -v))" -ForegroundColor Green
} else {
    Write-Host "Installing Node.js (latest v20 LTS)..." -ForegroundColor Yellow

    try {
        $indexHtml = Invoke-WebRequest -Uri "https://nodejs.org/download/release/latest-v20.x/"

        if ($indexHtml.Content -match 'node-v20\.[\d\.]+-x64\.msi') {
            $msiName = $Matches[0]
            $url = "https://nodejs.org/download/release/latest-v20.x/$msiName"

            Write-Host "Downloading $msiName ..." -ForegroundColor Yellow
            Invoke-WebRequest $url -OutFile $msiName -UseBasicParsing

            Write-Host "Installing $msiName ..." -ForegroundColor Yellow
            Start-Process msiexec.exe -Wait -ArgumentList "/I $msiName /passive"

            Write-Host "Cleaning up..." -ForegroundColor Yellow
            Remove-Item $msiName
        } else {
            Write-Host "Could not locate Node.js installer in latest-v20.x directory." -ForegroundColor Red
            pause
            exit 1
        }
    } catch {
        Write-Host "Error installing Node.js: $_" -ForegroundColor Red
        pause
        exit 1
    }
}

if (!(Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "npm was not installed correctly. Please restart PowerShell and re-run this script." -ForegroundColor Red
    pause
    exit 1
}

if (Get-Command ng -ErrorAction SilentlyContinue) {
    Write-Host "Angular CLI already installed (Version: $(ng version | Select-String 'Angular CLI').ToString())" -ForegroundColor Green
} else {
    Write-Host "Installing Angular CLI v20 ..." -ForegroundColor Yellow
    try {
        npm install -g @angular/cli@20
    } catch {
        Write-Host "Error installing Angular CLI: $_" -ForegroundColor Red
        pause
        exit 1
    }
}

Write-Host "`n Installation complete!" -ForegroundColor Green
Write-Host "   Node.js: $(node -v)"
Write-Host "   npm:     $(npm -v)"
Write-Host "   Angular: $(ng version | Select-String 'Angular CLI')" -ForegroundColor Cyan
Write-Host "`nYou can now run: ng new my-app" -ForegroundColor Magenta

pause
