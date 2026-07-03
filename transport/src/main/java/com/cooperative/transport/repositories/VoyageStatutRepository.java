package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Voyage;
import com.cooperative.transport.entities.VoyageStatut;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface VoyageStatutRepository extends JpaRepository<VoyageStatut, Long> {
    List<VoyageStatut> findByVoyageIdOrderByDateModificationDesc(Long voyageId);
    
    @Query("SELECT vs FROM VoyageStatut vs WHERE vs.voyage.id = :voyageId ORDER BY vs.dateModification DESC")
    Optional<VoyageStatut> findLatestByVoyageId(@Param("voyageId") Long voyageId);
}
