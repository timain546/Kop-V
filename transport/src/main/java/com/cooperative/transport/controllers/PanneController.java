package com.cooperative.transport.controllers;

import com.cooperative.transport.entity.MotifPanne;
import com.cooperative.transport.services.PanneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class PanneController {

    @Autowired
    private PanneService panneService;

    @GetMapping("/chauffeur/voyage/panne")
    public String afficherFormulairePanne(Model model) {
        List<MotifPanne> motifs = panneService.getTousLesMotifs();
        model.addAttribute("listeMotifs", motifs);
        
        // Simuler un ID voyage et chauffeur pour le moment vu l'absence de session/auth
        model.addAttribute("idVoyage", 1L); 
        
        return "signaler-panne";
    }

    @PostMapping("/chauffeur/voyage/panne")
    public String traiterFormulairePanne(
            @RequestParam("idVoyage") Long idVoyage,
            @RequestParam("lieu") String lieu,
            @RequestParam("idMotif") Long idMotif,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam(value = "photo", required = false) String photoUrl // Mocked pour l'instant
    ) {
        // ID chauffeur simulé = 1L
        Long idChauffeur = 1L; 
        
        panneService.signalerPanne(idVoyage, idChauffeur, idMotif, lieu, description, photoUrl);

        // Rediriger vers la liste des voyages ou une page de succès (pour l'instant la même page avec un paramètre success)
        return "redirect:/chauffeur/voyage/panne?success=true";
    }
}
