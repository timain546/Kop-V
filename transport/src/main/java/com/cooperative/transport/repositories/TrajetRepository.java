package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Gares;
import com.cooperative.transport.entities.Trajets;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface TrajetRepository extends JpaRepository<Trajets, Long> {

    public Optional<Trajets> findByGareDepartAndGareArrivee(Gares gareDepart, Gares gareArrivee);
}
