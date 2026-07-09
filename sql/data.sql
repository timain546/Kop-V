insert into role(libelle)
values
('Guichet'),
('Chauffeur');

insert into gares(nom, ville)
values
('Gare Tana', 'Antananarivo'),
('Gare Tamatave', 'Toamasina'),
('Gare Antsirabe', 'Antsirabe');

insert into statut_paiement(libelle)
values
('Non payé'),
('Partiellement payé'),
('Payé');

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
('Standard'),
('Premium'),
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

insert into client (nom, telephone)
values
('Randria Koto', '038 12 345 67');

insert into reservations_mere (date_reservation, libelle, id_voyage, id_statut_paiement, id_client)
values
('2026-07-02', 'Réservation pour 3 personnes', 1, 2, 1);

insert into reservations_fille (id_reservation_mere, id_place)
values
(1, 1),  -- A1
(1, 2),  -- A2
(1, 3);  -- A3

insert into paiements (montant, date_paiement, id_mode_paiement, id_reservation)
values
(30000, '2026-07-02', 1, 1);

insert into statut_reservation (libelle)
values
('Confirmée'),
('Annulée');
