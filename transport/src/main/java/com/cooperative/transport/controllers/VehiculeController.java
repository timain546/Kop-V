package com.cooperative.transport.controllers;

import com.cooperative.transport.entities.CategorieVehicule;
import com.cooperative.transport.entities.Vehicule;
import com.cooperative.transport.services.VehiculeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/vehicules")
public class VehiculeController {

    @Autowired
    private VehiculeService vehiculeService;

    @GetMapping
    public String afficherVehicules(Model model) {
        var vehicules = vehiculeService.listerVehicules();

        // Pré-calcul du statut "hors service" et du dernier motif pour chaque véhicule,
        // pour éviter de refaire des appels service directement dans le JSP.
        Map<Long, Boolean> statutHorsService = new HashMap<>();
        Map<Long, Object> derniersMotifs = new HashMap<>();
        for (Vehicule v : vehicules) {
            statutHorsService.put(v.getId(), vehiculeService.estHorsService(v.getId()));
            derniersMotifs.put(v.getId(), vehiculeService.getDernierMotif(v.getId()));
        }

        model.addAttribute("vehicules", vehicules);
        model.addAttribute("categories", CategorieVehicule.values());
        model.addAttribute("statutHorsService", statutHorsService);
        model.addAttribute("derniersMotifs", derniersMotifs);
        return "vehicules";
    }

        @PostMapping("/ajouter")
    public String ajouterVehicule(
            @RequestParam String immatriculation,
            @RequestParam String marque,
            @RequestParam String modele,
            @RequestParam Integer nombrePlaces,
            @RequestParam CategorieVehicule categorie,
            @RequestParam Double prixAchat) {

        Vehicule vehicule = new Vehicule(immatriculation, marque, modele, nombrePlaces, categorie, prixAchat);
        vehiculeService.ajouterVehicule(vehicule);
        return "redirect:/vehicules";
    }

    @PostMapping("/modifier/{id}")
    public String modifierVehicule(
            @PathVariable Long id,
            @RequestParam String immatriculation,
            @RequestParam CategorieVehicule categorie) {

        vehiculeService.modifierVehicule(id, immatriculation, categorie);
        return "redirect:/vehicules";
    }
    @PostMapping("/vendre/{id}")
    public String vendreVehicule(@PathVariable Long id) {
        vehiculeService.marquerAVendre(id);
        return "redirect:/vehicules";
    }

    // Pas de route "/supprimer" : suppression physique volontairement retirée
}