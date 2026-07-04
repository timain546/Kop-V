package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.VoyageStatut;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoyageStatutRepository extends JpaRepository<VoyageStatut, Integer> {
    List<VoyageStatut> findByVoyageIdOrderByDateModificationDesc(Long voyageId);
    List<Voyage> findByChauffeur(Utilisateur chauffeur);
    List<Voyage> findByChauffeurId(Long chauffeurId);
    
    @Query("SELECT vs FROM VoyageStatut vs WHERE vs.voyage.id = :voyageId ORDER BY vs.dateModification DESC")
    Optional<VoyageStatut> findLatestByVoyageId(@Param("voyageId") Long voyageId);
    
    @Query("SELECT v FROM Voyage v WHERE v.chauffeur.id = :chauffeurId AND v.dateHeureDepart >= :date")
    List<Voyage> findByChauffeurIdAndDateHeureDepartAfter(@Param("chauffeurId") Long chauffeurId,
                                                         @Param("date") LocalDateTime date);
}