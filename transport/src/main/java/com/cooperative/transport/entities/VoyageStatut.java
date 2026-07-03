package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Entity
@Table(name = "voyage_statut")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class VoyageStatut {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_voyage")
    private Voyage voyage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_statut")
    private StatutVoyage statut;

    @Column(name = "date_modification")
    private LocalDate dateModification;
}
