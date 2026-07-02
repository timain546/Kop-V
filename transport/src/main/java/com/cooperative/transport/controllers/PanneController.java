package com.cooperative.transport.controllers;

import com.cooperative.transport.entities.MotifPanne;
import com.cooperative.transport.services.PanneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
public class PanneController {

    @Autowired
    private PanneService panneService;

    @GetMapping("/chauffeur/voyage/panne")
    public String afficherFormulairePanne(Model model) {
        List<MotifPanne> motifs = panneService.getTousLesMotifs();
        model.addAttribute("listeMotifs", motifs);
        
        // MOCK : Simuler l'ID du voyage en cours (ex: 1L) en attendant l'intégration 
        // de la page de la liste des voyages du chauffeur.
        model.addAttribute("idVoyage", 1L); 
        
        return "signaler-panne";
    }

    @PostMapping("/chauffeur/voyage/panne")
    public String traiterFormulairePanne(
            @RequestParam("idVoyage") Long idVoyage,
            @RequestParam("lieu") String lieu,
            @RequestParam("idMotif") Long idMotif,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam(value = "photo", required = false) MultipartFile photoFile
    ) {
        // MOCK SÉCURITÉ / AUTHENTIFICATION :
        // TODO: Une fois l'authentification (Dev A) intégrée par le collègue, 
        // récupérer l'ID du chauffeur actuellement connecté depuis la session ou 
        // le contexte Spring Security (ex: Principal principal ou @AuthenticationPrincipal).
        // Pour l'instant, on simule l'ID du chauffeur = 1L.
        Long idChauffeur = 1L; 

        // Gestion de l'upload de photo
        String photoUrl = null;
        if (photoFile != null && !photoFile.isEmpty()) {
            try {
                // Définir le dossier d'upload localisé dans static/uploads pour être servi automatiquement par Spring Boot
                String uploadsDir = System.getProperty("user.dir") + "/transport/src/main/resources/static/uploads/";
                File uploadFolder = new File(uploadsDir);
                if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs();
                }

                // Générer un nom unique pour éviter les collisions
                String originalFilename = photoFile.getOriginalFilename();
                String fileExtension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String uniqueFilename = UUID.randomUUID().toString() + fileExtension;
                
                File destFile = new File(uploadFolder, uniqueFilename);
                photoFile.transferTo(destFile);
                
                // URL relative servant à accéder à la photo via le serveur web
                photoUrl = "/uploads/" + uniqueFilename;
            } catch (IOException e) {
                // Log de l'erreur mais on n'interrompt pas le flux si la photo échoue (car elle est optionnelle)
                System.err.println("Erreur lors de la sauvegarde de la photo : " + e.getMessage());
                e.printStackTrace();
            }
        }

        panneService.signalerPanne(idVoyage, idChauffeur, idMotif, lieu, description, photoUrl);

        // Rediriger vers le formulaire avec un paramètre success
        return "redirect:/chauffeur/voyage/panne?success=true";
    }
}
