package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Utilisateurs;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.time.LocalDateTime;

@Repository
public interface UtilisateurRepository extends JpaRepository<Utilisateurs, Integer> {
    @Query(value = "SELECT u.* FROM utilisateurs u WHERE u.id_role = (" +
        " SELECT r.id FROM role r WHERE r.libelle = 'Chauffeur')" +
        " AND u.id NOT IN (" +
        " SELECT voy.id_chauffeur FROM voyages voy WHERE" +
        " :dateCible >= voy.date_heure_depart AND" +
        " :dateCible < (voy.date_heure_depart + (voy.duree_estimee_minutes * INTERVAL '1 minute'))" +
        ")", nativeQuery = true)
    List<Utilisateurs> findAllChauffeurDispo(@Param("dateCible") LocalDateTime dateCible);
}