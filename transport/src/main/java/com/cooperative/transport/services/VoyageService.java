package com.cooperative.transport.services;

import com.cooperative.transport.dto.*;
import com.cooperative.transport.entities.*;
import com.cooperative.transport.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Service
public class VoyageService {

    @Autowired
    private VoyageRepository voyageRepository;

    @Autowired
    private StatutVoyageRepository statutVoyageRepo;

    @Autowired
    private VoyageStatutRepository voyageStatutRepo;

    @Autowired
    private TrajetRepository trajetRepo;

    @Autowired
    private VehiculeRepository vehiculeRepository;

    @Autowired
    private UtilisateurRepository utilisateurRepo;

    public List<Voyages> findAllVoyages() {
        return voyageRepository.findAllCatalogueVoyage();
    }

    public List<Trajets> findAllTrajets() {
        return trajetRepo.findAllTrajets();
    }

    public Optional<Voyages> findVoyageById(Integer id) {
        return voyageRepository.findById(id);
    }

    public void annuler(Voyages voyage) {
        VoyageStatut voyagestatut = new VoyageStatut();
        voyagestatut.setVoyage(voyage);
        Optional<StatutVoyage> statut = statutVoyageRepo.findByLibelle("Annulé");
        StatutVoyage statutAnnule = statut.get();
        voyagestatut.setStatut(statutAnnule);
        voyagestatut.setDateModification(LocalDate.now());

        voyageStatutRepo.save(voyagestatut);
    }

    public List<Vehicules> findAllVehiculesDispo(LocalDateTime dateCible) {
        return vehiculeRepository.findAllVehiculesDispo(dateCible);
    }

    public List<Utilisateurs> findAllChauffeurDispo(LocalDateTime dateCible) {
        return utilisateurRepo.findAllChauffeurDispo(dateCible);
    }

    public void creerNouveauVoyage(VoyageDTO voyageDTO) throws Exception {

        // Insertion voyage dans la table voyages

        Voyages nouveauVoyage = new Voyages();
        nouveauVoyage.setId(null);

        Optional<Trajets> trajetOptional = trajetRepo.findById(voyageDTO.getIdTrajet());

        if(trajetOptional.isEmpty()) {
            throw new Exception("Trajet T-00" + voyageDTO.getIdTrajet() + " introuvable");
        }

        Trajets trajet = trajetOptional.get();
        nouveauVoyage.setTrajet(trajet);

        Optional<Vehicules> vehiculeOptional = vehiculeRepository.findById(voyageDTO.getIdVehicule());
        if(vehiculeOptional.isEmpty()) {
            throw new Exception("Véhicule V-00" + voyageDTO.getIdVehicule() + " introuvable");
        }

        Vehicules vehicule = vehiculeOptional.get();
        nouveauVoyage.setVehicule(vehicule);

        Optional<Utilisateurs> chauffeurOptional = utilisateurRepo.findById(voyageDTO.getIdChauffeur());
        if(chauffeurOptional.isEmpty()) {
            throw new Exception("Chauffeur introuvable");
        }

        Utilisateurs chauffeur = chauffeurOptional.get();
        nouveauVoyage.setChauffeur(chauffeur);

        LocalDate dateDepart = voyageDTO.getDateDepart();
        LocalTime heureDepart = voyageDTO.getHeureDepart();
        LocalDateTime dateHeureDepart = dateDepart.atTime(heureDepart);

        nouveauVoyage.setDateHeureDepart(dateHeureDepart);

        int duree = voyageDTO.getDureeEstimeeMinutes().intValue();
        if(duree <= 0) {
            throw new Exception("La durée estimée doit être supérieure à zéro");
        }

        nouveauVoyage.setDureeEstimeeMinutes(voyageDTO.getDureeEstimeeMinutes());
        nouveauVoyage.setTarif(BigDecimal.valueOf(voyageDTO.getTarif()));

        // Insertion d'un nouveau statut

        Voyages voyageEnregistre = voyageRepository.save(nouveauVoyage);

        VoyageStatut nouveauVoyageStatut = new VoyageStatut();
        nouveauVoyageStatut.setId(null);
        nouveauVoyageStatut.setVoyage(voyageEnregistre);

        Optional<StatutVoyage> statutVoyageOptional = statutVoyageRepo.findByLibelle("Plannifié");
        if(statutVoyageOptional.isEmpty()) {
            throw new Exception("Le statut 'Plannifié' n'existe pas");
        }

        StatutVoyage statutVoyage = statutVoyageOptional.get();

        nouveauVoyageStatut.setStatut(statutVoyage);
        nouveauVoyageStatut.setDateModification(LocalDate.now());
        voyageStatutRepo.save(nouveauVoyageStatut);
    }
}
