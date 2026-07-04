package com.cooperative.transport.controllers;

import com.cooperative.transport.dto.TrajetDTO;
import com.cooperative.transport.entities.Gares;
import com.cooperative.transport.entities.Trajets;
import com.cooperative.transport.services.TrajetService;

import org.springframework.ui.Model;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
        List<Gares> gares = service.findAllGares();

        model.addAttribute("trajets", trajets);
        model.addAttribute("gares", gares);
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

    @PostMapping("/api/trajet/create")
    public ResponseEntity<Map<String, Object>> enregistrerTrajet(@RequestBody TrajetDTO trajetDTO) {
        Map<String, Object> response = new HashMap<>();

        try {
            Integer gareDepart = trajetDTO.getGareDepart();
            Integer gareArrivee = trajetDTO.getGareArrivee();

            if (gareDepart == null || gareArrivee == null) {
                response.put("status", "error");
                response.put("message", "Veuillez sélectionner une gare de départ et une gare d'arrivée.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            if (gareDepart.equals(gareArrivee)) {
                response.put("status", "error");
                response.put("message", "Les trajets doivent être différentes");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            Double distanceKm = trajetDTO.getDistanceKm();
            if(distanceKm == null) {
                response.put("status", "error");
                response.put("message", "Veuillez saisir une distance valide.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            double distance = distanceKm.doubleValue();
            if(distance <= 0) {
                response.put("status", "error");
                response.put("message", "La distance doit être supérieure à zéro.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            service.creerNouveauTrajet(trajetDTO);
            response.put("status", "success");
            response.put("message", "Insertion réussie !!");
            return ResponseEntity.ok(response);

        } catch(Exception e) {
            response.put("status", "error");
            response.put("message", "Une erreur interne s'est produite: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/api/trajet/edit/{id}")
    public ResponseEntity<Map<String, Object>> editTrajet(@PathVariable Integer id, @RequestBody TrajetDTO trajetDTO) {
        Map<String, Object> response = new HashMap<>();

        try {
            Integer gareDepart = trajetDTO.getGareDepart();
            Integer gareArrivee = trajetDTO.getGareArrivee();

            if(gareDepart == null || gareArrivee == null) {
                response.put("status", "error");
                response.put("message", "Veuillez sélectionner une gare de départ et une gare d'arrivée.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            if(gareDepart.equals(gareArrivee)) {
                response.put("status", "error");
                response.put("message", "Impossible de modifier : les gares de départ et d'arrivée doivent être différentes.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            Double distanceKm = trajetDTO.getDistanceKm();
            if(distanceKm == null) {
                response.put("status", "error");
                response.put("message", "Veuillez saisir une distance valide.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            double distance = distanceKm.doubleValue();
            if(distance <= 0) {
                response.put("status", "error");
                response.put("message", "La distance doit être supérieure à zéro.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            trajetDTO.setId(id);

            service.modifierTrajet(trajetDTO);

            response.put("status", "success");
            response.put("message", "Modification réussie !!");
            return ResponseEntity.ok(response);
        } catch(Exception e) {
            response.put("status", "error");
            response.put("message", "Une erreur interne s'est produite: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}