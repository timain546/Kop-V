package com.cooperative.transport.controllers;

import com.cooperative.transport.dto.PanneDTO;
import com.cooperative.transport.dto.VoyageListDTO;
import com.cooperative.transport.services.PanneService;
import com.cooperative.transport.services.VoyageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/chauffeur")
@RequiredArgsConstructor
public class ChauffeurRestController {

    private final VoyageService voyageService;
    private final PanneService panneService;

    @GetMapping("/voyages")
    public ResponseEntity<List<VoyageListDTO>> getVoyages(
            @RequestHeader("X-Chauffeur-Id") Integer chauffeurId,
            @RequestParam(required = false) String filter) {
        List<VoyageListDTO> voyages;
        if ("upcoming".equals(filter)) {
            voyages = voyageService.getUpcomingVoyagesByChauffeur(chauffeurId);
        } else {
            voyages = voyageService.getVoyagesByChauffeur(chauffeurId);
        }
        return ResponseEntity.ok(voyages);
    }

    @PostMapping("/voyages/{id}/arrivee")
    public ResponseEntity<?> signalerArrivee(
            @PathVariable Integer id,
            @RequestHeader("X-Chauffeur-Id") Integer chauffeurId) {
        boolean success = voyageService.signalerArrivee(id, chauffeurId);
        if (!success) {
            return ResponseEntity.badRequest().body(createErrorResponse("Voyage non trouvé ou accès refusé"));
        }
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Arrivée signalée avec succès");
        response.put("voyageId", id);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/pannes")
    public ResponseEntity<?> createPanne(
            @RequestHeader("X-Chauffeur-Id") Integer chauffeurId,
            @RequestBody Map<String, Object> requestBody) {
        try {
            Integer voyageId = Integer.valueOf(requestBody.get("voyageId").toString());
            String lieu = (String) requestBody.get("lieu");
            String motifPanneLibelle = (String) requestBody.get("motifPanneLibelle");
            String description = (String) requestBody.get("description");
            String photoUrl = (String) requestBody.get("photoUrl");

            PanneDTO panne = panneService.createPanne(voyageId, chauffeurId, lieu, motifPanneLibelle, description, photoUrl);
            return ResponseEntity.status(HttpStatus.CREATED).body(panne);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    private Map<String, Object> createErrorResponse(String message) {
        Map<String, Object> error = new HashMap<>();
        error.put("error", message);
        return error;
    }
}
