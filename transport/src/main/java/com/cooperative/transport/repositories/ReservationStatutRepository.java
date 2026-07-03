package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.ReservationStatut;

public interface ReservationStatutRepository extends JpaRepository<ReservationStatut, Long> {
}
