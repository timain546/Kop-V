package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "reparation")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Reparation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_panne")
    private Pannes panne;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_statut_reparation")
    private StatutReparation statutReparation;

    @Column(name = "date_modification")
    private LocalDate dateModification;
}
