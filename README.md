# The 1-Click Deployer

A Bash script to instantly initialize a Git repository and deploy it to a new private GitHub repository.

## Prerequisites

- **Git**: Installed and configured.
- **GitHub CLI (`gh`)**: Installed and authenticated (`gh auth login`).

## Features

- **Automated Init**: Initializes Git if not present.
- **Smart Gitignore**: Generates a universal `.gitignore` for common languages.
- **Instant Deployment**: Creates a private GitHub repository and pushes the code in one command.

## Usage

1.  Make the script executable:
    ```bash
    chmod +x deploy.sh
    ```
2.  Run inside your project directory:
    ```bash
    ./deploy.sh
    ```

## License

Copyright (c) 27 Janvier 2026 - Antigravity
See [LICENSE](LICENSE) for details.
