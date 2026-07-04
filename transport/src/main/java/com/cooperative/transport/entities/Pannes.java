package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "pannes")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Pannes {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_voyage")
    private Voyage voyage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_chauffeur")
    private Utilisateur chauffeur;

    @Column(name = "date_signalement")
    private java.time.LocalDate dateSignalement;

    @Column(name = "lieu", length = 255)
    private String lieu;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_motif_panne")
    private MotifPanne motifPanne;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "photo_url", length = 500)
    private String photoUrl;
}
