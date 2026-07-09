CREATE DATABASE kopv;
\c kopv;

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    semestre VARCHAR(2)
);

BEGIN;

-- Remplace 1 par l'id de la réservation à supprimer
DELETE FROM annulations
WHERE id_reservation = 6;

DELETE FROM paiements
WHERE id_reservation = 6;

DELETE FROM reservation_statut
WHERE id_reservation = 6;

DELETE FROM reservations_fille
WHERE id_reservation_mere = 6;

DELETE FROM reservations_mere
WHERE id = 6;

COMMIT;

BEGIN;

-- Remplace 1 par l'id de la réservation à supprimer
DELETE FROM annulations
WHERE id_reservation = 3;

DELETE FROM paiements
WHERE id_reservation = 3;

DELETE FROM reservation_statut
WHERE id_reservation = 3;

DELETE FROM reservations_fille
WHERE id_reservation_mere = 3;

DELETE FROM reservations_mere
WHERE id = 3;

COMMIT;