package com.cooperative.transport.repositories;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cooperative.transport.entities.Utilisateurs;
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

    @Query("SELECT DISTINCT e,s,r FROM Utilisateurs e LEFT JOIN e.salaires s JOIN e.role r where s.dateModification = (SELECT MAX(s2.dateModification) FROM Salaires s2 WHERE s2.employe.id = e.id ) or s is null")
    List<Object[]> findEmploye();
    @Query("SELECT DISTINCT e,s,r FROM Utilisateurs e LEFT JOIN e.salaires s JOIN e.role r where (s.dateModification = (SELECT MAX(s2.dateModification) FROM Salaires s2 WHERE s2.employe.id = e.id ) or s is null) and e.id = :id")
    List<Object[]> findEmployeById(Integer id);
}
