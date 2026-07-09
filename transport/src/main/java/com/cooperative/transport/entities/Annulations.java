package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;


@Entity
@Table(name = "annulations")
@Getter
@Setter
public class Annulations {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_reservation", nullable = false)
    private ReservationsMere reservation;

    @Column(name = "date_annulation", nullable = false)
    private LocalDateTime dateAnnulation;

    @Column(name = "frais_annulation", nullable = false)
    private BigDecimal fraisAnnulation;

    @Column(name = "motif", nullable = false, length = 200)
    private String motif;

    @Column(name = "prix_remboursement")
    private BigDecimal prixRemboursement;

    public Annulations() {}


}
