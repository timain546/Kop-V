package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.VoyageStatut;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface VoyageStatutRepository extends JpaRepository<VoyageStatut, Integer> {
    List<VoyageStatut> findByVoyageIdOrderByDateModificationDesc(Integer voyageId);

    @Query("SELECT vs FROM VoyageStatut vs WHERE vs.voyage.id = :voyageId ORDER BY vs.dateModification DESC LIMIT 1")
    Optional<VoyageStatut> findLatestByVoyageId(@Param("voyageId") Integer voyageId);
}
