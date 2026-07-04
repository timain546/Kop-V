package com.cooperative.transport.entities;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "reservation_statut")
@Getter
@Setter
public class ReservationStatut {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_reservation", nullable = false)
    private ReservationsMere reservation;

    @ManyToOne
    @JoinColumn(name = "id_statut", nullable = false)
    private StatutReservation statut;

    @Column(name = "date_modification")
    private LocalDateTime dateModification;
}
