package com.cooperative.transport.repositories;

import java.math.BigDecimal;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.cooperative.transport.entities.ReservationsMere;

public interface ReservationMereRepository extends JpaRepository<ReservationsMere, Long> {

    @Query("""
        SELECT COUNT(rf) * rf.reservationMere.voyage.tarif
        FROM ReservationsFille rf
        WHERE rf.reservationMere = :reservation
        GROUP BY rf.reservationMere.voyage.tarif
    """)
    public BigDecimal getPrixTotal(ReservationsMere reservation);
}
