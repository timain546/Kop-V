package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "reservations_mere")
@Getter
@Setter
public class ReservationsMere {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "libelle", nullable = false, length = 200)
    private String libelle;

    @ManyToOne
    @JoinColumn(name = "id_voyage", nullable = false)
    private Voyage voyage;

    @ManyToOne
    @JoinColumn(name = "id_client", nullable = false)
    private Client client;

    @Column(name = "date_reservation", nullable = false)
    private LocalDateTime dateReservation;

    @ManyToOne
    @JoinColumn(name = "id_statut_paiement", nullable = false)
    private StatutPaiement statutPaiement;
}
