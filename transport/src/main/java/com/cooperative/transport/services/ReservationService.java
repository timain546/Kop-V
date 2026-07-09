package com.cooperative.transport.services;

import java.math.BigDecimal;
import java.security.InvalidParameterException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cooperative.transport.entities.Annulations;
import com.cooperative.transport.entities.Client;
import com.cooperative.transport.entities.ModePaiement;
import com.cooperative.transport.entities.Paiements;
import com.cooperative.transport.entities.Places;
import com.cooperative.transport.entities.ReservationsFille;
import com.cooperative.transport.entities.ReservationsMere;
import com.cooperative.transport.entities.ReservationStatut;
import com.cooperative.transport.entities.StatutPaiement;
import com.cooperative.transport.entities.StatutReservation;
import com.cooperative.transport.repositories.AnnulationRepository;
import com.cooperative.transport.repositories.ClientRepository;
import com.cooperative.transport.repositories.PaiementRepository;
import com.cooperative.transport.repositories.ReservationFilleRepository;
import com.cooperative.transport.repositories.ReservationMereRepository;
import com.cooperative.transport.repositories.ReservationStatutRepository;
import com.cooperative.transport.repositories.StatutPaiementRepository;
import com.cooperative.transport.repositories.StatutReservationRepository;
import com.cooperative.transport.dto.InfoNewReservationDTO;
import com.cooperative.transport.dto.ReservationDTO;


@Service
public class ReservationService {

    @Autowired
    private AnnulationRepository annulationRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private PaiementRepository paiementRepository;

    @Autowired
    private ReservationFilleRepository reservationFilleRepository;

    @Autowired
    private ReservationMereRepository reservationMereRepository;

    @Autowired
    private StatutPaiementRepository statutPaiementRepository;

    @Autowired
    private StatutReservationRepository statutReservationRepository;

    @Autowired
    private ReservationStatutRepository reservationStatutRepository;


    @Transactional
    public ReservationsMere saveReservation(InfoNewReservationDTO info, String nomClient,
            String telephoneClient, BigDecimal montant, ModePaiement modePaiement, String reference) {
        if (montant.compareTo(BigDecimal.ZERO) <= 0) {
            throw new InvalidParameterException("Le montant est invalide");
        }

        BigDecimal prixTotal = info.getVoyage().getTarif().multiply(BigDecimal.valueOf(info.getNbPlaces()));
        String libelleStatut = "Partiellement payé";
        if (prixTotal.compareTo(montant) == 0) {
            libelleStatut = "Payé";
        }
        else if (prixTotal.compareTo(montant) < 0) {
            throw new InvalidParameterException("Le montant est trop élevé");
        }
        StatutPaiement statutPaiement = getOrCreateStatutPaiement(libelleStatut);

        Client client = new Client();
        client.setNom(nomClient);
        client.setTelephone(telephoneClient);
        clientRepository.save(client);

        StatutReservation statutReservation = getOrCreateStatutReservation("Confirmée");

        ReservationsMere reservation = new ReservationsMere();
        reservation.setLibelle("Réservation pour " + info.getPlaces().size() + " personnes");
        reservation.setVoyage(info.getVoyage());
        reservation.setClient(client);
        reservation.setDateReservation(LocalDateTime.now());
        reservation.setStatutPaiement(statutPaiement);
        reservationMereRepository.save(reservation);

        List<ReservationsFille> filles = new ArrayList<>();
        for (Places place : info.getPlaces()) {
             ReservationsFille fille = new ReservationsFille();
             fille.setReservationMere(reservation);
             fille.setPlace(place);
             filles.add(fille);
        }
        reservationFilleRepository.saveAll(filles);

        ReservationStatut rs = new ReservationStatut();
        rs.setReservation(reservation);
        rs.setStatut(statutReservation);
        rs.setDateModification(LocalDateTime.now());
        reservationStatutRepository.save(rs);

        Paiements paiement = new Paiements();
        paiement.setReservation(reservation);
        paiement.setMontant(montant);
        paiement.setModePaiement(modePaiement);
        paiement.setDatePaiement(LocalDateTime.now());
        paiement.setReferenceTransaction(reference);
        paiementRepository.save(paiement);

        return reservation;
    }

    @Transactional
    public void payerReservation(ReservationsMere reservation, BigDecimal montant, ModePaiement modePaiement, String reference) {
        if (montant.compareTo(BigDecimal.ZERO) <= 0) {
            throw new InvalidParameterException("Le montant est invalide");
        }

        BigDecimal prixTotal = reservationMereRepository.getPrixTotal(reservation);
        BigDecimal montantDejaPaye = paiementRepository.getPaiementTotal(reservation).orElse(BigDecimal.ZERO);
        String libelleStatut = "Partiellement payé";

        if (prixTotal.compareTo(montantDejaPaye.add(montant)) == 0) {
            libelleStatut = "Payé";
        }
        else if (prixTotal.compareTo(montantDejaPaye.add(montant)) < 0) {
            throw new InvalidParameterException("Le montant est trop élevé");
        }

        StatutPaiement statutPaiement = getOrCreateStatutPaiement(libelleStatut);
        reservation.setStatutPaiement(statutPaiement);
        reservationMereRepository.save(reservation);

        Paiements paiement = new Paiements();
        paiement.setReservation(reservation);
        paiement.setMontant(montant);
        paiement.setModePaiement(modePaiement);
        paiement.setDatePaiement(LocalDateTime.now());
        paiement.setReferenceTransaction(reference);
        paiementRepository.save(paiement);
    }

    @Transactional
    public void annulerReservation(ReservationsMere reservation, BigDecimal frais, String motif) {
        StatutReservation statutAnnulee = getOrCreateStatutReservation("Annulée");
        ReservationStatut rs = new ReservationStatut();
        rs.setReservation(reservation);
        rs.setStatut(statutAnnulee);
        rs.setDateModification(LocalDateTime.now());
        reservationStatutRepository.save(rs);

        Annulations annulation = new Annulations();
        annulation.setReservation(reservation);
        annulation.setDateAnnulation(LocalDateTime.now());
        annulation.setFraisAnnulation(frais);
        annulation.setMotif(motif);
        annulationRepository.save(annulation);
    }

    public List<ReservationDTO> getReservations(String date1, String date2, String villeDepart, String villeArrivee) {
        return reservationMereRepository.findReservationsByDateAndVilleDepartAndVilleArrivee(date1, date2, villeDepart, villeArrivee);
    }

    private StatutPaiement getOrCreateStatutPaiement(String libelle) {
        return statutPaiementRepository.findByLibelle(libelle)
                .orElseGet(() -> {
                    StatutPaiement statutPaiement = new StatutPaiement();
                    statutPaiement.setLibelle(libelle);
                    return statutPaiementRepository.save(statutPaiement);
                });
    }

    private StatutReservation getOrCreateStatutReservation(String libelle) {
        return statutReservationRepository.findByLibelle(libelle)
                .orElseGet(() -> {
                    StatutReservation statutReservation = new StatutReservation();
                    statutReservation.setLibelle(libelle);
                    return statutReservationRepository.save(statutReservation);
                });
    }
}
