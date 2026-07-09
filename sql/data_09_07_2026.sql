INSERT INTO motif_panne (libelle) VALUES
('Panne moteur'),
('Crevaison'),
('Problème électrique'),
('Surchauffe'),
('Autre');

INSERT INTO statut_reparation (libelle) VALUES
('en panne'),
('en cours de depannage'),
('resolu');

INSERT INTO vehicules (immatriculation, modele, id_categorie, nombre_places) VALUES
('6767BLA', 'Toyota Camry', 1, 4),
('5463BAL', 'Honda Accord', 2, 4),
('0911FRO', 'Ford Focus', 3, 4);

INSERT INTO utilisateurs (nom, prenom, id_role, email, mot_de_passe) VALUES
('Rajaonarivelo', 'Hery', 1, 'herya@gmail.com', '1234'),
('Rajao', 'Zo', 1, 'andry@gmail.com', '1234'),
('Razefa', 'Zefa', 1, 'zefa@gmail.com', '1234');

INSERT INTO voyages (id_trajet, id_vehicule, id_chauffeur, duree_estimee_minutes, date_heure_depart,tarif, id_statut_actuel) VALUES
(1, 4, 4, 15, '2026-07-10 08:00:00', 30.00, 2),
(2, 5, 5, 30, '2026-08-10 09:00:00', 30.00, 2),
(3, 6, 6, 45, '2026-09-10 10:00:00', 30.00, 2);

INSERT INTO pannes (id_voyage,id_chauffeur,date_signalement,id_motif_panne,description) VALUES
(1,4,'2026-07-10','1','Le moteur a surchauffé et le véhicule ne peut plus avancer.'),
(2,5,'2026-08-10','2','Une crevaison a été signalée sur le trajet.'),
(3,6,'2026-09-10','3','Problème électrique empêchant le démarrage du véhicule.');

INSERT INTO reparation (id_panne,id_statut_reparation,date_modification,cout) VALUES
(1,1,'2026-07-10',100.00),
(2,1,'2026-08-10',100.00),
(3,1,'2026-09-10',100.00);


insert into statut_employe (libelle) values
('Engagé'),
('Renvoyé'),
('Reambauché')