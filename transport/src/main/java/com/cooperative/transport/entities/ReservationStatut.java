package com.cooperative.transport.entities;

import java.time.LocalDateTime;

import jakarta.persistence.*;

@Entity
@Table(name = "reservation_statut")
public class ReservationStatut {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_reservation", nullable = false)
    private ReservationMere reservation;

    @ManyToOne
    @JoinColumn(name = "id_statut", nullable = false)
    private StatutReservation statut;

    @Column(name = "date_modification")
    private LocalDateTime dateModification;

    public ReservationStatut() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public ReservationMere getReservation() { return reservation; }
    public void setReservation(ReservationMere reservation) { this.reservation = reservation; }

    public StatutReservation getStatut() { return statut; }
    public void setStatut(StatutReservation statut) { this.statut = statut; }

    public LocalDateTime getDateModification() { return dateModification; }
    public void setDateModification(LocalDateTime dateModification) { this.dateModification = dateModification; }
}
