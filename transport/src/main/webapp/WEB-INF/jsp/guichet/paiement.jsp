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
    <title>Informations paiements — KOP-V</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guichet/paiement.css" />
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
            <div class="step step-done"><svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 6 9 17l-5-5"></path></svg><span>Voyages</span></div>
            <div class="step-divider step-divider-active"></div>
            <div class="step step-done"><svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 6 9 17l-5-5"></path></svg><span>Places</span></div>
            <div class="step-divider step-divider-active"></div>
            <div class="step active"><svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 20a6 6 0 0 0-12 0"></path><circle cx="12" cy="10" r="4"></circle><circle cx="12" cy="12" r="10"></circle></svg><span>Passagers</span></div>
          </nav>

          <div class="help-text">Aide ? <strong>+261 34 00 000 00</strong></div>
        </div>
      </header>

      <div class="main-grid passenger-grid">
        <main class="main-col">
          <form action="#" method="post" class="passenger-section">
            <div class="passenger-head">
              <div>
                <p class="hero-kicker">Étape 4 / 4</p>
                <h1 class="passenger-title">Informations additionnelles</h1>
                <p class="passenger-subtitle">Ces informations figureront sur vos billets et seront vérifiées à l'embarquement.</p>
              </div>
            </div>

            <div class="passenger-cards">
              <article class="passenger-card">
                <div class="passenger-form-grid">
                  <label class="field">
                    <span class="field-label">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle>
                      </svg>
                      Nom complet
                    </span>
                    <input name="nomClient" class="field-input" type="text" placeholder="Ex. Rakoto Andrianina" />
                  </label>

                  <label class="field">
                    <span class="field-label">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M13.832 16.568a1 1 0 0 0 1.213-.303l.355-.465A2 2 0 0 1 17 15h3a2 2 0 0 1 2 2v3a2 2 0 0 1-2 2A18 18 0 0 1 2 4a2 2 0 0 1 2-2h3a2 2 0 0 1 2 2v3a2 2 0 0 1-.8 1.6l-.468.351a1 1 0 0 0-.292 1.233 14 14 0 0 0 6.392 6.384"></path>
                      </svg>
                      Téléphone
                    </span>
                    <input name="telephoneClient" class="field-input" type="tel" placeholder="034 00 000 00" />
                  </label>

                  <label class="field">
                    <span class="field-label">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-banknote-icon lucide-banknote"><rect width="20" height="12" x="2" y="6" rx="2"/><circle cx="12" cy="12" r="2"/><path d="M6 12h.01M18 12h.01"/></svg>
                      Montant
                    </span>
                    <input name="montant" class="field-input" type="number" placeholder="Ex. 10 000 Ar" />
                  </label>

                  <label class="field">
                    <span class="field-label">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-credit-card-icon lucide-credit-card"><rect width="20" height="14" x="2" y="5" rx="2"/><line x1="2" x2="22" y1="10" y2="10"/></svg>
                      Mode de paiement
                    </span>
                    <select name="modePaiement" class="field-input">
                      <c:forEach var="mode" items="${modesPaiements}">
                        <option value="${mode.id}">${mode.libelle}</option>
                      </c:forEach>
                    </select>
                  </label>

                  <label class="field field-span-2">
                    <span class="field-label">
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M16 10h2"></path><path d="M16 14h2"></path><path d="M6.17 15a3 3 0 0 1 5.66 0"></path><circle cx="9" cy="11" r="2"></circle><rect x="2" y="5" width="20" height="14" rx="2"></rect>
                      </svg>
                      Référence de la transaction
                    </span>
                    <input name="reference" class="field-input" type="text" placeholder="S’il y en a" />
                  </label>
                </div>
              </article>
            </div>

            <div class="passenger-actions">
              <a href="${pageContext.request.contextPath}/guichet/reservation/new/choix-place" class="back-btn">← Retour aux places</a>
              <button type="submit" class="next-btn">Confirmer et payer</button>
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
              <div>
                <p class="summary-item-label">Sièges</p>
                <div class="selected-list">
                  <c:forEach var="place" items="${info.places}">
                    <span class="selected-seat">${place.numero}</span>
                  </c:forEach>
                </div>
              </div>
              <div class="summary-divider"></div>
              <div class="summary-total">
                <span>Total</span>
                <strong><fmt:formatNumber value="${info.voyage.tarif * info.places.size()}" pattern="#,##0"/> Ar</strong>
              </div>
            </div>
            <div class="summary-foot">Place garantie · Paiement sécurisé · Annulation possible jusqu'à 24h avant départ.</div>
          </div>
        </aside>
      </div>
    </div>
  </body>
</html>
