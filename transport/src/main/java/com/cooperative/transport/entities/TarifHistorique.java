package com.cooperative.transport.entities;

import jakarta.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "tarif_historique")
public class TarifHistorique {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_tarif", nullable = false)
    private Tarif tarif;

    @Enumerated(EnumType.STRING)
    @Column(name = "type_mouvement", nullable = false)
    private TypeMouvement typeMouvement;

    @Column(name = "prix_avant")
    private Double prixAvant; // null si c'est un AJOUT

    @Column(name = "prix_apres", nullable = false)
    private Double prixApres;

    @Column(name = "date_mouvement", nullable = false)
    private LocalDateTime dateMouvement;

    public enum TypeMouvement { AJOUT, MODIFICATION }

    public TarifHistorique() {}

    public TarifHistorique(Tarif tarif, TypeMouvement typeMouvement, Double prixAvant, Double prixApres) {
        this.tarif = tarif;
        this.typeMouvement = typeMouvement;
        this.prixAvant = prixAvant;
        this.prixApres = prixApres;
        this.dateMouvement = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Tarif getTarif() { return tarif; }
    public void setTarif(Tarif tarif) { this.tarif = tarif; }

    public TypeMouvement getTypeMouvement() { return typeMouvement; }
    public void setTypeMouvement(TypeMouvement typeMouvement) { this.typeMouvement = typeMouvement; }

    public Double getPrixAvant() { return prixAvant; }
    public void setPrixAvant(Double prixAvant) { this.prixAvant = prixAvant; }

    public Double getPrixApres() { return prixApres; }
    public void setPrixApres(Double prixApres) { this.prixApres = prixApres; }

    public LocalDateTime getDateMouvement() { return dateMouvement; }
    public void setDateMouvement(LocalDateTime dateMouvement) { this.dateMouvement = dateMouvement; }

    public Date getDateMouvementAsDate() {
        return dateMouvement != null ? Timestamp.valueOf(dateMouvement) : null;
    }
}