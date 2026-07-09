package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "places")
@Getter
@Setter
public class Places {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_vehicule", nullable = false)
    private Vehicules vehicule;

    @Column(name = "numero", nullable = false, length = 10)
    private String numero;

    @Column(name = "x", nullable = false)
    private Integer x;

    @Column(name = "y", nullable = false)
    private Integer y;

    public Places() {}

}
