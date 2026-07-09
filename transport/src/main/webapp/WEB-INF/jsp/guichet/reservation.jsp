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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/reservation.css" />
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

          <!-- Nav : Réservations (route réelle, inchangée) -->
          <nav class="admin-nav" aria-label="Navigation principale">
            <a href="${pageContext.request.contextPath}/guichet/reservation" class="admin-nav-pill active">
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

          <!-- ================= CARTE HÉRO ================= -->


          <!-- ================= FILTRES (date + ville, inchangés) ================= -->
          <form class="filters-card" action="${pageContext.request.contextPath}/guichet/reservation" method="get">
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

          <div class="page-size-wrap">
            <form class="page-size-form" action="${pageContext.request.contextPath}/guichet/reservation" method="get">
              <input type="hidden" name="page" value="0" />
              <input type="hidden" name="dateDebut" value="${filtre.dateDebut}" />
              <input type="hidden" name="dateFin" value="${filtre.dateFin}" />
              <input type="hidden" name="villeDepart" value="${filtre.villeDepart}" />
              <input type="hidden" name="villeArrivee" value="${filtre.villeArrivee}" />

              <label for="size" class="page-size-label">Afficher</label>
              <select id="size" name="size" class="page-size-select">
                <option value="5"  ${page.size == 5 ? 'selected' : ''}>5</option>
                <option value="10" ${page.size == 10 ? 'selected' : ''}>10</option>
                <option value="20" ${page.size == 20 ? 'selected' : ''}>20</option>
                <option value="50" ${page.size == 50 ? 'selected' : ''}>50</option>
                <option value="100" ${page.size == 100 ? 'selected' : ''}>100</option>
              </select>
              <span class="page-size-suffix">réservations par page</span>

              <button type="submit" class="page-size-btn">Appliquer</button>
            </form>
          </div>

          <!-- ================= LISTE (cartes ticket) ================= -->
          <div class="res-list">
            <c:forEach var="reservation" items="${reservations}">
              <c:set var="statutPaiementLower" value="${fn:toLowerCase(reservation.statutPaiement)}" />
              <c:set var="statutReservationLower" value="${fn:toLowerCase(reservation.statutReservation)}" />
              <c:set var="isAnnulee" value="${fn:contains(statutReservationLower, 'annul')}" />
              <article class="ticket-card ${isAnnulee ? 'ticket-card-cancelled' : ''}">
                <div class="ticket-left">
                  <div class="ticket-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" class="icon-md" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 3v4a1 1 0 0 0 1 1h4"></path><path d="M17 21H7a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h7l5 5v11a2 2 0 0 1-2 2z"></path><path d="m9 15 2 2 4-4"></path></svg>
                  </div>
                  <div>
                    <p class="ticket-code">KOPV-${reservation.idReservation}</p>
                    <p class="ticket-client">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-xs" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle></svg>
                      ${reservation.client}
                    </p>
                  </div>
                </div>

                <div class="ticket-route">
                  <div class="route-point">
                    <p class="route-time">${reservation.dateVoyage.format(DateTimeFormatter.ofPattern("HH:mm"))}</p>
                    <p class="route-city">${reservation.gareDepart}</p>
                  </div>
                  <div class="route-line-wrap">
                    <span class="route-date-badge">
                      ${reservation.dateVoyage.format(DateTimeFormatter.ofPattern("EEE dd MMM yyyy", Locale.FRENCH))}
                    </span>
                    <div class="route-line"></div>
                  </div>
                  <div class="route-point route-point-end">
                    <p class="route-city">${reservation.gareArrivee}</p>
                  </div>
                </div>

                <div class="ticket-side">
                  <div class="seats-block">
                    <span class="seats-label">
                      SIÈGES
                    </span>
                    <div class="seats-badges">
                      <c:forEach var="place" items="${fn:split(reservation.numeroPlace, ',')}">
                        <span class="seat-badge">${fn:trim(place)}</span>
                      </c:forEach>
                    </div>
                  </div>

                  <div class="ticket-money">
                    <p class="ticket-price"><fmt:formatNumber value="${reservation.tarif}" pattern="#,##0"/> Ar</p>
                    <c:if test="${isAnnulee}">
                      <p class="ticket-refund">
                        Remboursé <fmt:formatNumber value="${reservation.prixRemboursement}" pattern="#,##0"/> Ar
                      </p>
                    </c:if>
                  </div>

                  <c:choose>
                    <c:when test="${isAnnulee}">
                      <span class="ticket-status status-annulee">${reservation.statutReservation}</span>
                    </c:when>
                    <c:when test="${fn:contains(statutPaiementLower, 'rembour')}">
                      <span class="ticket-status status-remboursee">${reservation.statutPaiement}</span>
                    </c:when>
                    <c:when test="${fn:contains(statutPaiementLower, 'pay')}">
                      <span class="ticket-status status-paye">${reservation.statutPaiement}</span>
                    </c:when>
                    <c:otherwise>
                      <span class="ticket-status status-attente">${reservation.statutPaiement}</span>
                    </c:otherwise>
                  </c:choose>

                  <details class="ticket-actions">
                    <summary class="ticket-actions-trigger" aria-label="Actions de la réservation KOPV-${reservation.idReservation}">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="1"></circle>
                        <circle cx="19" cy="12" r="1"></circle>
                        <circle cx="5" cy="12" r="1"></circle>
                      </svg>
                    </summary>
                    <div class="ticket-actions-menu">
                      <a href="${pageContext.request.contextPath}/guichet/reservation/${reservation.idReservation}/annulation" class="ticket-action ticket-action-danger">Annuler</a>
                      <a href="${pageContext.request.contextPath}/guichet/reservation/${reservation.idReservation}/pdf" class="ticket-action">Exporter</a>
                      <a href="${pageContext.request.contextPath}/guichet/reservation/${reservation.idReservation}/paiement" class="ticket-action">Payer le reste</a>
                    </div>
                  </details>
                </div>
              </article>
            </c:forEach>

            <c:if test="${page.totalPages > 1}">
              <nav class="pagination" aria-label="Pagination des réservations">
                <!-- Précédent -->
                <c:choose>
                  <c:when test="${page.number > 0}">
                    <a class="pagination-btn pagination-nav"
                       href="?page=${page.number - 1}&size=${page.size}&dateDebut=${filtre.dateDebut}&dateFin=${filtre.dateFin}&villeDepart=${filtre.villeDepart}&villeArrivee=${filtre.villeArrivee}"
                       aria-label="Page précédente">
                      ← Précédent
                    </a>
                  </c:when>
                  <c:otherwise>
                    <span class="pagination-btn pagination-nav is-disabled" aria-disabled="true">← Précédent</span>
                  </c:otherwise>
                </c:choose>

                <!-- Numéros -->
                <div class="pagination-pages">
                  <c:forEach begin="0" end="${page.totalPages - 1}" var="i">
                    <c:choose>
                      <c:when test="${i == page.number}">
                        <span class="pagination-btn is-active" aria-current="page">${i + 1}</span>
                      </c:when>
                      <c:otherwise>
                        <a class="pagination-btn"
                           href="?page=${i}&size=${page.size}&dateDebut=${filtre.dateDebut}&dateFin=${filtre.dateFin}&villeDepart=${filtre.villeDepart}&villeArrivee=${filtre.villeArrivee}"
                           aria-label="Aller à la page ${i + 1}">
                          ${i + 1}
                        </a>
                      </c:otherwise>
                    </c:choose>
                  </c:forEach>
                </div>

                <!-- Suivant -->
                <c:choose>
                  <c:when test="${page.number < page.totalPages - 1}">
                    <a class="pagination-btn pagination-nav"
                       href="?page=${page.number + 1}&size=${page.size}&dateDebut=${filtre.dateDebut}&dateFin=${filtre.dateFin}&villeDepart=${filtre.villeDepart}&villeArrivee=${filtre.villeArrivee}"
                       aria-label="Page suivante">
                      Suivant →
                    </a>
                  </c:when>
                  <c:otherwise>
                    <span class="pagination-btn pagination-nav is-disabled" aria-disabled="true">Suivant →</span>
                  </c:otherwise>
                </c:choose>
              </nav>
            </c:if>

            <c:if test="${empty reservations}">
              <p class="res-empty">Aucune réservation ne correspond à ces critères.</p>
            </c:if>
          </div>
        </main>

        <aside class="summary-col">
          <section class="summary-card reservation-summary-card">
            <div class="reservation-summary-hero">
              <div class="reservation-summary-badge">Vue rapide</div>
              <h2 class="reservation-summary-title">Réservations du guichet</h2>
              <p class="reservation-summary-text">
                Un aperçu clair des réservations, des statuts de paiement et un accès direct à la création d'une nouvelle fiche.
              </p>

              <div class="reservation-summary-metrics">
                <div class="summary-metric summary-metric-primary">
                  <span class="summary-metric-value">${fn:length(reservations)}</span>
                  <span class="summary-metric-label">Réservations</span>
                </div>
                <div class="summary-metric">
                  <span class="summary-metric-value">${fn:length(stats)}</span>
                  <span class="summary-metric-label">Statuts suivis</span>
                </div>
                <div class="summary-metric">
                  <span class="summary-metric-value">24h</span>
                  <span class="summary-metric-label">Délai d'annulation</span>
                </div>
              </div>
            </div>

            <div class="reservation-summary-body">
              <div class="reservation-summary-panel">
                <div class="reservation-summary-panel-head">
                  <span>Répartition des paiements</span>
                </div>

                <div class="reservation-summary-status-list">
                  <c:forEach var="entry" items="${stats}">
                    <div class="reservation-summary-status-row">
                      <span class="reservation-summary-status-name">${fn:toUpperCase(entry.key)}</span>
                      <span class="reservation-summary-status-value">${entry.value}</span>
                    </div>
                  </c:forEach>
                  <c:if test="${empty stats}">
                    <p class="reservation-summary-empty">Aucun statut disponible pour le moment.</p>
                  </c:if>
                </div>
              </div>

              <div class="reservation-summary-note">
                <div class="reservation-summary-note-icon">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><path d="M12 16v-4"></path><path d="M12 8h.01"></path></svg>
                </div>
                <div>
                  <p class="reservation-summary-note-title">Navigation rapide</p>
                  <p class="reservation-summary-note-text">Créez une nouvelle réservation ou revenez au tableau de bord en un clic.</p>
                </div>
              </div>

              <a href="${pageContext.request.contextPath}/guichet/reservation/new" class="new-res-btn reservation-summary-cta">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"></path><path d="M12 5v14"></path></svg>
                Nouvelle réservation
              </a>

              <a href="${pageContext.request.contextPath}/guichet/reservation/import-excel" class="new-res-btn reservation-summary-cta">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"></path><path d="M12 5v14"></path></svg>
                Importer depuis un Excel
              </a>
            </div>
          </section>
        </aside>
      </div>
    </div>
  </body>
</html>
