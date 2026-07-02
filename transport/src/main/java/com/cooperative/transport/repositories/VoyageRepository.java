package com.cooperative.transport.repositories;

import com.cooperative.transport.dto.VoyageDTO;
import com.cooperative.transport.entities.Voyage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface VoyageRepository extends JpaRepository<Voyage, Integer> {

    @Query(value = """
        SELECT
            v.id                                              AS id,
            v.date_heure_depart::DATE                         AS dateDepart,
            TO_CHAR(v.date_heure_depart, 'HH24:MI')           AS heureDepart,
            g_dep.nom                                         AS gareDepart,
            g_arr.nom                                         AS gareArrivee,
            v.duree_estimee_minutes                           AS duree,
            t.distance_km                                     AS distance,
            vh.immatriculation                                AS immatriculationVehicule,
            vh.modele                                         AS modeleVehicule,
            cat.libelle                                       AS categorieVehicule,
            v.tarif,
            COUNT(DISTINCT p.id)                              AS nbPlacesTotales,
            COUNT(DISTINCT p.id) - COUNT(DISTINCT rf.id)      AS nbPlacesDisponibles

        FROM voyages v

        JOIN trajets t
            ON t.id = v.id_trajet

        JOIN gares g_dep
            ON g_dep.id = t.id_gare_depart

        JOIN gares g_arr
            ON g_arr.id = t.id_gare_arrivee

        JOIN vehicules vh
            ON vh.id = v.id_vehicule

        JOIN categorie_vehicule cat
            ON cat.id = vh.id_categorie

        LEFT JOIN places p
            ON p.id_vehicule = vh.id

        LEFT JOIN reservations_fille rf
            ON rf.id_place = p.id

        LEFT JOIN reservations_mere rm
            ON rm.id = rf.id_reservation_mere
           AND rm.id_voyage = v.id

        WHERE v.date_heure_depart::DATE
              BETWEEN CAST(:date1 AS DATE)
              AND CAST(:date2 AS DATE)

          AND g_dep.ville = :villeDepart

          AND g_arr.ville = :villeArrivee

        GROUP BY
            v.id,
            v.date_heure_depart,
            g_dep.nom,
            g_arr.nom,
            v.duree_estimee_minutes,
            t.distance_km,
            vh.immatriculation,
            vh.modele,
            cat.libelle,
            v.tarif

        HAVING COUNT(DISTINCT p.id) - COUNT(DISTINCT rf.id) >= :nbPlaces

        ORDER BY v.date_heure_depart ASC
        """, nativeQuery = true)

    List<VoyageDTO> findByDateBetween(

            @Param("date1") String date1,

            @Param("date2") String date2,

            @Param("villeDepart") String villeDepart,

            @Param("villeArrivee") String villeArrivee,

            @Param("nbPlaces") Integer nbPlaces
    );

}