package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Panne;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PanneRepository extends JpaRepository<Panne, Long> {
    List<Panne> findByChauffeurId(Long chauffeurId);
    List<Panne> findByVoyageId(Long voyageId);
}
