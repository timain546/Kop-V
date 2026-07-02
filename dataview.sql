# VIEW PLACE LIBRE 

CREATE OR REPLACE VIEW v_places_libres AS
SELECT
    v.id AS id_voyage,
    p.id AS id_place,
    p.numero AS numero_place,
    ve.id AS id_vehicule,
    ve.immatriculation,
    ve.modele
FROM voyages v
JOIN vehicules ve
    ON ve.id = v.id_vehicule
JOIN places p
    ON p.id_vehicule = ve.id
WHERE NOT EXISTS (
    SELECT 1
    FROM reservations_fille rf
    JOIN reservations_mere rm
        ON rm.id = rf.id_reservation_mere
    WHERE rm.id_voyage = v.id
      AND rf.id_place = p.id
);