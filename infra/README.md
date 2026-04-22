# Infra — Stellar Imperiums

Configuration d'infrastructure pour le développement local et le déploiement.

## Développement local (Docker Compose)

```bash
cp .env.example .env
docker compose up -d
```

Services :

| Service | Port | URL |
|---|---|---|
| PostgreSQL | 5432 | `postgresql://postgres:postgres@localhost:5432/stellar_imperiums` |
| MongoDB | 27017 | `mongodb://localhost:27017/stellar_imperiums` |
| API | 8080 | `http://localhost:8080` |
| Frontend | 5173 | `http://localhost:5173` |

## Déploiement Railway (`railway/`)

La configuration est versionnée dans `railway/railway.json`. Le déploiement est déclenché automatiquement à chaque push sur la branche `main` des dépôts applicatifs.
