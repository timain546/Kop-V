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
    @Query("SELECT p.* FROM pannes p WHERE p.id_statut_reparation_actuel != (SELECT s.id FROM statut_reparation s WHERE s.libelle = 'resolu')",nativeQuery = true);
    List<Pannes> findAllPannesSignale();
}
