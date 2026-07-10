package com.cooperative.transport.entities;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OrderBy;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.locationtech.jts.io.WKTWriter;

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
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_voyage")
    private Voyages voyage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_chauffeur")
    private Utilisateurs chauffeur;

    @Column(name = "date_signalement")
    private java.time.LocalDate dateSignalement;

    @Column(name = "lieu", columnDefinition = "geometry(Point,4326)")
    private org.locationtech.jts.geom.Point lieu;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_motif_panne")
    private MotifPanne motifPanne;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "photo_url", length = 255)
    private String photoUrl;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_statut_reparation_actuel")
    private StatutReparation statutReparationActuel;

    @OneToMany(mappedBy = "panne")
    @OrderBy("dateModification DESC")
    private List<Reparation> reparations;

    public String getLieuAsWkt() {
        if (this.lieu == null) return null;
        WKTWriter writer = new WKTWriter();
        return writer.write(this.lieu);
    }
}
