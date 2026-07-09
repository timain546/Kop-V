package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Paiements;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.cooperative.transport.entities.ReservationsMere;

public interface PaiementRepository extends JpaRepository<Paiements, Integer> {

    @Query("""
        SELECT SUM(p.montant)
        FROM Paiements p
        WHERE p.reservation = :reservation
    """)
    public Optional<BigDecimal> getPaiementTotal(ReservationsMere reservation);

    public List<Paiements> findByReservation(ReservationsMere reservation);
}
