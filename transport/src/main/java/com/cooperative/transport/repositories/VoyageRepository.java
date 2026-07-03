package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Utilisateur;
import com.cooperative.transport.entities.Voyage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface VoyageRepository extends JpaRepository<Voyage, Long> {
    List<Voyage> findByChauffeur(Utilisateur chauffeur);
    List<Voyage> findByChauffeurId(Long chauffeurId);
    
    @Query("SELECT v FROM Voyage v WHERE v.chauffeur.id = :chauffeurId AND v.dateHeureDepart >= :date")
    List<Voyage> findByChauffeurIdAndDateHeureDepartAfter(@Param("chauffeurId") Long chauffeurId,
                                                         @Param("date") LocalDateTime date);
}
