package com.cooperative.transport.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "places")
public class Place {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_vehicule", nullable = false)
    private Vehicule vehicule;

    @Column(name = "numero", nullable = false, length = 10)
    private String numero;

    @Column(name = "x", nullable = false)
    private Integer x;

    @Column(name = "y", nullable = false)
    private Integer y;

    public Place() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Vehicule getVehicule() { return vehicule; }
    public void setVehicule(Vehicule vehicule) { this.vehicule = vehicule; }

    public String getNumero() { return numero; }
    public void setNumero(String numero) { this.numero = numero; }

    public Integer getX() { return x; }
    public void setX(Integer x) { this.x = x; }

    public Integer getY() { return y; }
    public void setY(Integer y) { this.y = y; }
}
