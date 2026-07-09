package com.cooperative.transport.services;

import com.cooperative.transport.dto.*;
import com.cooperative.transport.entities.*;
import com.cooperative.transport.repositories.*;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Service
public class VoyageService {

    @Autowired
    private VoyageRepository voyageRepository;

    @Autowired
    private StatutVoyageRepository statutVoyageRepository;

    @Autowired
    private VoyageStatutRepository voyageStatutRepository;

    @Autowired
    private TrajetRepository trajetRepository;

    @Autowired
    private VehiculeRepository vehiculeRepository;

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    public List<Voyages> findAllVoyages() {
        return voyageRepository.findAllCatalogueVoyage();
    }

    public List<Trajets> findAllTrajets() {
        return trajetRepository.findAllTrajets();
    }

    public Optional<Voyages> findVoyageById(Integer id) {
        return voyageRepository.findById(id);
    }

    @Transactional
    public void annuler(Voyages voyage) {
        VoyageStatut voyagestatut = new VoyageStatut();
        voyagestatut.setVoyage(voyage);
        Optional<StatutVoyage> statut = statutVoyageRepository.findByLibelle("Annulé");
        StatutVoyage statutAnnule = statut.get();

        voyage.setStatutActuel(statutAnnule);
        voyagestatut.setId(null);
        voyagestatut.setVoyage(voyage);
        voyagestatut.setStatut(statutAnnule);
        voyagestatut.setDateModification(LocalDate.now());

        voyageStatutRepository.save(voyagestatut);
    }

    public List<Vehicules> findAllVehiculesDispo(LocalDateTime dateCible) {
        return vehiculeRepository.findAllVehiculesDispo(dateCible);
    }

    public List<Utilisateurs> findAllChauffeurDispo(LocalDateTime dateCible) {
        return utilisateurRepository.findAllChauffeurDispo(dateCible);
    }

    @Transactional
    public void creerNouveauVoyage(VoyageDTO voyageDTO) throws Exception {

        // Insertion voyage dans la table voyages

        Voyages nouveauVoyage = new Voyages();
        nouveauVoyage.setId(null);

        Optional<Trajets> trajetOptional = trajetRepository.findById(voyageDTO.getIdTrajet());

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

        Optional<Utilisateurs> chauffeurOptional = utilisateurRepository.findById(voyageDTO.getIdChauffeur());
        if(chauffeurOptional.isEmpty()) {
            throw new Exception("Chauffeur introuvable");
        }

        Utilisateurs chauffeur = chauffeurOptional.get();
        nouveauVoyage.setChauffeur(chauffeur);

        Optional<StatutVoyage> statutVoyageOptional = statutVoyageRepository.findByLibelle("Plannifié");
        if(statutVoyageOptional.isEmpty()) {
            throw new Exception("Le statut 'Plannifié' n'existe pas");
        }

        StatutVoyage statutVoyage = statutVoyageOptional.get();
        nouveauVoyage.setStatutActuel(statutVoyage);

        LocalDate dateDepart = voyageDTO.getDateDepart();
        LocalTime heureDepart = voyageDTO.getHeureDepart();
        LocalDateTime dateHeureDepart = dateDepart.atTime(heureDepart);

        nouveauVoyage.setDateHeureDepart(dateHeureDepart);
        nouveauVoyage.setDureeEstimeeMinutes(voyageDTO.getDureeEstimeeMinutes());
        nouveauVoyage.setTarif(BigDecimal.valueOf(voyageDTO.getTarif()));
        nouveauVoyage.setCarburant(BigDecimal.valueOf(voyageDTO.getCarburant()));

        // Insertion d'un nouveau statut

        Voyages voyageEnregistre = voyageRepository.save(nouveauVoyage);

        VoyageStatut nouveauVoyageStatut = new VoyageStatut();
        nouveauVoyageStatut.setId(null);
        nouveauVoyageStatut.setVoyage(voyageEnregistre);

        statutVoyageOptional = statutVoyageRepository.findByLibelle("Plannifié");
        if(statutVoyageOptional.isEmpty()) {
            throw new Exception("Le statut 'Plannifié' n'existe pas");
        }

        statutVoyage = statutVoyageOptional.get();

        nouveauVoyageStatut.setStatut(statutVoyage);
        nouveauVoyageStatut.setDateModification(LocalDate.now());
        voyageStatutRepository.save(nouveauVoyageStatut);
    }


    public List<VoyageListDTO> getVoyagesByChauffeur(Integer chauffeurId) {
        List<Voyages> voyages = voyageRepository.findByChauffeurId(chauffeurId);
        return voyages.stream()
                .map(this::mapToVoyageListDTO)
                .collect(Collectors.toList());
    }

    public List<VoyageListDTO> getUpcomingVoyagesByChauffeur(Integer chauffeurId) {
        List<Voyages> voyages = voyageRepository.findByChauffeurIdAndDateHeureDepartAfter(
                chauffeurId, LocalDateTime.now());
        return voyages.stream()
                .map(this::mapToVoyageListDTO)
                .collect(Collectors.toList());
    }

    public List<VoyageListDTO> getVoyagesByChauffeurAndStatut(Integer chauffeurId, String statut) {
        List<Voyages> voyages = voyageRepository.findByChauffeurId(chauffeurId);
        return voyages.stream()
                .map(this::mapToVoyageListDTO)
                .filter(dto -> statut.equalsIgnoreCase(dto.getStatutLibelle()))
                .collect(Collectors.toList());
    }

    public List<VoyageListDTO> getActiveVoyagesByChauffeur(Integer chauffeurId) {
        List<Voyages> voyages = voyageRepository.findByChauffeurId(chauffeurId);
        return voyages.stream()
                .map(this::mapToVoyageListDTO)
                .filter(dto -> {
                    String statut = dto.getStatutLibelle();
                    return statut == null || "en cours".equalsIgnoreCase(statut) || "".equals(statut);
                })
                .collect(Collectors.toList());
    }

    public boolean signalerArrivee(Integer voyageId, Integer chauffeurId) {
        Optional<Voyages> voyageOpt = voyageRepository.findById(voyageId);
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

    public boolean signalerEnPanne(Integer voyageId, Integer chauffeurId) {
        Optional<Voyages> voyageOpt = voyageRepository.findById(voyageId);
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

    private VoyageListDTO mapToVoyageListDTO(Voyages voyage) {
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
