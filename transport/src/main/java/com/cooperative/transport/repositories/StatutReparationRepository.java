package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.StatutReparation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface StatutReparationRepository extends JpaRepository<StatutReparation, Long> {
    Optional<StatutReparation> findByLibelle(String libelle);
}
