package com.cooperative.transport.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "mode_paiement")
public class ModePaiement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "libelle", nullable = false, unique = true, length = 50)
    private String libelle;

    public ModePaiement() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
}
