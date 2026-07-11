package com.cooperative.transport.repositories;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cooperative.transport.dto.ReservationDTO;
import com.cooperative.transport.entities.ReservationsMere;

public interface ReservationMereRepository extends JpaRepository<ReservationsMere, Integer> {

    @Query("""
        SELECT COUNT(rf) * rf.reservationMere.voyage.tarif
        FROM ReservationsFille rf
        WHERE rf.reservationMere = :reservation
        GROUP BY rf.reservationMere.voyage.tarif
    """)
    public BigDecimal getPrixTotal(ReservationsMere reservation);


    @Query(value = """
        SELECT
            rm.id                          AS idReservation,
            rm.date_reservation            AS dateReservation,
            c.nom                          AS client,
            c.telephone                    AS telephone,
            v.date_heure_depart            AS dateVoyage,
            gd.ville                       AS gareDepart,
            ga.ville                       AS gareArrivee,
            string_agg(p.numero, ', ' ORDER BY p.numero) AS numeroPlace,
            sp.libelle                     AS statutPaiement,
            COALESCE((
                SELECT sr.libelle
                FROM reservation_statut rs
                    JOIN statut_reservation sr ON sr.id = rs.id_statut
                WHERE rs.id_reservation = rm.id
                ORDER BY rs.date_modification DESC
                LIMIT 1
            ), '')                         AS statutReservation,
            COALESCE((
                SELECT a.prix_remboursement
                FROM annulations a
                WHERE a.id_reservation = rm.id
                ORDER BY a.date_annulation DESC
                LIMIT 1
            ), 0)                           AS prixRemboursement,
            sum(v.tarif)                   AS tarif
        FROM reservations_mere rm
            JOIN client c              ON c.id = rm.id_client
            JOIN voyages v             ON v.id = rm.id_voyage
            JOIN trajets t             ON t.id = v.id_trajet
            JOIN gares gd              ON gd.id = t.id_gare_depart
            JOIN gares ga              ON ga.id = t.id_gare_arrivee
            JOIN statut_paiement sp    ON sp.id = rm.id_statut_paiement
            JOIN reservations_fille rf ON rf.id_reservation_mere = rm.id
            JOIN places p              ON p.id = rf.id_place
        WHERE (:dateDebut IS NULL OR :dateDebut = '' OR v.date_heure_depart >= CAST(:dateDebut AS date))
          AND (:dateFin IS NULL OR :dateFin = '' OR v.date_heure_depart < CAST(:dateFin AS date) + interval '1 day')
          AND (:villeDepart IS NULL OR :villeDepart = '' OR gd.ville = :villeDepart)
          AND (:villeArrivee IS NULL OR :villeArrivee = '' OR ga.ville = :villeArrivee)
        GROUP BY rm.id, rm.date_reservation, c.nom, c.telephone,
                 v.date_heure_depart, gd.ville, ga.ville, sp.libelle
        ORDER BY rm.date_reservation DESC
        """, nativeQuery = true)
    Page<ReservationDTO> findReservationsByDateAndVilleDepartAndVilleArrivee(
            @Param("dateDebut") String dateDebut,
            @Param("dateFin") String dateFin,
            @Param("villeDepart") String villeDepart,
            @Param("villeArrivee") String villeArrivee,
            Pageable pageable);


    @Query(value = """
        SELECT
            rm.id                          AS idReservation,
            rm.date_reservation            AS dateReservation,
            c.nom                          AS client,
            c.telephone                    AS telephone,
            v.date_heure_depart            AS dateVoyage,
            gd.ville                       AS gareDepart,
            ga.ville                       AS gareArrivee,
            string_agg(p.numero, ', ' ORDER BY p.numero) AS numeroPlace,
            sp.libelle                     AS statutPaiement,
            COALESCE((
                SELECT sr.libelle
                FROM reservation_statut rs
                    JOIN statut_reservation sr ON sr.id = rs.id_statut
                WHERE rs.id_reservation = rm.id
                ORDER BY rs.date_modification DESC
                LIMIT 1
            ), '')                         AS statutReservation,
            COALESCE((
                SELECT a.prix_remboursement
                FROM annulations a
                WHERE a.id_reservation = rm.id
                ORDER BY a.date_annulation DESC
                LIMIT 1
            ), 0)                           AS prixRemboursement,
            sum(v.tarif)                   AS tarif
        FROM reservations_mere rm
            JOIN client c              ON c.id = rm.id_client
            JOIN voyages v             ON v.id = rm.id_voyage
            JOIN trajets t             ON t.id = v.id_trajet
            JOIN gares gd              ON gd.id = t.id_gare_depart
            JOIN gares ga              ON ga.id = t.id_gare_arrivee
            JOIN statut_paiement sp    ON sp.id = rm.id_statut_paiement
            JOIN reservations_fille rf ON rf.id_reservation_mere = rm.id
            JOIN places p              ON p.id = rf.id_place
        WHERE rm.id IN (:ids)
        GROUP BY rm.id, rm.date_reservation, c.nom, c.telephone,
                 v.date_heure_depart, gd.ville, ga.ville, sp.libelle
        ORDER BY rm.date_reservation DESC
        """, nativeQuery = true)
    List<ReservationDTO> findReservationsByIds(@Param("ids") List<Integer> ids);
}
