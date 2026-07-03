package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Annulation;

public interface AnnulationRepository extends JpaRepository<Annulation, Long> {
}
