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
    <title>Voyages disponibles — KOP-V</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css" />
    <script>!function(){var t=localStorage.getItem('kop-v-theme')||('matchMedia' in window&&matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light');document.documentElement.setAttribute('data-theme',t)}();</script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/choix-voyage.css" />
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

          <nav class="top-steps" aria-label="Étapes">
            <div class="step step-done"><svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 6 9 17l-5-5"></path></svg><span>Recherche</span></div>
            <div class="step-divider step-divider-active"></div>
            <div class="step active"><svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M8 6v6"></path><path d="M15 6v6"></path><path d="M2 12h19.6"></path><path d="M18 18h3s.5-1.7.8-2.8c.1-.4.2-.8.2-1.2 0-.4-.1-.8-.2-1.2l-1.4-5C20.1 6.8 19.1 6 18 6H4a2 2 0 0 0-2 2v10h3"></path><circle cx="7" cy="18" r="2"></circle><path d="M9 18h5"></path><circle cx="16" cy="18" r="2"></circle></svg><span>Voyages</span></div>
            <div class="step-divider"></div>
            <div class="step"><svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 9V6a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v3"></path><path d="M3 16a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-5a2 2 0 0 0-4 0v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V11a2 2 0 0 0-4 0z"></path><path d="M5 18v2"></path><path d="M19 18v2"></path></svg><span>Places</span></div>
            <div class="step-divider"></div>
            <div class="step"><svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 20a6 6 0 0 0-12 0"></path><circle cx="12" cy="10" r="4"></circle><circle cx="12" cy="12" r="10"></circle></svg><span>Passagers</span></div>
          </nav>

          <div class="topbar-actions" style="display:flex; align-items:center; gap:16px;">
              <div class="help-text">Aide ? <strong>+261 34 00 000 00</strong></div>
              <button class="theme-toggle" onclick="toggleTheme()" title="Changer de thème" style="position:relative;top:0;right:0;">
                  <i class="fas fa-sun theme-icon-light"></i>
                  <i class="fas fa-moon theme-icon-dark"></i>
              </button>
            </div>
        </div>
      </header>

      <div class="main-grid trips-grid">
        <main class="main-col">
          <section class="trips-section">
            <div class="trips-head">
              <div>
                <p class="hero-kicker">Étape 2 / 4</p>
                <h1 class="trips-title">${info.gareDepart.ville} → ${info.gareArrivee.ville}</h1>
                <p class="trips-subtitle">
                  ${voyages.size()} voyages disponibles ·
                  du ${info.dateMin.format(DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.FRENCH))}
                  au ${info.dateMax.format(DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.FRENCH))}
                </p>
              </div>
              <a href="${pageContext.request.contextPath}/guichet/reservation/new" class="edit-search-btn">← Modifier la recherche</a>
            </div>

            <div class="filters-bar">
              <div class="filter-label"><svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10 5H3"></path><path d="M12 19H3"></path><path d="M14 3v4"></path><path d="M16 17v4"></path><path d="M21 12h-9"></path><path d="M21 19h-5"></path><path d="M21 5h-7"></path><path d="M8 10v4"></path><path d="M8 12H3"></path></svg><span>Trier</span></div>
              <div class="chip-group"><button class="chip chip-active">Horaire</button><button class="chip">Prix</button><button class="chip">Durée</button></div>
              <div class="filter-label filter-label-right"><svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10 20a1 1 0 0 0 .553.895l2 1A1 1 0 0 0 14 21v-7a2 2 0 0 1 .517-1.341L21.74 4.67A1 1 0 0 0 21 3H3a1 1 0 0 0-.742 1.67l7.225 7.989A2 2 0 0 1 10 14z"></path></svg><span>Classe</span></div>
              <div class="chip-group"><button class="chip chip-active">Toutes</button><button class="chip">Standard</button><button class="chip">Confort</button><button class="chip">VIP</button></div>
            </div>

            <div class="trip-list">
              <c:forEach var="voyage" items="${voyages}">
                <article class="trip-card">
                  <div class="trip-operator">
                    <div class="trip-operator-icon">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-md" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M8 6v6"></path><path d="M15 6v6"></path><path d="M2 12h19.6"></path><path d="M18 18h3s.5-1.7.8-2.8c.1-.4.2-.8.2-1.2 0-.4-.1-.8-.2-1.2l-1.4-5C20.1 6.8 19.1 6 18 6H4a2 2 0 0 0-2 2v10h3"></path><circle cx="7" cy="18" r="2"></circle><path d="M9 18h5"></path><circle cx="16" cy="18" r="2"></circle></svg>
                    </div>
                    <div>
                      <p class="trip-operator-name">${voyage.dateDepart.format(DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.FRENCH))}</p>
                      <p class="trip-operator-meta">${voyage.immatriculationVehicule}</p>
                    </div>
                  </div>
                  <div class="trip-timeline">
                    <div class="trip-time-block">
                      <p class="trip-time">${voyage.heureDepart}</p>
                      <p class="trip-city">${voyage.gareDepart}</p>
                    </div>
                    <div class="trip-line-block">
                      <div class="trip-duration">
                        <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><path d="M12 6v6l4 2"></path></svg>
                        <span>${Double.valueOf(voyage.duree / 60).intValue()}h ${voyage.duree % 60}min</span>
                      </div>
                      <div class="trip-line"></div>
                      <span class="trip-badge trip-badge-${voyage.categorieVehicule}">
                        ${fn:toUpperCase(voyage.categorieVehicule)}
                      </span>
                    </div>
                    <div class="trip-time-block trip-time-block-end">
                      <p class="trip-time">${voyage.heureArrivee}</p>
                      <p class="trip-city">${voyage.gareArrivee}</p>
                    </div>
                  </div>
                  <div class="trip-price-col">
                    <div class="trip-price-wrap">
                      <div class="trip-price">
                        <fmt:formatNumber value="${voyage.tarif}" pattern="#,##0"/> Ar
                      </div>
                      <c:choose>
                        <c:when test="${info.nbPlaces + 3 >= voyage.nbPlacesDisponibles}">
                          <div class="trip-seats trip-seats-low">
                            Plus que ${voyage.nbPlacesDisponibles} places
                          </div>
                        </c:when>
                        <c:otherwise>
                          <div class="trip-seats">
                            ${voyage.nbPlacesDisponibles} places restantes
                          </div>
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <form action="#" method="post">
                      <input type="hidden" name="voyage" value="${voyage.id}">
                      <button type="submit" class="choose-btn">
                        Choisir
                        <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"></path><path d="m12 5 7 7-7 7"></path></svg>
                      </button>
                    </form>
                  </div>
                </article>
              </c:forEach>
            </div>
          </section>
        </main>

        <aside class="summary-col">
          <div class="summary-card">
            <div class="summary-head">
              <p class="summary-kicker">Récapitulatif</p>
              <p class="summary-title">Votre voyage</p>
            </div>
            <div class="summary-body">
              <div class="summary-item">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-md icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"></path><circle cx="12" cy="10" r="3"></circle></svg>
                <div>
                  <p class="summary-item-label">Trajet</p>
                  <p class="summary-item-value">${info.gareDepart.ville} → ${info.gareArrivee.ville}</p>
                </div>
              </div>
              <div class="summary-item">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-md icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path><path d="M16 3.128a4 4 0 0 1 0 7.744"></path><path d="M22 21v-2a4 4 0 0 0-3-3.87"></path><circle cx="9" cy="7" r="4"></circle></svg>
                <div>
                  <p class="summary-item-label">Passagers</p>
                  <p class="summary-item-value">${info.nbPlaces} personne${info.nbPlaces > 1 ? 's' : ''}</p>
                </div>
              </div>
            </div>
            <div class="summary-foot">Place garantie · Paiement sécurisé · Annulation possible jusqu'à 24h avant départ.</div>
          </div>
        </aside>
      </div>
    </div>
      <script src="${pageContext.request.contextPath}/assets/js/animations.js"></script>
  </body>
</html>
