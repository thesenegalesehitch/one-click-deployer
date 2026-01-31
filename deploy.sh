#!/bin/bash
# =============================================================================
# @file deploy.sh
# @description Script de déploiement en un clic vers GitHub
# 
# Ce script automatise le processus de déploiement d'un projet vers GitHub :
# 1. Vérifie les dépendances (Git, GitHub CLI)
# 2. Initialise ou vérifie le dépôt Git local
# 3. Génère un fichier .gitignore universel
# 4. Crée un dépôt GitHub privé (si inexistant)
# 5. Pousse le code vers GitHub
#
# @author Antigravity
# @version 1.0.0
# @date Janvier 2026
# =============================================================================

# Sortie en cas d'erreur (arrête le script si une commande échoue)
set -e

# -----------------------------------------------------------------------------
# Configuration des couleurs pour l'affichage dans le terminal
# -----------------------------------------------------------------------------
VERT='\033[0;32m'    # Couleur verte pour les messages de succès
ROUGE='\033[0;31m'   # Couleur rouge pour les messages d'erreur
NC='\033[0m'         # Aucune couleur (reset)

# -----------------------------------------------------------------------------
# Étape 1 : Vérification des dépendances
# -----------------------------------------------------------------------------

echo -e "${VERT}Démarrage du Déploiement en Un Clic...${NC}"

# Vérification de l'installation de Git
if ! command -v git &> /dev/null; then
    echo -e "${ROUGE}Erreur : Git n'est pas installé.${NC}"
    exit 1
fi

# Vérification de l'installation de GitHub CLI (gh)
if ! command -v gh &> /dev/null; then
    echo -e "${ROUGE}Erreur : gh (GitHub CLI) n'est pas installé.${NC}"
    exit 1
fi

# Vérification de l'authentification GitHub CLI
if ! gh auth status &> /dev/null; then
    echo -e "${ROUGE}Erreur : gh n'est pas authentifié. Exécutez 'gh auth login'.${NC}"
    exit 1
fi

# -----------------------------------------------------------------------------
# Étape 2 : Initialisation ou vérification du dépôt Git
# -----------------------------------------------------------------------------

# Vérification de l'existence du répertoire .git
if [ ! -d ".git" ]; then
    echo "Initialisation du dépôt Git..."
    git init
else
    echo "Dépôt Git déjà initialisé."
fi

# -----------------------------------------------------------------------------
# Étape 3 : Génération du fichier .gitignore
# -----------------------------------------------------------------------------

# Vérification de l'existence du fichier .gitignore
if [ ! -f ".gitignore" ]; then
    echo "Génération du fichier .gitignore universel..."
    
    # Création du fichier .gitignore avec les patterns courants
    cat <<EOF > .gitignore
# Fichiers système
.DS_Store

# Fichiers de log
*.log

# Node.js
node_modules/
dist/
.env

# Python
__pycache__/
*.pyc
venv/

# Builds
build/
bin/
obj/
EOF
    
    echo "Fichier .gitignore créé."
fi

# -----------------------------------------------------------------------------
# Étape 4 : Création du dépôt GitHub distant
# -----------------------------------------------------------------------------

# Extraction du nom du projet à partir du chemin courant
NOM_PROJET=$(basename "$PWD")
echo "Création du dépôt GitHub : $NOM_PROJET"

# Vérification de l'existence du dépôt distant
if gh repo view "$NOM_PROJET" &> /dev/null; then
    echo "Le dépôt existe déjà."
else
    # Création du dépôt privé et poussée du code
    # --private : dépôt privé
    # --source=. : pousse depuis le répertoire courant
    # --remote=origin : nom du remote
    # --push : pousse immédiatement après création
    gh repo create "$NOM_PROJET" --private --source=. --remote=origin --push
    echo -e "${VERTDépôt créé avec succès !${NC}"
    echo "Consultez-le à : https://github.com/$(gh api user -q .login)/$NOM_PROJET"
fi

# -----------------------------------------------------------------------------
# Étape 5 : Fin du déploiement
# -----------------------------------------------------------------------------

echo -e "${VERT}Déploiement Terminé !${NC}"
echo "Votre code est maintenant sur GitHub."
