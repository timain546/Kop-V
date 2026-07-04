package com.cooperative.transport.entities;

import org.springframework.data.annotation.Immutable;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "v_places_statuts")
@Immutable
@Getter
@Setter
public class PlaceStatut {

    @Id
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id", insertable = false, updatable = false, foreignKey = @ForeignKey(ConstraintMode.NO_CONSTRAINT))
    private Place place;

    @ManyToOne
    @JoinColumn(name = "id_voyage", nullable = false, foreignKey = @ForeignKey(ConstraintMode.NO_CONSTRAINT))
    private Voyage voyage;

    @Column(name = "occupee", nullable = false)
    private Boolean occupee;

    public PlaceStatut() {}

}
