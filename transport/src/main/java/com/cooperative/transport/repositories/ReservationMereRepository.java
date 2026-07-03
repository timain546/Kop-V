package com.cooperative.transport.repositories;

import java.math.BigDecimal;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.cooperative.transport.entities.ReservationMere;

public interface ReservationMereRepository extends JpaRepository<ReservationMere, Long> {

    @Query("""
        SELECT COUNT(rf) * rf.reservationMere.voyage.tarif
        FROM ReservationFille rf
        WHERE rf.reservationMere = :reservation
        GROUP BY rf.reservationMere.voyage.tarif
    """)
    public BigDecimal getPrixTotal(ReservationMere reservation);
}
