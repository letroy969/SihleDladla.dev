# PowerShell Script to Clone Repository and Add Fly.io Files
# Run this from the SihleDladla.dev directory

Write-Host "🚀 Setting up Fly.io deployment for AI-Cybersecurity_honeypot..." -ForegroundColor Cyan

# Get current directory
$currentDir = Get-Location
$portfolioDir = $currentDir.Path
$parentDir = Split-Path $portfolioDir -Parent
$honeypotPath = Join-Path $parentDir "AI-Cybersecurity_honeypot"

Write-Host "`nCurrent directory: $portfolioDir" -ForegroundColor Gray
Write-Host "Target repository: $honeypotPath" -ForegroundColor Gray

# Check if repository exists
if (Test-Path $honeypotPath) {
    Write-Host "`n✅ Repository found at: $honeypotPath" -ForegroundColor Green
} else {
    Write-Host "`n⚠️  Repository not found locally." -ForegroundColor Yellow
    Write-Host "Would you like to clone it? (Y/N)" -ForegroundColor Yellow
    $clone = Read-Host
    
    if ($clone -eq "Y" -or $clone -eq "y") {
        Write-Host "`n📥 Cloning repository..." -ForegroundColor Cyan
        Set-Location $parentDir
        git clone https://github.com/letroy969/AI-Cybersecurity_honeypot.git
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Repository cloned successfully!" -ForegroundColor Green
        } else {
            Write-Host "❌ Failed to clone repository. Please clone manually." -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "`nPlease clone the repository manually:" -ForegroundColor Yellow
        Write-Host "git clone https://github.com/letroy969/AI-Cybersecurity_honeypot.git" -ForegroundColor White
        Write-Host "`nThen run this script again." -ForegroundColor Yellow
        exit 0
    }
}

# Verify repository exists
if (-not (Test-Path $honeypotPath)) {
    Write-Host "❌ Repository path not found: $honeypotPath" -ForegroundColor Red
    exit 1
}

# Files to copy
$filesToCopy = @(
    @{Source = "fly.toml"; Dest = "fly.toml"},
    @{Source = "fly.backend.toml"; Dest = "fly.backend.toml"},
    @{Source = "fly.frontend.toml"; Dest = "fly.frontend.toml"},
    @{Source = "FLY_DEPLOYMENT.md"; Dest = "FLY_DEPLOYMENT.md"},
    @{Source = ".dockerignore"; Dest = ".dockerignore"},
    @{Source = "Dockerfile.fly"; Dest = "Dockerfile.fly"}
)

Write-Host "`n📋 Copying Fly.io deployment files..." -ForegroundColor Cyan

# Copy files
$copiedCount = 0
foreach ($file in $filesToCopy) {
    $sourceFile = Join-Path $portfolioDir $file.Source
    $destFile = Join-Path $honeypotPath $file.Dest
    
    if (Test-Path $sourceFile) {
        try {
            Copy-Item -Path $sourceFile -Destination $destFile -Force
            Write-Host "  ✅ $($file.Dest)" -ForegroundColor Green
            $copiedCount++
        }
        catch {
            Write-Host "  ❌ Failed to copy $($file.Dest): $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "  ⚠️  File not found: $($file.Source)" -ForegroundColor Yellow
    }
}

Write-Host "`n✨ Successfully copied $copiedCount files!" -ForegroundColor Cyan

# Navigate to repository
Set-Location $honeypotPath

Write-Host "`n📝 Files added to repository:" -ForegroundColor Yellow
Get-ChildItem fly*.toml, FLY_DEPLOYMENT.md, .dockerignore, Dockerfile.fly -ErrorAction SilentlyContinue | Select-Object Name

Write-Host "`n🎯 Next steps:" -ForegroundColor Cyan
Write-Host "1. Review the files and customize if needed" -ForegroundColor White
Write-Host "2. Commit to git:" -ForegroundColor White
Write-Host "   git add fly*.toml FLY_DEPLOYMENT.md .dockerignore Dockerfile.fly" -ForegroundColor Gray
Write-Host "   git commit -m 'Add Fly.io deployment configuration'" -ForegroundColor Gray
Write-Host "   git push origin main" -ForegroundColor Gray
Write-Host "3. Follow FLY_DEPLOYMENT.md for deployment instructions" -ForegroundColor White

Write-Host "`n✅ Setup complete!" -ForegroundColor Green



