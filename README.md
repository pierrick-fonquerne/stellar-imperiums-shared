# Stellar Imperiums — Ressources transverses

Ressources communes au projet **Stellar Imperiums**, jeu de gestion de colonie spatiale en navigateur développé par **Synarion Entertainments**.

Ce dépôt centralise l'ensemble des éléments transverses aux composants applicatifs : documentation, scripts de base de données et configuration d'infrastructure.

## Dépôts du projet

| Rôle | Dépôt |
|---|---|
| Backend API (.NET 10 + PostgreSQL + MongoDB) | [stellar-imperiums-api](https://github.com/pierrick-fonquerne/generium-api) |
| Frontend (React 19 + TypeScript + Vite) | [stellar-imperiums-frontend](https://github.com/pierrick-fonquerne/stellar-imperiums-frontend) |
| **Ressources transverses (ce dépôt)** | [stellar-imperiums-shared](https://github.com/pierrick-fonquerne/stellar-imperiums-shared) |

## Structure

```
stellar-imperiums-shared/
├── docs/            Documentation du dossier professionnel (PDF + annexes)
├── database/        Scripts SQL de création et de peuplement + init MongoDB
└── infra/           Configuration Docker Compose et Railway
```

### `docs/`

Livrables attendus par l'énoncé :

- `charte-graphique.pdf` — Identité visuelle, palette, typographie, composants, maquettes.
- `manuel-utilisation.pdf` — Présentation de l'application et parcours utilisateurs.
- `documentation-technique.pdf` — Architecture, réflexions technologiques, MCD, diagrammes.
- `dossier-deploiement.pdf` — Procédure de déploiement local et production.
- `gestion-projet.pdf` — Méthodologie, outillage et pilotage.
- `annexes/` — Diagrammes UML, MCD, MLD, cas d'utilisation, diagrammes de séquence.

### `database/`

- `sql/01-schema.sql` — Création des tables PostgreSQL (utilisateur, planete, batiment, recherche, file_construction).
- `sql/02-seed.sql` — Données de référence (compte administrateur, bâtiments et technologies initiaux).
- `sql/03-fixtures.sql` — Jeu de données de test.
- `mongodb/init-logs.js` — Initialisation de la collection `logs_activite`.

### `infra/`

- `docker-compose.yml` — Stack complète pour développement local (PostgreSQL + MongoDB + API + Frontend).
- `railway/` — Fichiers de configuration pour le déploiement Railway.
- `.env.example` — Variables d'environnement nécessaires.

## Démarrage local

Se référer au `README.md` de chaque dépôt applicatif pour la procédure complète. La stack locale est orchestrée depuis ce dépôt via :

```bash
cd infra
docker compose up -d
```

## Licence

Les ressources de ce dépôt sont diffusées sous licence MIT.
