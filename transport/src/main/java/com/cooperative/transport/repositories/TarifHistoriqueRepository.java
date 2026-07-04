package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.TarifHistorique;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDateTime;
import java.util.List;

public interface TarifHistoriqueRepository extends JpaRepository<TarifHistorique, Long> {
    List<TarifHistorique> findByDateMouvementBetween(LocalDateTime debut, LocalDateTime fin);
    List<TarifHistorique> findAllByOrderByDateMouvementDesc();
    List<TarifHistorique> findAllByOrderByDateMouvementAsc();
}