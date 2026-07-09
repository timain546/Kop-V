package com.cooperative.transport.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.StatutReservation;

public interface StatutReservationRepository extends JpaRepository<StatutReservation, Long> {

    public Optional<StatutReservation> findByLibelle(String libelle);
}
