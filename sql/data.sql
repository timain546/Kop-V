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
