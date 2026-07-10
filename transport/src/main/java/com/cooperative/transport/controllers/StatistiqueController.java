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
        import java.util.List;
        import java.util.ArrayList;

        import java.time.YearMonth;
        import java.math.BigDecimal;
        import java.time.LocalDate;


        @Controller
        @RequestMapping("/admin")

        public class StatistiqueController {
        @Autowired
        StatistiqueService statistiqueService;
        @GetMapping("/stats")
        public String afficherStatistiques(@RequestParam(defaultValue="2026")int annee,Model model) {
            List<BigDecimal> totalPaiementsParMois = new ArrayList<>();
            List<BigDecimal> totalCarburantParMois = new ArrayList<>();
            List<BigDecimal> totalSalaireParMois = new ArrayList<>();
            List<BigDecimal> totalReparationsParMois = new ArrayList<>();
            List<BigDecimal> totalAnnulationsParMois = new ArrayList<>();
            List<BigDecimal> totalRemboursementParMois = new ArrayList<>();
            List<BigDecimal> totalRecetteParMois = new ArrayList<>();
            List<BigDecimal> totalDepensesParMois = new ArrayList<>();
            List<BigDecimal> totalBeneficeParMois = new ArrayList<>();
            
            for(int i=1;i<=12;i++){
                BigDecimal PaiementMensuel = statistiqueService.getTotalPaiementsParMois(i,annee);
                totalPaiementsParMois.add(PaiementMensuel);
                BigDecimal CarburantMensuel = statistiqueService.getCarburantparMois(i,annee);
                totalCarburantParMois.add(CarburantMensuel);
                BigDecimal SalaireMensuel = statistiqueService.getSommeSalaire(i,annee);
                totalSalaireParMois.add(SalaireMensuel);
                BigDecimal ReparationMensuel = statistiqueService.getTotalReparationsParMois(i,annee);
                totalReparationsParMois.add(ReparationMensuel);
                BigDecimal AnnulationMensuel = statistiqueService.getTotalAnnulationsParMois(i,annee);
                totalAnnulationsParMois.add(AnnulationMensuel);
                BigDecimal RemboursementMensuel = statistiqueService.getTotalRemboursementParMois(i,annee);
                totalRemboursementParMois.add(RemboursementMensuel);
                BigDecimal recetteMensuelle = PaiementMensuel.add(CarburantMensuel).add(SalaireMensuel).add(ReparationMensuel).add(AnnulationMensuel).add(RemboursementMensuel);
                totalRecetteParMois.add(recetteMensuelle);
                BigDecimal depensesMensuelles = CarburantMensuel.add(SalaireMensuel).add(ReparationMensuel).add(RemboursementMensuel);
                totalDepensesParMois.add(depensesMensuelles);
                BigDecimal beneficeMensuel = recetteMensuelle.subtract(depensesMensuelles);
                totalBeneficeParMois.add(beneficeMensuel);
            }
            model.addAttribute("totalPaiementsParMois", totalPaiementsParMois);
            model.addAttribute("totalCarburantParMois", totalCarburantParMois);
            model.addAttribute("totalSalaireParMois", totalSalaireParMois);
            model.addAttribute("totalReparationsParMois", totalReparationsParMois);
            model.addAttribute("totalAnnulationsParMois", totalAnnulationsParMois);
            model.addAttribute("totalRemboursementParMois", totalRemboursementParMois);
            model.addAttribute("totalRecetteParMois", totalRecetteParMois);
            model.addAttribute("totalDepensesParMois", totalDepensesParMois);
            model.addAttribute("totalBeneficeParMois", totalBeneficeParMois);
            model.addAttribute("annee", annee);
            return "admin/statistique";
        
        }
        }
