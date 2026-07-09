package com.cooperative.transport.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cooperative.transport.entities.Gares;
import com.cooperative.transport.entities.Trajets;

@Repository
public interface TrajetRepository extends JpaRepository<Trajets, Integer> {
    @EntityGraph(attributePaths = {
        "gareDepart",
        "gareArrivee"
    })
    @Query("SELECT t FROM Trajets t WHERE t.dateSuppression IS NULL ORDER BY t.id ASC")
    List<Trajets> findAllTrajets();

    @Query("SELECT t FROM Trajets t WHERE t.gareDepart.id = :gareDepart AND t.gareArrivee.id = :gareArrivee AND t.dateSuppression IS NULL")
    Trajets findByGareDepartAndGareArrivee(@Param("gareDepart") Integer gareDepart, @Param("gareArrivee") Integer gareArrivee);

    public Optional<Trajets> findByGareDepartAndGareArrivee(Gares gareDepart, Gares gareArrivee);
}
