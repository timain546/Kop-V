package com.cooperative.transport.services;

import java.math.BigDecimal;
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
import com.cooperative.transport.enums.StatutPaiementId;
import com.cooperative.transport.enums.StatutReservationId;
import com.cooperative.transport.exceptions.ValidationException;
import com.cooperative.transport.models.InfoNewReservation;
import com.cooperative.transport.models.ReservationNewPaiementForm;
import com.cooperative.transport.repositories.AnnulationRepository;
import com.cooperative.transport.repositories.ClientRepository;
import com.cooperative.transport.repositories.PaiementRepository;
import com.cooperative.transport.repositories.ReservationFilleRepository;
import com.cooperative.transport.repositories.ReservationMereRepository;
import com.cooperative.transport.repositories.ReservationStatutRepository;
import com.cooperative.transport.repositories.StatutPaiementRepository;
import com.cooperative.transport.repositories.StatutReservationRepository;
import com.cooperative.transport.dto.ReservationDTO;
import com.cooperative.transport.repositories.ReservationRepository;


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

    @Autowired
    private ReservationRepository reservationRepository;


    @Transactional
    public ReservationsMere saveReservation(InfoNewReservation info, ReservationNewPaiementForm form) throws ValidationException {
        // TODO: valider tout en fait
        if (form.getMontant().compareTo(BigDecimal.ZERO) <= 0) {
            throw new ValidationException("montant", form.getMontant(), "Le montant est invalide");
        }

        Client client = new Client();
        client.setNom(form.getNomClient());
        client.setTelephone(form.getTelephoneClient());
        clientRepository.save(client);

        StatutPaiement statutPaiement = statutPaiementRepository.findById(StatutPaiementId.PART_PAYE.getId()).get();
        StatutReservation statutReservation = statutReservationRepository.findById(StatutReservationId.CONFIRMEE.getId()).get();

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
        paiement.setMontant(form.getMontant());
        paiement.setModePaiement(form.getModePaiement());
        paiement.setDate(LocalDateTime.now());
        paiement.setReferenceTransaction(form.getReference());
        paiementRepository.save(paiement);

        return reservation;
    }

    @Transactional
    public void payerReservation(ReservationsMere reservation, BigDecimal montant, ModePaiement modePaiement, String reference) throws ValidationException {
        if (montant.compareTo(BigDecimal.ZERO) <= 0) {
            throw new ValidationException("montant", montant, "Le montant est invalide");
        }

        BigDecimal prixTotal = reservationMereRepository.getPrixTotal(reservation);
        BigDecimal montantDejaPaye = paiementRepository.getPaiementTotal(reservation);
        StatutPaiementId statut = StatutPaiementId.PART_PAYE;
        if (prixTotal.compareTo(montantDejaPaye.add(montant)) == 0) {
            statut = StatutPaiementId.PAYE;
        }
        else if (prixTotal.compareTo(montantDejaPaye.add(montant)) < 0) {
            throw new ValidationException("montant", montant, "Le montant est trop élevé");
        }

        StatutPaiement statutPaiement = statutPaiementRepository.findById(statut.getId()).get();
        reservation.setStatutPaiement(statutPaiement);
        reservationMereRepository.save(reservation);

        Paiements paiement = new Paiements();
        paiement.setReservation(reservation);
        paiement.setMontant(montant);
        paiement.setModePaiement(modePaiement);
        paiement.setDate(LocalDateTime.now());
        paiement.setReferenceTransaction(reference);
        paiementRepository.save(paiement);
    }

    @Transactional
    public void annulerReservation(ReservationsMere reservation, BigDecimal frais, String motif) {
        StatutReservation statutAnnulee = statutReservationRepository.findById(StatutReservationId.ANNULEE.getId()).get();
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
        return reservationRepository.findReservationsByDateAndVilleDepartAndVilleArrivee(date1, date2, villeDepart, villeArrivee);
    }
}
