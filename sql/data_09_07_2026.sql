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

INSERT INTO pannes (id_voyage,id_chauffeur,date_signalement,id_motif_panne,description,id_statut_reparation_actuel) VALUES
(1,4,'2026-07-10','1','Le moteur a surchauffé et le véhicule ne peut plus avancer.',1),
(2,5,'2026-08-10','2','Une crevaison a été signalée sur le trajet.',1),
(3,6,'2026-09-10','3','Problème électrique empêchant le démarrage du véhicule.',1);

INSERT INTO reparation (id_panne,id_statut_reparation,date_modification,cout) VALUES
(1,1,'2026-07-10',NULL),
(2,1,'2026-08-10',NULL),
(3,3,'2026-09-10',100.00);


insert into statut_employe (libelle) values
('Engagé'),
('Renvoyé'),
('Reambauché');

insert into employe_statut (id_employe, id_statut, date_modification) values
(1,1,'2026-01-01'),
(2,1,'2026-02-01'),
(3,1,'2026-03-01'),
(4,1,'2026-04-01'),
(5,1,'2026-02-01'),
(6,1,'2026-03-01'),
(7,1,'2026-04-01');

insert into client (nom,telephone) values
('Client 1','0341234567'),
('Client 2','0342345678'),
('Client 3','0343456789'),
('Client 4','0344567890'),
('Client 5','0345678901'),
('Client 6','0346789012');

insert into statut_paiement (libelle) values
('non-payé'),
('payé'),
('partiellement-payé');


insert into reservations_mere (date_reservation, libelle, id_client, id_statut_paiement, id_voyage) values
('2026-07-10', 'Reservation 1', 1, 2, 1),
('2026-08-10', 'Reservation 2', 2, 2, 2),
('2026-09-10', 'Reservation 3', 3, 3, 3),
('2026-07-10', 'Reservation 4', 4, 3, 4),
('2026-08-10', 'Reservation 5', 5, 2, 5),
('2026-09-10', 'Reservation 6', 6, 2, 6);

insert into mode_paiement (libelle) values
('Carte bancaire'),
('Espèces'),
('Virement bancaire');

insert into paiements (date_paiement,montant,reference_transaction,id_mode_paiement,id_reservation) values
('2026-04-10',30, 'REF001', 1, 13),
('2026-08-10',30, 'REF002', 2, 14),
('2026-09-10',30, 'REF003', 3, 15),
('2026-07-10',30, 'REF004', 1, 16),
('2026-08-10',30, 'REF005', 2, 17),
('2026-09-10',30, 'REF006', 3, 18);