package com.cooperative.transport.services;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cooperative.transport.entities.Client;
import com.cooperative.transport.entities.Paiement;
import com.cooperative.transport.entities.Place;
import com.cooperative.transport.entities.ReservationFille;
import com.cooperative.transport.entities.ReservationMere;
import com.cooperative.transport.entities.StatutPaiement;
import com.cooperative.transport.enums.StatutPaiementId;
import com.cooperative.transport.models.InfoNewReservation;
import com.cooperative.transport.models.ReservationNewPaiementForm;
import com.cooperative.transport.repositories.ClientRepository;
import com.cooperative.transport.repositories.PaiementRepository;
import com.cooperative.transport.repositories.ReservationFilleRepository;
import com.cooperative.transport.repositories.ReservationMereRepository;
import com.cooperative.transport.repositories.StatutPaiementRepository;

@Service
public class ReservationService {

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

    @Transactional
    public ReservationMere saveReservation(InfoNewReservation info, ReservationNewPaiementForm form) {
        // TODO: valider form.montant
        // TODO: valider tout en fait

        Client client = new Client();
        client.setNom(form.getNomClient());
        client.setTelephone(form.getTelephoneClient());
        clientRepository.save(client);

        StatutPaiement statutPaiement = statutPaiementRepository.findById(StatutPaiementId.PART_PAYE.getId()).get();

        ReservationMere reservation = new ReservationMere();
        reservation.setLibelle("Réservation pour " + info.getPlaces().size() + " personnes");
        reservation.setVoyage(info.getVoyage());
        reservation.setClient(client);
        reservation.setDateReservation(LocalDateTime.now());
        reservation.setStatutPaiement(statutPaiement);
        reservationMereRepository.save(reservation);

        List<ReservationFille> filles = new ArrayList<>();
        for (Place place : info.getPlaces()) {
             ReservationFille fille = new ReservationFille();
             fille.setReservationMere(reservation);
             fille.setPlace(place);
             filles.add(fille);
        }
        reservationFilleRepository.saveAll(filles);

        Paiement paiement = new Paiement();
        paiement.setReservation(reservation);
        paiement.setMontant(form.getMontant());
        paiement.setModePaiement(form.getModePaiement());
        paiement.setDate(LocalDateTime.now());
        paiement.setReferenceTransaction(form.getReference());
        paiementRepository.save(paiement);

        return reservation;
    }
}
