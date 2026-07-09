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
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Liste des réservations — KOP-V</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guichet/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guichet/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guichet/reservation.css" />
  </head>
  <body>
    <div class="app-shell">
      <header class="topbar">
        <div class="container topbar-inner">
          <a href="${pageContext.request.contextPath}/" class="brand-link">
            <div class="brand-icon">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-lg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M8 6v6"></path><path d="M15 6v6"></path><path d="M2 12h19.6"></path>
                <path d="M18 18h3s.5-1.7.8-2.8c.1-.4.2-.8.2-1.2 0-.4-.1-.8-.2-1.2l-1.4-5C20.1 6.8 19.1 6 18 6H4a2 2 0 0 0-2 2v10h3"></path>
                <circle cx="7" cy="18" r="2"></circle><path d="M9 18h5"></path><circle cx="16" cy="18" r="2"></circle>
              </svg>
            </div>
            <div class="brand-title"><span class="kop">KOP</span><span class="dash">—</span><span class="v">V</span></div>
          </a>

          <!-- Nav admin : Réservations passe avant Recherche -->
          <nav class="admin-nav" aria-label="Navigation principale">
            <a href="${pageContext.request.contextPath}/guichet/reservation" class="admin-nav-link active">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"></rect><path d="M16 2v4"></path><path d="M8 2v4"></path><path d="M3 10h18"></path><path d="m9 16 2 2 4-4"></path></svg>
              <span>Réservations</span>
            </a>
          </nav>

          <div class="topbar-right">
            <div class="help-text">Aide ? <strong>+261 34 00 000 00</strong></div>
            <div class="agent-menu">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21a8 8 0 0 0-16 0"></path><circle cx="12" cy="7" r="4"></circle></svg>
              <span>Agent</span>
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-xs" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m6 9 6 6 6-6"></path></svg>
            </div>
          </div>
        </div>
      </header>

      <div class="main-grid reservations-grid">
        <main class="main-col">
          <section class="res-section">
            <div class="res-head">
              <div>
                <p class="hero-kicker">Réservations</p>
                <h1 class="res-title">Liste des réservations</h1>
                <p class="res-subtitle">${fn:length(reservations)} réservations trouvées</p>
              </div>
              <button type="button" class="export-btn">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><path d="M7 10l5 5 5-5"></path><path d="M12 15V3"></path></svg>
                Exporter
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-xs" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m6 9 6 6 6-6"></path></svg>
              </button>
            </div>

            <!-- Action pointe vers /guichet/reservation (route réelle du controller).
                 Le filtre "Statut paiement" a été retiré : le controller/repository actuels
                 ne le reçoivent pas encore côté requête. Ajoute-le des deux côtés si besoin. -->
            <form class="filters-bar res-filters" action="${pageContext.request.contextPath}/guichet/reservation" method="get">
              <div class="filter-field">
                <label class="filter-label-top">Date du voyage</label>
                <div class="date-range">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"></rect><path d="M16 2v4"></path><path d="M8 2v4"></path><path d="M3 10h18"></path></svg>
                  <input type="date" name="dateDebut" value="${filtre.dateDebut}" />
                  <span class="date-range-sep">→</span>
                  <input type="date" name="dateFin" value="${filtre.dateFin}" />
                </div>
              </div>

              <div class="filter-field">
                <label class="filter-label-top">Ville de départ</label>
                <select name="villeDepart" class="select-filter">
                  <option value="">Toutes</option>
                  <c:forEach var="ville" items="${villes}">
                    <option value="${ville}" ${ville == filtre.villeDepart ? 'selected' : ''}>${ville}</option>
                  </c:forEach>
                </select>
              </div>

              <div class="filter-field">
                <label class="filter-label-top">Ville d'arrivée</label>
                <select name="villeArrivee" class="select-filter">
                  <option value="">Toutes</option>
                  <c:forEach var="ville" items="${villes}">
                    <option value="${ville}" ${ville == filtre.villeArrivee ? 'selected' : ''}>${ville}</option>
                  </c:forEach>
                </select>
              </div>

              <button type="submit" class="search-btn">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><path d="m21 21-4.3-4.3"></path></svg>
                Rechercher
              </button>
            </form>

            <div class="res-table">
              <div class="res-table-head">
                <span>Réservation</span>
                <span>Client</span>
                <span>Voyage</span>
                <span>Places</span>
                <span>Tarif</span>
                <span>Statut</span>
              </div>

              <c:forEach var="reservation" items="${reservations}">
                <article class="res-row">
                  <div class="res-col res-col-code">
                    <div class="res-code-icon">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-md" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 3v4a1 1 0 0 0 1 1h4"></path><path d="M17 21H7a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h7l5 5v11a2 2 0 0 1-2 2z"></path><path d="m9 15 2 2 4-4"></path></svg>
                    </div>
                    <div>
                      <p class="res-code">#RES-${reservation.idReservation}</p>
                      <p class="res-meta">${reservation.dateReservation.format(DateTimeFormatter.ofPattern("dd MMM yyyy · HH:mm", Locale.FRENCH))}</p>
                    </div>
                  </div>

                  <div class="res-col res-col-client">
                    <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-muted" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle></svg>
                    <div>
                      <p class="res-client-name">${reservation.client}</p>
                      <p class="res-meta">${reservation.telephone}</p>
                    </div>
                  </div>

                  <div class="res-col res-col-voyage">
                    <div class="res-voyage-date">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-muted" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"></rect><path d="M16 2v4"></path><path d="M8 2v4"></path><path d="M3 10h18"></path></svg>
                      <span>${reservation.dateVoyage.format(DateTimeFormatter.ofPattern("EEE dd MMM yyyy", Locale.FRENCH))}</span>
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-muted" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><path d="M12 6v6l4 2"></path></svg>
                      <span>${reservation.dateVoyage.format(DateTimeFormatter.ofPattern("HH:mm"))}</span>
                    </div>
                    <div class="res-voyage-route">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-muted" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"></path><circle cx="12" cy="10" r="3"></circle></svg>
                      <span>${reservation.gareDepart}</span>
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-xs" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"></path><path d="m12 5 7 7-7 7"></path></svg>
                      <span>${reservation.gareArrivee}</span>
                    </div>
                  </div>

                  <div class="res-col res-col-places">
                    <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-muted" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10 20a1 1 0 0 0 .553.895l2 1A1 1 0 0 0 14 21v-7a2 2 0 0 1 .517-1.341L21.74 4.67A1 1 0 0 0 21 3H3a1 1 0 0 0-.742 1.67l7.225 7.989A2 2 0 0 1 10 14z"></path></svg>
                    <p class="res-places-list">${reservation.numeroPlace}</p>
                  </div>

                  <div class="res-col res-col-tarif">
                    <fmt:formatNumber value="${reservation.tarif}" pattern="#,##0"/> Ar
                  </div>

                  <div class="res-col res-col-statut">
                    <c:set var="statutLower" value="${fn:toLowerCase(reservation.statutPaiement)}" />
                    <c:choose>
                      <c:when test="${fn:contains(statutLower, 'annul')}">
                        <span class="res-badge res-badge-annulee">${reservation.statutPaiement}</span>
                      </c:when>
                      <c:when test="${fn:contains(statutLower, 'rembour')}">
                        <span class="res-badge res-badge-remboursee">${reservation.statutPaiement}</span>
                      </c:when>
                      <c:when test="${fn:contains(statutLower, 'pay')}">
                        <span class="res-badge res-badge-paye">${reservation.statutPaiement}</span>
                      </c:when>
                      <c:otherwise>
                        <span class="res-badge res-badge-attente">${reservation.statutPaiement}</span>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </article>
              </c:forEach>

              <c:if test="${empty reservations}">
                <p class="res-empty">Aucune réservation ne correspond à ces critères.</p>
              </c:if>
            </div>

            <!-- Pagination retirée pour l'instant : le controller/service actuels renvoient
                 toutes les réservations correspondant au filtre, sans découpage par page.
                 Réintègre ce bloc quand getReservations(...) acceptera page/taillePage. -->
          </section>
        </main>

        <aside class="summary-col">
          <!-- À la place du récapitulatif de recherche : bouton Nouvelle réservation -->
          <a href="${pageContext.request.contextPath}/guichet/reservation/new" class="new-res-card">
            <div class="new-res-icon">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-lg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"></path><path d="M12 5v14"></path></svg>
            </div>
            <div>
              <p class="new-res-title">Nouvelle réservation</p>
              <p class="new-res-subtitle">Créer une réservation pour un client</p>
            </div>
          </a>

          <div class="summary-card">
            <div class="summary-head">
              <p class="summary-title">Besoin d'aide ?</p>
            </div>
            <div class="summary-body">
              <p class="help-desc">Vous pouvez filtrer les réservations par période ou par ville.</p>
              <button type="button" class="new-filter-btn">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 3H2l8 9.46V19l4 2v-8.54z"></path></svg>
                Nouveau filtre
              </button>
            </div>
          </div>

          <!-- stats est une Map<String, Long> : clé = libellé réel du statut de paiement
               en base (ex. "Payé", "Part. payé"...), valeur = nombre de réservations. -->
          <div class="summary-card">
            <div class="summary-head">
              <p class="summary-title">Statuts de paiement</p>
            </div>
            <div class="summary-body">
              <c:forEach var="entry" items="${stats}">
                <div class="legend-row">
                  <span class="legend-label">${entry.key}</span>
                  <span class="legend-count">${entry.value}</span>
                </div>
              </c:forEach>
              <c:if test="${empty stats}">
                <p class="res-empty">Pas encore de données.</p>
              </c:if>
            </div>
          </div>
        </aside>
      </div>
    </div>
  </body>
</html>
