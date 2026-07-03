CREATE DATABASE kopv;
\c kopv;

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    semestre VARCHAR(2)
);
CREATE TABLE role(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);
CREATE TABLE utilisateurs(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    id_role INT REFERENCES role(id),
    email VARCHAR(50) UNIQUE,
    mot_de_passe varchar(50)
    );

CREATE TABLE salaires(
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES utilisateurs(id),
    salaire DECIMAL(10, 2),
    date_modification 
);
CREATE TABLE contrats_employes(
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES utilisateurs(id),
    date_embauche date,
    date_renvoie date
);
create TABLE statut_employe(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);
create TABLE employe_statut(
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES utilisateurs(id),
    id_statut INT REFERENCES statut_employe(id),
    date_modification date
);
--gares
create table gares(
    id SERIAL PRIMARY KEY,
    nom varchar(50),
    ville varchar(50),
    position GEOMETRY(Point, 4326)
);

--trajets
create table trajets(
    id SERIAL PRIMARY KEY,
    id_gare_depart INT REFERENCES gares(id),
    id_gare_arrivee INT REFERENCES gares(id),
    distance_km DECIMAL(10, 2)
);

--vehicules
create table categorie_vehicule(
    id SERIAL PRIMARY KEY,
    libelle varchar(50)
);

create table vehicules(
    id SERIAL PRIMARY KEY,
    immatriculation varchar(50),
    modele varchar(50),
    id_categorie INT REFERENCES categorie_vehicule(id),
    nombre_places INT
);
--places
create table places(
    id SERIAL PRIMARY KEY,
    x int,
    y int,
    id_vehicule INT REFERENCES vehicules(id),
    numero INT
);

-- reservations
create table reservations_mere(
id serial PRIMARY KEY,
libelle varchar(50),
id_voyage INT REFERENCES voyages(id),
id_client INT REFERENCES clients(id),
date_reservation date,
id_statut_paiement INT REFERENCES statut_reservation(id)
);

create table reservations_fille(
    id serial PRIMARY KEY,
    id_reservation_mere INT REFERENCES reservations_mere(id),
    id_place INT REFERENCES places(id)
);
create table statut_reservation(
    id serial PRIMARY KEY,
    libelle varchar(50)
);

create table reservation_statut(
    id serial PRIMARY KEY,
    id_reservation INT REFERENCES reservations_mere(id),
    id_statut INT REFERENCES statut_reservation(id),
    date_modification date
);


-- paiement
create table paiements(
id SERIAL PRIMARY KEY,
id_reservation INT REFERENCES reservations_mere(id),
montant DECIMAL(10, 2),
id_mode_paiement INT REFERENCES mode_paiement(id),
date_paiement date,
references_transaction VARCHAR(50)
);
create table statut_paiement(
    id serial PRIMARY KEY,
    libelle varchar(50)
);

create table mode_paiement(
    id serial PRIMARY KEY,
    libelle varchar(50)
);
--voyages
create table voyages(
    id SERIAL PRIMARY KEY,
    id_trajet INT REFERENCES trajets(id),
    id_vehicule INT REFERENCES vehicules(id),
    id_chauffeur INT REFERENCES utilisateurs(id),
    date_heure_depart timestamp,
    duree_estimee_minutes INT,
   tarif DECIMAL(10, 2)
);

create table statut_voyage(
    id serial PRIMARY KEY,
    libelle varchar(50)
);
create table voyage_statut(
    id serial PRIMARY KEY,
    id_voyage INT REFERENCES voyages(id),
    id_statut INT REFERENCES statut_voyage(id),
    date_modification date
);

create table clients(
   id SERIAL PRIMARY KEY,
   nom VARCHAR(50),
   telephone VARCHAR(20)
);



insert into statut_paiement(libelle) values('non-payé');
insert into statut_paiement(libelle) values('payé');
insert into statut_paiement(libelle) values('partiellement payé');

insert into mode_paiement(libelle) values('espèce');
insert into mode_paiement(libelle) values('carte bancaire');



insert into role(libelle) values('RE');
insert into role(libelle) values('chauffeur');
insert into role(libelle) values('employe');

insert into utilisateurs(nom, prenom, id_role, email, mot_de_passe) values('Rakoto', 'Jean', 1,'rakoto@gmail.com','123');
insert into utilisateurs(nom, prenom, id_role, email, mot_de_passe) values('Rabe', 'Marie', 2,'rabe@gmail.com','456');
insert into utilisateurs(nom, prenom, id_role, email, mot_de_passe) values('Rajaonarivelo', 'Andry', 3,'rajaonarivelo@gmail.com','789');
insert into utilisateurs(nom, prenom, id_role, email, mot_de_passe) values('Rasoa', 'Lalao', 3,'rasoa@gmail.com','012');

insert into salaires(id_employe, salaire, date_modification) values(1, 1500.00, '2024-01-01');
insert into salaires(id_employe, salaire, date_modification) values(2, 2000.00, '2024-02-01');
insert into salaires(id_employe, salaire, date_modification) values(3, 2500.00, '2024-03-01');
insert into salaires(id_employe, salaire, date_modification) values(1, 2600.00, '2024-04-01');

insert into statut_employe(libelle) values('Engagé');
insert into statut_employe(libelle) values('Renvoyé');
insert into statut_employe(libelle) values('Reambauché');

insert into employe_statut(id_employe, id_statut, date_modification) values(1, 1, '2024-01-01');
insert into employe_statut(id_employe, id_statut, date_modification) values(2, 1, '2024-02-01');
insert into employe_statut(id_employe, id_statut, date_modification) values(3, 1, '2024-03-01');
insert into employe_statut(id_employe, id_statut, date_modification) values(4, 1, '2024-04-01');


insert into contrats_employes(id_employe, date_embauche, date_renvoie) values(1, '2024-01-01', null);
insert into contrats_employes(id_employe, date_embauche, date_renvoie) values(2, '2024-02-01', null);
insert into contrats_employes(id_employe, date_embauche, date_renvoie) values(3, '2024-03-01', null);
insert into contrats_employes(id_employe, date_embauche, date_renvoie) values(4, '2024-04-01', null);

insert into role(libelle)
values
('guichet'),
('chauffeur');

insert into gares(nom, ville)
values
('Gare Tana', 'Antananarivo'),
('Gare Tamatave', 'Toamasina'),
('Gare Antsirabe', 'Antsirabe');

insert into statut_paiement(libelle)
values
('non payé'),
('partiellement payé'),
('payé');

insert into mode_paiement(libelle)
values
('espèce'),
('mobile money'),
('carte');

insert into trajets(distance_km, id_gare_depart, id_gare_arrivee)
values
(166, 1, 3),
(166, 3, 1),
(350, 1, 2),
(350, 2, 1);

insert into categorie_vehicule(libelle)
values
('standard'),
('premium'),
('VIP');

insert into utilisateurs(email, mot_de_passe, nom, prenom, id_role)
values
('jean.rakoto@transport.mg', 'password123', 'Rakoto', 'Jean', 2),
('paul.rabe@transport.mg', 'password123', 'Rabe', 'Paul', 2),
('luc.rasoa@transport.mg', 'password123', 'Rasoa', 'Luc', 2),
('marc.randria@transport.mg', 'password123', 'Randria', 'Marc', 2),
('hery.rakotomalala@transport.mg', 'password123', 'Rakotomalala', 'Hery', 2);

insert into vehicules(immatriculation, modele, nombre_places, id_categorie)
values
('9038 TCA', 'Mercedes Sprinter', 16, 1),
('2467 TBD', 'Toyota Coaster', 30, 2),
('5819 TBE', 'Hyundai County', 29, 2),
('3742 TBK', 'Mercedes Vito', 12, 3),
('6985 TCB', 'Isuzu Journey', 25, 2);

insert into voyages
(date_heure_depart, duree_estimee_minutes, tarif, id_chauffeur, id_trajet, id_vehicule)
values
('2026-07-01 06:00:00', 180, 25000, 2, 1, 1),
('2026-07-01 08:00:00', 180, 25000, 1, 2, 2),
('2026-07-01 14:00:00', 180, 25000, 2, 1, 3),
('2026-07-02 06:30:00', 180, 25000, 1, 2, 1),
('2026-07-02 13:00:00', 180, 25000, 2, 1, 2),
('2026-07-02 18:00:00', 180, 25000, 1, 2, 3),
('2026-07-03 05:30:00', 360, 45000, 2, 3, 1),
('2026-07-03 14:00:00', 360, 45000, 1, 4, 2),
('2026-07-04 06:00:00', 360, 45000, 2, 3, 3),
('2026-07-04 15:00:00', 360, 45000, 1, 4, 1),
('2026-07-05 06:30:00', 180, 25000, 2, 1, 2),
('2026-07-05 14:30:00', 180, 25000, 1, 2, 3),
('2026-07-06 06:00:00', 360, 45000, 2, 3, 1),
('2026-07-06 15:30:00', 360, 45000, 1, 4, 2);

insert into places (numero, x, y, id_vehicule) values
-- Véhicule 1 (16 places)
('A1',0,1,1),('A2',1,1,1),('A3',2,1,1),
('B1',0,2,1),('B2',1,2,1),('B3',2,2,1),
('C1',0,3,1),('C2',1,3,1),('C3',2,3,1),
('D1',0,4,1),('D2',1,4,1),('D3',2,4,1),
('E1',0,5,1),('E2',1,5,1),('E3',2,5,1),
('F2',1,6,1),
-- Véhicule 2 (30 places)
('A1',0,1,2),('A2',1,1,2),('A3',2,1,2),
('B1',0,2,2),('B2',1,2,2),('B3',2,2,2),
('C1',0,3,2),('C2',1,3,2),('C3',2,3,2),
('D1',0,4,2),('D2',1,4,2),('D3',2,4,2),
('E1',0,5,2),('E2',1,5,2),('E3',2,5,2),
('F1',0,6,2),('F2',1,6,2),('F3',2,6,2),
('G1',0,7,2),('G2',1,7,2),('G3',2,7,2),
('H1',0,8,2),('H2',1,8,2),('H3',2,8,2),
('I1',0,9,2),('I2',1,9,2),('I3',2,9,2),
('J1',0,10,2),('J2',1,10,2),('J3',2,10,2),
-- Véhicule 3 (29 places)
('A1',0,1,3),('A2',1,1,3),('A3',2,1,3),
('B1',0,2,3),('B2',1,2,3),('B3',2,2,3),
('C1',0,3,3),('C2',1,3,3),('C3',2,3,3),
('D1',0,4,3),('D2',1,4,3),('D3',2,4,3),
('E1',0,5,3),('E2',1,5,3),('E3',2,5,3),
('F1',0,6,3),('F2',1,6,3),('F3',2,6,3),
('G1',0,7,3),('G2',1,7,3),('G3',2,7,3),
('H1',0,8,3),('H2',1,8,3),('H3',2,8,3),
('I1',0,9,3),('I2',1,9,3),('I3',2,9,3),
('J1',0,10,3),('J2',1,10,3),
-- Véhicule 4 (12 places)
('A1',0,1,4),('A2',1,1,4),('A3',2,1,4),
('B1',0,2,4),('B2',1,2,4),('B3',2,2,4),
('C1',0,3,4),('C2',1,3,4),('C3',2,3,4),
('D1',0,4,4),('D2',1,4,4),('D3',2,4,4),
-- Véhicule 5 (25 places)
('A1',0,1,5),('A2',1,1,5),('A3',2,1,5),
('B1',0,2,5),('B2',1,2,5),('B3',2,2,5),
('C1',0,3,5),('C2',1,3,5),('C3',2,3,5),
('D1',0,4,5),('D2',1,4,5),('D3',2,4,5),
('E1',0,5,5),('E2',1,5,5),('E3',2,5,5),
('F1',0,6,5),('F2',1,6,5),('F3',2,6,5),
('G1',0,7,5),('G2',1,7,5),('G3',2,7,5),
('H1',0,8,5),('H2',1,8,5),('H3',2,8,5),
('I2',1,9,5);

insert into clients (nom, telephone)
values
('Randria Koto', '038 12 345 67');

insert into reservations_mere (date_reservation, libelle, id_voyage, id_statut_paiement, id_client)
values
('2026-07-02', 'Réservation pour 3 personnes', 1, 2, 1);

insert into reservations_fille (id_reservation_mere, id_place)
values
(3, 1),  -- A1
(3, 2),  -- A2
(3, 3);  -- A3

insert into paiements (montant, date_paiement, id_mode_paiement, id_reservation)
values
(30000, '2026-07-02', 1, 3);

insert into statut_reservation (libelle)
values
('en attente'),
('confirmée'),
('annulée');

insert into reservation_statut (id_reservation, id_statut, date_modification)
values
(3, 2, '2026-07-02');
