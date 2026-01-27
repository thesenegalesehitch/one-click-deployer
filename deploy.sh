#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}Starting 1-Click Deployer...${NC}"

# 1. Check dependencies
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed.${NC}"
    exit 1
fi

if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: gh (GitHub CLI) is not installed.${NC}"
    exit 1
fi

if ! gh auth status &> /dev/null; then
    echo -e "${RED}Error: gh is not authenticated. Run 'gh auth login'.${NC}"
    exit 1
fi

# 2. Check/Init Git
if [ ! -d ".git" ]; then
    echo "Initializing Git repository..."
    git init
else
    echo "Git repository already initialized."
fi

# 3. Generate .gitignore
if [ ! -f ".gitignore" ]; then
    echo "Generating universal .gitignore..."
    cat <<EOF > .gitignore
# General
.DS_Store
*.log
node_modules/
dist/
build/
.env
__pycache__/
*.pyc
venv/
bin/
obj/
EOF
    echo ".gitignore created."
fi

# 4. Create Remote Repo
PROJECT_NAME=$(basename "$PWD")
echo "Creating GitHub repository: $PROJECT_NAME"

# Check if repo exists
if gh repo view "$PROJECT_NAME" &> /dev/null; then
    echo "Repository already exists."
else
    # Default to private, can be changed
    gh repo create "$PROJECT_NAME" --private --source=. --remote=origin --push
    echo -e "${GREEN}Repository created successfully!${NC}"
    echo "View it at: https://github.com/$(gh api user -q .login)/$PROJECT_NAME"
fi

# 5. Success
echo -e "${GREEN}Deployment Complete!${NC}"
echo "Your code is now on GitHub."
