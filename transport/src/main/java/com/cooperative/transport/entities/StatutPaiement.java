package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "statut_paiement")
@Getter
@Setter
public class StatutPaiement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "libelle", nullable = false, length = 50)
    private String libelle;
}
