package com.cooperative.transport.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "paiements")
@Getter
@Setter
public class Paiement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_reservation", nullable = false)
    private ReservationMere reservation;

    @Column(name = "montant", nullable = false)
    private BigDecimal montant;

    @ManyToOne
    @JoinColumn(name = "id_mode_paiement", nullable = false)
    private ModePaiement modePaiement;

    @Column(name = "date_paiement", nullable = false)
    private LocalDateTime date;

    @Column(name = "reference_transaction", length = 50)
    private String referenceTransaction;

    public Paiement() {}

}
