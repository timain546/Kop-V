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
    <title>Annulation — KOP-V</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/paiement.css" />
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
          <form action="#" method="post" class="passenger-section">
            <div class="passenger-head">
              <div>
                <h1 class="passenger-title">Annulation de la réservation #${reservation.id}</h1>
                <p class="passenger-subtitle">
                  Une réservation peut être annulée 24 heures avant le départ.
                  Montant déjà payé : <fmt:formatNumber value="${montantPayeTotal}" pattern="#,##0"/> Ar.
                </p>
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
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="19" y1="5" x2="5" y2="19"></line>
                        <circle cx="7" cy="7" r="2"></circle>
                        <circle cx="17" cy="17" r="2"></circle>
                      </svg>
                      Pourcentage retenu
                    </span>
                    <input name="pourcentageFrais" class="field-input" type="number" min="0" max="100" step="0.01" value="10" placeholder="Ex. 10" />
                  </label>

                  <label class="field field-span-2">
                    <span class="field-label">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M16 10h2"></path><path d="M16 14h2"></path><path d="M6.17 15a3 3 0 0 1 5.66 0"></path><circle cx="9" cy="11" r="2"></circle><rect x="2" y="5" width="20" height="14" rx="2"></rect>
                      </svg>
                      Motif
                    </span>
                    <input name="motif" class="field-input" type="text" placeholder="Pourquoi le client veut annuler la réservation ?" />
                  </label>
                </div>
              </article>
            </div>

            <div class="passenger-actions">
              <a href="${pageContext.request.contextPath}/guichet/reservation" class="back-btn">← Retour aux réservations</a>
              <button type="submit" class="next-btn">Annuler</button>
            </div>
          </form>
        </main>
      </div>
    </div>
  </body>
</html>
