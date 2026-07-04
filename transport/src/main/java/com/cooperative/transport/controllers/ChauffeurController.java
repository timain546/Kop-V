package com.cooperative.transport.controllers;

import com.cooperative.transport.dto.PanneDTO;
import com.cooperative.transport.dto.VoyageListDTO;
import com.cooperative.transport.entities.MotifPanne;
import com.cooperative.transport.entities.Utilisateurs;
import com.cooperative.transport.repositories.MotifPanneRepository;
import com.cooperative.transport.repositories.UtilisateurRepository;
import com.cooperative.transport.services.PanneService;
import com.cooperative.transport.services.VoyageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/chauffeur")
@RequiredArgsConstructor
public class ChauffeurController {

    private final VoyageService voyageService;
    private final PanneService panneService;
    private final UtilisateurRepository utilisateurRepository;
    private final MotifPanneRepository motifPanneRepository;

    // ID du chauffeur de démonstration (Rakoto Jean, id=2 d'après les données d'insertion)
    private static final Long DEMO_CHAUFFEUR_ID = 2L;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        List<VoyageListDTO> allVoyages = voyageService.getVoyagesByChauffeur(DEMO_CHAUFFEUR_ID);
        List<VoyageListDTO> upcomingVoyages = voyageService.getUpcomingVoyagesByChauffeur(DEMO_CHAUFFEUR_ID);
        List<PanneDTO> recentPannes = panneService.getPannesByChauffeur(DEMO_CHAUFFEUR_ID);
        Optional<Utilisateurs> chauffeurOpt = utilisateurRepository.findById(DEMO_CHAUFFEUR_ID);

        model.addAttribute("allVoyages", allVoyages);
        model.addAttribute("upcomingVoyages", upcomingVoyages);
        model.addAttribute("recentPannes", recentPannes);
        model.addAttribute("chauffeurId", DEMO_CHAUFFEUR_ID);
        chauffeurOpt.ifPresent(chauffeur -> model.addAttribute("chauffeur", chauffeur));

        return "chauffeur-dashboard";
    }

    @GetMapping("/voyages")
    public String voyages(Model model,
                          @RequestParam(required = false) String statut,
                          @RequestParam(required = false) String search) {
        List<VoyageListDTO> voyages;

        if (statut != null && !statut.isEmpty()) {
            if ("a_venir".equals(statut)) {
                voyages = voyageService.getUpcomingVoyagesByChauffeur(DEMO_CHAUFFEUR_ID);
            } else {
                voyages = voyageService.getVoyagesByChauffeurAndStatut(DEMO_CHAUFFEUR_ID, statut.replace("_", " "));
            }
        } else {
            voyages = voyageService.getVoyagesByChauffeur(DEMO_CHAUFFEUR_ID);
        }

        // Apply search filter if provided
        if (search != null && !search.trim().isEmpty()) {
            String searchLower = search.trim().toLowerCase();
            voyages = voyages.stream()
                    .filter(v -> {
                        boolean matchGareDepart = v.getGareDepart() != null && v.getGareDepart().toLowerCase().contains(searchLower);
                        boolean matchGareArrivee = v.getGareArrivee() != null && v.getGareArrivee().toLowerCase().contains(searchLower);
                        boolean matchVille = (v.getGareDepartVille() != null && v.getGareDepartVille().toLowerCase().contains(searchLower))
                                || (v.getGareArriveeVille() != null && v.getGareArriveeVille().toLowerCase().contains(searchLower));
                        boolean matchImmat = v.getVehiculeImmatriculation() != null && v.getVehiculeImmatriculation().toLowerCase().contains(searchLower);
                        boolean matchModele = v.getVehiculeModele() != null && v.getVehiculeModele().toLowerCase().contains(searchLower);
                        boolean matchId = String.valueOf(v.getId()).contains(searchLower);
                        return matchGareDepart || matchGareArrivee || matchVille || matchImmat || matchModele || matchId;
                    })
                    .collect(java.util.stream.Collectors.toList());
        }

        Optional<Utilisateurs> chauffeurOpt = utilisateurRepository.findById(DEMO_CHAUFFEUR_ID);
        model.addAttribute("voyages", voyages);
        model.addAttribute("statut", statut);
        model.addAttribute("search", search);
        model.addAttribute("chauffeurId", DEMO_CHAUFFEUR_ID);
        chauffeurOpt.ifPresent(chauffeur -> model.addAttribute("chauffeur", chauffeur));

        return "chauffeur-voyages";
    }

    @GetMapping("/signaler-panne")
    public String signalerPanneForm(Model model, @RequestParam(required = false) Long voyageId) {
        List<VoyageListDTO> voyages = voyageService.getActiveVoyagesByChauffeur(DEMO_CHAUFFEUR_ID);
        Optional<Utilisateurs> chauffeurOpt = utilisateurRepository.findById(DEMO_CHAUFFEUR_ID);
        List<MotifPanne> motifsPanne = motifPanneRepository.findAll();

        model.addAttribute("voyages", voyages);
        model.addAttribute("chauffeurId", DEMO_CHAUFFEUR_ID);
        model.addAttribute("selectedVoyageId", voyageId);
        model.addAttribute("motifsPanne", motifsPanne);
        chauffeurOpt.ifPresent(chauffeur -> model.addAttribute("chauffeur", chauffeur));

        return "chauffeur-signaler-panne";
    }
}
