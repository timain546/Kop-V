package com.cooperative.transport.repositories;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cooperative.transport.entities.Reparation;

public interface ReparationRepository extends JpaRepository<Reparation, Long> {

    /*
     * Une panne peut avoir plusieurs lignes d'historique dans "reparation"
     * (en_attente -> en_cours -> resolu). On ne compte comme dépense que la ligne
     * dont le statut correspond au statut ACTUEL de la panne
     * (pannes.id_statut_reparation_actuel), pour éviter de compter deux fois
     * la même réparation si son statut a été modifié plusieurs fois.
     */
    @Query(value =
        "SELECT COALESCE(SUM(r.cout), 0) " +
        "FROM reparation r " +
        "JOIN pannes p ON p.id = r.id_panne AND p.id_statut_reparation_actuel = r.id_statut_reparation " +
        "JOIN statut_reparation sr ON sr.id = r.id_statut_reparation " +
        "WHERE sr.libelle = 'resolu'",
        nativeQuery = true)
    Double sumCoutReparationsResolues();

    @Query(value =
        "SELECT COALESCE(SUM(r.cout), 0) " +
        "FROM reparation r " +
        "JOIN pannes p ON p.id = r.id_panne AND p.id_statut_reparation_actuel = r.id_statut_reparation " +
        "JOIN statut_reparation sr ON sr.id = r.id_statut_reparation " +
        "WHERE sr.libelle = 'résolu' " +
        "AND r.date_modification BETWEEN :debut AND :fin",
        nativeQuery = true)
    Double sumCoutReparationsResoluesEntre(@Param("debut") LocalDate debut, @Param("fin") LocalDate fin);
}