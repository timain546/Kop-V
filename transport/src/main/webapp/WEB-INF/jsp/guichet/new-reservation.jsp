<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>KOP-V — Réserver un voyage interurbain à Madagascar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guichet/new-reservation.css" />
  </head>
  <body>
    <div class="app-shell">
      <header class="topbar">
        <div class="container topbar-inner">
          <a class="brand-link" href="/" aria-current="page">
            <div class="brand-icon">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-lg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M8 6v6"></path>
                <path d="M15 6v6"></path>
                <path d="M2 12h19.6"></path>
                <path d="M18 18h3s.5-1.7.8-2.8c.1-.4.2-.8.2-1.2 0-.4-.1-.8-.2-1.2l-1.4-5C20.1 6.8 19.1 6 18 6H4a2 2 0 0 0-2 2v10h3"></path>
                <circle cx="7" cy="18" r="2"></circle>
                <path d="M9 18h5"></path>
                <circle cx="16" cy="18" r="2"></circle>
              </svg>
            </div>
            <div class="brand-title"><span class="kop">KOP</span><span class="dash">—</span><span class="v">V</span></div>
          </a>

          <nav class="top-steps" aria-label="Étapes">
            <div class="step active">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"></path>
                <circle cx="12" cy="10" r="3"></circle>
              </svg>
              <span>Recherche</span>
            </div>
            <div class="step-divider"></div>
            <div class="step">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M8 6v6"></path><path d="M15 6v6"></path><path d="M2 12h19.6"></path>
                <path d="M18 18h3s.5-1.7.8-2.8c.1-.4.2-.8.2-1.2 0-.4-.1-.8-.2-1.2l-1.4-5C20.1 6.8 19.1 6 18 6H4a2 2 0 0 0-2 2v10h3"></path>
                <circle cx="7" cy="18" r="2"></circle><path d="M9 18h5"></path><circle cx="16" cy="18" r="2"></circle>
              </svg>
              <span>Voyages</span>
            </div>
            <div class="step-divider"></div>
            <div class="step">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M19 9V6a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v3"></path>
                <path d="M3 16a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-5a2 2 0 0 0-4 0v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V11a2 2 0 0 0-4 0z"></path>
                <path d="M5 18v2"></path><path d="M19 18v2"></path>
              </svg>
              <span>Places</span>
            </div>
            <div class="step-divider"></div>
            <div class="step">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M18 20a6 6 0 0 0-12 0"></path>
                <circle cx="12" cy="10" r="4"></circle>
                <circle cx="12" cy="12" r="10"></circle>
              </svg>
              <span>Passagers</span>
            </div>
          </nav>

          <div class="help-text">Aide ? <strong>+261 34 00 000 00</strong></div>
        </div>
      </header>

      <div class="main-grid">
        <main class="main-col">
          <p class="hero-kicker">Réservation</p>
          <h1 class="hero-title">Où souhaitez-vous voyager aujourd'hui ?</h1>
          <p class="hero-subtitle">
            Choisissez votre itinéraire et trouvez un voyage fiable, à l'heure et confortable sur le réseau KOP-V.
          </p>

          <form action="#" method="post" class="search-card" aria-label="Recherche">
            <div class="form-grid">
              <label class="field">
                <span class="field-label">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"></path>
                    <circle cx="12" cy="10" r="3"></circle>
                  </svg>
                  Ville de départ
                </span>
                <div class="field-control">
                  <select name="gareDepart">
                    <c:forEach var="gare" items="${gares}">
                      <option value="${gare.id}">${gare.ville}</option>
                    </c:forEach>
                  </select>
                </div>
              </label>

              <button class="swap-btn" type="button" aria-label="Inverser">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon-md" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M8 3 4 7l4 4"></path><path d="M4 7h16"></path>
                  <path d="m16 21 4-4-4-4"></path><path d="M20 17H4"></path>
                </svg>
              </button>

              <label class="field">
                <span class="field-label">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"></path>
                    <circle cx="12" cy="10" r="3"></circle>
                  </svg>
                  Ville d'arrivée
                </span>
                <div class="field-control">
                  <select name="gareArrivee">
                    <c:forEach var="gare" items="${gares}">
                      <option value="${gare.id}">${gare.ville}</option>
                    </c:forEach>
                  </select>
                </div>
              </label>

              <label class="field">
                <span class="field-label">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M8 2v4"></path><path d="M16 2v4"></path>
                    <rect width="18" height="18" x="3" y="4" rx="2"></rect><path d="M3 10h18"></path>
                  </svg>
                  Date de départ de
                </span>
                <div class="field-control"><input name="dateMin" type="date" value="2026-07-02" /></div>
              </label>

              <label class="field">
                <span class="field-label">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M8 2v4"></path><path d="M16 2v4"></path>
                    <rect width="18" height="18" x="3" y="4" rx="2"></rect><path d="M3 10h18"></path>
                  </svg>
                  À
                </span>
                <div class="field-control"><input name="dateMax" type="date" value="2026-07-20" /></div>
              </label>

              <label class="field">
                <span class="field-label">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon-sm icon-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path>
                    <path d="M16 3.128a4 4 0 0 1 0 7.744"></path>
                    <path d="M22 21v-2a4 4 0 0 0-3-3.87"></path>
                    <circle cx="9" cy="7" r="4"></circle>
                  </svg>
                  Passagers
                </span>
                <div class="field-control passenger-picker">
                  <button class="circle-btn" type="button">−</button>
                  <input name="nbPlaces" type="number" min="1" value="1" />
                  <%-- <span class="passenger-count">1</span> --%>
                  <button class="circle-btn" type="button">+</button>
                </div>
              </label>
            </div>

            <button type="submit" class="search-btn">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon-md" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="m21 21-4.34-4.34"></path><circle cx="11" cy="11" r="8"></circle>
              </svg>
              Rechercher un voyage
            </button>
          </form>
        </main>
      </div>
    </div>
  </body>
</html>
