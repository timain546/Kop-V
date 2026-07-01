package com.cooperative.transport.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "pannes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Panne {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_voyage")
    private Voyage voyage;

    // TODO: Link to Utilisateur chauffeur when the entity is defined
    @Column(name = "id_chauffeur")
    private Long idChauffeur;

    @Column(name = "date_signalement")
    private LocalDateTime dateSignalement;

    @Column(name = "lieu", nullable = false)
    private String lieu;

    @ManyToOne
    @JoinColumn(name = "id_motif_panne")
    private MotifPanne motifPanne;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "photo_url")
    private String photoUrl;
}
