<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<fmt:setLocale value="fr"/>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informations passagers — KOP-V</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/guichet/new-paiement.css">
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
        <!-- ================= ETAPES ================= -->
        <div class="steps-card">
          <div class="step-item done">
            <div class="step-icon">
              <i class="fas fa-check"></i>
            </div>
            <span>
            Recherche
            </span>
          </div>
          <div class="step-line active"></div>
          <div class="step-item done">
            <div class="step-icon">
              <i class="fas fa-check"></i>
            </div>
            <span>
            Voyages
            </span>
          </div>
          <div class="step-line active"></div>
          <div class="step-item done">
            <div class="step-icon">
              <i class="fas fa-check"></i>
            </div>
            <span>
            Places
            </span>
          </div>
          <div class="step-line active"></div>
          <div class="step-item active">
            <div class="step-icon">
              <i class="fas fa-user"></i>
            </div>
            <span>
            Passagers
            </span>
          </div>
        </div>
        <!-- ================= HEADER ================= -->
        <div class="page-header">
          <div>
            <span class="header-label">
            INFORMATIONS PASSAGERS
            </span>
            <h1>
              <i class="fas fa-user-check"></i>
              Finalisez la réservation
            </h1>
            <p class="header-subtitle">
              Ces informations figureront sur les billets et seront vérifiées lors de l'embarquement.
            </p>
          </div>
        </div>
        <form method="post"
          action="#"
          class="section-card">
          <c:if test="${erreur != null}">
            <div class="alert-error">
              <i class="fas fa-circle-exclamation"></i>
              ${erreur}
            </div>
          </c:if>
          <!-- ================= FORMULAIRE ================= -->
          <div class="section-header">
            <div>
              <h2>
                <i class="fas fa-id-card"></i>
                Informations personnelles
              </h2>
              <p class="section-subtitle">
                Veuillez renseigner les informations du voyageur principal.
              </p>
            </div>
          </div>
          <div class="passenger-form-grid">
            <div class="field">
              <label>
              <i class="fas fa-user"></i>
              Nom complet
              </label>
              <input
                type="text"
                name="nomClient"
                value="${previousNomClient != null ? previousNomClient : ''}"
                placeholder="Ex. Rakoto Andrianina"
                required
                >
            </div>
            <div class="field">
              <label>
              <i class="fas fa-phone"></i>
              Téléphone
              </label>
              <input
                type="tel"
                name="telephoneClient"
                value="${previousTelephoneClient != null ? previousTelephoneClient : ''}"
                placeholder="034 00 000 00"
                required
                >
            </div>
            <div class="field">
              <label>
              <i class="fas fa-money-bill"></i>
              Montant
              </label>
              <input
                type="number"
                name="montant"
                value="${previousMontant != null ? previousMontant : ''}"
                placeholder="Ex. 10000"
                required
                >
            </div>
            <div class="field">
              <label>
              <i class="fas fa-credit-card"></i>
              Mode de paiement
              </label>
              <select name="modePaiement">
                <c:forEach var="mode"
                  items="${modesPaiements}">
                  <option
                  value="${mode.id}"
                  ${(previousModePaiement != null && previousModePaiement.id == mode.id)
                  ? 'selected'
                  : ''}
                  >
                  ${mode.libelle}
                  </option>
                </c:forEach>
              </select>
            </div>
            <div class="field full">
              <label>
              <i class="fas fa-receipt"></i>
              Référence transaction
              </label>
              <input
                type="text"
                name="reference"
                value="${previousReference != null ? previousReference : ''}"
                placeholder="S’il y en a"
                >
            </div>
          </div>
          <!-- ================= ACTIONS ================= -->
          <div class="form-actions">
            <a href="${pageContext.request.contextPath}/guichet/reservation/new/choix-place"
              class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>
            Retour aux places
            </a>
            <button type="submit"
              class="btn btn-success">
            <i class="fas fa-check"></i>
            Confirmer et payer
            </button>
          </div>
        </form>
      </main>
      <!-- ================= SIDEBAR ================= -->
      <aside class="sidebar">
        <div class="profile-card">
          <div class="profile-header-label">
            RÉCAPITULATIF VOYAGE
          </div>
          <h3 class="profile-name">
            Votre réservation
          </h3>
          <div class="profile-avatar">
            <i class="fas fa-bus"></i>
          </div>
          <div class="profile-info-section">
            <!-- TRAJET -->
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-route"></i>
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
            <!-- DATE -->
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-calendar"></i>
              </span>
              <div>
                <span class="info-label">
                DATE
                </span>
                <span class="info-value">
                ${info.voyage.dateHeureDepart.format(
                DateTimeFormatter.ofPattern(
                "EEEE d MMMM",
                Locale.FRENCH
                )
                )}
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
          <div class="summary-extra">
            <div class="summary-line">
              <span>
              Compagnie
              </span>
              <strong>
              KOP-V
              </strong>
            </div>
            <div class="summary-line">
              <span>
              Horaire
              </span>
              <strong>
              ${info.voyage.heureDepart}
              →
              ${info.voyage.heureArrivee}
              </strong>
            </div>
            <div class="summary-line">
              <span>
              Classe
              </span>
              <strong>
              ${info.voyage.vehicule.categorie.libelle}
              </strong>
            </div>
          </div>
          <div class="seat-summary">
            <h4>
              <i class="fas fa-chair"></i>
              Places choisies
            </h4>
            <div class="selected-list">
              <c:forEach var="place"
                items="${info.places}">
                <span class="selected-seat">
                ${place.numero}
                </span>
              </c:forEach>
            </div>
          </div>
          <div class="total-box">
            <span>
            Total
            </span>
            <strong>
              <fmt:formatNumber
                value="${info.voyage.tarif * info.places.size()}"
                pattern="#,##0"
                />
              Ar
            </strong>
          </div>
          <div class="advantages">
            <div class="advantage">
              <i class="fas fa-check-circle"></i>
              Place garantie
            </div>
            <div class="advantage">
              <i class="fas fa-lock"></i>
              Paiement sécurisé
            </div>
            <div class="advantage">
              <i class="fas fa-clock"></i>
              Annulation jusqu'à 24h
            </div>
          </div>
        </div>
      </aside>
    </div>
    </div>
  </body>
</html>
