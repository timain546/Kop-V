package com.cooperative.transport.controllers;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cooperative.transport.dto.InfoNewReservationDTO;
import com.cooperative.transport.dto.ReservationDTO;
import com.cooperative.transport.dto.ReservationFiltreDTO;
import com.cooperative.transport.dto.VoyageDisponibleDTO;
import com.cooperative.transport.entities.Gares;
import com.cooperative.transport.entities.ModePaiement;
import com.cooperative.transport.entities.Paiements;
import com.cooperative.transport.entities.Places;
import com.cooperative.transport.entities.PlaceStatut;
import com.cooperative.transport.entities.ReservationsMere;
import com.cooperative.transport.entities.Voyages;
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
        List<Gares> gares = gareRepository.findAll();
        model.addAttribute("gares", gares);

        return "guichet/new-reservation";
    }

    @PostMapping("/guichet/reservation/new")
    public String newIndex(HttpSession session, @ModelAttribute InfoNewReservationDTO info) {
        session.setAttribute("infoNewReservation", info);

        return "redirect:/guichet/reservation/new/choix-voyage";
    }

    @GetMapping("/guichet/reservation/new/choix-voyage")
    public String newChoixVoyage(HttpSession session, Model model) {
        InfoNewReservationDTO info = (InfoNewReservationDTO) session.getAttribute("infoNewReservation");
        List<VoyageDisponibleDTO> voyages = voyageService.getVoyagesDisponibles(
            info.getDateMin(), info.getDateMax(), info.getNbPlaces(),
            info.getGareDepart().getVille(), info.getGareArrivee().getVille()
        );

        model.addAttribute("info", info);
        model.addAttribute("voyages", voyages);

        return "guichet/choix-voyage";
    }

    @PostMapping("/guichet/reservation/new/choix-voyage")
    public String postNewChoixVoyage(HttpSession session, @RequestParam Voyages voyage) {
        InfoNewReservationDTO info = (InfoNewReservationDTO) session.getAttribute("infoNewReservation");

        info.setVoyage(voyage);

        return "redirect:/guichet/reservation/new/choix-place";
    }

    @GetMapping("/guichet/reservation/new/choix-place")
    public String newChoixPlace(HttpSession session, Model model) {
        InfoNewReservationDTO info = (InfoNewReservationDTO) session.getAttribute("infoNewReservation");
        List<PlaceStatut> places = placeStatutRepository.findByVoyage(info.getVoyage());
        int maxY = places.stream().mapToInt(p -> p.getPlace().getY()).max().getAsInt();

        model.addAttribute("info", info);
        model.addAttribute("places", places);
        model.addAttribute("maxY", maxY);

        return "guichet/choix-place";
    }

    @PostMapping("/guichet/reservation/new/choix-place")
    public String postNewChoixPlace(HttpSession session, @RequestParam List<Long> idPlaces) {
        InfoNewReservationDTO info = (InfoNewReservationDTO) session.getAttribute("infoNewReservation");

        List<Places> places = placeRepository.findAllById(idPlaces);
        info.setPlaces(places);

        return "redirect:/guichet/reservation/new/paiement";
    }

    @GetMapping("/guichet/reservation/new/paiement")
    public String newPaiement(HttpSession session, Model model) {
        InfoNewReservationDTO info = (InfoNewReservationDTO) session.getAttribute("infoNewReservation");
        List<ModePaiement> modesPaiements = modePaiementRepository.findAll();

        model.addAttribute("info", info);
        model.addAttribute("modesPaiements", modesPaiements);

        return "guichet/new-paiement";
    }

    @PostMapping("/guichet/reservation/new/paiement")
    public String postNewPaiement(HttpSession session, @RequestParam String nomClient,
            @RequestParam String telephoneClient, @RequestParam BigDecimal montant,
            @RequestParam ModePaiement modePaiement, @RequestParam String reference) {
        InfoNewReservationDTO info = (InfoNewReservationDTO) session.getAttribute("infoNewReservation");

        reservationService.saveReservation(info, nomClient, telephoneClient, montant, modePaiement, reference);

        return "redirect:/guichet/reservation";
    }

    @GetMapping("/guichet/reservation/{idReservation}/paiement")
    public String paiement(Model model, @PathVariable Long idReservation) {
        ReservationsMere reservation = reservationMereRepository.findById(idReservation).get();
        List<ModePaiement> modesPaiements = modePaiementRepository.findAll();
        List<Paiements> paiements = paiementRepository.findByReservation(reservation);
        BigDecimal montantPayeTotal = paiementRepository.getPaiementTotal(reservation);

        model.addAttribute("reservation", reservation);
        model.addAttribute("modesPaiements", modesPaiements);
        model.addAttribute("paiements", paiements);
        model.addAttribute("montantPayeTotal", montantPayeTotal);

        return "guichet/paiement";
    }

    @PostMapping("/guichet/reservation/{idReservation}/paiement")
    public String postPaiement(@PathVariable Long idReservation, @RequestParam BigDecimal montant,
            @RequestParam ModePaiement modePaiement,
            @RequestParam(required = false, defaultValue = "") String reference) {
        ReservationsMere reservation = reservationMereRepository.findById(idReservation).get();

        reservationService.payerReservation(reservation, montant, modePaiement, reference);

        return "redirect:/guichet/reservation/" + idReservation + "/paiement";
    }

    @GetMapping("/guichet/reservation/{idReservation}/annulation")
    public String annulation(Model model, @PathVariable Long idReservation) {
        ReservationsMere reservation = reservationMereRepository.findById(idReservation).get();

        model.addAttribute("reservation", reservation);

        return "guichet/annulation";
    }

    @PostMapping("/guichet/reservation/{idReservation}/annulation")
    public String postAnnulation(@PathVariable Long idReservation, @RequestParam BigDecimal frais, @RequestParam String motif) {
        ReservationsMere reservation = reservationMereRepository.findById(idReservation).get();

        reservationService.annulerReservation(reservation, frais, motif);

        return "redirect:/guichet/reservation";
    }


    @GetMapping("/guichet/reservation")
    public String getReservations(
            @RequestParam(required = false) String dateDebut,
            @RequestParam(required = false) String dateFin,
            @RequestParam(required = false, defaultValue = "") String villeDepart,
            @RequestParam(required = false, defaultValue = "") String villeArrivee,
            Model model) {

        List<ReservationDTO> reservations = reservationService.getReservations(
                dateDebut, dateFin, villeDepart, villeArrivee);

        model.addAttribute("reservations", reservations);
        model.addAttribute("villes",
                gareRepository.findAll().stream().map(Gares::getVille).distinct().toList());

        ReservationFiltreDTO filtre = new ReservationFiltreDTO(dateDebut, dateFin, villeDepart, villeArrivee);
        model.addAttribute("filtre", filtre);

        model.addAttribute("stats", computeStats(reservations));

        return "guichet/reservation";
    }

    private Map<String, Long> computeStats(List<ReservationDTO> reservations) {
        return reservations.stream()
                .collect(Collectors.groupingBy(ReservationDTO::getStatutPaiement, Collectors.counting()));
    }
}
