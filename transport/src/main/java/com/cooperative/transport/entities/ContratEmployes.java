package com.cooperative.transport.entities;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;
@Entity
@Table(name = "contrats_employes")
@Getter
@Setter

public class ContratEmployes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private java.sql.Date date_embauche;
    private java.sql.Date date_renvoie;
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="id_employe")
    private Employes employe;

    public ContratEmployes(int id, java.sql.Date date_embauche, java.sql.Date date_renvoie, Employes employe) {
        this.id = id;
        this.date_embauche = date_embauche;
        this.date_renvoie = date_renvoie;
        this.employe = employe;
    }
    public ContratEmployes() {
    }
  
}