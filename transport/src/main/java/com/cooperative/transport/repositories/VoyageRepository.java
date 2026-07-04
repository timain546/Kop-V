package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Utilisateurs;
import com.cooperative.transport.entities.Voyages;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

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
}
