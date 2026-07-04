package com.cooperative.transport.services;

import com.cooperative.transport.entities.*;
import com.cooperative.transport.repositories.TarifHistoriqueRepository;
import com.cooperative.transport.repositories.TarifRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Service
public class TarifService {

    @Autowired
    private TarifRepository tarifRepository;

    @Autowired
    private TarifHistoriqueRepository tarifHistoriqueRepository;

    // ---------- LECTURE ----------

    public List<Tarif> listerTarifs() {
        return tarifRepository.findAllByOrderByDateEnregistrementDesc();
    }

    public List<Tarif> listerTarifsTries(boolean ascendant) {
        return ascendant
                ? tarifRepository.findAllByOrderByDateEnregistrementAsc()
                : tarifRepository.findAllByOrderByDateEnregistrementDesc();
    }

    public List<Tarif> rechercherParIntervalle(LocalDate debut, LocalDate fin) {
        LocalDateTime debutDateTime = debut.atStartOfDay();
        LocalDateTime finDateTime = fin.atTime(LocalTime.MAX);
        return tarifRepository.findByDateEnregistrementBetween(debutDateTime, finDateTime);
    }

    public Tarif rechercherParId(Long id) {
        return tarifRepository.findById(id).orElse(null);
    }

    // ---------- ECRITURE ----------

    public Tarif ajouterTarif(Trajet trajet, CategorieVehicule categorie, LocalDate dateInsertion, Double prix) {
        Tarif tarif = new Tarif(trajet, categorie, dateInsertion, prix);
        Tarif enregistre = tarifRepository.save(tarif);

        // Historisation : mouvement AJOUT
        TarifHistorique mouvement = new TarifHistorique(
                enregistre, TarifHistorique.TypeMouvement.AJOUT, null, prix);
        tarifHistoriqueRepository.save(mouvement);

        return enregistre;
    }

    @Transactional
    public Tarif modifierTarif(Long id, Double nouveauPrix) {
        Tarif tarif = tarifRepository.findById(id).orElse(null);
        if (tarif == null) return null;

        Double ancienPrix = tarif.getPrixTarif();

        // 1) INSERT d'abord dans l'historique
        TarifHistorique mouvement = new TarifHistorique(
                tarif, TarifHistorique.TypeMouvement.MODIFICATION, ancienPrix, nouveauPrix);
        tarifHistoriqueRepository.save(mouvement);

        // 2) UPDATE ensuite le tarif actif — date ré-générée automatiquement
        tarif.setPrixTarif(nouveauPrix);
        tarif.setDateEnregistrement(LocalDateTime.now());

        return tarifRepository.save(tarif);
    }
    // Pas de suppression physique proposée ici volontairement (cohérent avec ta règle "pas de retrait")
    // Si tu en as besoin plus tard : tarifRepository.deleteById(id);

    // ---------- HISTORIQUE (lecture seule) ----------

    public List<TarifHistorique> listerHistorique() {
        return tarifHistoriqueRepository.findAllByOrderByDateMouvementDesc();
    }

    public List<TarifHistorique> listerHistoriqueTrie(boolean ascendant) {
        return ascendant
                ? tarifHistoriqueRepository.findAllByOrderByDateMouvementAsc()
                : tarifHistoriqueRepository.findAllByOrderByDateMouvementDesc();
    }

    public List<TarifHistorique> rechercherHistoriqueParIntervalle(LocalDate debut, LocalDate fin) {
        LocalDateTime debutDateTime = debut.atStartOfDay();
        LocalDateTime finDateTime = fin.atTime(LocalTime.MAX);
        return tarifHistoriqueRepository.findByDateMouvementBetween(debutDateTime, finDateTime);
    }
}