package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.StatutVoyage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface StatutVoyageRepository extends JpaRepository<StatutVoyage, Long> {
    Optional<StatutVoyage> findByLibelle(String libelle);
}
