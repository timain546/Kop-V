package com.cooperative.transport.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "statut_voyage")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StatutVoyage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, length = 50)
    private String libelle;
}
