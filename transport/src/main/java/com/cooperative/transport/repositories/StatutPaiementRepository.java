package com.cooperative.transport.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.StatutPaiement;

public interface StatutPaiementRepository extends JpaRepository<StatutPaiement, Integer> {

    public Optional<StatutPaiement> findByLibelle(String libelle);
}
