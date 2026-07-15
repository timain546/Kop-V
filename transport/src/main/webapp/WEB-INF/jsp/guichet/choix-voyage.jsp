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
    <title>KOP-V - Choix du voyage</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/guichet/choix-voyage.css">
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
          <a class="nav-link active"
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
      <main class="main-content">
        <!-- ================= HEADER ================= -->
        <div class="page-header">
          <div>
            <span class="header-label">
            CHOIX DU VOYAGE
            </span>
            <h1>
              ${info.gareDepart.ville}
              <i class="fas fa-arrow-right"
                style="color:#16a34a;">
              </i>
              ${info.gareArrivee.ville}
            </h1>
            <p class="header-subtitle">
              ${voyages.size()}
              voyages disponibles
              ·
              du
              ${info.dateMin.format(
              DateTimeFormatter.ofPattern(
              "EEEE d MMMM",
              Locale.FRENCH
              )
              )}
              au
              ${info.dateMax.format(
              DateTimeFormatter.ofPattern(
              "EEEE d MMMM",
              Locale.FRENCH
              )
              )}
            </p>
          </div>
          <a href="${pageContext.request.contextPath}/guichet/reservation/new"
            class="btn btn-primary">
          <i class="fas fa-edit"></i>
          Modifier la recherche
          </a>
        </div>
        <!-- ================= ETAPES ================= -->
        <div class="steps-card">
          <div class="step-item">
            <div class="step-icon">
              <i class="fas fa-map-marker-alt"></i>
            </div>
            <span>
            Recherche
            </span>
          </div>
          <div class="step-line"></div>
          <div class="step-item active">
            <div class="step-icon">
              <i class="fas fa-bus"></i>
            </div>
            <span>
            Voyages
            </span>
          </div>
          <div class="step-line"></div>
          <div class="step-item">
            <div class="step-icon">
              <i class="fas fa-chair"></i>
            </div>
            <span>
            Places
            </span>
          </div>
          <div class="step-line"></div>
          <div class="step-item">
            <div class="step-icon">
              <i class="fas fa-users"></i>
            </div>
            <span>
            Passagers
            </span>
          </div>
        </div>
        <!-- ================= LISTE DES VOYAGES ================= -->
        <div class="section-card">
          <!-- HEADER SECTION -->
          <div class="section-header">
            <div>
              <h2>
                <i class="fas fa-route"></i>
                Voyages disponibles
              </h2>
              <p class="section-subtitle">
                Sélectionnez le trajet qui correspond à vos besoins.
              </p>
            </div>
          </div>
          <!-- ================= CARDS VOYAGES ================= -->
          <div class="reservations-list">
            <c:forEach var="voyage" items="${voyages}">
              <article class="reservation-card">
                <!-- ICON -->
                <div class="reservation-icon">
                  <i class="fas fa-bus"></i>
                </div>
                <!-- DETAILS -->
                <div class="reservation-details">
                  <div class="reservation-header">
                    <div class="reservation-title">
                      <strong>
                      ${voyage.dateDepart.format(
                      DateTimeFormatter.ofPattern(
                      "EEEE d MMMM",
                      Locale.FRENCH
                      )
                      )}
                      </strong>
                      <span class="client-name">
                      <i class="fas fa-id-card"></i>
                      ${voyage.immatriculationVehicule}
                      </span>
                    </div>
                    <div class="reservation-route">
                      <strong>
                      ${voyage.gareDepart}
                      </strong>
                      <i class="fas fa-arrow-right"></i>
                      <strong>
                      ${voyage.gareArrivee}
                      </strong>
                    </div>
                  </div>
                  <!-- META -->
                  <div class="reservation-meta">
                    <span>
                    <i class="fas fa-clock"></i>
                    ${voyage.heureDepart}
                    -
                    ${voyage.heureArrivee}
                    </span>
                    <span>
                    <i class="fas fa-hourglass-half"></i>
                    ${Double.valueOf(voyage.duree / 60).intValue()}h
                    ${voyage.duree % 60}min
                    </span>
                    <span>
                    <i class="fas fa-bus-alt"></i>
                    ${fn:toUpperCase(voyage.categorieVehicule)}
                    </span>
                  </div>
                </div>
                <!-- PRIX + ACTION -->
                <div class="reservation-info">
                  <div class="price-block">
                    <span class="price-value">
                      <fmt:formatNumber
                        value="${voyage.tarif}"
                        pattern="#,##0"/>
                      Ar
                    </span>
                    <c:choose>
                      <c:when test="${info.nbPlaces + 3 >= voyage.nbPlacesDisponibles}">
                        <span class="refund-value">
                        Plus que
                        ${voyage.nbPlacesDisponibles}
                        places
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="client-name">
                        ${voyage.nbPlacesDisponibles}
                        places restantes
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
                <!-- ACTION -->
                <div class="reservation-actions">
                  <form action="#" method="post">
                    <input type="hidden"
                      name="voyage"
                      value="${voyage.id}">
                    <button type="submit"
                      class="btn btn-success">
                    <i class="fas fa-check"></i>
                    Choisir
                    </button>
                  </form>
                </div>
              </article>
            </c:forEach>
          </div>
        </div>
      </main>
      <!-- ================= SIDEBAR ================= -->
      <aside class="sidebar">
        <div class="profile-card">
          <div class="profile-header-label">
            RÉCAPITULATIF VOYAGE
          </div>
          <h3 class="profile-name">
            Le trajet
          </h3>
          <div class="profile-avatar">
            <i class="fas fa-route"></i>
          </div>
          <div class="profile-info-section">
            <!-- TRAJET -->
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-map-marker-alt"></i>
              </span>
              <div>
                <span class="info-label">
                TRAJET
                </span>
                <span class="info-value">
                ${info.gareDepart.ville}
                →
                ${info.gareArrivee.ville}
                </span>
              </div>
            </div>
            <!-- PASSAGERS -->
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-users"></i>
              </span>
              <div>
                <span class="info-label">
                PASSAGERS
                </span>
                <span class="info-value">
                ${info.nbPlaces}
                personne${info.nbPlaces > 1 ? 's' : ''}
                </span>
              </div>
            </div>
          </div>
          <!-- AVANTAGES -->
          <div class="advantages">
            <div class="advantage">
              <i class="fas fa-check-circle"></i>
              Place garantie
            </div>
            <div class="advantage">
              <i class="fas fa-check-circle"></i>
              Véhicules confortables
            </div>
            <div class="advantage">
              <i class="fas fa-check-circle"></i>
              Réseau Madagascar
            </div>
          </div>
        </div>
      </aside>
    </div>
    <!-- FIN PAGE CONTAINER -->
  </body>
</html>
