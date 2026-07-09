package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.FetchType;

import org.locationtech.jts.geom.LineString;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.List;
import java.time.LocalDate;
import java.math.BigDecimal;

import org.locationtech.jts.io.WKTWriter;

@Entity
@Table(name = "trajets")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Trajets {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_gare_depart", nullable = false)
    private Gares gareDepart;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_gare_arrivee", nullable = false)
    private Gares gareArrivee;

    @Column(name = "distance_km", precision = 10, scale = 2)
    private BigDecimal distanceKm;

    @Column(name = "date_suppression")
    private LocalDate dateSuppression;

    @Column(columnDefinition = "geometry(LineString,4326)")
    private LineString trace;

    @OneToMany(mappedBy = "trajet")
    private List<Voyages> voyages;

    public String getTraceAsWkt() {
        if (this.trace == null) return null;
        WKTWriter writer = new WKTWriter();
        return writer.write(this.trace);
    }
}
