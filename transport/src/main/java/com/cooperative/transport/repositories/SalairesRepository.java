package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Salaires;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.sql.Date;

public interface SalairesRepository extends JpaRepository<Salaires, Integer> {

    @Query("SELECT COALESCE(SUM(s.salaire), 0) FROM Salaires s")
    Double sumTotalSalaires();

    @Query("SELECT COALESCE(SUM(s.salaire), 0) FROM Salaires s WHERE s.date_modification BETWEEN :debut AND :fin")
    Double sumSalairesEntre(@Param("debut") Date debut, @Param("fin") Date fin);
}
