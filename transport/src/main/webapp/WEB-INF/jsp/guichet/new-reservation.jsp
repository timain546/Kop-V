<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOP-V - Réserver un voyage</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/guichet/new-reservation.css">
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
        <!-- HEADER -->
        <div class="page-header">
          <div>
            <span class="header-label">
            NOUVELLE RÉSERVATION
            </span>
            <h1>
              Où souhaite le client aller ?
            </h1>
          </div>
        </div>
        <!-- ETAPES -->
        <div class="steps-card">
          <div class="step-item active">
            <div class="step-icon">
              <i class="fas fa-map-marker-alt"></i>
            </div>
            <span>
            Recherche
            </span>
          </div>
          <div class="step-line"></div>
          <div class="step-item">
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
        <!-- SEARCH CARD -->
        <div class="section-card">
          <div class="section-header">
            <div>
              <h2>
                <i class="fas fa-search"></i>
                Rechercher un voyage
              </h2>
              <p class="section-subtitle">
                Sélectionnez votre trajet et votre date de départ.
              </p>
            </div>
          </div>
          <form method="post" action="#" class="reservation-form">
            <div class="form-grid">
              <!-- DEPART -->
              <div class="form-group">
                <label>
                <i class="fas fa-map-marker-alt"></i>
                Ville de départ
                </label>
                <select name="gareDepart">
                  <c:forEach var="gare" items="${gares}">
                    <option value="${gare.id}"
                    ${(info.gareDepart != null
                    && info.gareDepart.id == gare.id)
                    ? 'selected' : ''}>
                    ${gare.ville}
                    </option>
                  </c:forEach>
                </select>
              </div>
              <!-- ARRIVEE -->
              <div class="form-group">
                <label>
                <i class="fas fa-location-arrow"></i>
                Ville d'arrivée
                </label>
                <select name="gareArrivee">
                  <c:forEach var="gare" items="${gares}">
                    <option value="${gare.id}"
                    ${(info.gareArrivee != null
                    && info.gareArrivee.id == gare.id)
                    ? 'selected' : ''}>
                    ${gare.ville}
                    </option>
                  </c:forEach>
                </select>
              </div>
              <!-- DATE MIN -->
              <div class="form-group">
                <label>
                <i class="fas fa-calendar-alt"></i>
                Date de départ à partir du
                </label>
                <input
                  type="date"
                  name="dateMin"
                  value="${info.dateMin != null ? info.dateMin : '2026-07-02'}">
              </div>
              <!-- DATE MAX -->
              <div class="form-group">
                <label>
                <i class="fas fa-calendar-check"></i>
                Jusqu'au
                </label>
                <input
                  type="date"
                  name="dateMax"
                  value="${info.dateMax != null ? info.dateMax : '2026-07-20'}">
              </div>
              <!-- PASSAGERS -->
              <div class="form-group">
                <label>
                <i class="fas fa-users"></i>
                Nombre de passagers
                </label>
                <div class="passenger-control">
                  <button
                    type="button"
                    class="passenger-btn"
                    id="minus-passenger">
                  <i class="fas fa-minus"></i>
                  </button>
                  <input
                    type="number"
                    name="nbPlaces"
                    min="1"
                    value="${info.nbPlaces != 0 ? info.nbPlaces : 1}">
                  <button
                    type="button"
                    class="passenger-btn"
                    id="plus-passenger">
                  <i class="fas fa-plus"></i>
                  </button>
                </div>
              </div>
            </div>
            <!-- BUTTON -->
            <button type="submit"
              class="btn btn-primary search-btn">
            <i class="fas fa-search"></i>
            Rechercher un voyage
            </button>
          </form>
        </div>
      </main>
      <!-- SIDEBAR -->
      <aside class="sidebar">
        <div class="info-card">
          <div class="info-header">
            <i class="fas fa-route"></i>
            Le voyage
          </div>
          <div class="info-body">
            <div class="info-item">
              <span class="info-icon">
              <i class="fas fa-bus"></i>
              </span>
              <div>
                <span class="info-label">
                TRANSPORT
                </span>
                <span class="info-value">
                Voyage interurbain
                </span>
              </div>
            </div>
            <div class="info-item">
              <span class="info-icon">
              <i class="fas fa-shield-alt"></i>
              </span>
              <div>
                <span class="info-label">
                GARANTIE
                </span>
                <span class="info-value">
                Transport sécurisé
                </span>
              </div>
            </div>
            <div class="info-item">
              <span class="info-icon">
              <i class="fas fa-clock"></i>
              </span>
              <div>
                <span class="info-label">
                SERVICE
                </span>
                <span class="info-value">
                Ponctuel et fiable
                </span>
              </div>
            </div>
          </div>
          <div class="advantages">
            <div class="advantage">
              <i class="fas fa-check-circle"></i>
              Chauffeurs vérifiés
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

    <script>
    document.addEventListener("DOMContentLoaded", () => {
        const input = document.querySelector('input[name="nbPlaces"]');
        const minus = document.getElementById("minus-passenger");
        const plus = document.getElementById("plus-passenger");

        minus.addEventListener("click", () => {
            let value = parseInt(input.value) || 1;
            if (value > parseInt(input.min)) {
                input.value = value - 1;
            }
        });

        plus.addEventListener("click", () => {
            let value = parseInt(input.value) || 1;
            input.value = value + 1;
        });
    });
    </script>
  </body>
</html>
