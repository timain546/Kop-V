package com.cooperative.transport.services;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import com.cooperative.transport.entities.ReservationsFille;
import com.cooperative.transport.entities.ReservationsMere;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

@Service
public class PdfService {

    public byte[] generatePdf() {

        try {

            ByteArrayOutputStream out = new ByteArrayOutputStream();

            Document document = new Document(PageSize.A4, 40, 40, 40, 40);

            PdfWriter.getInstance(document, out);

            document.open();

            // ==========================
            // Logo
            // ==========================
            try {

            ClassPathResource resource = new ClassPathResource("static/images/logo.jpeg");

            Image logo = Image.getInstance(resource.getURL());

            logo.scaleToFit(120, 120);
            logo.setAlignment(Image.ALIGN_CENTER);

            document.add(logo);

            } catch (Exception e) {
                e.printStackTrace();
            }

            Font titleFont = new Font(Font.HELVETICA, 22, Font.BOLD, new Color(34, 139, 34));
            Font subtitleFont = new Font(Font.HELVETICA, 12, Font.NORMAL, Color.DARK_GRAY);
            Font textFont = new Font(Font.HELVETICA, 11);

            Paragraph title = new Paragraph("FACTURE D'ACHAT", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);

            document.add(title);

            Paragraph company = new Paragraph("KOP-V\nVoyagez en toute confiance", subtitleFont);
            company.setAlignment(Element.ALIGN_CENTER);

            document.add(company);

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Numéro : FAC-2026-0001", textFont));
            document.add(new Paragraph("Date : 02/07/2026", textFont));
            document.add(new Paragraph("Client : Nom du client", textFont));

            document.add(new Paragraph(" "));

            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);

            table.setWidths(new float[] {4,2,2,2});

            addHeader(table, "Trajet");
            addHeader(table, "Date");
            addHeader(table, "Qté");
            addHeader(table, "Prix");

            table.addCell("Antananarivo → Toamasina");
            table.addCell("15/07/2026");
            table.addCell("2");
            table.addCell("100 000 Ar");

            table.addCell("Antananarivo → Mahajanga");
            table.addCell("20/07/2026");
            table.addCell("1");
            table.addCell("80 000 Ar");

            document.add(table);

            document.add(new Paragraph(" "));

            Font totalFont = new Font(Font.HELVETICA, 14, Font.BOLD, new Color(34, 139, 34));

            Paragraph total = new Paragraph("TOTAL : 180 000 Ar", totalFont);
            total.setAlignment(Element.ALIGN_RIGHT);

            document.add(total);

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Merci pour votre confiance.", subtitleFont));

            document.close();

            return out.toByteArray();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    public byte[] generateReservationPdf(ReservationsMere reservation, List<ReservationsFille> places) {

        try {

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            Document document = new Document(PageSize.A4, 40, 40, 40, 40);

            PdfWriter.getInstance(document, out);
            document.open();

            Font titleFont = new Font(Font.HELVETICA, 22, Font.BOLD, new Color(34, 139, 34));
            Font subtitleFont = new Font(Font.HELVETICA, 12, Font.NORMAL, Color.DARK_GRAY);
            Font textFont = new Font(Font.HELVETICA, 11);
            Font totalFont = new Font(Font.HELVETICA, 14, Font.BOLD, new Color(34, 139, 34));

            Paragraph title = new Paragraph("FACTURE DE RESERVATION", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            Paragraph company = new Paragraph("KOP-V\nVoyagez en toute confiance", subtitleFont);
            company.setAlignment(Element.ALIGN_CENTER);
            document.add(company);

            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm", Locale.FRENCH);
            int quantity = places.size();
            BigDecimal unitPrice = reservation.getVoyage().getTarif();
            BigDecimal total = unitPrice.multiply(BigDecimal.valueOf(quantity));
            String seats = places.stream()
                    .map(reservationFille -> reservationFille.getPlace().getNumero())
                    .collect(Collectors.joining(", "));

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Numero : KOPV-" + reservation.getId(), textFont));
            document.add(new Paragraph("Date de reservation : " + reservation.getDateReservation().format(dateFormatter), textFont));
            document.add(new Paragraph("Client : " + reservation.getClient().getNom(), textFont));
            document.add(new Paragraph("Telephone : " + reservation.getClient().getTelephone(), textFont));
            document.add(new Paragraph("Statut paiement : " + reservation.getStatutPaiement().getLibelle(), textFont));
            document.add(new Paragraph("Sieges : " + seats, textFont));

            document.add(new Paragraph(" "));

            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            table.setWidths(new float[] {4,2,2,2});

            addHeader(table, "Trajet");
            addHeader(table, "Date");
            addHeader(table, "Qte");
            addHeader(table, "Prix");

            String route = reservation.getVoyage().getTrajet().getGareDepart().getVille()
                    + " -> "
                    + reservation.getVoyage().getTrajet().getGareArrivee().getVille();

            table.addCell(route);
            table.addCell(reservation.getVoyage().getDateHeureDepart().format(dateFormatter));
            table.addCell(String.valueOf(quantity));
            table.addCell(formatAriary(unitPrice));

            document.add(table);

            document.add(new Paragraph(" "));

            Paragraph totalParagraph = new Paragraph("TOTAL : " + formatAriary(total), totalFont);
            totalParagraph.setAlignment(Element.ALIGN_RIGHT);
            document.add(totalParagraph);

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Merci pour votre confiance.", subtitleFont));

            document.close();

            return out.toByteArray();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private void addLogo(Document document) {
        try {
            ClassPathResource resource = new ClassPathResource("static/images/logo.jpeg");
            Image logo = Image.getInstance(resource.getURL());

            logo.scaleToFit(120, 120);
            logo.setAlignment(Image.ALIGN_CENTER);

            document.add(logo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String formatAriary(BigDecimal amount) {
        NumberFormat formatter = NumberFormat.getNumberInstance(Locale.FRENCH);
        formatter.setMaximumFractionDigits(0);
        return formatter.format(amount) + " Ar";
    }

    private void addHeader(PdfPTable table, String text){

        PdfPCell cell = new PdfPCell(new Phrase(text));

        cell.setBackgroundColor(new Color(34,139,34));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);

        table.addCell(cell);

    }

}
