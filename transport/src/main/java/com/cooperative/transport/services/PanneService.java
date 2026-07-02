package com.cooperative.transport.services;

import com.cooperative.transport.entities.*;
import com.cooperative.transport.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class PanneService {

    @Autowired
    private MotifPanneRepository motifPanneRepository;

    @Autowired
    private PanneRepository panneRepository;

    @Autowired
    private VoyageRepository voyageRepository;

    @Autowired
    private StatutVoyageRepository statutVoyageRepository;

    @Autowired
    private VoyageStatutRepository voyageStatutRepository;

    @Autowired
    private StatutReparationRepository statutReparationRepository;

    @Autowired
    private ReparationRepository reparationRepository;

    public List<MotifPanne> getTousLesMotifs() {
        return motifPanneRepository.findAll();
    }

    @Transactional
    public Panne signalerPanne(Long idVoyage, Long idChauffeur, Long idMotifPanne, String lieu, String description, String photoUrl) {
        // 1. Récupérer le Voyage
        Voyage voyage = voyageRepository.findById(idVoyage)
                .orElseThrow(() -> new RuntimeException("Voyage introuvable avec l'ID : " + idVoyage));

        // 2. Récupérer le Motif de panne
        MotifPanne motif = motifPanneRepository.findById(idMotifPanne)
                .orElseThrow(() -> new RuntimeException("Motif de panne introuvable avec l'ID : " + idMotifPanne));

        // 3. Créer et enregistrer la Panne
        Panne panne = new Panne();
        panne.setVoyage(voyage);
        panne.setIdChauffeur(idChauffeur);
        panne.setDateSignalement(LocalDateTime.now());
        panne.setLieu(lieu);
        panne.setMotifPanne(motif);
        panne.setDescription(description);
        panne.setPhotoUrl(photoUrl);
        Panne savedPanne = panneRepository.save(panne);

        // 4. Mettre à jour le statut du Voyage vers "en panne"
        StatutVoyage statutEnPanne = statutVoyageRepository.findByLibelle("en panne")
                .orElseThrow(() -> new RuntimeException("Statut de voyage 'en panne' introuvable en base."));

        VoyageStatut voyageStatut = new VoyageStatut();
        voyageStatut.setVoyage(voyage);
        voyageStatut.setStatut(statutEnPanne);
        voyageStatut.setDateModification(LocalDateTime.now());
        voyageStatutRepository.save(voyageStatut);

        // 5. Créer automatiquement une Réparation au statut "en attente"
        StatutReparation statutEnAttente = statutReparationRepository.findByLibelle("en attente")
                .orElseThrow(() -> new RuntimeException("Statut de réparation 'en attente' introuvable en base."));

        Reparation reparation = new Reparation();
        reparation.setPanne(savedPanne);
        reparation.setStatutReparation(statutEnAttente);
        reparation.setDateModification(LocalDateTime.now());
        reparationRepository.save(reparation);

        return savedPanne;
    }
}
