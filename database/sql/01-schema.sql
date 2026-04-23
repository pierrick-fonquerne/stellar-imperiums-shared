DROP TABLE IF EXISTS file_construction    CASCADE;
DROP TABLE IF EXISTS recherche            CASCADE;
DROP TABLE IF EXISTS batiment             CASCADE;
DROP TABLE IF EXISTS planete              CASCADE;
DROP TABLE IF EXISTS utilisateur          CASCADE;
DROP TABLE IF EXISTS recherche_definition CASCADE;
DROP TABLE IF EXISTS batiment_definition  CASCADE;


CREATE TABLE batiment_definition (
    id_batiment_definition  SERIAL         PRIMARY KEY,
    code                    VARCHAR(50)    NOT NULL UNIQUE,
    nom                     VARCHAR(100)   NOT NULL,
    description             TEXT           NOT NULL,
    type_production         VARCHAR(20)    NOT NULL,
    base_cout_metal         INTEGER        NOT NULL,
    base_cout_cristal       INTEGER        NOT NULL,
    base_cout_energie       INTEGER        NOT NULL,
    base_production_horaire INTEGER            NULL,
    base_capacite_stockage  INTEGER            NULL,
    base_duree_secondes     INTEGER        NOT NULL,
    multiplicateur_cout     NUMERIC(4, 2)  NOT NULL DEFAULT 1.50,
    multiplicateur_duree    NUMERIC(4, 2)  NOT NULL DEFAULT 1.40,

    CONSTRAINT ck_batiment_definition_type
        CHECK (type_production IN ('metal', 'cristal', 'energie',
                                   'stockage_metal_cristal', 'stockage_energie')),
    CONSTRAINT ck_batiment_definition_couts_positifs
        CHECK (base_cout_metal    >= 0
           AND base_cout_cristal  >= 0
           AND base_cout_energie  >= 0),
    CONSTRAINT ck_batiment_definition_duree_positive
        CHECK (base_duree_secondes > 0),
    CONSTRAINT ck_batiment_definition_production_ou_stockage
        CHECK ((base_production_horaire IS NOT NULL AND base_capacite_stockage IS     NULL)
            OR (base_production_horaire IS     NULL AND base_capacite_stockage IS NOT NULL))
);


CREATE TABLE recherche_definition (
    id_recherche_definition SERIAL         PRIMARY KEY,
    code                    VARCHAR(50)    NOT NULL UNIQUE,
    nom                     VARCHAR(100)   NOT NULL,
    description             TEXT           NOT NULL,
    type_bonus              VARCHAR(30)    NOT NULL,
    bonus_par_niveau        NUMERIC(5, 4)  NOT NULL,
    base_cout_metal         INTEGER        NOT NULL,
    base_cout_cristal       INTEGER        NOT NULL,
    base_cout_energie       INTEGER        NOT NULL,
    base_duree_secondes     INTEGER        NOT NULL,
    multiplicateur_cout     NUMERIC(4, 2)  NOT NULL DEFAULT 2.00,
    multiplicateur_duree    NUMERIC(4, 2)  NOT NULL DEFAULT 1.80,

    CONSTRAINT ck_recherche_definition_type
        CHECK (type_bonus IN ('production_metal', 'production_cristal',
                              'production_energie', 'capacite_stockage')),
    CONSTRAINT ck_recherche_definition_bonus_positif
        CHECK (bonus_par_niveau > 0),
    CONSTRAINT ck_recherche_definition_couts_positifs
        CHECK (base_cout_metal    >= 0
           AND base_cout_cristal  >= 0
           AND base_cout_energie  >= 0),
    CONSTRAINT ck_recherche_definition_duree_positive
        CHECK (base_duree_secondes > 0)
);


CREATE TABLE utilisateur (
    id_utilisateur          SERIAL         PRIMARY KEY,
    pseudo                  VARCHAR(50)    NOT NULL UNIQUE,
    mail                    VARCHAR(100)   NOT NULL UNIQUE,
    mot_de_passe            VARCHAR(255)   NOT NULL,
    suspendu                BOOLEAN        NOT NULL DEFAULT FALSE,
    necessaire_a_modifier   BOOLEAN        NOT NULL DEFAULT FALSE,
    role                    VARCHAR(20)    NOT NULL DEFAULT 'joueur',
    date_inscription        TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    derniere_connexion      TIMESTAMPTZ        NULL,
    reset_token             VARCHAR(255)       NULL,
    reset_token_expire_le   TIMESTAMPTZ        NULL,

    CONSTRAINT ck_utilisateur_role
        CHECK (role IN ('joueur', 'admin')),
    CONSTRAINT ck_utilisateur_pseudo_longueur
        CHECK (LENGTH(pseudo) >= 3),
    CONSTRAINT ck_utilisateur_mail_format
        CHECK (mail ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT ck_utilisateur_reset_token_expire
        CHECK ((reset_token IS     NULL AND reset_token_expire_le IS     NULL)
            OR (reset_token IS NOT NULL AND reset_token_expire_le IS NOT NULL))
);

CREATE        INDEX idx_utilisateur_role             ON utilisateur (role);
CREATE        INDEX idx_utilisateur_date_inscription ON utilisateur (date_inscription DESC);
CREATE UNIQUE INDEX idx_utilisateur_reset_token      ON utilisateur (reset_token)
    WHERE reset_token IS NOT NULL;


CREATE TABLE planete (
    id_planete              SERIAL         PRIMARY KEY,
    nom                     VARCHAR(50)    NOT NULL,
    id_utilisateur          INTEGER        NOT NULL UNIQUE,
    metal                   NUMERIC(18, 4) NOT NULL DEFAULT 500,
    cristal                 NUMERIC(18, 4) NOT NULL DEFAULT 300,
    energie                 NUMERIC(18, 4) NOT NULL DEFAULT 200,
    derniere_mise_a_jour    TIMESTAMPTZ    NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_planete_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES utilisateur (id_utilisateur)
        ON DELETE CASCADE,
    CONSTRAINT ck_planete_ressources_positives
        CHECK (metal >= 0 AND cristal >= 0 AND energie >= 0),
    CONSTRAINT ck_planete_nom_longueur
        CHECK (LENGTH(nom) >= 1)
);


CREATE TABLE batiment (
    id_batiment             SERIAL         PRIMARY KEY,
    id_planete              INTEGER        NOT NULL,
    id_batiment_definition  INTEGER        NOT NULL,
    niveau                  INTEGER        NOT NULL DEFAULT 1,

    CONSTRAINT fk_batiment_planete
        FOREIGN KEY (id_planete)
        REFERENCES planete (id_planete)
        ON DELETE CASCADE,
    CONSTRAINT fk_batiment_definition
        FOREIGN KEY (id_batiment_definition)
        REFERENCES batiment_definition (id_batiment_definition)
        ON DELETE RESTRICT,
    CONSTRAINT uq_batiment_planete_definition
        UNIQUE (id_planete, id_batiment_definition),
    CONSTRAINT ck_batiment_niveau_positif
        CHECK (niveau >= 1)
);

CREATE INDEX idx_batiment_planete    ON batiment (id_planete);
CREATE INDEX idx_batiment_definition ON batiment (id_batiment_definition);


CREATE TABLE recherche (
    id_recherche            SERIAL         PRIMARY KEY,
    id_utilisateur          INTEGER        NOT NULL,
    id_recherche_definition INTEGER        NOT NULL,
    niveau                  INTEGER        NOT NULL DEFAULT 1,

    CONSTRAINT fk_recherche_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES utilisateur (id_utilisateur)
        ON DELETE CASCADE,
    CONSTRAINT fk_recherche_definition
        FOREIGN KEY (id_recherche_definition)
        REFERENCES recherche_definition (id_recherche_definition)
        ON DELETE RESTRICT,
    CONSTRAINT uq_recherche_utilisateur_definition
        UNIQUE (id_utilisateur, id_recherche_definition),
    CONSTRAINT ck_recherche_niveau_positif
        CHECK (niveau >= 1)
);

CREATE INDEX idx_recherche_utilisateur ON recherche (id_utilisateur);
CREATE INDEX idx_recherche_definition  ON recherche (id_recherche_definition);


CREATE TABLE file_construction (
    id_construction         SERIAL         PRIMARY KEY,
    id_planete              INTEGER        NOT NULL,
    type_element            VARCHAR(20)    NOT NULL,
    type_action             VARCHAR(20)    NOT NULL DEFAULT 'amelioration',
    niveau_cible            INTEGER        NOT NULL,
    date_debut              TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    date_fin                TIMESTAMPTZ    NOT NULL,

    CONSTRAINT fk_file_construction_planete
        FOREIGN KEY (id_planete)
        REFERENCES planete (id_planete)
        ON DELETE CASCADE,
    CONSTRAINT ck_file_construction_type_element
        CHECK (type_element IN ('batiment', 'recherche')),
    CONSTRAINT ck_file_construction_type_action
        CHECK (type_action IN ('amelioration')),
    CONSTRAINT ck_file_construction_niveau_cible_positif
        CHECK (niveau_cible >= 1),
    CONSTRAINT ck_file_construction_dates_coherentes
        CHECK (date_fin > date_debut)
);

CREATE UNIQUE INDEX idx_file_construction_batiment_unique
    ON file_construction (id_planete)
    WHERE type_element = 'batiment';

CREATE UNIQUE INDEX idx_file_construction_recherche_unique
    ON file_construction (id_planete)
    WHERE type_element = 'recherche';

CREATE INDEX idx_file_construction_date_fin ON file_construction (date_fin);
