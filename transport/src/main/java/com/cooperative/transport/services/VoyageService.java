package com.cooperative.transport.services;

import com.cooperative.transport.dto.VoyageListDTO;
import com.cooperative.transport.entities.*;
import com.cooperative.transport.repositories.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class VoyageService {

    private final VoyageRepository voyageRepository;
    private final VoyageStatutRepository voyageStatutRepository;
    private final StatutVoyageRepository statutVoyageRepository;

    public List<VoyageListDTO> getVoyagesByChauffeur(Long chauffeurId) {
        List<Voyage> voyages = voyageRepository.findByChauffeurId(chauffeurId);
        return voyages.stream()
                .map(this::mapToVoyageListDTO)
                .collect(Collectors.toList());
    }

    public List<VoyageListDTO> getUpcomingVoyagesByChauffeur(Long chauffeurId) {
        List<Voyage> voyages = voyageRepository.findByChauffeurIdAndDateHeureDepartAfter(
                chauffeurId, LocalDateTime.now());
        return voyages.stream()
                .map(this::mapToVoyageListDTO)
                .collect(Collectors.toList());
    }

    public List<VoyageListDTO> getVoyagesByChauffeurAndStatut(Long chauffeurId, String statut) {
        List<Voyage> voyages = voyageRepository.findByChauffeurId(chauffeurId);
        return voyages.stream()
                .map(this::mapToVoyageListDTO)
                .filter(dto -> statut.equalsIgnoreCase(dto.getStatutLibelle()))
                .collect(Collectors.toList());
    }

    /**
     * Returns voyages for a chauffeur that are currently "en cours" or have no status yet
     * (i.e., they are in-progress and eligible for panne/arrivée signalement)
     */
    public List<VoyageListDTO> getActiveVoyagesByChauffeur(Long chauffeurId) {
        List<Voyage> voyages = voyageRepository.findByChauffeurId(chauffeurId);
        return voyages.stream()
                .map(this::mapToVoyageListDTO)
                .filter(dto -> {
                    String statut = dto.getStatutLibelle();
                    return statut == null || "en cours".equalsIgnoreCase(statut) || "".equals(statut);
                })
                .collect(Collectors.toList());
    }

    public boolean signalerArrivee(Long voyageId, Long chauffeurId) {
        Optional<Voyage> voyageOpt = voyageRepository.findById(voyageId);
        if (voyageOpt.isEmpty() || !voyageOpt.get().getChauffeur().getId().equals(chauffeurId)) {
            return false;
        }

        Optional<StatutVoyage> statutTermineOpt = statutVoyageRepository.findByLibelle("terminé");
        if (statutTermineOpt.isPresent()) {
            VoyageStatut voyageStatut = new VoyageStatut();
            voyageStatut.setVoyage(voyageOpt.get());
            voyageStatut.setStatut(statutTermineOpt.get());
            voyageStatut.setDateModification(LocalDate.now());
            voyageStatutRepository.save(voyageStatut);
        }

        return true;
    }

    public boolean signalerEnPanne(Long voyageId, Long chauffeurId) {
        Optional<Voyage> voyageOpt = voyageRepository.findById(voyageId);
        if (voyageOpt.isEmpty() || !voyageOpt.get().getChauffeur().getId().equals(chauffeurId)) {
            return false;
        }

        Optional<StatutVoyage> statutPanneOpt = statutVoyageRepository.findByLibelle("en panne");
        if (statutPanneOpt.isPresent()) {
            VoyageStatut voyageStatut = new VoyageStatut();
            voyageStatut.setVoyage(voyageOpt.get());
            voyageStatut.setStatut(statutPanneOpt.get());
            voyageStatut.setDateModification(LocalDate.now());
            voyageStatutRepository.save(voyageStatut);
        }

        return true;
    }

    private VoyageListDTO mapToVoyageListDTO(Voyage voyage) {
        VoyageListDTO dto = new VoyageListDTO();
        dto.setId(voyage.getId());

        if (voyage.getTrajet() != null) {
            if (voyage.getTrajet().getGareDepart() != null) {
                dto.setGareDepart(voyage.getTrajet().getGareDepart().getNom());
                dto.setGareDepartVille(voyage.getTrajet().getGareDepart().getVille());
            }
            if (voyage.getTrajet().getGareArrivee() != null) {
                dto.setGareArrivee(voyage.getTrajet().getGareArrivee().getNom());
                dto.setGareArriveeVille(voyage.getTrajet().getGareArrivee().getVille());
            }
            dto.setDistanceKm(voyage.getTrajet().getDistanceKm());
        }

        dto.setDateHeureDepart(voyage.getDateHeureDepart());
        dto.setDureeEstimeeMinutes(voyage.getDureeEstimeeMinutes());
        dto.setTarif(voyage.getTarif());

        if (voyage.getVehicule() != null) {
            dto.setVehiculeImmatriculation(voyage.getVehicule().getImmatriculation());
            dto.setVehiculeModele(voyage.getVehicule().getModele());
            dto.setVehiculeNombrePlaces(voyage.getVehicule().getNombrePlaces());
            if (voyage.getVehicule().getCategorie() != null) {
                dto.setVehiculeCategorie(voyage.getVehicule().getCategorie().getLibelle());
            }
        }

        Optional<VoyageStatut> latestStatut = voyageStatutRepository.findLatestByVoyageId(voyage.getId());
        if (latestStatut.isPresent() && latestStatut.get().getStatut() != null) {
            dto.setStatutLibelle(latestStatut.get().getStatut().getLibelle());
        }

        return dto;
    }
}
