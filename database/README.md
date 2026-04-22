# Database — Stellar Imperiums

Scripts de création et de peuplement des bases de données relationnelle (PostgreSQL) et non relationnelle (MongoDB).

## PostgreSQL (`sql/`)

Ordre d'exécution :

1. `01-schema.sql` — Création des tables et contraintes.
2. `02-seed.sql` — Données de référence indispensables (compte administrateur, catalogue de bâtiments et technologies).
3. `03-fixtures.sql` — Jeu de données de test pour les parcours utilisateurs.

```bash
psql -U postgres -d stellar_imperiums -f sql/01-schema.sql
psql -U postgres -d stellar_imperiums -f sql/02-seed.sql
psql -U postgres -d stellar_imperiums -f sql/03-fixtures.sql
```

## MongoDB (`mongodb/`)

Initialisation de la collection `logs_activite` :

```bash
mongosh stellar_imperiums mongodb/init-logs.js
```
