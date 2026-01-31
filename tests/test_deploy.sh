#!/bin/bash
# =============================================================================
# @file test_deploy.sh
# @description Tests unitaires pour le script de déploiement deploy.sh
# 
# Ce fichier contient des tests basiques pour vérifier :
# - La syntaxe du script deploy.sh
# - L'existence du fichier de script
# - Les mocks des commandes git et gh
#
# @note Ces tests sont des tests de base car il est difficile de mocker
#       les commandes système dans un script bash sans modification.
#
# @author Alexandre Albert Ndour
# @version 1.0.0
# @date Janvier 2026
# =============================================================================

# -----------------------------------------------------------------------------
# Configuration des mocks pour les commandes système
# -----------------------------------------------------------------------------

# Mock de la commande git
# Simule les appels à git et affiche les arguments reçus
git() {
    echo "Appel de git avec les arguments : $@"
}

# Mock de la commande gh (GitHub CLI)
# Simule les différents comportements de gh :
# - auth : retourne succès (authentification simulée)
# - repo view : retourne erreur (dépôt inexistant simulé)
gh() {
    echo "Appel de gh avec les arguments : $@"
    
    # Simulation de la vérification d'authentification
    if [[ "$1" == "auth" ]]; then
        return 0  # Succès simulés
    # Simulation de la vérification d'existence du dépôt
    elif [[ "$1" == "repo" && "$2" == "view" ]]; then
        return 1  # Erreur : dépôt inexistant
    fi
}

# Chemin du script de déploiement à tester
SCRIPT_DEPLOY="../deploy.sh"

# -----------------------------------------------------------------------------
# Exécution des tests
# -----------------------------------------------------------------------------

echo "Exécution des tests pour deploy.sh..."

# -----------------------------------------------------------------------------
# Test 1 : Vérification de la syntaxe du script
# -----------------------------------------------------------------------------
# La commande 'bash -n' vérifie la syntaxe sans exécuter le script
# Si le script contient des erreurs de syntaxe, ce test échoue

# Vérification de la syntaxe du script deploy.sh
bash -n "$SCRIPT_DEPLOY"

# Vérification du code de retour de la commande
if [ $? -eq 0 ]; then
    echo "Vérification de la syntaxe : OK"
else
    echo "Vérification de la syntaxe : ÉCHOUÉE"
    exit 1
fi

# -----------------------------------------------------------------------------
# Test 2 : Vérification de l'existence du script
# -----------------------------------------------------------------------------

# Vérification que le fichier de script existe
if [ -f "$SCRIPT_DEPLOY" ]; then
    echo "Le script existe."
else
    echo "Le script est manquant."
    exit 1
fi

# -----------------------------------------------------------------------------
# Résumé des tests
# -----------------------------------------------------------------------------

echo "Tous les contrôles ont réussi."
