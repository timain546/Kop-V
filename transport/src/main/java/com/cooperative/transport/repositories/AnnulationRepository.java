package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Annulations;
import org.springframework.data.jpa.repository.Query;
import java.math.BigDecimal;

public interface AnnulationRepository extends JpaRepository<Annulations, Integer> {
    @Query("SELECT COALESCE(SUM(a.fraisAnnulation), 0) FROM Annulations a WHERE year(a.dateAnnulation) = :year AND month(a.dateAnnulation) = :month")
    BigDecimal getTotalAnnulationsParMois(int month,int year);
    @Query("SELECT COALESCE(SUM(a.prixRemboursement), 0) FROM Annulations a WHERE year(a.dateAnnulation) = :year AND month(a.dateAnnulation) = :month")
    BigDecimal getTotalRemboursementParMois(int month,int year);
}
