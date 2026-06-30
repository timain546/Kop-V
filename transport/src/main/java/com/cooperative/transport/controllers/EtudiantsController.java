package com.cooperative.transport.controllers;

import com.cooperative.transport.entities.Etudiants;
import com.cooperative.transport.services.EtudiantsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class EtudiantsController {

    @Autowired
    private EtudiantsService etudiantsService;

    @GetMapping("/etudiants/list")
    public String getListeEtudiants(Model model) {
        List<Etudiants> etudiants = etudiantsService.findAllEtudiants();
        
        model.addAttribute("listeEtudiants", etudiants);
        return "list-etudiants";
    }
}