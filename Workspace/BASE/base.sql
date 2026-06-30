CREATE DATABASE kopv;
-- ============================================================
-- Schéma PostgreSQL — Module Chauffeur
-- Périmètre : Mes voyages, Signaler une panne, Signaler arrivée
-- Pas de SIG (pas de type GEOMETRY), pas de point kilométrique
-- ============================================================

-- ============================================================
-- Référentiels de base
-- ============================================================

CREATE TABLE role (
    id          SERIAL PRIMARY KEY,
    libelle     VARCHAR(50) NOT NULL UNIQUE  -- admin, guichet, chauffeur, RH, RE
);

CREATE TABLE utilisateurs (
    id              SERIAL PRIMARY KEY,
    nom             VARCHAR(100) NOT NULL,
    prenom          VARCHAR(100) NOT NULL,
    id_role         INTEGER NOT NULL REFERENCES role(id),
    email           VARCHAR(150) NOT NULL UNIQUE,
    mot_de_passe    VARCHAR(255) NOT NULL
);

CREATE TABLE categorie_vehicule (
    id          SERIAL PRIMARY KEY,
    libelle     VARCHAR(50) NOT NULL UNIQUE  -- VIP, Premium, Standard
);

CREATE TABLE vehicules (
    id                  SERIAL PRIMARY KEY,
    immatriculation     VARCHAR(20) NOT NULL UNIQUE,
    modele              VARCHAR(100) NOT NULL,
    id_categorie        INTEGER NOT NULL REFERENCES categorie_vehicule(id),
    nombre_places       INTEGER NOT NULL CHECK (nombre_places > 0)
);

-- ============================================================
-- Trajets et itinéraires (sans géométrie)
-- ============================================================

CREATE TABLE gares (
    id      SERIAL PRIMARY KEY,
    nom     VARCHAR(150) NOT NULL,
    ville   VARCHAR(100) NOT NULL
);

CREATE TABLE trajets (
    id                  SERIAL PRIMARY KEY,
    id_gare_depart      INTEGER NOT NULL REFERENCES gares(id),
    id_gare_arrivee     INTEGER NOT NULL REFERENCES gares(id),
    distance_km         NUMERIC(10,2) NOT NULL CHECK (distance_km >= 0),
    CONSTRAINT chk_gares_differentes CHECK (id_gare_depart <> id_gare_arrivee)
);

CREATE TABLE point_ramassage (
    id      SERIAL PRIMARY KEY,
    nom     VARCHAR(150) NOT NULL
);

CREATE TABLE trajet_etapes (
    id                              SERIAL PRIMARY KEY,
    id_trajet                       INTEGER NOT NULL REFERENCES trajets(id),
    id_point_ramassage              INTEGER NOT NULL REFERENCES point_ramassage(id),
    ordre                           INTEGER NOT NULL CHECK (ordre > 0),
    duree_depuis_depart_minute      INTEGER NOT NULL CHECK (duree_depuis_depart_minute >= 0),
    CONSTRAINT uq_trajet_ordre UNIQUE (id_trajet, ordre)
);

-- ============================================================
-- Voyages
-- ============================================================

CREATE TABLE statut_voyage (
    id          SERIAL PRIMARY KEY,
    libelle     VARCHAR(50) NOT NULL UNIQUE  -- en cours, planifié, terminé, en panne
);

CREATE TABLE voyages (
    id                          SERIAL PRIMARY KEY,
    id_trajet                   INTEGER NOT NULL REFERENCES trajets(id),
    id_vehicule                 INTEGER NOT NULL REFERENCES vehicules(id),
    id_chauffeur                INTEGER NOT NULL REFERENCES utilisateurs(id),
    date_heure_depart           TIMESTAMP NOT NULL,
    duree_estimee_minutes       INTEGER NOT NULL CHECK (duree_estimee_minutes > 0),
    tarif                       NUMERIC(10,2) NOT NULL CHECK (tarif >= 0)
);

CREATE TABLE voyage_statut (
    id                  SERIAL PRIMARY KEY,
    id_voyage           INTEGER NOT NULL REFERENCES voyages(id),
    id_statut           INTEGER NOT NULL REFERENCES statut_voyage(id),
    date_modification   TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX idx_voyage_statut_voyage ON voyage_statut(id_voyage);
CREATE INDEX idx_voyages_chauffeur ON voyages(id_chauffeur);

-- ============================================================
-- Pannes
-- ============================================================

CREATE TABLE motif_panne (
    id          SERIAL PRIMARY KEY,
    libelle     VARCHAR(50) NOT NULL UNIQUE  -- mécanique, électrique, pneu, autre
);

CREATE TABLE pannes (
    id                  SERIAL PRIMARY KEY,
    id_voyage           INTEGER NOT NULL REFERENCES voyages(id),
    id_chauffeur        INTEGER NOT NULL REFERENCES utilisateurs(id),
    date_signalement    TIMESTAMP NOT NULL DEFAULT now(),
    lieu                VARCHAR(255) NOT NULL,
    id_motif_panne      INTEGER NOT NULL REFERENCES motif_panne(id),
    description         TEXT,
    photo_url           VARCHAR(500)
);

CREATE INDEX idx_pannes_voyage ON pannes(id_voyage);

CREATE TABLE statut_reparation (
    id          SERIAL PRIMARY KEY,
    libelle     VARCHAR(50) NOT NULL UNIQUE  -- en attente, en cours de dépannage, résolu
);

CREATE TABLE reparation (
    id                      SERIAL PRIMARY KEY,
    id_panne                INTEGER NOT NULL REFERENCES pannes(id),
    id_statut_reparation    INTEGER NOT NULL REFERENCES statut_reparation(id),
    date_modification       TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX idx_reparation_panne ON reparation(id_panne);

-- ============================================================
-- Données de référence (seed minimal pour démarrer)
-- ============================================================

INSERT INTO role (libelle) VALUES
    ('admin'), ('guichet'), ('chauffeur'), ('RH'), ('RE');

INSERT INTO statut_voyage (libelle) VALUES
    ('planifié'), ('en cours'), ('terminé'), ('en panne');

INSERT INTO motif_panne (libelle) VALUES
    ('mécanique'), ('électrique'), ('pneu'), ('autre');

INSERT INTO statut_reparation (libelle) VALUES
    ('en attente'), ('en cours de dépannage'), ('résolu');