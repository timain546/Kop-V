package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Pannes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PanneRepository extends JpaRepository<Pannes, Long> {
    List<Pannes> findByChauffeurId(Long chauffeurId);
    List<Pannes> findByVoyageId(Long voyageId);
}
