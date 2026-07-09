package com.cooperative.transport.services;

import java.awt.Color;
import java.io.ByteArrayOutputStream;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

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

    private void addHeader(PdfPTable table, String text){

        PdfPCell cell = new PdfPCell(new Phrase(text));

        cell.setBackgroundColor(new Color(34,139,34));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);

        table.addCell(cell);

    }

}