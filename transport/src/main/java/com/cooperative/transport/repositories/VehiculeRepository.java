package com.cooperative.transport.repositories;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cooperative.transport.entities.Vehicule;

public interface VehiculeRepository extends JpaRepository<Vehicule, Long> {

    @Query("SELECT COALESCE(SUM(v.prixAchat), 0) FROM Vehicule v")
    Double sumPrixAchat();

    @Query("SELECT COALESCE(SUM(v.prixAchat), 0) FROM Vehicule v WHERE v.dateAchat BETWEEN :debut AND :fin")
    Double sumPrixAchatEntre(@Param("debut") LocalDate debut, @Param("fin") LocalDate fin);
}