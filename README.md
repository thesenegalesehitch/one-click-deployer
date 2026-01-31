# Le Déploiement en Un Clic

Un script Bash pour initialiser instantanément un dépôt Git et le déployer vers un nouveau dépôt GitHub privé.

## Prérequis

- **Git** : Installé et configuré.
- **GitHub CLI (`gh`)** : Installé et authentifié (`gh auth login`).

## Fonctionnalités

- **Initialisation Automatique** : Initialise Git s'il n'est pas présent.
- **Gitignore Intelligent** : Génère un `.gitignore` universel pour les langages courants.
- **Déploiement Instantané** : Crée un dépôt GitHub privé et pousse le code en une seule commande.

## Utilisation

1.  Rendez le script exécutable :
    ```bash
    chmod +x deploy.sh
    ```
2.  Exécutez dans votre répertoire de projet :
    ```bash
    ./deploy.sh
    ```

## Structure du Projet

```
one-click-deployer/
├── deploy.sh        # Script principal de déploiement
├── README.md        # Documentation
├── LICENSE          # Licence
└── tests/
    └── test_deploy.sh # Tests du script
```

## Licence

Copyright (c) 27 Janvier 2026 - Antigravity
Voir [LICENSE](LICENSE) pour plus de détails.
