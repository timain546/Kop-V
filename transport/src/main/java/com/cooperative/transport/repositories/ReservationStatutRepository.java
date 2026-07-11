package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.ReservationStatut;
import com.cooperative.transport.entities.ReservationsMere;
import com.cooperative.transport.entities.StatutReservation;

public interface ReservationStatutRepository extends JpaRepository<ReservationStatut, Integer> {

    public boolean existsByReservationAndStatut(ReservationsMere reservation, StatutReservation statut);
}
