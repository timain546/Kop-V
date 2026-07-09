CREATE DATABASE kopv;
CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE utilisateurs (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    id_role INT NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    email VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL
);

CREATE TABLE categorie_vehicule (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE vehicules(
    id SERIAL PRIMARY KEY,
    immatriculation VARCHAR(20) NOT NULL UNIQUE,
    modele VARCHAR(50) NOT NULL,
    id_categorie INT NOT NULL REFERENCES categorie_vehicule(id) ON DELETE CASCADE,
    nombre_places INT NOT NULL,
    date_vente DATE DEFAULT NULL,
    prix FLOAT
);

CREATE TABLE gares(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE,
    ville VARCHAR(50) NOT NULL,
    position GEOMETRY(POINT, 4326) NOT NULL
);

CREATE TABLE trajets(
    id SERIAL PRIMARY KEY,
    id_gare_depart INT NOT NULL REFERENCES gares(id) ON DELETE CASCADE,
    id_gare_arrivee INT NOT NULL REFERENCES gares(id) ON DELETE CASCADE,
    distance_km NUMERIC(10, 2) NOT NULL,
    date_suppression TIMESTAMP DEFAULT NULL
);

CREATE TABLE statut_voyage(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE voyages(
    id SERIAL PRIMARY KEY,
    id_trajet INT NOT NULL REFERENCES trajets(id) ON DELETE CASCADE,
    id_vehicule INT NOT NULL REFERENCES vehicules(id) ON DELETE CASCADE,
    id_chauffeur INT NOT NULL REFERENCES utilisateurs(id) ON DELETE CASCADE,
    duree_estimee_minutes INT NOT NULL,
    tarif NUMERIC(10, 2) NOT NULL,
    date_heure_depart TIMESTAMP NOT NULL,
    id_statut_actuel INT REFERENCES statut_voyage(id) NOT NULL,
    carburant NUMERIC(10, 2) DEFAULT NULL
);

CREATE TABLE tarif_voyage(
    id SERIAL PRIMARY KEY,
    id_categorie INT NOT NULL REFERENCES categorie_vehicule(id) ON DELETE CASCADE,
    prix NUMERIC(10, 2) NOT NULL,
    date_modification DATE NOT NULL DEFAULT NOW()
);

CREATE TABLE voyage_statut(
    id SERIAL PRIMARY KEY,
    id_voyage INT NOT NULL REFERENCES voyages(id) ON DELETE CASCADE,
    id_statut INT NOT NULL REFERENCES statut_voyage(id) ON DELETE CASCADE,
    date_modification DATE NOT NULL DEFAULT NOW()
);

CREATE TABLE indisponibilite_vehicule(
    id SERIAL PRIMARY KEY,
    id_vehicule INT NOT NULL REFERENCES vehicules(id) ON DELETE CASCADE,
    motif VARCHAR(255) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin_estimee DATE NOT NULL
);

CREATE TABLE motif_panne(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE statut_reparation(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE pannes(
    id SERIAL PRIMARY KEY,
    id_voyage INT NOT NULL REFERENCES voyages(id) ON DELETE CASCADE,
    id_chauffeur INT NOT NULL REFERENCES utilisateurs(id) ON DELETE CASCADE,
    date_signalement DATE NOT NULL,
    lieu GEOMETRY(POINT, 4326) DEFAULT NULL,
    id_motif_panne INT NOT NULL REFERENCES motif_panne(id) ON DELETE CASCADE,
    description VARCHAR(60) NOT NULL,
    photo_url VARCHAR(500) DEFAULT NULL
);

CREATE TABLE reparation(
    id SERIAL PRIMARY KEY,
    id_panne INT NOT NULL REFERENCES pannes(id) ON DELETE CASCADE,
    id_statut_reparation INT NOT NULL REFERENCES statut_reparation(id) ON DELETE CASCADE,
    date_modification DATE NOT NULL DEFAULT NOW(),
    cout NUMERIC(10, 2) DEFAULT NULL
);

ALTER TABLE pannes ADD COLUMN id_statut_reparation_actuel INT REFERENCES statut_reparation(id) DEFAULT NULL;

create table salaires(
    id SERIAL PRIMARY KEY,
    id_employe INT NOT NULL REFERENCES utilisateurs(id) ON DELETE CASCADE,
    salaire NUMERIC(10, 2) NOT NULL,
    date_modification DATE NOT NULL DEFAULT NOW()
);

create table contrats_employes(
    id SERIAL PRIMARY KEY,
    id_employe INT NOT NULL REFERENCES utilisateurs(id) ON DELETE CASCADE,
    date_embauche DATE NOT NULL,
    date_renvoi DATE DEFAULT NULL
);

create table statut_employe(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

create table employe_statut(
    id SERIAL PRIMARY KEY,
    id_employe INT NOT NULL REFERENCES utilisateurs(id) ON DELETE CASCADE,
    id_statut INT NOT NULL REFERENCES statut_employe(id) ON DELETE CASCADE,
    date_modification DATE NOT NULL DEFAULT NOW()
);
