package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Paiement;

public interface PaiementRepository extends JpaRepository<Paiement, Long> {
}
