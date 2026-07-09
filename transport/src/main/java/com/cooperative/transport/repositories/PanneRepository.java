package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Pannes;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PanneRepository extends JpaRepository<Pannes, Integer> {
    List<Pannes> findByChauffeurId(Integer chauffeurId);
    List<Pannes> findByVoyageId(Integer voyageId);

    @EntityGraph(attributePaths = {
        "voyage",
        "voyage.vehicule",
        "voyage.trajet",
        "voyage.trajet.gareDepart",
        "voyage.trajet.gareArrivee",
        "chauffeur",
        "motifPanne"
    })
    @Query("SELECT p FROM Pannes p ORDER BY dateSignalement DESC")
    List<Pannes> findAllPannes();
}
