package com.cooperative.transport.services;

import java.util.List;
import java.util.Optional;
import java.time.LocalDate;
import java.math.BigDecimal;

import com.cooperative.transport.dto.TrajetDTO;
import com.cooperative.transport.entities.Voyages;
import com.cooperative.transport.entities.Trajets;
import com.cooperative.transport.entities.Gares;
import com.cooperative.transport.repositories.VoyageRepository;
import com.cooperative.transport.repositories.TrajetRepository;
import com.cooperative.transport.repositories.GareRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TrajetService {
    @Autowired
    private VoyageRepository voyageRepo;

    @Autowired
    private TrajetRepository trajetRepo;

    @Autowired
    private GareRepository gareRepo;

    public List<Trajets> findAllTrajets() {
        return trajetRepo.findAllTrajets();
    }

    public List<Gares> findAllGares() {
        return gareRepo.findAll();
    }

    public Optional<Trajets> findTrajetById(Integer id) {
        return trajetRepo.findById(id);
    }

    public void supprimerTrajet(Integer id) throws Exception {
        List<Voyages> voyagesPrevus = voyageRepo.findAllVoyagePrevusByTrajet(id);

        if(!voyagesPrevus.isEmpty()) {
            throw new Exception("Le trajet T-00" + id + " est déjà assigné à un voyage");
        }

        Optional<Trajets> trajetOptional = trajetRepo.findById(id);

        Trajets trajet = trajetOptional.get();
        trajet.setDateSuppression(LocalDate.now());

        // Mettre à jour la date de suppression du trajet dans la base
        trajetRepo.save(trajet);
    }

    public void creerNouveauTrajet(TrajetDTO trajetDTO) throws Exception {
        Trajets nouveautrajet = new Trajets();

        Optional<Gares> gareDepartOptional = gareRepo.findById(trajetDTO.getGareDepart());
        if(gareDepartOptional.isEmpty()) {
            throw new Exception("Impossible de trouver la gare G-00" + trajetDTO.getGareDepart());
        }

        Gares gareDepart = gareDepartOptional.get();

        Optional<Gares> gareArriveeOptional = gareRepo.findById(trajetDTO.getGareArrivee());
        if(gareArriveeOptional.isEmpty()) {
            throw new Exception("Impossible de trouver la gare G-00" + trajetDTO.getGareArrivee());
        }

        Gares gareArrivee = gareArriveeOptional.get();

        nouveautrajet.setId(null);
        nouveautrajet.setGareDepart(gareDepart);
        nouveautrajet.setGareArrivee(gareArrivee);
        nouveautrajet.setDistanceKm(BigDecimal.valueOf(trajetDTO.getDistanceKm()));
        nouveautrajet.setDateSuppression(null);

        Trajets trajetCorrespondant = trajetRepo.findByGareDepartAndGareArrivee(gareDepart.getId(), gareArrivee.getId());

        if(trajetCorrespondant != null) {
            throw new Exception("Le trajet entre les gares " + gareDepart.getNom() + " et " + gareArrivee.getNom() + " existe déjà");
        }

        trajetRepo.save(nouveautrajet);
    }

    public void modifierTrajet(TrajetDTO trajetDTO) throws Exception {
        Trajets trajetAModifier = trajetRepo.findById(trajetDTO.getId())
            .orElseThrow(() -> new Exception("Trajet introuvable avec l'ID " + trajetDTO.getId()));

        Gares gareDepart = gareRepo.findById(trajetDTO.getGareDepart())
            .orElseThrow(() -> new Exception("Impossible de trouver la gare de départ G-00" + trajetDTO.getGareDepart()));

        Gares gareArrivee = gareRepo.findById(trajetDTO.getGareArrivee())
            .orElseThrow(() -> new Exception("Impossible de trouver la gare d'arrivée G-00" + trajetDTO.getGareArrivee()));

        Trajets trajetExistant = trajetRepo.findByGareDepartAndGareArrivee(gareDepart.getId(), gareArrivee.getId());
        if (trajetExistant != null && !trajetExistant.getId().equals(trajetAModifier.getId())) {
            throw new Exception("Un autre trajet existe déjà entre " + gareDepart.getNom() + " et " + gareArrivee.getNom());
        }

        trajetAModifier.setGareDepart(gareDepart);
        trajetAModifier.setGareArrivee(gareArrivee);
        trajetAModifier.setDistanceKm(BigDecimal.valueOf(trajetDTO.getDistanceKm()));

        trajetRepo.save(trajetAModifier);
    }
}
