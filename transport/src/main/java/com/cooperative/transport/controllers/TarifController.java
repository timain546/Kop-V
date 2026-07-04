package com.cooperative.transport.controllers;

import com.cooperative.transport.entities.CategorieVehicule;
import com.cooperative.transport.entities.Tarif;
import com.cooperative.transport.entities.TarifHistorique;
import com.cooperative.transport.services.TarifService;
import com.cooperative.transport.services.TrajetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/tarifs")
public class TarifController {

    @Autowired
    private TarifService tarifService;

    @Autowired
    private TrajetService trajetService;

    @GetMapping
    public String afficherTarifs(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateDebut,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFin,
            @RequestParam(required = false, defaultValue = "false") boolean asc,
            Model model) {

        List<Tarif> tarifs;
        if (dateDebut != null && dateFin != null) {
            tarifs = tarifService.rechercherParIntervalle(dateDebut, dateFin);
        } else {
            tarifs = tarifService.listerTarifsTries(asc);
        }

        model.addAttribute("tarifs", tarifs);
        model.addAttribute("trajets", trajetService.listerTrajets());
        model.addAttribute("categories", CategorieVehicule.values());
        model.addAttribute("dateDebut", dateDebut);
        model.addAttribute("dateFin", dateFin);
        model.addAttribute("asc", asc);
        return "tarifs";
    }

    @PostMapping("/ajouter")
    public String ajouterTarif(
            @RequestParam Long trajetId,
            @RequestParam CategorieVehicule categorie,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateInsertion,
            @RequestParam Double prix) {

        tarifService.ajouterTarif(
                trajetService.rechercherParId(trajetId),
                categorie,
                dateInsertion,
                prix
        );
        return "redirect:/tarifs";
    }

    @PostMapping("/modifier/{id}")
public String modifierTarif(@PathVariable Long id, @RequestParam Double prix) {
    tarifService.modifierTarif(id, prix);
    return "redirect:/tarifs";
}



    @GetMapping("/historique")
    public String afficherHistorique(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateDebut,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFin,
            @RequestParam(required = false, defaultValue = "false") boolean asc,
            Model model) {

        List<TarifHistorique> historique;
        if (dateDebut != null && dateFin != null) {
            historique = tarifService.rechercherHistoriqueParIntervalle(dateDebut, dateFin);
        } else {
            historique = tarifService.listerHistoriqueTrie(asc);
        }

        model.addAttribute("historique", historique);
        model.addAttribute("dateDebut", dateDebut);
        model.addAttribute("dateFin", dateFin);
        model.addAttribute("asc", asc);
        return "historique-tarifs";
    }
}