#!/bin/bash
# Bash Script to Copy Fly.io Files to AI-Cybersecurity_honeypot Repository
# Run this from the SihleDladla.dev directory

echo "🚀 Copying Fly.io deployment files to AI-Cybersecurity_honeypot repository..."

# Get current directory
CURRENT_DIR=$(pwd)
PORTFOLIO_DIR="$CURRENT_DIR"

# Ask for honeypot repo path
echo ""
echo "Please enter the path to your AI-Cybersecurity_honeypot repository:"
echo "Example: /path/to/AI-Cybersecurity_honeypot"
read -p "Path: " HONEYPOT_PATH

# Check if path exists
if [ ! -d "$HONEYPOT_PATH" ]; then
    echo "❌ Path does not exist: $HONEYPOT_PATH"
    echo "Please check the path and try again."
    exit 1
fi

echo "✅ Found repository at: $HONEYPOT_PATH"

# Files to copy
FILES=("fly.toml" "fly.backend.toml" "fly.frontend.toml" "FLY_DEPLOYMENT.md" ".dockerignore" "Dockerfile.fly")

# Copy files
COPIED_COUNT=0
for file in "${FILES[@]}"; do
    SOURCE_FILE="$PORTFOLIO_DIR/$file"
    DEST_FILE="$HONEYPOT_PATH/$file"
    
    if [ -f "$SOURCE_FILE" ]; then
        cp "$SOURCE_FILE" "$DEST_FILE"
        echo "✅ Copied: $file"
        ((COPIED_COUNT++))
    else
        echo "⚠️  File not found: $file"
    fi
done

echo ""
echo "✨ Successfully copied $COPIED_COUNT files!"
echo ""
echo "Next steps:"
echo "1. Navigate to: $HONEYPOT_PATH"
echo "2. Review the files and customize if needed"
echo "3. Commit to git: git add fly*.toml FLY_DEPLOYMENT.md .dockerignore Dockerfile.fly"
echo "4. Follow FLY_DEPLOYMENT.md for deployment instructions"



