package com.cooperative.transport.repositories;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cooperative.transport.dto.VoyageDisponibleDTO;
import com.cooperative.transport.entities.Trajets;
import com.cooperative.transport.entities.Utilisateurs;
import com.cooperative.transport.entities.Voyages;

@Repository
public interface VoyageRepository extends JpaRepository<Voyages, Integer> {
    @EntityGraph(attributePaths = {
            "trajet",
            "trajet.gareDepart",
            "trajet.gareArrivee",
            "vehicule",
            "chauffeur",
            "statutActuel"
    })
    @Query("SELECT v FROM Voyages v ORDER BY v.dateHeureDepart ASC")
    List<Voyages> findAllCatalogueVoyage();

    @Query(value = "SELECT v.* FROM voyages v WHERE v.date_heure_depart >= NOW()" +
        " AND v.id_trajet = :idTrajet AND v.id_statut_actuel = (" +
        " SELECT s.id FROM statut_voyage s WHERE s.libelle = 'Plannifié')"
        , nativeQuery = true)
    List<Voyages> findAllVoyagePrevusByTrajet(@Param("idTrajet") Integer idTrajet);

    List<Voyages> findByChauffeur(Utilisateurs chauffeur);
    List<Voyages> findByChauffeurId(Integer chauffeurId);

    @Query("SELECT v FROM Voyages v WHERE v.chauffeur.id = :chauffeurId AND v.dateHeureDepart >= :date")
    List<Voyages> findByChauffeurIdAndDateHeureDepartAfter(@Param("chauffeurId") Integer chauffeurId,
                                                         @Param("date") LocalDateTime date);

    @Query("SELECT v FROM Voyages v WHERE v.trajet = :trajet AND v.dateHeureDepart = :dateHeureDepart AND v.vehicule.categorie.libelle = :categorie")
    public Optional<Voyages> findByTrajetAndDateHeureDepartAndCategorie(Trajets trajet, LocalDateTime dateHeureDepart, String categorie);

    @Query(value = """
        SELECT
            v.id                                                                                    AS id,
            v.date_heure_depart::DATE                                                               AS dateDepart,
            TO_CHAR(v.date_heure_depart, 'HH24:MI')                                                 AS heureDepart,
            TO_CHAR(v.date_heure_depart + v.duree_estimee_minutes * INTERVAL '1 minute', 'HH24:MI') AS heureArrivee,
            g_dep.nom                                                                               AS gareDepart,
            g_arr.nom                                                                               AS gareArrivee,
            v.duree_estimee_minutes                                                                 AS duree,
            t.distance_km                                                                           AS distance,
            vh.immatriculation                                                                      AS immatriculationVehicule,
            vh.modele                                                                               AS modeleVehicule,
            cat.libelle                                                                             AS categorieVehicule,
            v.tarif,
            COUNT(DISTINCT p.id)                                                                    AS nbPlacesTotales,
            COUNT(DISTINCT p.id) - COUNT(DISTINCT rf.id)                                            AS nbPlacesDisponibles

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

        LEFT JOIN reservations_mere rm
            ON rm.id_voyage = v.id

        LEFT JOIN reservations_fille rf
            ON rf.id_reservation_mere = rm.id
           AND rf.id_place = p.id

        WHERE v.date_heure_depart::DATE
              BETWEEN :date1
              AND :date2

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

    List<VoyageDisponibleDTO> findByDateBetweenAndVilleAndNbPlaces(

            @Param("date1") LocalDate date1,

            @Param("date2") LocalDate date2,

            @Param("villeDepart") String villeDepart,

            @Param("villeArrivee") String villeArrivee,

            @Param("nbPlaces") Integer nbPlaces
    );

}
