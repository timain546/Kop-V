package com.cooperative.transport.services;

import com.cooperative.transport.entity.MotifPanne;
import com.cooperative.transport.entity.Panne;
import com.cooperative.transport.entity.Voyage;
import com.cooperative.transport.repository.MotifPanneRepository;
import com.cooperative.transport.repository.PanneRepository;
import com.cooperative.transport.repository.VoyageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    public List<MotifPanne> getTousLesMotifs() {
        return motifPanneRepository.findAll();
    }

    public Panne signalerPanne(Long idVoyage, Long idChauffeur, Long idMotifPanne, String lieu, String description, String photoUrl) {
        Voyage voyage = voyageRepository.findById(idVoyage)
                .orElseThrow(() -> new RuntimeException("Voyage introuvable avec l'ID: " + idVoyage));

        MotifPanne motif = motifPanneRepository.findById(idMotifPanne)
                .orElseThrow(() -> new RuntimeException("Motif de panne introuvable avec l'ID: " + idMotifPanne));

        Panne panne = new Panne();
        panne.setVoyage(voyage);
        panne.setIdChauffeur(idChauffeur);
        panne.setDateSignalement(LocalDateTime.now());
        panne.setLieu(lieu);
        panne.setMotifPanne(motif);
        panne.setDescription(description);
        panne.setPhotoUrl(photoUrl);

        return panneRepository.save(panne);
    }
}
