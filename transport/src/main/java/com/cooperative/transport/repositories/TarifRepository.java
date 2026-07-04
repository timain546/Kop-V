package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Tarif;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDateTime;
import java.util.List;

public interface TarifRepository extends JpaRepository<Tarif, Long> {
    List<Tarif> findByDateEnregistrementBetween(LocalDateTime debut, LocalDateTime fin);
    List<Tarif> findAllByOrderByDateEnregistrementDesc();
    List<Tarif> findAllByOrderByDateEnregistrementAsc();
}