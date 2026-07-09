package com.cooperative.transport.services;

import com.cooperative.transport.dto.PanneDTO;
import com.cooperative.transport.entities.*;
import com.cooperative.transport.repositories.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class PanneService {

    private final PanneRepository panneRepository;
    private final VoyageRepository voyageRepository;
    private final MotifPanneRepository motifPanneRepository;
    private final VoyageService voyageService;
    private final StatutReparationRepository statutReparationRepository;

    public PanneDTO createPanne(Integer voyageId, Integer chauffeurId, String lieu, String motifPanneLibelle,
            String description, String photoUrl) {
        Optional<Voyages> voyageOpt = voyageRepository.findById(voyageId);
        if (voyageOpt.isEmpty() || !voyageOpt.get().getChauffeur().getId().equals(chauffeurId)) {
            throw new IllegalArgumentException("Voyage non trouvé ou accès refusé");
        }

        Optional<MotifPanne> motifPanneOpt = motifPanneRepository.findByLibelle(motifPanneLibelle);
        if (motifPanneOpt.isEmpty()) {
            throw new IllegalArgumentException("Motif de panne non trouvé");
        }

        Optional<StatutReparation> statuReparation = 

        Pannes panne = new Pannes();
        panne.setVoyage(voyageOpt.get());
        panne.setChauffeur(voyageOpt.get().getChauffeur());
        panne.setDateSignalement(LocalDate.now());
        panne.setLieu(lieu);
        panne.setMotifPanne(motifPanneOpt.get());
        panne.setDescription(description);
        panne.setPhotoUrl(photoUrl);

        Pannes savedPanne = panneRepository.save(panne);

        // Update voyage status to "en panne"
        voyageService.signalerEnPanne(voyageId, chauffeurId);

        return mapToPanneDTO(savedPanne);
    }

    public List<PanneDTO> getPannesByChauffeur(Integer chauffeurId) {
        List<Pannes> pannes = panneRepository.findByChauffeurId(chauffeurId);
        return pannes.stream()
                .map(this::mapToPanneDTO)
                .collect(Collectors.toList());
    }

    private PanneDTO mapToPanneDTO(Pannes panne) {
        PanneDTO dto = new PanneDTO();
        dto.setId(panne.getId());
        dto.setVoyageId(panne.getVoyage() != null ? panne.getVoyage().getId() : null);
        dto.setDateSignalement(panne.getDateSignalement());
        dto.setLieu(panne.getLieu());
        dto.setDescription(panne.getDescription());
        dto.setPhotoUrl(panne.getPhotoUrl());

        if (panne.getMotifPanne() != null) {
            dto.setMotifPanneLibelle(panne.getMotifPanne().getLibelle());
        }

        return dto;
    }

    public List<Pannes> findAllPannesSignale() {
        return panneRepository.findAllPannesSignale();
    }
}
