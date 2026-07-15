<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="fr"/>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOP-V - Annulation de réservation</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/guichet/annulation.css">
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
    <div class="page-container">
      <div class="main-content">
        <div class="page-header">
          <div class="header-left">
            <span class="header-label">
            GESTION DES RÉSERVATIONS
            </span>
            <h1>
              Annulation de la réservation #${reservation.id}
            </h1>
            <p class="header-subtitle">
              Une réservation peut être annulée uniquement
              avant les 24 heures précédant le départ.
            </p>
          </div>
          <a href="${pageContext.request.contextPath}/guichet/reservation"
            class="btn btn-export">
          <i class="fas fa-arrow-left"></i>
          Retour
          </a>
        </div>
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-header">
              <span class="stat-label">
              RÉSERVATION
              </span>
              <div class="stat-icon icon-blue">
                <i class="fas fa-ticket-alt"></i>
              </div>
            </div>
            <div class="stat-value">
              #${reservation.id}
            </div>
            <div class="stat-sub">
              Référence client
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-header">
              <span class="stat-label">
              MONTANT PAYÉ
              </span>
              <div class="stat-icon icon-green">
                <i class="fas fa-money-bill-wave"></i>
              </div>
            </div>
            <div class="stat-value">
              <fmt:formatNumber
                value="${montantPayeTotal}"
                pattern="#,##0"/>
              Ar
            </div>
            <div class="stat-sub">
              Total déjà encaissé
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-header">
              <span class="stat-label">
              ACTION
              </span>
              <div class="stat-icon icon-yellow">
                <i class="fas fa-ban"></i>
              </div>
            </div>
            <div class="stat-value">
              Annulation
            </div>
            <div class="stat-sub">
              Avec remboursement
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-header">
              <span class="stat-label">
              STATUT
              </span>
              <div class="stat-icon icon-purple">
                <i class="fas fa-clock"></i>
              </div>
            </div>
            <div class="stat-value">
              En attente
            </div>
            <div class="stat-sub">
              Validation guichet
            </div>
          </div>
        </div>
        <div class="section-card">
          <div class="section-header">
            <div>
              <h2>
                <i class="fas fa-times-circle"></i>
                Formulaire d'annulation
              </h2>
              <p class="section-subtitle">
                Complétez les informations ci-dessous afin de procéder
                à l'annulation de la réservation.
              </p>
            </div>
          </div>
          <c:if test="${erreur != null}">
            <div class="alert-danger">
              <i class="fas fa-exclamation-circle"></i>
              ${erreur}
            </div>
          </c:if>
          <form action="#" method="post">
            <div class="form-grid">
              <div class="form-group">
                <label>
                Pourcentage retenu
                </label>
                <input
                  id="pourcentageFrais"
                  type="number"
                  name="pourcentageFrais"
                  value="10"
                  min="0"
                  max="100"
                  step="0.01"
                  placeholder="Ex : 10"/>
              </div>
              <div class="form-group">
                <label>
                Motif de l'annulation
                </label>
                <input
                  type="text"
                  name="motif"
                  placeholder="Pourquoi le client souhaite annuler ?"/>
              </div>
            </div>
            <div class="summary-card">
              <div class="summary-header">
                <i class="fas fa-info-circle"></i>
                Résumé du remboursement
              </div>
              <div class="summary-content">
                <div class="summary-item">
                  <span>
                  Montant payé
                  </span>
                  <strong>
                    <fmt:formatNumber
                      value="${montantPayeTotal}"
                      pattern="#,##0"/>
                    Ar
                  </strong>
                </div>
                <div class="summary-item">
                  <span>
                  Frais d'annulation
                  </span>
                  <strong id="fraisAnnulation">
                  10 %
                  </strong>
                </div>
                <div class="summary-item total">
                  <span>
                  Montant remboursé estimé
                  </span>
                  <strong id="montantRembourse">
                    <fmt:formatNumber
                      value="${montantPayeTotal * 0.9}"
                      pattern="#,##0"/>
                    Ar
                  </strong>
                </div>
              </div>
            </div>
            <div class="form-warning">
              <i class="fas fa-exclamation-triangle"></i>
              Cette action est définitive.
              Vérifiez les informations avant de confirmer.
            </div>
            <div class="form-actions">
              <a href="${pageContext.request.contextPath}/guichet/reservation"
                class="btn btn-export">
              <i class="fas fa-arrow-left"></i>
              Retour aux réservations
              </a>
              <button type="submit"
                class="btn btn-danger">
              <i class="fas fa-times"></i>
              Annuler la réservation
              </button>
            </div>
          </form>
        </div>
      </div>
      <aside class="sidebar">
        <div class="profile-card">
          <div class="profile-header-label">
            INFORMATIONS RÉSERVATION
          </div>
          <div class="profile-avatar">
            <i class="fas fa-user"></i>
          </div>
          <h3 class="profile-name">
            Client réservation
          </h3>
          <div class="profile-role">
            Réservation #${reservation.id}
          </div>
          <div class="profile-badge">
            <i class="fas fa-check-circle"></i>
            KOP-V
          </div>
          <div class="profile-info-section">
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-calendar-alt"></i>
              </span>
              <div>
                <span class="info-label">
                DATE DÉPART
                </span>
                <span class="info-value">
                ${reservation.voyage.dateHeureDepart}
                </span>
              </div>
            </div>
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-map-marker-alt"></i>
              </span>
              <div>
                <span class="info-label">
                TRAJET
                </span>
                <span class="info-value">
                ${reservation.voyage.trajet.gareDepart.ville}
                -
                ${reservation.voyage.trajet.gareArrivee.ville}
                </span>
              </div>
            </div>
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-users"></i>
              </span>
              <div>
                <span class="info-label">
                PASSAGERS
                </span>
                <span class="info-value">
                ${nbPlaces}
                </span>
              </div>
            </div>
          </div>
          <div class="profile-stats">
            <div class="profile-stat">
              <span class="profile-stat-label">
              PRIX TOTAL
              </span>
              <span class="profile-stat-value">
                <fmt:formatNumber
                  value="${montantPayeTotal}"
                  pattern="#,##0"/>
              </span>
            </div>
            <div class="profile-stat">
              <span class="profile-stat-label">
              REMBOURS.
              </span>
              <span class="profile-stat-value" id="pourcentageRemboursement">
              90 %
              </span>
            </div>
          </div>
        </div>
      </aside>
    </div>

    <script>

    const montantPaye = ${montantPayeTotal};

    const inputTaux = document.getElementById("pourcentageFrais");
    const remboursementTaux = document.getElementById("pourcentageRemboursement");
    const fraisElement = document.getElementById("fraisAnnulation");
    const remboursementElement = document.getElementById("montantRembourse");


    function formatAr(value) {
        return new Intl.NumberFormat('fr-FR').format(Math.round(value));
    }


    function calculerRemboursement() {

        let taux = parseFloat(inputTaux.value);

        if (isNaN(taux)) {
            taux = 0;
        }

        if (taux < 0) {
            taux = 0;
        }

        if (taux > 100) {
            taux = 100;
        }


        const frais = montantPaye * taux / 100;

        const remboursement = montantPaye - frais;


        fraisElement.textContent = taux + " %";
        remboursementTaux.textContent = (100 - taux) + " %";

        remboursementElement.textContent = formatAr(remboursement) + " Ar";
    }


    inputTaux.addEventListener(
        "input",
        calculerRemboursement
    );


    calculerRemboursement();

    </script>
  </body>
</html>
