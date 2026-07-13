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
    <title>Importation Excel — KOP-V</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/paiement.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/reservation.css" />
  </head>
  <body>
    <div class="app-shell">
      <header class="topbar">
        <div class="container topbar-inner">
          <a href="/" class="brand-link">
            <div class="brand-icon">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-lg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M8 6v6"></path><path d="M15 6v6"></path><path d="M2 12h19.6"></path>
                <path d="M18 18h3s.5-1.7.8-2.8c.1-.4.2-.8.2-1.2 0-.4-.1-.8-.2-1.2l-1.4-5C20.1 6.8 19.1 6 18 6H4a2 2 0 0 0-2 2v10h3"></path>
                <circle cx="7" cy="18" r="2"></circle><path d="M9 18h5"></path><circle cx="16" cy="18" r="2"></circle>
              </svg>
            </div>
            <div class="brand-title"><span class="kop">KOP</span><span class="dash">—</span><span class="v">V</span></div>
          </a>

          <div class="help-text">Aide ? <strong>+261 34 00 000 00</strong></div>
        </div>
      </header>

      <div class="main-grid passenger-grid">
        <main class="main-col">
          <form action="#" method="post" class="passenger-section" enctype="multipart/form-data">
            <div class="passenger-head">
              <div>
                <h1 class="passenger-title">Importation d’un fichier Excel</h1>
                <p class="passenger-subtitle">Importez les réservations provenant d’un fichier Excel.</p>
                <a href="${pageContext.request.contextPath}/assets/reservation-template.xlsx" download class="next-btn">Télécharger le template</a>
              </div>
            </div>

            <c:if test="${erreur != null}">
                <div class="passenger-cards">
                    <article class="passenger-card error-card">
                        <div class="error-message">
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-error" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="12" cy="12" r="10"></circle>
                                <line x1="12" y1="8" x2="12" y2="12"></line>
                                <line x1="12" y1="16" x2="12.01" y2="16"></line>
                            </svg>
                            <span>${erreur}</span>
                        </div>
                    </article>
                </div>
            </c:if>

            <div class="passenger-cards">
              <article class="passenger-card">
                <div class="passenger-form-grid">
                  <label class="field field-span-2">
                    <span class="field-label">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-banknote-icon lucide-banknote"><rect width="20" height="12" x="2" y="6" rx="2"/><circle cx="12" cy="12" r="2"/><path d="M6 12h.01M18 12h.01"/></svg>
                      Fichier
                    </span>
                    <input name="file" class="field-input" type="file" />
                  </label>
                </div>
              </article>
            </div>

            <div class="passenger-actions">
              <a href="${pageContext.request.contextPath}/guichet/reservation" class="back-btn">← Retour aux réservations</a>
              <button type="submit" class="next-btn">Importer</button>
            </div>
          </form>

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
                </div>
              </article>
            </c:forEach>

            <c:if test="${empty reservations}">
              <p class="res-empty">Les réservations importées apparaîtront ici.</p>
            </c:if>
          </div>
        </main>
      </div>
    </div>
  </body>
</html>
