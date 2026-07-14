package com.cooperative.transport.controllers;

import com.cooperative.transport.dto.PanneDTO;
import com.cooperative.transport.dto.VoyageListDTO;
import com.cooperative.transport.entities.StatutVoyage;
import com.cooperative.transport.entities.MotifPanne;
import com.cooperative.transport.entities.Utilisateurs;
import com.cooperative.transport.repositories.MotifPanneRepository;
import com.cooperative.transport.services.PanneService;
import com.cooperative.transport.services.VoyageService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.ArrayList;

@Controller
@RequestMapping("/chauffeur")
@RequiredArgsConstructor
public class ChauffeurController {

    private final VoyageService voyageService;
    private final PanneService panneService;
    private final MotifPanneRepository motifPanneRepository;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Utilisateurs chauffeur = (Utilisateurs) session.getAttribute("utilisateur");

        List<VoyageListDTO> allVoyages = voyageService.getVoyagesByChauffeur(chauffeur.getId());
        List<VoyageListDTO> upcomingVoyages = voyageService.getUpcomingVoyagesByChauffeur(chauffeur.getId());
        List<PanneDTO> recentPannes = panneService.getPannesByChauffeur(chauffeur.getId());

        model.addAttribute("allVoyages", allVoyages);
        model.addAttribute("upcomingVoyages", upcomingVoyages);
        model.addAttribute("recentPannes", recentPannes);
        model.addAttribute("chauffeurId", chauffeur.getId());
        model.addAttribute("chauffeur", chauffeur);

        return "chauffeur/chauffeur-dashboard";
    }

    @GetMapping("/voyages")
    public String voyages(HttpSession session, Model model,
                          @RequestParam(required = false) String statut,
                          @RequestParam(required = false) String search) {
        List<VoyageListDTO> voyages = new ArrayList<>();
        List<StatutVoyage> statuts = new ArrayList<>();

        Utilisateurs chauffeur = (Utilisateurs) session.getAttribute("utilisateur");

        if (statut != null && !statut.isEmpty()) {
            voyages = voyageService.getVoyagesByChauffeurAndStatut(chauffeur.getId(), statut);
        } else {
            voyages = voyageService.getVoyagesByChauffeur(chauffeur.getId());
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

        statuts = voyageService.findAllStatutVoyage();

        model.addAttribute("voyages", voyages);
        model.addAttribute("listeStatuts", statuts);
        model.addAttribute("statut", statut);
        model.addAttribute("search", search);
        model.addAttribute("chauffeurId", chauffeur.getId());
        model.addAttribute("chauffeur", chauffeur);

        return "chauffeur/chauffeur-voyages";
    }

    @GetMapping("/signaler-panne")
    public String signalerPanneForm(HttpSession session, Model model, @RequestParam(required = false) Integer voyageId) {
        Utilisateurs chauffeur = (Utilisateurs) session.getAttribute("utilisateur");

        List<VoyageListDTO> voyages = voyageService.getActiveVoyagesByChauffeur(chauffeur.getId());
        List<MotifPanne> motifsPanne = motifPanneRepository.findAll();

        model.addAttribute("voyages", voyages);
        model.addAttribute("chauffeurId", chauffeur.getId());
        model.addAttribute("selectedVoyageId", voyageId);
        model.addAttribute("motifsPanne", motifsPanne);
        model.addAttribute("chauffeur", chauffeur);

        return "chauffeur/chauffeur-signaler-panne";
    }
}
