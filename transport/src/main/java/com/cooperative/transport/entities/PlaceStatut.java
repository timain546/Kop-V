package com.cooperative.transport.entities;

import org.springframework.data.annotation.Immutable;

import jakarta.persistence.*;

@Entity
@Table(name = "v_places_statuts")
@Immutable
public class PlaceStatut {

    @Id
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id", insertable = false, updatable = false)
    private Place place;

    @ManyToOne
    @JoinColumn(name = "id_voyage", nullable = false)
    private Voyage voyage;

    @Column(name = "occupee", nullable = false)
    private Boolean occupee;

    public PlaceStatut() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Place getPlace() { return place; }
    public void setPlace(Place place) { this.place = place; }

    public Voyage getVoyage() { return voyage; }
    public void setVoyage(Voyage voyage) { this.voyage = voyage; }

    public Boolean getOccupee() { return occupee; }
    public void setOccupee(Boolean occupee) { this.occupee = occupee; }
}
