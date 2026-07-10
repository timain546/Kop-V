package com.cooperative.transport.services;

import java.sql.Date;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cooperative.transport.repositories.ReparationRepository;
import com.cooperative.transport.repositories.SalairesRepository;
import com.cooperative.transport.repositories.VehiculeRepository;

@Service
public class DepenseService {

    @Autowired
    private VehiculeRepository vehiculeRepository;

    @Autowired
    private SalairesRepository salairesRepository;

    @Autowired
    private ReparationRepository reparationRepository;

    /**
     * Total des dépenses (toutes périodes confondues).
     */
    public double calculerDepenseTotale() {
        double depenseVehicules = vehiculeRepository.sumPrixAchat();
        double depenseSalaires = salairesRepository.sumTotalSalaires();
        double depenseReparations = reparationRepository.sumCoutReparationsResolues();
        return depenseVehicules + depenseSalaires + depenseReparations;
    }

    /**
     * Total des dépenses sur une période donnée (utile pour un calcul mensuel).
     */
    public double calculerDepenseEntre(LocalDate debut, LocalDate fin) {
        double depenseVehicules = vehiculeRepository.sumPrixAchatEntre(debut, fin);
        double depenseSalaires = salairesRepository.sumSalairesEntre(Date.valueOf(debut), Date.valueOf(fin));
        double depenseReparations = reparationRepository.sumCoutReparationsResoluesEntre(debut, fin);
        return depenseVehicules + depenseSalaires + depenseReparations;
    }

    public double calculerDepenseVehicules() {
        return vehiculeRepository.sumPrixAchat();
    }

    public double calculerDepenseSalaires() {
        return salairesRepository.sumTotalSalaires();
    }

    public double calculerDepenseReparations() {
        return reparationRepository.sumCoutReparationsResolues();
    }

    /**
     * Total des dépenses pour un mois donné (ex : mois=7, annee=2026 -> juillet 2026).
     */
    public double calculerDepenseParMois(int annee, int mois) {
        LocalDate debut = LocalDate.of(annee, mois, 1);
        LocalDate fin = debut.withDayOfMonth(debut.lengthOfMonth());
        return calculerDepenseEntre(debut, fin);
    }

    /**
     * Total des dépenses pour une année donnée.
     */
    public double calculerDepenseParAnnee(int annee) {
        LocalDate debut = LocalDate.of(annee, 1, 1);
        LocalDate fin = LocalDate.of(annee, 12, 31);
        return calculerDepenseEntre(debut, fin);
    }

    public double calculerDepenseVehiculesParAnnee(int annee) {
        return vehiculeRepository.sumPrixAchatEntre(LocalDate.of(annee, 1, 1), LocalDate.of(annee, 12, 31));
    }

    public double calculerDepenseSalairesParAnnee(int annee) {
        return salairesRepository.sumSalairesEntre(
                Date.valueOf(LocalDate.of(annee, 1, 1)), Date.valueOf(LocalDate.of(annee, 12, 31)));
    }

    public double calculerDepenseReparationsParAnnee(int annee) {
        return reparationRepository.sumCoutReparationsResoluesEntre(
                LocalDate.of(annee, 1, 1), LocalDate.of(annee, 12, 31));
    }

    public double calculerDepenseVehiculesEntre(LocalDate debut, LocalDate fin) {
        return vehiculeRepository.sumPrixAchatEntre(debut, fin);
    }

    public double calculerDepenseSalairesEntre(LocalDate debut, LocalDate fin) {
        return salairesRepository.sumSalairesEntre(Date.valueOf(debut), Date.valueOf(fin));
    }

    public double calculerDepenseReparationsEntre(LocalDate debut, LocalDate fin) {
        return reparationRepository.sumCoutReparationsResoluesEntre(debut, fin);
    }
}