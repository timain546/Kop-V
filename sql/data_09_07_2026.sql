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