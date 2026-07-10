package com.cooperative.transport.repositories;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.cooperative.transport.entities.Reparation;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.math.BigDecimal;

@Repository
public interface ReparationRepository extends JpaRepository<Reparation, Integer> {
    @Query("SELECT COALESCE(SUM(r.cout), 0) FROM Reparation r WHERE year(r.dateModification) = :year AND month(r.dateModification) = :month and r.statutReparation.id=3")
    BigDecimal getTotalReparationsParMois(int month,int year);
}