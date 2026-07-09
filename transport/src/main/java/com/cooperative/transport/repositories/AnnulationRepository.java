package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Annulations;

public interface AnnulationRepository extends JpaRepository<Annulations, Integer> {
}
