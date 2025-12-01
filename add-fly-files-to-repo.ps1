# Non-interactive script to add Fly.io files to AI-Cybersecurity_honeypot repo
# This will clone the repo if needed, then copy the files

$currentDir = Get-Location
$portfolioDir = $currentDir.Path
$parentDir = Split-Path $portfolioDir -Parent
$honeypotPath = Join-Path $parentDir "AI-Cybersecurity_honeypot"

Write-Host "🚀 Adding Fly.io deployment files to AI-Cybersecurity_honeypot..." -ForegroundColor Cyan

# Clone repository if it doesn't exist
if (-not (Test-Path $honeypotPath)) {
    Write-Host "📥 Cloning repository..." -ForegroundColor Yellow
    Set-Location $parentDir
    git clone https://github.com/letroy969/AI-Cybersecurity_honeypot.git
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to clone repository" -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Repository cloned!" -ForegroundColor Green
}

# Copy files
$files = @("fly.toml", "fly.backend.toml", "fly.frontend.toml", "FLY_DEPLOYMENT.md", ".dockerignore", "Dockerfile.fly")
$copied = 0

foreach ($file in $files) {
    $src = Join-Path $portfolioDir $file
    $dst = Join-Path $honeypotPath $file
    if (Test-Path $src) {
        Copy-Item $src $dst -Force
        Write-Host "✅ Copied: $file" -ForegroundColor Green
        $copied++
    }
}

Write-Host "`n✨ Copied $copied files to $honeypotPath" -ForegroundColor Cyan
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "  cd $honeypotPath" -ForegroundColor White
Write-Host "  git add fly*.toml FLY_DEPLOYMENT.md .dockerignore Dockerfile.fly" -ForegroundColor White
Write-Host "  git commit -m 'Add Fly.io deployment configuration'" -ForegroundColor White
Write-Host "  git push origin main" -ForegroundColor White

