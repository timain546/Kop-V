package com.cooperative.transport.controllers;

import java.util.List;

import com.cooperative.transport.entities.ReservationsFille;
import com.cooperative.transport.entities.ReservationsMere;
import com.cooperative.transport.repositories.ReservationFilleRepository;
import com.cooperative.transport.repositories.ReservationMereRepository;
import com.cooperative.transport.services.PdfService;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PdfController {

    private final PdfService pdfService;
    private final ReservationMereRepository reservationMereRepository;
    private final ReservationFilleRepository reservationFilleRepository;

    public PdfController(PdfService pdfService, ReservationMereRepository reservationMereRepository,
            ReservationFilleRepository reservationFilleRepository) {
        this.pdfService = pdfService;
        this.reservationMereRepository = reservationMereRepository;
        this.reservationFilleRepository = reservationFilleRepository;
    }

    @GetMapping("/facture/pdf")
    public ResponseEntity<byte[]> downloadPdf() {

        byte[] pdf = pdfService.generatePdf();

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=facture-kop-v.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .contentLength(pdf.length)
                .body(pdf);
    }

    @GetMapping("/guichet/reservation/{idReservation}/pdf")
    public ResponseEntity<byte[]> downloadReservationPdf(@PathVariable Long idReservation) {

        ReservationsMere reservation = reservationMereRepository.findById(idReservation).get();
        List<ReservationsFille> places = reservationFilleRepository.findByReservationMere(reservation);
        byte[] pdf = pdfService.generateReservationPdf(reservation, places);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=reservation-kopv-" + reservation.getId() + ".pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .contentLength(pdf.length)
                .body(pdf);
    }

}
