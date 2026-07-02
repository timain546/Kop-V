package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "voyage_statut")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class VoyageStatut {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_voyage")
    private Voyage voyage;

    @ManyToOne
    @JoinColumn(name = "id_statut")
    private StatutVoyage statut;

    @Column(name = "date_modification")
    private LocalDateTime dateModification;
}
