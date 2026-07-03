package com.cooperative.transport.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cooperative.transport.dto.VoyageDTO;
import com.cooperative.transport.entities.Gare;
import com.cooperative.transport.entities.ModePaiement;
import com.cooperative.transport.entities.Place;
import com.cooperative.transport.entities.PlaceStatut;
import com.cooperative.transport.entities.Voyage;
import com.cooperative.transport.models.InfoNewReservation;
import com.cooperative.transport.models.ReservationNewPaiementForm;
import com.cooperative.transport.repositories.GareRepository;
import com.cooperative.transport.repositories.ModePaiementRepository;
import com.cooperative.transport.repositories.PlaceRepository;
import com.cooperative.transport.repositories.PlaceStatutRepository;
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

        return "guichet/paiement";
    }

    @PostMapping("/guichet/reservation/new/paiement")
    public String postNewPaiement(HttpSession session, ReservationNewPaiementForm form) {
        InfoNewReservation info = (InfoNewReservation) session.getAttribute("infoNewReservation");

        reservationService.saveReservation(info, form);

        return "redirect:/";
    }
}
