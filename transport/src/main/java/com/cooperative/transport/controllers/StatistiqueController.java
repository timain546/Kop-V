package com.cooperative.transport.controllers;

import com.cooperative.transport.dto.StatistiqueJournaliereDTO;
import com.cooperative.transport.services.StatistiqueService;
import com.cooperative.transport.dto.StatistiqueMensuelleDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.time.LocalDate;

import java.time.YearMonth;
import com.cooperative.transport.services.StatistiqueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequestMapping("/admin")
@Autowired
StatistiqueService statistiqueService;
public class StatistiqueController {
@GetMapping("/stats")
public String afficherStatistiques(Model model) {
    BigDecimal PaiementMensuel = statistiqueService.getTotalPaiementsParMois(2026, 9);
    model.addAttribute("totalPaiements",PaiementMensuel);
    return "admin/statistique";
}


}
