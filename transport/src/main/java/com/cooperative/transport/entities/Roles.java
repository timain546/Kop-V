package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.List;

@Entity
@Table(name="role")
public class Roles {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int id;
    private String libelle;

    @OneToMany(mappedBy="role")
    private List<Employes> employes;

    public Roles(int id, String libelle, List<Employes> employes) {
        this.id = id;
        this.libelle = libelle;
        this.employes = employes;
    }

    public Roles() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public List<Employes> getEmployes() {
        return employes;
    }

    public void setEmployes(List<Employes> employes) {
        this.employes = employes;
    }
}
