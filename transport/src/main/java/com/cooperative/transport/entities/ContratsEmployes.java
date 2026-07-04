package com.cooperative.transport.entities;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.sql.Date;

@Entity
@Table(name = "contrats_employes")
@Getter
@Setter
public class ContratsEmployes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "date_embauche")
    private java.sql.Date dateEmbauche;
    @Column(name = "date_renvoie")
    private java.sql.Date dateRenvoie;
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="id_employe")
    private Utilisateurs employe;

    public ContratsEmployes(int id, java.sql.Date dateEmbauche, java.sql.Date dateRenvoie, Utilisateurs employe) {
        this.id = id;
        this.dateEmbauche = dateEmbauche;
        this.dateRenvoie = dateRenvoie;
        this.employe = employe;
    }

    public ContratsEmployes() {
    }

}
