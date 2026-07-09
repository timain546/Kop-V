package com.cooperative.transport.services;

import java.math.BigDecimal;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.cooperative.transport.repositories.ReservationMereRepository;
import com.cooperative.transport.repositories.VoyageRepository;
import com.cooperative.transport.repositories.UtilisateurRepository;
import com.cooperative.transport.repositories.PaiementRepository;
import com.cooperative.transport.repositories.SalaireRepository;

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

    public BigDecimal getTotalPaiementsParMois(int year, int month) {
        return paiementRepository.getTotalPaiementsParMoi(year, month);
    }
}