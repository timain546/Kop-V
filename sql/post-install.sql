DROP VIEW IF EXISTS v_reservations_mere_fille;
CREATE VIEW v_reservations_mere_fille AS
SELECT rf.id_reservation_mere, rf.id as id_reservation_fille, rf.id_place,
    rm.date_reservation, rm.libelle, rm.id_client, rm.id_statut_paiement, rm.id_voyage
FROM reservations_fille rf
JOIN reservations_mere rm ON rm.id = rf.id_reservation_mere;

DROP TABLE IF EXISTS v_places_statuts;
DROP VIEW IF EXISTS v_places_statuts;
CREATE VIEW v_places_statuts AS
SELECT p.id, v.id AS id_voyage, rmf.id_reservation_fille IS NOT NULL AS occupee
FROM places p
JOIN voyages v ON p.id_vehicule = v.id_vehicule
LEFT JOIN v_reservations_mere_fille rmf ON v.id = rmf.id_voyage AND p.id = rmf.id_place;
