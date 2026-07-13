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
    <title>Choix des places — KOP-V</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css" />
    <script>!function(){var t=localStorage.getItem('kop-v-theme')||('matchMedia' in window&&matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light');document.documentElement.setAttribute('data-theme',t)}();</script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guichet/choix-place.css" />
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
            <div class="step step-done">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 6 9 17l-5-5"></path></svg>
              <span>Recherche</span>
            </div>
            <div class="step-divider step-divider-active"></div>
            <div class="step step-done">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 6 9 17l-5-5"></path></svg>
              <span>Voyages</span>
            </div>
            <div class="step-divider step-divider-active"></div>
            <div class="step active">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M19 9V6a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v3"></path>
                <path d="M3 16a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-5a2 2 0 0 0-4 0v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V11a2 2 0 0 0-4 0z"></path>
                <path d="M5 18v2"></path><path d="M19 18v2"></path>
              </svg>
              <span>Places</span>
            </div>
            <div class="step-divider"></div>
            <div class="step">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 20a6 6 0 0 0-12 0"></path><circle cx="12" cy="10" r="4"></circle><circle cx="12" cy="12" r="10"></circle></svg>
              <span>Passagers</span>
            </div>
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

      <div class="main-grid seats-grid">
        <main class="main-col">
          <form action="#" method="post" class="seats-section">
            <div>
              <p class="hero-kicker">Étape 3 / 4</p>
              <h1 class="seats-title">Choisissez vos places</h1>
              <p class="seats-subtitle">
                KOP-V ${info.voyage.vehicule.categorieVehicule.libelle}
                · Véhicule à ${places.size()} places
                · départ ${info.voyage.heureDepart}
              </p>
            </div>

            <div class="seat-layout-grid">
              <div class="seat-map-card">
                <div class="seat-map-wrap">
                  <div class="seat-map-head">
                    <div class="driver-box">🚗</div>
                    <span class="seat-map-front">Avant</span>
                  </div>

                  <div class="seat-grid">
                    <c:forEach begin="1" end="${maxY}" var="row">
                      <div class="seat-row">
                        <c:forEach begin="0" end="3" var="col">
                          <!-- aisle -->
                          <c:if test="${col == 2}">
                            <div class="aisle"></div>
                          </c:if>
                          <!-- seat -->
                          <c:set var="place" value="${null}" />
                          <c:forEach var="p" items="${places}">
                            <c:if test="${p.place.x == col && p.place.y == row}">
                              <c:set var="place" value="${p}" />
                            </c:if>
                          </c:forEach>
                          <c:choose>
                            <c:when test="${place != null}">
                              <label class="seat ${place.occupee ? 'seat-occupied' : 'seat-free'}">
                                <input
                                    type="checkbox"
                                    name="idPlaces"
                                    value="${place.id}"
                                    data-numero="${place.place.numero}"
                                    ${place.occupee ? 'disabled' : ''}>
                                <span>${place.place.numero}</span>
                              </label>
                            </c:when>
                            <c:otherwise>
                              <div class="seat-empty"></div>
                            </c:otherwise>
                          </c:choose>
                        </c:forEach>
                      </div>
                    </c:forEach>
                  </div>
                </div>

                <div class="seat-legend">
                  <div><span class="legend-dot legend-free"></span>Disponible</div>
                  <div><span class="legend-dot legend-selected"></span>Sélectionné</div>
                  <div><span class="legend-dot legend-occupied"></span>Occupé</div>
                </div>
              </div>

              <div class="seat-side">
                <div class="side-card">
                  <p class="side-kicker">Sélection</p>
                  <p class="side-value"><span id="selected-seat-count">0</span> / ${info.nbPlaces} place${info.nbPlaces > 1 ? 's' : ''}</p>
                  <div class="selected-list">
                  </div>
                </div>

                <div class="side-meta">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M19 9V6a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v3"></path>
                    <path d="M3 16a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-5a2 2 0 0 0-4 0v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V11a2 2 0 0 0-4 0z"></path>
                    <path d="M5 18v2"></path><path d="M19 18v2"></path>
                  </svg>
                  <span>${places.size()} sièges au total</span>
                </div>
              </div>
            </div>

            <div class="seat-actions">
              <a href="${pageContext.request.contextPath}/guichet/reservation/new/choix-voyage" class="back-btn">← Retour</a>
              <button type="submit" class="next-btn">
                Continuer
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-md" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"></path><path d="m12 5 7 7-7 7"></path></svg>
              </button>
            </div>
          </form>
        </main>

        <aside class="summary-col">
          <div class="summary-card">
            <div class="summary-head"><p class="summary-kicker">Récapitulatif</p><p class="summary-title">Votre voyage</p></div>
            <div class="summary-body">
              <div class="summary-item">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-md icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"></path><circle cx="12" cy="10" r="3"></circle></svg>
                <div>
                  <p class="summary-item-label">Trajet</p>
                  <p class="summary-item-value">${info.gareDepart.ville} → ${info.gareArrivee.ville}</p>
                </div>
              </div>
              <div class="summary-item">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-md icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M8 2v4"></path><path d="M16 2v4"></path><rect width="18" height="18" x="3" y="4" rx="2"></rect><path d="M3 10h18"></path></svg>
                <div>
                  <p class="summary-item-label">Date</p>
                  <p class="summary-item-value">${info.voyage.dateHeureDepart.format(DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.FRENCH))}</p>
                </div>
              </div>
              <div class="summary-item">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-md icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path><path d="M16 3.128a4 4 0 0 1 0 7.744"></path><path d="M22 21v-2a4 4 0 0 0-3-3.87"></path><circle cx="9" cy="7" r="4"></circle></svg>
                <div>
                  <p class="summary-item-label">Passagers</p>
                  <p class="summary-item-value">${info.nbPlaces} personne${info.nbPlaces > 1 ? 's' : ''}</p>
                </div>
              </div>

              <div class="summary-divider"></div>
              <div>
                <p class="summary-item-label">Compagnie</p>
                <p class="summary-item-value">KOP-V</p>
                <p class="trip-mini">
                  ${info.voyage.heureDepart}
                  → ${info.voyage.heureArrivee}
                  · ${info.voyage.vehicule.categorieVehicule.libelle}
                </p>
              </div>
              <div class="summary-divider"></div>
              <%-- TODO --%>
              <div class="summary-total"><span>Total</span><strong id="total-price">0 Ar</strong></div>
            </div>
            <div class="summary-foot">Place garantie · Paiement sécurisé · Annulation possible jusqu'à 24h avant départ.</div>
          </div>
        </aside>
      </div>
    </div>
      <script src="${pageContext.request.contextPath}/assets/js/animations.js"></script>
  </body>

  <script>
    const maxSeatCount = ${info.nbPlaces};
    const price = ${info.voyage.tarif};

    document.addEventListener("DOMContentLoaded", () => {
        const totalPriceSpan = document.getElementById('total-price');
        const selectedSeatCount = document.getElementById('selected-seat-count');
        const selectedListDiv = document.querySelector('.selected-list');
        const nextBtn = document.querySelector('.next-btn');

        document.querySelectorAll('input[name="idPlaces"]').forEach(cb => {
            cb.addEventListener("change", () => {
                const selected = [...document.querySelectorAll('input[name="idPlaces"]:checked')];

                if (selected.length > maxSeatCount) {
                    cb.checked = false;
                    cb.dispatchEvent(new Event("change"));
                    return;
                }

                selectedSeatCount.textContent = selected.length;
                totalPriceSpan.textContent = (price * selected.length).toLocaleString("fr-FR") + " Ar";

                selectedListDiv.innerHTML = "";
                selected.forEach(seat => {
                    const span = document.createElement("span");
                    span.className = "selected-seat";
                    span.textContent = seat.dataset.numero;
                    selectedListDiv.appendChild(span);
                });

                nextBtn.disabled = ! (selected.length == maxSeatCount);
            });
        });
    });
  </script>
</html>
