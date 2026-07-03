package com.cooperative.transport.entities;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "annulations")
public class Annulation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_reservation", nullable = false)
    private ReservationMere reservation;

    @Column(name = "date_annulation", nullable = false)
    private LocalDateTime dateAnnulation;

    @Column(name = "frais_annulation", nullable = false)
    private BigDecimal fraisAnnulation;

    @Column(name = "motif", nullable = false, length = 200)
    private String motif;

    public Annulation() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public ReservationMere getReservation() { return reservation; }
    public void setReservation(ReservationMere reservation) { this.reservation = reservation; }
    public LocalDateTime getDateAnnulation() { return dateAnnulation; }
    public void setDateAnnulation(LocalDateTime dateAnnulation) { this.dateAnnulation = dateAnnulation; }
    public BigDecimal getFraisAnnulation() { return fraisAnnulation; }
    public void setFraisAnnulation(BigDecimal fraisAnnulation) { this.fraisAnnulation = fraisAnnulation; }
    public String getMotif() { return motif; }
    public void setMotif(String motif) { this.motif = motif; }
}
