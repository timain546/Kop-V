package com.cooperative.transport.controllers;

import com.cooperative.transport.dto.VehiculesDisponibleDTO;
import com.cooperative.transport.dto.ChauffeurDTO;
import com.cooperative.transport.dto.VoyageDTO;
import com.cooperative.transport.entities.Voyages;
import com.cooperative.transport.entities.Trajets;
import com.cooperative.transport.entities.Vehicules;
import com.cooperative.transport.entities.Utilisateurs;
import com.cooperative.transport.services.VoyageService;

import org.springframework.ui.Model;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.lang.String;

@Controller
@RequestMapping("/re")
public class VoyageController {

    @Autowired
    private VoyageService service;

    @GetMapping("/voyage/list")
    public String getListeVoyages(@RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size", defaultValue = "10") int size, Model model) {

        Pageable pageable = PageRequest.of(page - 1, size, Sort.by("dateHeureDepart").descending());
        Page<Voyages> pageVoyages = service.findPaginated(pageable);

        Long nbActif = service.findAllVoyages().stream()
                .filter(v -> v.getStatutActuel().getLibelle().equalsIgnoreCase("en cours")).count();

        model.addAttribute("nbActif", nbActif);
        model.addAttribute("listeVoyages", pageVoyages.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageVoyages.getTotalPages());
        model.addAttribute("currentSize", size);

        return "re/liste-voyages";
    }

    @GetMapping("/api/voyage/annuler/{id}")
    public ResponseEntity<Map<String, Object>> annulerVoyage(@PathVariable("id") Integer id) {
        Map<String, Object> response = new HashMap<>();

        try {
            Optional<Voyages> optionalVoyage = service.findVoyageById(id);

            if (!optionalVoyage.isEmpty()) {
                Voyages voyage = optionalVoyage.get();
                String libelleStatut = voyage.getStatutActuel().getLibelle();

                if (libelleStatut.equalsIgnoreCase("En cours") || libelleStatut.equalsIgnoreCase("Terminé")
                        || libelleStatut.equalsIgnoreCase("Annulé")) {
                    response.put("status", "error");
                    response.put("message", "Impossible d'annuler un voyage déjà en cours ou terminé");
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
                }

                // Faire appel à la méthode de service
                service.annuler(voyage);

                response.put("status", "success");
                response.put("message", "Le voyage V-00" + voyage.getId() + " a été annulé avec succès!!");
                return ResponseEntity.ok(response);

            } else {
                response.put("status", "error");
                response.put("message", "Voyage introuvable");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Une erreur interne est survenue : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/voyage/new")
    public String nouveauVoyage(Model model) {
        List<Trajets> trajets = service.findAllTrajets();
        model.addAttribute("listeTrajets", trajets);

        return "re/formulaire-voyage";
    }

    @GetMapping("/api/vehicule-dispo/list")
    public ResponseEntity<List<VehiculesDisponibleDTO>> getListeVehiculesDisponible(
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(value = "heure", required = false) String heureStr) {

        LocalTime heure = (heureStr == null || heureStr.trim().isEmpty())
                ? LocalTime.MIDNIGHT
                : LocalTime.parse(heureStr);

        LocalDateTime dateEtHeure = date.atTime(heure);

        List<Vehicules> vehicules = service.findAllVehiculesDispo(dateEtHeure);

        List<VehiculesDisponibleDTO> vehiculesDTO = vehicules.stream()
                .map(v -> new VehiculesDisponibleDTO(v.getId(), v.getImmatriculation(), v.getModele(),
                        v.getNombrePlaces()))
                .toList();

        return ResponseEntity.ok(vehiculesDTO);
    }

    @GetMapping("/api/chauffeur-dispo/list")
    public ResponseEntity<List<ChauffeurDTO>> getListeChauffeurDisponible(
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(value = "heure", required = false) String heureStr) {
        LocalTime heure = (heureStr == null || heureStr.trim().isEmpty())
                ? LocalTime.MIDNIGHT
                : LocalTime.parse(heureStr);

        LocalDateTime dateEtHeure = date.atTime(heure);

        List<Utilisateurs> chauffeurs = service.findAllChauffeurDispo(dateEtHeure);

        List<ChauffeurDTO> chauffeursDTO = chauffeurs.stream()
                .map(c -> new ChauffeurDTO(c.getId(), c.getNom(), c.getPrenom()))
                .toList();

        return ResponseEntity.ok(chauffeursDTO);
    }

    @PostMapping("/voyage/create")
    public String enregistrerVoyage(@ModelAttribute VoyageDTO voyageDTO, Model model) {
        try {
            Integer dureeMinutes = voyageDTO.getDureeEstimeeMinutes();
            if (dureeMinutes == null) {
                model.addAttribute("errorMessage", "La durée estimée est obligatoire");
                model.addAttribute("listeTrajets", service.findAllTrajets());
                return "re/formulaire-voyage";
            }

            int duree = dureeMinutes.intValue();
            if (duree <= 0) {
                model.addAttribute("errorMessage", "La durée estimée doit être supérieure à zéro");
                model.addAttribute("listeTrajets", service.findAllTrajets());
                return "re/formulaire-voyage";
            }

            Double tarifVoyage = voyageDTO.getTarif();
            if (tarifVoyage == null) {
                model.addAttribute("errorMessage", "Le tarif est obligatoire");
                model.addAttribute("listeTrajets", service.findAllTrajets());
                return "re/formulaire-voyage";
            }

            double tarif = tarifVoyage.doubleValue();
            if (tarif <= 0) {
                model.addAttribute("errorMessage", "Le tarif doit être supérieur à zéro");
                model.addAttribute("listeTrajets", service.findAllTrajets());
                return "re/formulaire-voyage";
            }

            Double carburant = voyageDTO.getCarburant();
            if (carburant == null) {
                model.addAttribute("errorMessage", "Le carburant est obligatoire");
                model.addAttribute("listeTrajets", service.findAllTrajets());
                return "re/formulaire-voyage";
            }

            double carburantValue = carburant.doubleValue();
            if (carburantValue <= 0) {
                model.addAttribute("errorMessage", "Le carburant doit être supérieur à zéro");
                model.addAttribute("listeTrajets", service.findAllTrajets());
                return "re/formulaire-voyage";
            }

            service.creerNouveauVoyage(voyageDTO);
            return "redirect:/re/voyage/list";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Une erreur interne est survenue: " + e.getMessage());
            model.addAttribute("listeTrajets", service.findAllTrajets());
            return "re/formulaire-voyage";
        }
    }
}
