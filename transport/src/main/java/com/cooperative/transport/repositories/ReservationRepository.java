package com.cooperative.transport.repositories;

import com.sun.org.apache.xalan.internal.xsltc.compiler.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cooperative.transport.dto.ReservationDTO;
import com.cooperative.transport.entities.ReservationFille;
import com.cooperative.transport.entities.ReservationMere;

import java.util.List;

public interface ReservationRepository extends JpaRepository<ReservationMere, Integer>{

    @Query(value = """
            
   SELECT

rm.id                                    AS idReservation,

rm.date_reservation                      AS dateReservation,

c.nom                                    AS client,

c.telephone                              AS telephone,

v.date_heure_depart                      AS dateVoyage,

g_dep.nom                                AS gareDepart,

g_arr.nom                                AS gareArrivee,

p.numero                                 AS numeroPlace,

sp.libelle                               AS statutPaiement,

v.tarif                                  AS tarif

FROM reservations_mere rm

JOIN client c
ON c.id = rm.id_client

JOIN voyages v
ON v.id = rm.id_voyage

JOIN trajets t
ON t.id = v.id_trajet

JOIN gares g_dep
ON g_dep.id = t.id_gare_depart

JOIN gares g_arr
ON g_arr.id = t.id_gare_arrivee

JOIN statut_paiement sp
ON sp.id = rm.id_statut_paiement

JOIN reservations_fille rf
ON rf.id_reservation_mere = rm.id

JOIN places p
ON p.id = rf.id_place

WHERE v.date_heure_depart::DATE
BETWEEN CAST(:date1 AS DATE)
AND CAST(:date2 AS DATE)

AND g_dep.ville = :villeDepart

AND g_arr.ville = :villeArrivee

ORDER BY v.date_heure_depart;

            
           
    """, nativeQuery = true)
List<ReservationDTO> findReservationsByDateAndVilleDepartAndVilleArrivee(

        @Param("date1") String date1,

        @Param("date2") String date2,

        @Param("villeDepart") String villeDepart,

        @Param("villeArrivee") String villeArrivee
);
}
