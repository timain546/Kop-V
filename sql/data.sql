INSERT INTO role (libelle) VALUES
('Chauffeur'),
('RE');

INSERT INTO utilisateurs (nom, prenom, id_role, email, mot_de_passe) VALUES
('Rakoto', 'John', 1, 'john@gmail.com', '1234'), 
('Rabe', 'Jean', 1, 'jean@gmail.com', '1234'),   
('Rado', 'Paul', 1, 'paul@gmail.com', '1234'),   
('Randria', 'Alice', 2, 'alice@gmail.com', '1234');

INSERT INTO categorie_vehicule (libelle) VALUES
('VIP'),
('Premium'),
('Standard');

INSERT INTO vehicules (immatriculation, modele, id_categorie, nombre_places) VALUES
('1234ABC', 'Toyota Camry', 1, 4),
('5678DEF', 'Honda Accord', 2, 4),
('9012GHI', 'Ford Focus', 3, 4);

INSERT INTO gares (nom, ville, position) VALUES
('Gare Centrale', 'Antananarivo', ST_SetSRID(ST_MakePoint(47.5162, -18.8792), 4326)),
('Gare Nord', 'Toamasina', ST_SetSRID(ST_MakePoint(47.5165, -18.8795), 4326)),
('Gare Sud', 'Antsirabe', ST_SetSRID(ST_MakePoint(47.5168, -18.8798), 4326));

INSERT INTO trajets (id_gare_depart, id_gare_arrivee, distance_km) VALUES
(1, 2, 5.0),
(2, 3, 10.0),
(3, 1, 15.0);

INSERT INTO statut_voyage (libelle) VALUES
('Plannifié'),
('En cours'),
('Terminé'),
('Annulé'),
('En panne');

INSERT INTO voyages (id_trajet, id_vehicule, id_chauffeur, duree_estimee_minutes, date_heure_depart,tarif, id_statut_actuel) VALUES
(1, 1, 1, 15, '2026-07-10 08:00:00', 30.00, 1),
(2, 2, 2, 30, '2026-07-10 09:00:00', 30.00, 1),
(3, 3, 3, 45, '2026-07-10 10:00:00', 30.00, 1);

INSERT INTO tarif_voyage (id_categorie, prix, date_modification) VALUES
(1, 30.00, '2026-01-01'),
(1, 35.00, '2026-06-01'),
(2, 20.00, '2026-01-01'),
(2, 25.00, '2026-06-01'),
(3, 10.00, '2026-01-01'),
(3, 12.00, '2026-06-01');

INSERT INTO voyage_statut (id_voyage, id_statut, date_modification) VALUES
(3, 1, '2026-06-01'),
(1, 2, '2026-06-01'),
(2, 3, '2026-06-01');

INSERT INTO salaires (id_employe, montant, date_modification) VALUES
(1, 2000.00, '2026-01-01'),
(2, 2500.00, '2026-01-01'),
(3, 3000.00, '2026-01-01'),
(4, 3500.00, '2026-01-01');

INSERT INTO contrats_employes (id_employe, date_embauche, date_renvoi) VALUES
(1, '2026-01-01', NULL),
(2, '2026-02-01', NULL),
(3, '2026-03-01', NULL),
(4, '2026-04-01', NULL);