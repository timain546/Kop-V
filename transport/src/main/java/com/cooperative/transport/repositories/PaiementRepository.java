package com.cooperative.transport.repositories;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.cooperative.transport.entities.Paiement;
import com.cooperative.transport.entities.ReservationMere;

public interface PaiementRepository extends JpaRepository<Paiement, Long> {

    @Query("""
        SELECT SUM(p.montant)
        FROM Paiement p
        WHERE p.reservation = :reservation
    """)
    public BigDecimal getPaiementTotal(ReservationMere reservation);

    public List<Paiement> findByReservation(ReservationMere reservation);
}
