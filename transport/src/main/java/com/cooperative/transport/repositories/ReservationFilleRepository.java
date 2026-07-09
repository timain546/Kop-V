package com.cooperative.transport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.ReservationsFille;
import com.cooperative.transport.entities.ReservationsMere;

public interface ReservationFilleRepository extends JpaRepository<ReservationsFille, Long> {
    List<ReservationsFille> findByReservationMere(ReservationsMere reservationMere);
}
