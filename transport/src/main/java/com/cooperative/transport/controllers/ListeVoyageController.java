package com.cooperative.transport.controllers;

import com.cooperative.transport.services.ListeVoyageService;
import com.cooperative.transport.services.VoyageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ListeVoyageController  {

    private final ListeVoyageService listeVoyageService;

    public ListeVoyageController(ListeVoyageService listeVoyageService) {
        this.listeVoyageService = listeVoyageService;
    }

    @GetMapping("/voyage")
    public String getListeVoyage(@RequestParam String date1,
    @RequestParam String date2, @RequestParam String villeDepart, @RequestParam String villeArrive, @RequestParam Integer nbPlaces,Model model){
       model.addAttribute("listeVoyage",listeVoyageService.getVoyages(date1, date2, nbPlaces, villeDepart, villeArrive));
       
        return "/voyage/liste";
    }
}