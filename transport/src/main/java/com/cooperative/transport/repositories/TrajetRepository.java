package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Trajets;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TrajetRepository extends JpaRepository<Trajets, Integer> {
    @EntityGraph(attributePaths = {
        "gareDepart",
        "gareArrivee"
    })
    @Query("SELECT t FROM Trajets t WHERE t.date_suppression IS NULL")
    List<Trajets> findAllTrajets();
}