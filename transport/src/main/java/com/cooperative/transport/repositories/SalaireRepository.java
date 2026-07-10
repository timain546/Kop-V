package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Salaires;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.math.BigDecimal;

@Repository
public interface SalaireRepository extends JpaRepository<Salaires, Integer> {
    @Query("Select s from Salaires s where s.employe.id=:id order by s.dateModification desc limit 1")
    Salaires findByIdEmp(@Param("id") Integer id);
    @Query("SELECT COALESCE(SUM(s.salaire), 0) FROM Salaires s " +
           "WHERE s.dateModification = (" +
           "    SELECT MAX(s2.dateModification) " +
           "    FROM Salaires s2 " +
           "    WHERE s2.employe.id = s.employe.id " +
           "    AND (YEAR(s2.dateModification) < :annee OR (YEAR(s2.dateModification) = :annee AND MONTH(s2.dateModification) <= :mois))" +
           ") " +
           "AND s.employe.id IN (" +
           "    SELECT es.employe.id FROM EmployeStatut es " +
           "    WHERE es.dateModification = (" +
           "        SELECT MAX(es2.dateModification) " +
           "        FROM EmployeStatut es2 " +
           "        WHERE es2.employe.id = es.employe.id " +
           "        AND (YEAR(es2.dateModification) < :annee OR (YEAR(es2.dateModification) = :annee AND MONTH(es2.dateModification) <= :mois))" +
           "    ) " +
           "    AND es.statutEmploye.id IN (1, 3)" +
           ")")
    BigDecimal getSommeSalaire(
        @Param("mois") int mois,
        @Param("annee") int annee
    );
        }
