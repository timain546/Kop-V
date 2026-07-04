package com.cooperative.transport.controllers;

import com.cooperative.transport.entities.Trajets;
import com.cooperative.transport.services.TrajetService;

import org.springframework.ui.Model;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;

@Controller
@RequestMapping("/re")
public class TrajetController {

    @Autowired
    private TrajetService service;

    @GetMapping("/trajet/list")
    public String getListeTrajets(Model model) {
        List<Trajets> trajets = service.findAllTrajets();
        model.addAttribute("trajets", trajets);
        return "re/crud-trajets";
    }

    @GetMapping("/api/trajet/delete/{id}")
    public ResponseEntity<Map<String, Object>> supprimerTrajet(@PathVariable Integer id) {
        Map<String, Object> response = new HashMap<>();

        try {
            Optional<Trajets> trajetOptional = service.findTrajetById(id);

            if(!trajetOptional.isEmpty()) {
                service.supprimerTrajet(id);

                response.put("status", "success");
                response.put("message", "Le trajet T-00" + id + " a été supprimé avec succès!!");
                return ResponseEntity.ok(response);

            } else {
                response.put("status", "error");
                response.put("message", "Trajet introuvable");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

        } catch(Exception e) {
            response.put("status", "error");
            response.put("message", "Une erreur interne s'est produite: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}