package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "reservations_fille")
@Getter
@Setter
public class ReservationsFille {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_reservation_mere", nullable = false)
    private ReservationsMere reservationMere;

    @ManyToOne
    @JoinColumn(name = "id_place", nullable = false)
    private Places place;
}
