package com.cooperative.transport.services;

import com.cooperative.transport.entities.StatistiqueJournaliere;
import com.cooperative.transport.entities.StatistiqueMensuelle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.YearMonth;

@Service
public class StatistiqueService {
    
    @Autowired
    private EntityManager entityManager;
    
    // ========================================
    // STATISTIQUE JOURNALIERE
    // ========================================
    public StatistiqueJournaliere getStatsJournaliere(LocalDate date) {
        StatistiqueJournaliere stats = new StatistiqueJournaliere();
        stats.setDate(date);
        
        // Recette
        Query q1 = entityManager.createNativeQuery(
            "SELECT COALESCE(SUM(montant), 0) FROM paiements WHERE DATE(date_paiement) = :date"
        );
        q1.setParameter("date", date);
        stats.setRecette((BigDecimal) q1.getSingleResult());
        
        // Nombre de voyages
        Query q2 = entityManager.createNativeQuery(
            "SELECT COUNT(*) FROM voyages WHERE DATE(date_heure_depart) = :date"
        );
        q2.setParameter("date", date);
        stats.setNbVoyages(((Number) q2.getSingleResult()).intValue());
        
        // Nombre de clients
        Query q3 = entityManager.createNativeQuery(
            "SELECT COUNT(DISTINCT id_client) FROM reservations_mere r " +
            "JOIN paiements p ON p.id_reservation = r.id " +
            "WHERE DATE(p.date_paiement) = :date"
        );
        q3.setParameter("date", date);
        stats.setNbClients(((Number) q3.getSingleResult()).intValue());
        
        return stats;
    }
    
    // ========================================
    // STATISTIQUE MENSUELLE
    // ========================================
    public StatistiqueMensuelle getStatsMensuelle(int annee, int mois) {
        StatistiqueMensuelle stats = new StatistiqueMensuelle();
        stats.setAnnee(annee);
        stats.setMois(mois);
        
        // ✅ Recette totale (corrigé avec EXTRACT)
        Query q1 = entityManager.createNativeQuery(
            "SELECT COALESCE(SUM(montant), 0) FROM paiements " +
            "WHERE EXTRACT(YEAR FROM date_paiement) = :annee " +
            "AND EXTRACT(MONTH FROM date_paiement) = :mois"
        );
        q1.setParameter("annee", annee);
        q1.setParameter("mois", mois);
        BigDecimal recetteTotale = (BigDecimal) q1.getSingleResult();
        stats.setRecetteTotale(recetteTotale);
        
        // ✅ Nombre de voyages (corrigé avec EXTRACT)
        Query q2 = entityManager.createNativeQuery(
            "SELECT COUNT(*) FROM voyages " +
            "WHERE EXTRACT(YEAR FROM date_heure_depart) = :annee " +
            "AND EXTRACT(MONTH FROM date_heure_depart) = :mois"
        );
        q2.setParameter("annee", annee);
        q2.setParameter("mois", mois);
        stats.setNbVoyagesTotal(((Number) q2.getSingleResult()).intValue());
        
        // ✅ Nombre de clients (corrigé avec EXTRACT)
        Query q3 = entityManager.createNativeQuery(
            "SELECT COUNT(DISTINCT id_client) FROM reservations_mere r " +
            "JOIN paiements p ON p.id_reservation = r.id " +
            "WHERE EXTRACT(YEAR FROM p.date_paiement) = :annee " +
            "AND EXTRACT(MONTH FROM p.date_paiement) = :mois"
        );
        q3.setParameter("annee", annee);
        q3.setParameter("mois", mois);
        stats.setNbClientsTotal(((Number) q3.getSingleResult()).intValue());
        
        // Évolution par rapport au mois précédent
        BigDecimal evolution = calculerEvolution(annee, mois, recetteTotale);
        stats.setEvolution(evolution);
        
        // Moyenne journalière
        int joursDansMois = YearMonth.of(annee, mois).lengthOfMonth();
        BigDecimal moyenne = recetteTotale.divide(BigDecimal.valueOf(joursDansMois), 2, RoundingMode.HALF_UP);
        stats.setMoyenneJournaliere(moyenne);
        
        return stats;
    }
    
    private BigDecimal calculerEvolution(int annee, int mois, BigDecimal recetteActuelle) {
        YearMonth currentMonth = YearMonth.of(annee, mois);
        YearMonth previousMonth = currentMonth.minusMonths(1);
        
        // ✅ Requête corrigée avec EXTRACT
        Query q = entityManager.createNativeQuery(
            "SELECT COALESCE(SUM(montant), 0) FROM paiements " +
            "WHERE EXTRACT(YEAR FROM date_paiement) = :annee " +
            "AND EXTRACT(MONTH FROM date_paiement) = :mois"
        );
        q.setParameter("annee", previousMonth.getYear());
        q.setParameter("mois", previousMonth.getMonthValue());
        BigDecimal recettePrecedente = (BigDecimal) q.getSingleResult();
        
        if (recettePrecedente.compareTo(BigDecimal.ZERO) > 0) {
            return recetteActuelle
                .subtract(recettePrecedente)
                .divide(recettePrecedente, 2, RoundingMode.HALF_UP)
                .multiply(BigDecimal.valueOf(100));
        }
        return BigDecimal.ZERO;
    }
}