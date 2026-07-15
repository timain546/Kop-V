<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<fmt:setLocale value="fr"/>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Import Excel — KOP-V</title>
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/guichet/import-excel.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet">
  </head>
  <body>
    <!-- ================= NAVBAR ================= -->
    <nav class="navbar">
      <div class="nav-container">
        <a class="nav-brand" href="${pageContext.request.contextPath}/guichet/reservation">
        <i class="fas fa-bus"></i>
        KOP-V
        </a>
        <div class="nav-links">
          <a class="nav-link"
            href="${pageContext.request.contextPath}/guichet/reservation">
          <i class="fas fa-ticket-alt"></i>
          Réservations
          </a>
          <a class="nav-link"
            href="${pageContext.request.contextPath}/guichet/reservation/new">
          <i class="fas fa-plus-circle"></i>
          Nouvelle réservation
          </a>
          <a class="nav-link active"
            href="${pageContext.request.contextPath}/guichet/reservation/import-excel">
          <i class="fas fa-file-excel"></i>
          Import Excel
          </a>
        </div>
        <div class="nav-user">
          <div class="agent-box">
            <div class="agent-avatar">
              <i class="fas fa-user"></i>
            </div>
            <div>
              <span class="agent-label">
              Agent guichet
              </span>
              <span class="agent-name">
              ${utilisateur.nom} ${utilisateur.prenom}
              </span>
            </div>
          </div>
          <a class="logout-btn" href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt"></i>
            Déconnexion
          </a>
        </div>
      </div>
    </nav>
    <!-- ================= PAGE ================= -->
    <div class="page-container">
      <div class="main-content">
        <!-- ================= HEADER ================= -->
        <div class="page-header">
          <div>
            <span class="header-label">
            IMPORTATION DES RÉSERVATIONS
            </span>
            <h1 class="page-title">
              Importer un fichier Excel
            </h1>
            <p class="page-subtitle">
              Ajoutez plusieurs réservations rapidement depuis un fichier Excel.
            </p>
          </div>
          <a href="${pageContext.request.contextPath}/assets/reservation-template.xlsx"
            class="btn btn-primary"
            download>
          <i class="fas fa-download"></i>
          Télécharger le modèle
          </a>
        </div>
        <!-- ================= ERREUR ================= -->
        <c:if test="${not empty erreur}">
          <div class="alert alert-danger">
            <i class="fas fa-circle-exclamation"></i>
            ${erreur}
          </div>
        </c:if>
        <!-- ================= IMPORT CARD ================= -->
        <form method="post"
          enctype="multipart/form-data"
          class="section-card">
          <div class="section-header">
            <div>
              <h2>
                <i class="fas fa-file-excel"></i>
                Importer Excel
              </h2>
              <p class="section-subtitle">
                Sélectionnez un fichier .xlsx contenant les réservations.
              </p>
            </div>
          </div>
          <div class="form-grid">
            <div class="form-field full-width">
              <label class="form-label">
              <i class="fas fa-file"></i>
              Fichier Excel
              </label>
              <input type="file"
                name="file"
                accept=".xlsx,.xls"
                class="form-input"
                required>
            </div>
          </div>
          <div class="form-actions">
            <a href="${pageContext.request.contextPath}/guichet/reservation"
              class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>
            Retour
            </a>
            <button type="submit"
              class="btn btn-primary">
            <i class="fas fa-upload"></i>
            Importer
            </button>
          </div>
        </form>
        <!-- ================= RESERVATIONS IMPORTEES ================= -->
        <div class="section-card imported-section">
          <div class="section-header">
            <div>
              <h2>
                <i class="fas fa-list"></i>
                Réservations importées
              </h2>
              <p class="section-subtitle">
                Les réservations ajoutées depuis le fichier Excel apparaîtront ici.
              </p>
            </div>
            <span class="filter-tab active">
            ${fn:length(reservations)} réservation(s)
            </span>
          </div>
          <div class="reservations-list">
            <c:forEach var="reservation" items="${reservations}">
              <c:set var="statutPaiementLower"
                value="${fn:toLowerCase(reservation.statutPaiement)}"/>
              <c:set var="statutReservationLower"
                value="${fn:toLowerCase(reservation.statutReservation)}"/>
              <c:set var="isAnnulee"
                value="${fn:contains(statutReservationLower,'annul')}"/>
              <article class="reservation-card ${isAnnulee ? 'reservation-cancelled' : ''}">
                <!-- ICON -->
                <div class="reservation-icon">
                  <i class="fas fa-ticket"></i>
                </div>
                <!-- DETAILS -->
                <div class="reservation-details">
                  <div class="reservation-header">
                    <div class="reservation-title">
                      <strong>
                      KOPV-${reservation.idReservation}
                      </strong>
                      <span class="client-name">
                      <i class="fas fa-user"></i>
                      ${reservation.client}
                      </span>
                    </div>
                    <div class="reservation-route">
                      <strong>
                      ${reservation.gareDepart}
                      </strong>
                      <i class="fas fa-arrow-right"></i>
                      <strong>
                      ${reservation.gareArrivee}
                      </strong>
                    </div>
                  </div>
                  <div class="reservation-meta">
                    <span>
                    <i class="fas fa-calendar"></i>
                    ${reservation.dateVoyage.format(
                    DateTimeFormatter.ofPattern(
                    "EEE dd MMM yyyy",
                    Locale.FRENCH
                    ))}
                    </span>
                    <span>
                    <i class="fas fa-clock"></i>
                    ${reservation.dateVoyage.format(
                    DateTimeFormatter.ofPattern("HH:mm")
                    )}
                    </span>
                    <span>
                    <i class="fas fa-chair"></i>
                    ${fn:length(fn:split(
                    reservation.numeroPlace,
                    ','
                    ))}
                    place(s)
                    </span>
                  </div>
                </div>
                <!-- INFO -->
                <div class="reservation-info">
                  <div class="seat-block">
                    <span class="info-label">
                    SIÈGES
                    </span>
                    <div class="seat-list">
                      <c:forEach var="place"
                        items="${fn:split(reservation.numeroPlace,',')}">
                        <span class="seat-badge">
                        ${fn:trim(place)}
                        </span>
                      </c:forEach>
                    </div>
                  </div>
                  <div class="price-block">
                    <span class="price-value">
                      <fmt:formatNumber
                        value="${reservation.tarif}"
                        pattern="#,##0"/>
                      Ar
                    </span>
                    <c:if test="${isAnnulee}">
                      <span class="refund-value">
                        Remboursé :
                        <fmt:formatNumber
                          value="${reservation.prixRemboursement}"
                          pattern="#,##0"/>
                        Ar
                      </span>
                    </c:if>
                  </div>
                </div>
                <!-- STATUS -->
                <div class="reservation-actions">
                  <c:choose>
                    <c:when test="${isAnnulee}">
                      <span class="status-badge status-annule">
                      <i class="fas fa-ban"></i>
                      ${reservation.statutReservation}
                      </span>
                    </c:when>
                    <c:when test="${fn:contains(statutPaiementLower,'rembour')}">
                      <span class="status-badge status-rembourse">
                      <i class="fas fa-rotate-left"></i>
                      ${reservation.statutPaiement}
                      </span>
                    </c:when>
                    <c:when test="${fn:contains(statutPaiementLower,'pay')}">
                      <span class="status-badge status-paye">
                      <i class="fas fa-check"></i>
                      ${reservation.statutPaiement}
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span class="status-badge status-attente">
                      <i class="fas fa-clock"></i>
                      ${reservation.statutPaiement}
                      </span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </article>
            </c:forEach>
            <c:if test="${empty reservations}">
              <div class="empty-state">
                <i class="fas fa-file-excel"></i>
                <p>
                  Les réservations importées apparaîtront ici.
                </p>
              </div>
            </c:if>
          </div>
        </div>
      </div>
      <!-- FIN MAIN CONTENT -->
    </div>
    <!-- FIN PAGE CONTAINER -->
  </body>
</html>
