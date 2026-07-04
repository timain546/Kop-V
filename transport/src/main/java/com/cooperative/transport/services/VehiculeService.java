package com.cooperative.transport.services;

import com.cooperative.transport.entities.CategorieVehicule;
import com.cooperative.transport.entities.IndisponibiliteVehicule;
import com.cooperative.transport.entities.Vehicule;
import com.cooperative.transport.repositories.IndisponibiliteVehiculeRepository;
import com.cooperative.transport.repositories.VehiculeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class VehiculeService {

    @Autowired
    private VehiculeRepository vehiculeRepository;

    @Autowired
    private IndisponibiliteVehiculeRepository indisponibiliteRepository;

    // ⚠️ TODO : remplacer par un vrai appel à VoyageRepository une fois que ton binôme
    // aura fini le module Voyage. Pour l'instant, on suppose qu'il n'y a jamais de
    // voyage futur planifié (donc la détection "hors service" repose uniquement sur la panne).
    // Signature prévue plus tard : voyageRepository.existsVoyageFuturPourVehicule(idVehicule)
    private boolean aUnVoyageFutur(Long idVehicule) {
        return false; // stub temporaire — À BRANCHER avec le vrai module Voyage
    }

    public List<Vehicule> listerVehicules() {
        return vehiculeRepository.findAll();
    }

    public Vehicule rechercherParId(Long id) {
        return vehiculeRepository.findById(id).orElse(null);
    }

    public Vehicule ajouterVehicule(Vehicule vehicule) {
        return vehiculeRepository.save(vehicule);
    }

    public Vehicule modifierVehicule(Long id, String immatriculation, CategorieVehicule categorie) {
    Vehicule vehicule = vehiculeRepository.findById(id).orElse(null);
    if (vehicule == null) return null;

    vehicule.setImmatriculation(immatriculation);
    vehicule.setCategorie(categorie);

    return vehiculeRepository.save(vehicule);
    }

    // Un véhicule est "hors service" si : en panne ET aucun voyage futur planifié
    public boolean estHorsService(Long idVehicule) {
        Vehicule vehicule = vehiculeRepository.findById(idVehicule).orElse(null);
        if (vehicule == null || vehicule.getDateVente() != null) return false;

        Optional<IndisponibiliteVehicule> panne = indisponibiliteRepository
                .findFirstByVehiculeAndMotifOrderByDateDebutDesc(
                        vehicule, IndisponibiliteVehicule.MotifIndisponibilite.EN_PANNE);

        boolean estEnPanne = panne.isPresent();
        boolean voyageFutur = aUnVoyageFutur(idVehicule);

        return estEnPanne && !voyageFutur;
    }

    // Retourne le motif d'indisponibilité le plus récent pour l'affichage, ou null si aucun
    public IndisponibiliteVehicule.MotifIndisponibilite getDernierMotif(Long idVehicule) {
        Vehicule vehicule = vehiculeRepository.findById(idVehicule).orElse(null);
        if (vehicule == null) return null;
        return indisponibiliteRepository.findFirstByVehiculeOrderByDateDebutDesc(vehicule)
                .map(IndisponibiliteVehicule::getMotif)
                .orElse(null);
    }

    // Marque le véhicule comme "à vendre" : action définitive, jamais réinitialisée
    public Vehicule marquerAVendre(Long idVehicule) {
        Vehicule vehicule = vehiculeRepository.findById(idVehicule).orElse(null);
        if (vehicule == null || vehicule.getDateVente() != null) return vehicule;

        vehicule.setDateVente(LocalDate.now());
        return vehiculeRepository.save(vehicule);
    }
}