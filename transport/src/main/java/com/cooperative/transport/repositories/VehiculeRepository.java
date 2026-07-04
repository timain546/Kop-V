package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Vehicules;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface VehiculeRepository extends JpaRepository<Vehicules, Integer> {

    @Query(value = "SELECT v.* FROM vehicules v WHERE v.id NOT IN (" +
               "  SELECT voy.id_vehicule FROM voyages voy " +
               "  WHERE :dateCible >= voy.date_heure_depart " +
               "  AND :dateCible < (voy.date_heure_depart + (voy.duree_estimee_minutes * INTERVAL '1 minute'))" +
               ") AND v.id NOT IN (SELECT indispo.id_vehicule FROM indisponibilite_vehicule indispo WHERE" +
               " :dateCible >= indispo.date_debut AND :dateCible < indispo.date_fin_estimee)" +
               " AND v.date_vente IS NULL" , nativeQuery = true)
    List<Vehicules> findAllVehiculesDispo(@Param("dateCible") LocalDateTime dateCible);
}