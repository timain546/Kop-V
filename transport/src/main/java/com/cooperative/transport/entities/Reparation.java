package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "reparation")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Reparation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_panne", nullable = false)
    private Panne panne;

    @ManyToOne
    @JoinColumn(name = "id_statut_reparation", nullable = false)
    private StatutReparation statutReparation;

    @Column(name = "date_modification", nullable = false)
    private LocalDateTime dateModification;
}
