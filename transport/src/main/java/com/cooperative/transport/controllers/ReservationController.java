package com.cooperative.transport.controllers;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cooperative.transport.dto.VoyageDTO;
import com.cooperative.transport.entities.Gare;
import com.cooperative.transport.entities.ModePaiement;
import com.cooperative.transport.entities.Paiement;
import com.cooperative.transport.entities.Place;
import com.cooperative.transport.entities.PlaceStatut;
import com.cooperative.transport.entities.ReservationMere;
import com.cooperative.transport.entities.Voyage;
import com.cooperative.transport.models.InfoNewReservation;
import com.cooperative.transport.models.ReservationNewPaiementForm;
import com.cooperative.transport.models.ReservationPaiementForm;
import com.cooperative.transport.repositories.GareRepository;
import com.cooperative.transport.repositories.ModePaiementRepository;
import com.cooperative.transport.repositories.PaiementRepository;
import com.cooperative.transport.repositories.PlaceRepository;
import com.cooperative.transport.repositories.PlaceStatutRepository;
import com.cooperative.transport.repositories.ReservationMereRepository;
import com.cooperative.transport.services.ReservationService;
import com.cooperative.transport.services.VoyageService;



import jakarta.servlet.http.HttpSession;

@Controller
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private VoyageService voyageService;

    @Autowired
    private GareRepository gareRepository;

    @Autowired
    private ModePaiementRepository modePaiementRepository;

    @Autowired
    private ReservationMereRepository reservationMereRepository;

    @Autowired
    private PaiementRepository paiementRepository;

    @Autowired
    private PlaceStatutRepository placeStatutRepository;

    @Autowired
    private PlaceRepository placeRepository;

    @GetMapping("/guichet/reservation/new")
    public String newIndex(HttpSession session, Model model) {
        List<Gare> gares = gareRepository.findAll();
        model.addAttribute("gares", gares);

        return "guichet/new-reservation";
    }

    @PostMapping("/guichet/reservation/new")
    public String newIndex(HttpSession session, @ModelAttribute InfoNewReservation info) {
        session.setAttribute("infoNewReservation", info);

        return "redirect:/guichet/reservation/new/choix-voyage";
    }

    @GetMapping("/guichet/reservation/new/choix-voyage")
    public String newChoixVoyage(HttpSession session, Model model) {
        InfoNewReservation info = (InfoNewReservation) session.getAttribute("infoNewReservation");
        List<VoyageDTO> voyages = voyageService.getVoyagesDisponibles(
            info.getDateMin(), info.getDateMax(), info.getNbPlaces(),
            info.getGareDepart().getVille(), info.getGareArrivee().getVille()
        );

        model.addAttribute("info", info);
        model.addAttribute("voyages", voyages);

        return "guichet/choix-voyage";
    }

    @PostMapping("/guichet/reservation/new/choix-voyage")
    public String postNewChoixVoyage(HttpSession session, @RequestParam Voyage voyage) {
        InfoNewReservation info = (InfoNewReservation) session.getAttribute("infoNewReservation");

        info.setVoyage(voyage);

        return "redirect:/guichet/reservation/new/choix-place";
    }

    @GetMapping("/guichet/reservation/new/choix-place")
    public String newChoixPlace(HttpSession session, Model model) {
        InfoNewReservation info = (InfoNewReservation) session.getAttribute("infoNewReservation");
        List<PlaceStatut> places = placeStatutRepository.findByVoyage(info.getVoyage());
        int maxY = places.stream().mapToInt(p -> p.getPlace().getY()).max().getAsInt();

        model.addAttribute("info", info);
        model.addAttribute("places", places);
        model.addAttribute("maxY", maxY);

        return "guichet/choix-place";
    }

    @PostMapping("/guichet/reservation/new/choix-place")
    public String postNewChoixPlace(HttpSession session, @RequestParam List<Long> idPlaces) {
        InfoNewReservation info = (InfoNewReservation) session.getAttribute("infoNewReservation");

        List<Place> places = placeRepository.findAllById(idPlaces);
        info.setPlaces(places);

        return "redirect:/guichet/reservation/new/paiement";
    }

    @GetMapping("/guichet/reservation/new/paiement")
    public String newPaiement(HttpSession session, Model model) {
        InfoNewReservation info = (InfoNewReservation) session.getAttribute("infoNewReservation");
        List<ModePaiement> modesPaiements = modePaiementRepository.findAll();

        model.addAttribute("info", info);
        model.addAttribute("modesPaiements", modesPaiements);

        return "guichet/new-paiement";
    }

    @PostMapping("/guichet/reservation/new/paiement")
    public String postNewPaiement(HttpSession session, @ModelAttribute ReservationNewPaiementForm form) {
        InfoNewReservation info = (InfoNewReservation) session.getAttribute("infoNewReservation");

        reservationService.saveReservation(info, form);

        return "redirect:/";
    }

    @GetMapping("/guichet/reservation/{idReservation}/paiement")
    public String paiement(Model model, @PathVariable Long idReservation) {
        ReservationMere reservation = reservationMereRepository.findById(idReservation).get();
        List<ModePaiement> modesPaiements = modePaiementRepository.findAll();
        List<Paiement> paiements = paiementRepository.findByReservation(reservation);
        BigDecimal montantPayeTotal = paiementRepository.getPaiementTotal(reservation);

        model.addAttribute("reservation", reservation);
        model.addAttribute("modesPaiements", modesPaiements);
        model.addAttribute("paiements", paiements);
        model.addAttribute("montantPayeTotal", montantPayeTotal);

        return "guichet/paiement";
    }

    @PostMapping("/guichet/reservation/{idReservation}/paiement")
    public String postPaiement(@PathVariable Long idReservation, @ModelAttribute ReservationPaiementForm form) {
        ReservationMere reservation = reservationMereRepository.findById(idReservation).get();

        reservationService.payerReservation(reservation, form.getMontant(), form.getModePaiement(), form.getReference());

        return "redirect:/guichet/reservation/" + idReservation + "/paiement";
    }

    @GetMapping("/guichet/reservation/{idReservation}/annulation")
    public String annulation(Model model, @PathVariable Long idReservation) {
        ReservationMere reservation = reservationMereRepository.findById(idReservation).get();

        model.addAttribute("reservation", reservation);

        return "guichet/annulation";
    }

    @PostMapping("/guichet/reservation/{idReservation}/annulation")
    public String postAnnulation(@PathVariable Long idReservation, @RequestParam BigDecimal frais, @RequestParam String motif) {
        ReservationMere reservation = reservationMereRepository.findById(idReservation).get();

        reservationService.annulerReservation(reservation, frais, motif);

        return "redirect:/guichet/reservation/";
    }


    @GetMapping("guichet/reservation")
    public String getReservations(
            @RequestParam String date1,
            @RequestParam String date2,
            @RequestParam String villeDepart,
            @RequestParam String villeArrivee,
            Model model) {

        model.addAttribute(
                "reservations",
                reservationService.getReservations(
                        date1,
                        date2,
                        villeDepart,
                        villeArrivee
                )
        );

        return "reservation/liste";
    }
}
