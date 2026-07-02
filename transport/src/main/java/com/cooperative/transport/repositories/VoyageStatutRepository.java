package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.VoyageStatut;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoyageStatutRepository extends JpaRepository<VoyageStatut, Long> {
}
