package com.cooperative.transport.services;

import java.math.BigDecimal;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.cooperative.transport.repositories.ReservationMereRepository;
import com.cooperative.transport.repositories.VoyageRepository;
import com.cooperative.transport.repositories.UtilisateurRepository;
import com.cooperative.transport.repositories.PaiementRepository;
import com.cooperative.transport.repositories.SalaireRepository;
import com.cooperative.transport.repositories.ReparationRepository;
import com.cooperative.transport.repositories.AnnulationRepository;

@Service
public class StatistiqueService {

    @Autowired
    private ReservationMereRepository reservationRepository;

    @Autowired
    private VoyageRepository voyageRepository;

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    @Autowired
    private PaiementRepository paiementRepository;

    @Autowired
    private SalaireRepository salaireRepository;

    @Autowired
    private ReparationRepository reparationRepository;

    @Autowired
    private AnnulationRepository annulationRepository;

    public BigDecimal getTotalPaiementsParMois(int month, int year) {
        return paiementRepository.getTotalPaiementsParMois(month,year);
    }
    public BigDecimal getCarburantparMois(int month,int year) {
        return voyageRepository.getCarburantparMois(month,year);
    }
    public BigDecimal getSommeSalaire(int month,int year) {
        return salaireRepository.getSommeSalaire(month,year);
    }
    public BigDecimal getTotalReparationsParMois(int month,int year) {
        return reparationRepository.getTotalReparationsParMois(month,year);
    }
    public BigDecimal getTotalAnnulationsParMois(int month,int year) {
        return annulationRepository.getTotalAnnulationsParMois(month,year);
    }
    public BigDecimal getTotalRemboursementParMois(int month,int year) {
        return annulationRepository.getTotalRemboursementParMois(month,year);
    }
}