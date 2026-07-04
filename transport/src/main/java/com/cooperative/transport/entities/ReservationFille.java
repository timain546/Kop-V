package com.cooperative.transport.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "reservations_fille")
public class ReservationFille {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_reservation_mere", nullable = false)
    private ReservationMere reservationMere;

    @ManyToOne
    @JoinColumn(name = "id_place", nullable = false)
    private Place place;

    public ReservationFille() {}

    
}
