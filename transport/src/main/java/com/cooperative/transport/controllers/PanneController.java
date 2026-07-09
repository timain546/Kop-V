package com.cooperative.transport.controllers;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import com.cooperative.transport.entities.Pannes;
import com.cooperative.transport.services.PanneService;

import org.springframework.ui.Model;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/re")
public class PanneController {

    @Autowired
    private PanneService panneService;

    @GetMapping("/panne/list")
    public String getListPannes(Model model) {
        List<Pannes> pannes = panneService.findAllPannesSignale();
        model.addAttribute("pannes", pannes);
        return "re/carte-pannes";
    }

    @GetMapping("/api/panne/prendre-en-charge/{id}")
    public ResponseEntity<Map<String, Object>> prendreEnChargePanne(@PathVariable Integer idPanne) {
        Map<String, Object> response = new HashMap<>();
        try {
            panneService.prendreEnChargePanne(idPanne);
            response.put("status", "success");
            response.put("message", "La panne P-00" + idPanne + " est en cours de dépannage");
            return ResponseEntity.ok(response);
        } catch(Exception e) {
            response.put("status", "error");
            response.put("message", "Erreur interne: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}