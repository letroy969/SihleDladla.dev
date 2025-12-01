# PowerShell Script to Copy Fly.io Files to AI-Cybersecurity_honeypot Repository
# Run this from the SihleDladla.dev directory

Write-Host "🚀 Copying Fly.io deployment files to AI-Cybersecurity_honeypot repository..." -ForegroundColor Cyan

# Get current directory
$currentDir = Get-Location
$portfolioDir = $currentDir.Path

# Ask for honeypot repo path
Write-Host "`nPlease enter the path to your AI-Cybersecurity_honeypot repository:" -ForegroundColor Yellow
Write-Host "Example: C:\projects21\AI-Cybersecurity_honeypot" -ForegroundColor Gray
$honeypotPath = Read-Host "Path"

# Check if path exists
if (-not (Test-Path $honeypotPath)) {
    Write-Host "❌ Path does not exist: $honeypotPath" -ForegroundColor Red
    Write-Host "Please check the path and try again." -ForegroundColor Yellow
    exit 1
}

Write-Host "`n✅ Found repository at: $honeypotPath" -ForegroundColor Green

# Files to copy
$filesToCopy = @(
    "fly.toml",
    "fly.backend.toml",
    "fly.frontend.toml",
    "FLY_DEPLOYMENT.md",
    ".dockerignore",
    "Dockerfile.fly"
)

# Copy files
$copiedCount = 0
foreach ($file in $filesToCopy) {
    $sourceFile = Join-Path $portfolioDir $file
    $destFile = Join-Path $honeypotPath $file
    
    if (Test-Path $sourceFile) {
        try {
            Copy-Item -Path $sourceFile -Destination $destFile -Force
            Write-Host "✅ Copied: $file" -ForegroundColor Green
            $copiedCount++
        }
        catch {
            Write-Host "❌ Failed to copy: $file - $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "⚠️  File not found: $file" -ForegroundColor Yellow
    }
}

Write-Host "`n✨ Successfully copied $copiedCount files!" -ForegroundColor Cyan
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Navigate to: $honeypotPath" -ForegroundColor White
Write-Host "2. Review the files and customize if needed" -ForegroundColor White
Write-Host "3. Commit to git: git add fly*.toml FLY_DEPLOYMENT.md .dockerignore Dockerfile.fly" -ForegroundColor White
Write-Host "4. Follow FLY_DEPLOYMENT.md for deployment instructions" -ForegroundColor White



