package com.cooperative.transport.controllers;

import com.cooperative.transport.services.DepenseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;

@Controller
public class DepenseController {

    @Autowired
    private DepenseService depenseService;

    @GetMapping("/depenses")
    public String afficherDepenses(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateDebut,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFin,
            @RequestParam(required = false) Integer mois,
            @RequestParam(required = false) Integer annee,
            Model model) {

        LocalDate debut = dateDebut;
        LocalDate fin = dateFin;

        // Le filtre mois/année a priorité sur le filtre date libre s'il est renseigné
        if (mois != null && annee != null) {
            debut = LocalDate.of(annee, mois, 1);
            fin = debut.withDayOfMonth(debut.lengthOfMonth());
        } else if (annee != null) {
            debut = LocalDate.of(annee, 1, 1);
            fin = LocalDate.of(annee, 12, 31);
        }

        double depenseVehicules;
        double depenseSalaires;
        double depenseReparations;

        if (debut != null && fin != null) {
            depenseVehicules = depenseService.calculerDepenseVehiculesEntre(debut, fin);
            depenseSalaires = depenseService.calculerDepenseSalairesEntre(debut, fin);
            depenseReparations = depenseService.calculerDepenseReparationsEntre(debut, fin);
        } else {
            depenseVehicules = depenseService.calculerDepenseVehicules();
            depenseSalaires = depenseService.calculerDepenseSalaires();
            depenseReparations = depenseService.calculerDepenseReparations();
        }

        double depenseTotale = depenseVehicules + depenseSalaires + depenseReparations;

        model.addAttribute("depenseVehicules", depenseVehicules);
        model.addAttribute("depenseSalaires", depenseSalaires);
        model.addAttribute("depenseReparations", depenseReparations);
        model.addAttribute("depenseTotale", depenseTotale);
        model.addAttribute("dateDebut", dateDebut);
        model.addAttribute("dateFin", dateFin);
        model.addAttribute("mois", mois);
        model.addAttribute("annee", annee);

        return "depenses";
    }
}
