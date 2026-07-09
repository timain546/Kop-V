package com.cooperative.transport.services;

import java.math.BigDecimal;
import java.security.InvalidParameterException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cooperative.transport.entities.Annulations;
import com.cooperative.transport.entities.Client;
import com.cooperative.transport.entities.Gares;
import com.cooperative.transport.entities.ModePaiement;
import com.cooperative.transport.entities.Paiements;
import com.cooperative.transport.entities.Places;
import com.cooperative.transport.entities.ReservationsFille;
import com.cooperative.transport.entities.ReservationsMere;
import com.cooperative.transport.entities.ReservationStatut;
import com.cooperative.transport.entities.StatutPaiement;
import com.cooperative.transport.entities.StatutReservation;
import com.cooperative.transport.entities.Trajets;
import com.cooperative.transport.entities.Voyages;
import com.cooperative.transport.repositories.AnnulationRepository;
import com.cooperative.transport.repositories.ClientRepository;
import com.cooperative.transport.repositories.GareRepository;
import com.cooperative.transport.repositories.ModePaiementRepository;
import com.cooperative.transport.repositories.PaiementRepository;
import com.cooperative.transport.repositories.PlaceRepository;
import com.cooperative.transport.repositories.PlaceStatutRepository;
import com.cooperative.transport.repositories.ReservationFilleRepository;
import com.cooperative.transport.repositories.ReservationMereRepository;
import com.cooperative.transport.repositories.ReservationStatutRepository;
import com.cooperative.transport.repositories.StatutPaiementRepository;
import com.cooperative.transport.repositories.StatutReservationRepository;
import com.cooperative.transport.repositories.TrajetRepository;
import com.cooperative.transport.repositories.VoyageRepository;
import com.cooperative.transport.dto.InfoNewReservationDTO;
import com.cooperative.transport.dto.ReservationDTO;


@Service
public class ReservationService {

    @Autowired
    private AnnulationRepository annulationRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private GareRepository gareRepository;

    @Autowired
    private ModePaiementRepository modePaiementRepository;

    @Autowired
    private PaiementRepository paiementRepository;

    @Autowired
    private PlaceRepository placeRepository;

    @Autowired
    private PlaceStatutRepository placeStatutRepository;

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
    private TrajetRepository trajetRepository;

    @Autowired
    private VoyageRepository voyageRepository;


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

        if (reservationStatutRepository.existsByReservationAndStatut(reservation, statutAnnulee)) {
            throw new InvalidParameterException("La réservation est déjà annulée");
        }

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

    public Page<ReservationDTO> getReservations(String date1, String date2, String villeDepart, String villeArrivee, Pageable pageable) {
        return reservationMereRepository.findReservationsByDateAndVilleDepartAndVilleArrivee(date1, date2, villeDepart, villeArrivee, pageable);
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

    @Transactional
	public List<ReservationsMere> importReservationsFromExcel(MultipartFile file) {
        List<ReservationsMere> reservations = new ArrayList<>();
        if (! file.getContentType().equals("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")) {
            throw new InvalidParameterException("Le fichier doit être un fichier Excel (.xlsx)");
        }

        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {
            Sheet sheet = workbook.getSheetAt(0);

            // Lecture de l’ordre des colonnes
            Row headerRow = sheet.getRow(0);
            int columnCount = headerRow.getLastCellNum();
            Map<String, Integer> columnIndexes = new HashMap<>();
            columnIndexes.put("Date", -1);
            columnIndexes.put("Nom du client", -1);
            columnIndexes.put("Téléphone du client", -1);
            columnIndexes.put("Date de départ", -1);
            columnIndexes.put("Gare de départ", -1);
            columnIndexes.put("Gare d’arrivée", -1);
            columnIndexes.put("Catégorie", -1);
            columnIndexes.put("Places", -1);
            columnIndexes.put("Montant payé", -1);
            columnIndexes.put("Mode de paiement", -1);
            columnIndexes.put("Référence de paiement", -1);
            for (int i = 0; i < columnCount; i++) {
                String column = headerRow.getCell(i).getStringCellValue();
                if (!columnIndexes.containsKey(column)) {
                    throw new InvalidParameterException("Colonne inconnue : " + column);
                }
                columnIndexes.put(column, i);
            }
            for (Map.Entry<String, Integer> entry : columnIndexes.entrySet()) {
                if (entry.getValue() == -1) {
                    throw new InvalidParameterException("Colonne manquante : " + entry.getKey());
                }
            }

            // Lecture des données
            for (int i = 1; i < sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                LocalDateTime date = row.getCell(columnIndexes.get("Date")).getLocalDateTimeCellValue();
                String nomClient = row.getCell(columnIndexes.get("Nom du client")).getStringCellValue();
                String telephoneClient = row.getCell(columnIndexes.get("Téléphone du client")).getStringCellValue();
                LocalDateTime dateHeureDepart = row.getCell(columnIndexes.get("Date de départ")).getLocalDateTimeCellValue();
                String libelleGareDepart = row.getCell(columnIndexes.get("Gare de départ")).getStringCellValue();
                String libelleGareArrivee = row.getCell(columnIndexes.get("Gare d’arrivée")).getStringCellValue();
                String categorie = row.getCell(columnIndexes.get("Catégorie")).getStringCellValue();
                String placesCSV = row.getCell(columnIndexes.get("Places")).getStringCellValue();
                double montantPaye = row.getCell(columnIndexes.get("Montant payé")).getNumericCellValue();
                String libelleModePaiement = row.getCell(columnIndexes.get("Mode de paiement")).getStringCellValue();
                Cell cell = row.getCell(columnIndexes.get("Référence de paiement"));
				String reference = cell == null ? null : cell.getStringCellValue();

                Client client = clientRepository.findByTelephone(telephoneClient).orElseGet(() -> {
                    Client c = new Client();
                    c.setNom(nomClient);
                    c.setTelephone(telephoneClient);
                    clientRepository.save(c);
                    return c;
                });

                Gares gareDepart = gareRepository.findByVille(libelleGareDepart).orElseThrow(() -> {
                    return new InvalidParameterException("La gare n’existe pas : " + libelleGareDepart);
                });
                Gares gareArrivee = gareRepository.findByVille(libelleGareArrivee).orElseThrow(() -> {
                    return new InvalidParameterException("La gare n’existe pas : " + libelleGareArrivee);
                });
                Trajets trajet = trajetRepository.findByGareDepartAndGareArrivee(gareDepart, gareArrivee).orElseThrow(() -> {
                    return new InvalidParameterException("Le trajet n’existe pas : " + libelleGareDepart + " → " + libelleGareArrivee);
                });
                Voyages voyage = voyageRepository.findByTrajetAndDateHeureDepartAndCategorie(trajet, dateHeureDepart, categorie).orElseThrow(() -> {
                    return new InvalidParameterException("Le voyage n’existe pas : "
                        + libelleGareDepart + " → " + libelleGareArrivee + " le " + dateHeureDepart.toLocalDate()
                        + " à " + dateHeureDepart.toLocalTime() + " (" + categorie + ")");
                });

                ModePaiement modePaiement = modePaiementRepository.findByLibelle(libelleModePaiement).orElseThrow(() -> {
                    return new InvalidParameterException("Le mode de paiement n’existe pas : " + libelleModePaiement);
                });

                String[] placesStr = placesCSV.split(",");

                if (montantPaye < 0) {
                    throw new InvalidParameterException("Le montant est invalide");
                }

                BigDecimal prixTotal = voyage.getTarif().multiply(BigDecimal.valueOf(placesStr.length));
                String libelleStatut = "Partiellement payé";
                if (montantPaye == 0) {
                    libelleStatut = "Non payé";
                }
                else if (prixTotal.compareTo(BigDecimal.valueOf(montantPaye)) == 0) {
                    libelleStatut = "Payé";
                }
                else if (prixTotal.compareTo(BigDecimal.valueOf(montantPaye)) < 0) {
                    throw new InvalidParameterException("Le montant payé est trop élevé");
                }
                StatutPaiement statutPaiement = statutPaiementRepository.findByLibelle(libelleStatut).get();

                ReservationsMere reservation = new ReservationsMere();
                reservation.setDateReservation(date);
                reservation.setLibelle("Réservation pour " + placesStr.length + " personnes");
                reservation.setClient(client);
                reservation.setVoyage(voyage);
                reservation.setStatutPaiement(statutPaiement);
                reservationMereRepository.save(reservation);

                List<ReservationsFille> filles = new ArrayList<>();
                for (String numero : placesStr) {
                    Places p = placeRepository.findByVehiculeAndNumero(voyage.getVehicule(), numero).orElseThrow(() -> {
                        return new InvalidParameterException("La place n’existe pas : " + numero);
                    });
                    // todo: test if not occupied
                    if (placeStatutRepository.findByVoyageAndPlace(voyage, p).get().getOccupee()) {
                        throw new InvalidParameterException("La place est déjà occupée : " + numero);
                    }
                    ReservationsFille fille = new ReservationsFille();
                    fille.setPlace(p);
                    fille.setReservationMere(reservation);
                    filles.add(fille);
                }
                reservationFilleRepository.saveAll(filles);

                StatutReservation statutReservation = statutReservationRepository.findByLibelle("Confirmée").get();

                ReservationStatut rs = new ReservationStatut();
                rs.setReservation(reservation);
                rs.setStatut(statutReservation);
                rs.setDateModification(date);
                reservationStatutRepository.save(rs);

                Paiements paiement = new Paiements();
                paiement.setReservation(reservation);
                paiement.setMontant(BigDecimal.valueOf(montantPaye));
                paiement.setModePaiement(modePaiement);
                paiement.setDatePaiement(LocalDateTime.now());
                paiement.setReferenceTransaction(reference);
                paiementRepository.save(paiement);

                reservations.add(reservation);
            }
        }
        catch (InvalidParameterException e) {
            throw e;
        }
        catch (Exception e) {
            throw new InvalidParameterException("Une erreur s’est produite : " + e);
        }

        return reservations;
    }
}
