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
    <title>Paiement réservation - KOP-V</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/guichet/paiement.css">
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
            GESTION DES PAIEMENTS
            </span>
            <h1>
              Paiement réservation #${reservation.id}
            </h1>
            <p class="header-subtitle">
              Enregistrez un paiement partiel ou complet pour cette réservation.
            </p>
          </div>
          <a href="${pageContext.request.contextPath}/guichet/reservation"
            class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i>
          Retour
          </a>
        </div>
        <!-- ================= INFOS RESERVATION ================= -->
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-header">
              <span class="stat-label">
              CLIENT
              </span>
              <div class="stat-icon icon-green">
                <i class="fas fa-user"></i>
              </div>
            </div>
            <div class="stat-value"
              style="font-size:20px">
              ${reservation.client.nom}
            </div>
            <div class="stat-sub">
              Téléphone :
              ${reservation.client.telephone}
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-header">
              <span class="stat-label">
              MONTANT TOTAL
              </span>
              <div class="stat-icon icon-green">
                <i class="fas fa-money-bill"></i>
              </div>
            </div>
            <div class="stat-value">
              <fmt:formatNumber
                value="${prixTotal}"
                pattern="#,##0"/>
              Ar
            </div>
            <div class="stat-sub">
              Prix réservation
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-header">
              <span class="stat-label">
              DÉJÀ PAYÉ
              </span>
              <div class="stat-icon icon-green">
                <i class="fas fa-check-circle"></i>
              </div>
            </div>
            <div class="stat-value">
              <fmt:formatNumber
                value="${montantPayeTotal}"
                pattern="#,##0"/>
              Ar
            </div>
            <div class="stat-sub">
              Paiements enregistrés
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-header">
              <span class="stat-label">
              RESTE À PAYER
              </span>
              <div class="stat-icon icon-red">
                <i class="fas fa-hourglass-half"></i>
              </div>
            </div>
            <div class="stat-value">
              <fmt:formatNumber
                value="${reservation.voyage.tarif * paiements.size() - montantPayeTotal}"
                pattern="#,##0"/>
              Ar
            </div>
            <div class="stat-sub">
              Solde restant
            </div>
          </div>
        </div>
        <!-- ================= FORMULAIRE ================= -->
        <div class="section-card">
          <div class="section-header">
            <div>
              <h2>
                <i class="fas fa-money-check-alt"></i>
                Nouveau paiement
              </h2>
              <p class="section-subtitle">
                Saisissez le montant reçu et le mode de paiement.
              </p>
            </div>
          </div>
          <c:if test="${not empty erreur}">
            <div class="alert alert-danger">
              <i class="fas fa-exclamation-triangle"></i>
              ${erreur}
            </div>
          </c:if>
          <form method="post"
            action="${pageContext.request.contextPath}/guichet/reservation/${reservation.id}/paiement">
            <div class="filters-panel">
              <div class="filter-group">
                <label>
                Montant
                </label>
                <input type="number"
                  name="montant"
                  required
                  placeholder="Ex : 10000">
              </div>
              <div class="filter-group">
                <label>
                Mode paiement
                </label>
                <select name="modePaiement"
                  required>
                  <c:forEach var="mode"
                    items="${modesPaiements}">
                    <option value="${mode.id}">
                      ${mode.libelle}
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="filter-group">
                <label>
                Référence transaction
                </label>
                <input type="text"
                  name="reference"
                  placeholder="Optionnel">
              </div>
              <div class="filter-group">
                <button class="btn btn-success"
                  type="submit"
                  style="margin-top:20px">
                <i class="fas fa-check"></i>
                Valider paiement
                </button>
              </div>
            </div>
          </form>
        </div>
        <!-- ================= HISTORIQUE PAIEMENTS ================= -->
        <div class="section-card">
          <div class="section-header">
            <div>
              <h2>
                <i class="fas fa-history"></i>
                Historique des paiements
              </h2>
              <p class="section-subtitle">
                Liste des versements effectués pour cette réservation.
              </p>
            </div>
          </div>
          <div class="table-container">
            <table class="payment-table">
              <thead>
                <tr>
                  <th>
                    Date
                  </th>
                  <th>
                    Montant
                  </th>
                  <th>
                    Mode
                  </th>
                  <th>
                    Référence
                  </th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${not empty paiements}">
                    <c:forEach var="paiement"
                      items="${paiements}">
                      <tr>
                        <td>
                          <div class="table-date">
                            <i class="fas fa-calendar-alt"></i>
                            ${paiement.datePaiement.format(
                            DateTimeFormatter.ofPattern(
                            "dd MMMM yyyy",
                            Locale.FRENCH
                            ))}
                          </div>
                        </td>
                        <td>
                          <strong class="amount-green">
                            <fmt:formatNumber
                              value="${paiement.montant}"
                              pattern="#,##0"/>
                            Ar
                          </strong>
                        </td>
                        <td>
                          <span class="status-badge status-paye">
                          <i class="fas fa-money-bill-wave"></i>
                          ${paiement.modePaiement.libelle}
                          </span>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${not empty paiement.referenceTransaction}">
                              <span class="reference">
                              ${paiement.referenceTransaction}
                              </span>
                            </c:when>
                            <c:otherwise>
                              <span class="text-muted">
                              -
                              </span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="5">
                        <div class="empty-state">
                          <i class="fas fa-receipt"></i>
                          <p>
                            Aucun paiement enregistré.
                          </p>
                        </div>
                      </td>
                    </tr>
                  </c:otherwise>
                </c:choose>
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="3">
                    <strong>
                    Total payé
                    </strong>
                  </td>
                  <td colspan="2">
                    <strong class="amount-green">
                      <fmt:formatNumber
                        value="${montantPayeTotal}"
                        pattern="#,##0"/>
                      Ar
                    </strong>
                  </td>
                </tr>
                <tr>
                  <td colspan="3">
                    <strong>
                    Reste à payer
                    </strong>
                  </td>
                  <td colspan="2">
                    <strong class="amount-red">
                      <fmt:formatNumber
                        value="${prixTotal - montantPayeTotal}"
                        pattern="#,##0"/>
                      Ar
                    </strong>
                  </td>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>
      </div>
      <!-- FIN MAIN CONTENT -->
    </div>
    <!-- FIN PAGE CONTAINER -->
  </body>
</html>
