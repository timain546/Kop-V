package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Entity
@Table(name = "reparation")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reparation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_panne")
    private Panne panne;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_statut_reparation")
    private StatutReparation statutReparation;

    @Column(name = "date_modification")
    private LocalDate dateModification;
}
