package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.ModePaiement;

public interface ModePaiementRepository extends JpaRepository<ModePaiement, Long> {
}
