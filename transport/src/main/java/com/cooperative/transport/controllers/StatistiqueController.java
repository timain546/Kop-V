package com.cooperative.transport.controllers;

import com.cooperative.transport.entities.StatistiqueJournaliere;
import com.cooperative.transport.services.StatistiqueService;
import com.cooperative.transport.entities.StatistiqueMensuelle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.time.LocalDate;

@Controller
@RequestMapping("/stats")
public class StatistiqueController {
    
    @Autowired
    private StatistiqueService statistiqueService;
    
    
    @GetMapping("/journaliere")
    public String getStatsJournaliere(
            @RequestParam(required = false) String date,
            Model model) {
        
        LocalDate jour = date != null ? LocalDate.parse(date) : LocalDate.now();
        StatistiqueJournaliere stats = statistiqueService.getStatsJournaliere(jour);
        
        model.addAttribute("stats", stats);
        model.addAttribute("titre", "Statistiques Journalières");
        
        return "stats-journaliere";
    }
    
    // STATISTIQUE MENSUELLE
    @GetMapping("/mensuelle")
    public String getStatsMensuelle(
            @RequestParam(required = false) Integer annee,
            @RequestParam(required = false) Integer mois,
            Model model) {
        
        if (annee == null || mois == null) {
            LocalDate now = LocalDate.now();
            annee = now.getYear();
            mois = now.getMonthValue();
        }
        
        StatistiqueMensuelle stats = statistiqueService.getStatsMensuelle(annee, mois);
        
        model.addAttribute("stats", stats);
        model.addAttribute("titre", "Statistiques Mensuelles");
        
        return "stats-mensuelle";
    }
}