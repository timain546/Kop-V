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
    <title>KOP-V - Gestion des réservations</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/reservation.css">
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
          <a class="nav-link active"
            href="${pageContext.request.contextPath}/guichet/reservation">
          <i class="fas fa-ticket-alt"></i>
          Réservations
          </a>
          <a class="nav-link"
            href="${pageContext.request.contextPath}/guichet/reservation/new">
          <i class="fas fa-plus-circle"></i>
          Nouvelle réservation
          </a>
          <a class="nav-link"
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
          <div class="header-left">
            <span class="header-label">
            GESTION DES RÉSERVATIONS
            </span>
            <h1>
              Bonjour,
              <c:choose>
                <c:when test="${not empty agent}">
                  ${utilisateur.nom} ${utilisateur.prenom}
                </c:when>
                <c:otherwise>
                  Agent guichet
                </c:otherwise>
              </c:choose>
            </h1>
            <p class="header-subtitle">
              Consultez, filtrez et gérez toutes les réservations KOP-V.
            </p>
          </div>
          <a href="${pageContext.request.contextPath}/guichet/reservation/new"
            class="btn btn-primary">
          <i class="fas fa-plus"></i>
          Nouvelle réservation
          </a>
        </div>
        <!-- ================= SECTION RESERVATIONS ================= -->
        <div class="section-card">
          <!-- ================= FILTRES ================= -->
          <form class="filters-panel"
            action="${pageContext.request.contextPath}/guichet/reservation"
            method="get">
            <div class="filter-group">
              <label>
              Date début
              </label>
              <input type="date"
                name="dateDebut"
                value="${filtre.dateDebut}"/>
            </div>
            <div class="filter-group">
              <label>
              Date fin
              </label>
              <input type="date"
                name="dateFin"
                value="${filtre.dateFin}"/>
            </div>
            <div class="filter-group">
              <label>
              Ville départ
              </label>
              <select name="villeDepart">
                <option value="">
                  Toutes
                </option>
                <c:forEach var="ville" items="${villes}">
                  <option value="${ville}"
                  ${ville == filtre.villeDepart ? 'selected' : ''}>
                  ${ville}
                  </option>
                </c:forEach>
              </select>
            </div>
            <div class="filter-group">
              <label>
              Ville arrivée
              </label>
              <select name="villeArrivee">
                <option value="">
                  Toutes
                </option>
                <c:forEach var="ville" items="${villes}">
                  <option value="${ville}"
                  ${ville == filtre.villeArrivee ? 'selected' : ''}>
                  ${ville}
                  </option>
                </c:forEach>
              </select>
            </div>
            <button type="submit"
              class="btn btn-search">
            <i class="fas fa-search"></i>
            Rechercher
            </button>
          </form>
          <!-- ================= LISTE DES RESERVATIONS ================= -->
          <div class="reservations-list" id="reservationsList">
            <c:forEach var="reservation" items="${reservations}" varStatus="loop">
              <c:set var="statutPaiementLower"
                value="${fn:toLowerCase(reservation.statutPaiement)}"/>
              <c:set var="statutReservationLower"
                value="${fn:toLowerCase(reservation.statutReservation)}"/>
              <c:set var="isAnnulee"
                value="${fn:contains(statutReservationLower,'annul')}"/>
              <div class="reservation-card ${isAnnulee ? 'reservation-cancelled' : ''}"
                data-status="${statutReservationLower}"
                style="animation-delay:${loop.index * 0.05}s;">
                <!-- ICON -->
                <div class="reservation-icon">
                  <i class="fas fa-ticket-alt"></i>
                </div>
                <!-- INFORMATIONS PRINCIPALES -->
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
                    <i class="fas fa-calendar-alt"></i>
                    ${reservation.dateReservation.format(
                    DateTimeFormatter.ofPattern("EEE dd MMM yyyy",
                    Locale.FRENCH))}
                    </span>
                    <span>
                    <i class="fas fa-clock"></i>
                    ${reservation.dateReservation.format(
                    DateTimeFormatter.ofPattern("HH:mm"))}
                    </span>
                    <span>
                    <i class="fas fa-chair"></i>
                    ${fn:length(fn:split(reservation.numeroPlace,','))}
                    place(s)
                    </span>
                  </div>
                </div>
                <!-- SIEGES + PRIX -->
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
                      <fmt:formatNumber value="${reservation.tarif}"
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
                <!-- ACTIONS -->
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
                      <i class="fas fa-undo"></i>
                      ${reservation.statutPaiement}
                      </span>
                    </c:when>
                    <c:when test="${fn:contains(statutPaiementLower,'pay')}">
                      <span class="status-badge status-paye">
                      <i class="fas fa-check-circle"></i>
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
                  <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/guichet/reservation/${reservation.idReservation}/pdf"
                      class="btn btn-sm btn-secondary">
                    <i class="fas fa-file-pdf"></i>
                    PDF
                    </a>
                    <c:if test="${not isAnnulee}">
                      <a href="${pageContext.request.contextPath}/guichet/reservation/${reservation.idReservation}/paiement"
                        class="btn btn-sm btn-success">
                      <i class="fas fa-money-bill"></i>
                      Payer
                      </a>
                      <a href="${pageContext.request.contextPath}/guichet/reservation/${reservation.idReservation}/annulation"
                        class="btn btn-sm btn-danger">
                      <i class="fas fa-times"></i>
                      Annuler
                      </a>
                    </c:if>
                  </div>
                </div>
              </div>
            </c:forEach>
            <c:if test="${empty reservations}">
              <div class="empty-state">
                <i class="fas fa-ticket-alt"></i>
                <p>
                  Aucune réservation trouvée.
                </p>
              </div>
            </c:if>
          </div>
          <!-- ================= PAGINATION ================= -->
          <c:if test="${page.totalPages > 1}">
            <nav class="pagination">
              <c:choose>
                <c:when test="${page.number > 0}">
                  <a class="pagination-btn"
                    href="?page=${page.number - 1}
                    &size=${page.size}
                    &dateDebut=${filtre.dateDebut}
                    &dateFin=${filtre.dateFin}
                    &villeDepart=${filtre.villeDepart}
                    &villeArrivee=${filtre.villeArrivee}">
                  ← Précédent
                  </a>
                </c:when>
                <c:otherwise>
                  <span class="pagination-btn disabled">
                  ← Précédent
                  </span>
                </c:otherwise>
              </c:choose>
              <div class="pagination-pages">
                <c:forEach begin="0"
                  end="${page.totalPages - 1}"
                  var="i">
                  <c:choose>
                    <c:when test="${i == page.number}">
                      <span class="pagination-btn active">
                      ${i + 1}
                      </span>
                    </c:when>
                    <c:otherwise>
                      <a class="pagination-btn"
                        href="?page=${i}
                        &size=${page.size}
                        &dateDebut=${filtre.dateDebut}
                        &dateFin=${filtre.dateFin}
                        &villeDepart=${filtre.villeDepart}
                        &villeArrivee=${filtre.villeArrivee}">
                      ${i + 1}
                      </a>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </div>
              <c:choose>
                <c:when test="${page.number < page.totalPages - 1}">
                  <a class="pagination-btn"
                    href="?page=${page.number + 1}
                    &size=${page.size}
                    &dateDebut=${filtre.dateDebut}
                    &dateFin=${filtre.dateFin}
                    &villeDepart=${filtre.villeDepart}
                    &villeArrivee=${filtre.villeArrivee}">
                  Suivant →
                  </a>
                </c:when>
                <c:otherwise>
                  <span class="pagination-btn disabled">
                  Suivant →
                  </span>
                </c:otherwise>
              </c:choose>
            </nav>
          </c:if>
        </div>
        <!-- FIN SECTION CARD -->
      </div>
      <!-- FIN MAIN CONTENT -->
      <!-- ================= SIDEBAR ================= -->
      <aside class="sidebar">
        <div class="profile-card">
          <div class="profile-header-label">
            GUICHET KOP-V
          </div>
          <h3 class="profile-name">
            <c:choose>
              <c:when test="${not empty utilisateur}">
                ${utilisateur.nom}
                ${utilisateur.prenom}
              </c:when>
              <c:otherwise>
                Agent
              </c:otherwise>
            </c:choose>
          </h3>
          <div class="profile-avatar">
            <c:choose>
              <c:when test="${not empty utilisateur}">
                ${fn:substring(utilisateur.nom,0,1)}${fn:substring(utilisateur.prenom,0,1)}
              </c:when>
              <c:otherwise>
                KV
              </c:otherwise>
            </c:choose>
          </div>
          <div class="profile-role">
            Agent de réservation
          </div>
          <div class="profile-badge">
            <i class="fas fa-check-circle"></i>
            Session active
          </div>
          <div class="profile-info-section">
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-id-card"></i>
              </span>
              <div>
                <span class="info-label">
                MATRICULE
                </span>
                <span class="info-value">
                AG-${utilisateur.id}
                </span>
              </div>
            </div>
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-envelope"></i>
              </span>
              <div>
                <span class="info-label">
                EMAIL
                </span>
                <span class="info-value">
                  <c:choose>
                    <c:when test="${not empty utilisateur.email}">
                        ${utilisateur.email}
                    </c:when>
                    <c:otherwise>
                      -
                    </c:otherwise>
                  </c:choose>
                </span>
              </div>
            </div>
          </div>
          <a href="${pageContext.request.contextPath}/guichet/reservation/new"
            class="btn btn-profile">
          <i class="fas fa-plus"></i>
          Nouvelle réservation
          </a>
          <a href="${pageContext.request.contextPath}/guichet/reservation/import-excel"
            class="btn btn-profile">
          <i class="fas fa-file-excel"></i>
          Import Excel
          </a>
        </div>
      </aside>
    </div>
    <!-- FIN PAGE CONTAINER -->
  </body>
</html>
