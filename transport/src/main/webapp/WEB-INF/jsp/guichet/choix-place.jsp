<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<fmt:setLocale value="fr"/>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOP-V - Choix des places</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/guichet/choix-place.css">
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
          <a class="nav-link"
            href="${pageContext.request.contextPath}/guichet/reservation">
          <i class="fas fa-ticket-alt"></i>
          Réservations
          </a>
          <a class="nav-link active"
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
      <main class="main-content">
        <!-- ================= HEADER ================= -->
        <div class="page-header">
          <div>
            <span class="header-label">
            CHOIX DES PLACES
            </span>
            <h1>
              Choisissez vos places
            </h1>
            <p class="header-subtitle">
              KOP-V ${info.voyage.vehicule.categorie.libelle}
              · Véhicule à ${places.size()} places
              · départ ${info.voyage.heureDepart}
            </p>
          </div>
        </div>
        <!-- ================= ETAPES ================= -->
        <div class="steps-card">
          <div class="step-item">
            <div class="step-icon">
              <i class="fas fa-check"></i>
            </div>
            <span>
            Recherche
            </span>
          </div>
          <div class="step-line active"></div>
          <div class="step-item">
            <div class="step-icon">
              <i class="fas fa-check"></i>
            </div>
            <span>
            Voyages
            </span>
          </div>
          <div class="step-line active"></div>
          <div class="step-item active">
            <div class="step-icon">
              <i class="fas fa-chair"></i>
            </div>
            <span>
            Places
            </span>
          </div>
          <div class="step-line"></div>
          <div class="step-item">
            <div class="step-icon">
              <i class="fas fa-users"></i>
            </div>
            <span>
            Passagers
            </span>
          </div>
        </div>
        <!-- ================= SECTION PLACES ================= -->
        <div class="section-card">
          <div class="section-header">
            <div>
              <h2>
                <i class="fas fa-chair"></i>
                Sélection des places
              </h2>
              <p class="section-subtitle">
                Choisissez ${info.nbPlaces} place${info.nbPlaces > 1 ? 's' : ''}
                pour le voyage.
              </p>
            </div>
          </div>
          <form method="post"
            action="#"
            class="reservation-form">
            <div class="seat-layout">
              <!-- ================= PLAN BUS ================= -->
              <div class="seat-map-card">
                <div class="seat-map-header">
                  <div class="driver-box">
                    <i class="fas fa-car"></i>
                  </div>
                  <span>
                  Avant du véhicule
                  </span>
                </div>
                <div class="seat-grid">
                  <c:forEach begin="1"
                    end="${maxY}"
                    var="row">
                    <div class="seat-row">
                      <c:forEach begin="0"
                        end="2"
                        var="col">
                        <!-- COULOIR CENTRAL -->
                        <c:if test="${col == 2}">
                          <div class="aisle"></div>
                        </c:if>
                        <!-- RECHERCHE PLACE -->
                        <c:set var="place"
                          value="${null}" />
                        <c:forEach var="p"
                          items="${places}">
                          <c:if test="${p.place.x == col &&
                            p.place.y == row}">
                            <c:set var="place"
                              value="${p}" />
                          </c:if>
                        </c:forEach>
                        <!-- AFFICHAGE PLACE -->
                        <c:choose>
                          <c:when test="${place != null}">
                            <label class="seat
                              ${place.occupee ? 'occupied':'available'}">
                            <input type="checkbox"
                            name="idPlaces"
                            value="${place.id}"
                            data-numero="${place.place.numero}"
                            ${place.occupee ? 'disabled':''}>
                            <span>
                            ${place.place.numero}
                            </span>
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
                <!-- ================= LEGENDE ================= -->
                <div class="seat-legend">
                  <div>
                    <span class="legend-dot free"></span>
                    Disponible
                  </div>
                  <div>
                    <span class="legend-dot selected"></span>
                    Sélectionné
                  </div>
                  <div>
                    <span class="legend-dot occupied"></span>
                    Occupé
                  </div>
                </div>
              </div>
              <!-- ================= PANNEAU SELECTION ================= -->
              <div class="seat-selection">
                <div class="selection-card">
                  <span class="card-label">
                  SÉLECTION
                  </span>
                  <h3>
                    <span id="selected-seat-count">
                    0
                    </span>
                    /
                    ${info.nbPlaces}
                    place${info.nbPlaces > 1 ? 's':''}
                  </h3>
                  <div class="selected-list">
                  </div>
                </div>
                <div class="seat-info">
                  <i class="fas fa-chair"></i>
                  <span>
                  ${places.size()} sièges au total
                  </span>
                </div>
              </div>
            </div>
            <!-- ================= ACTIONS ================= -->
            <div class="seat-actions">
              <a href="${pageContext.request.contextPath}/guichet/reservation/new/choix-voyage"
                class="btn back-btn">
              <i class="fas fa-arrow-left"></i>
              Retour
              </a>
              <button type="submit"
                class="btn btn-primary next-btn"
                disabled>
              Continuer
              <i class="fas fa-arrow-right"></i>
              </button>
            </div>
          </form>
        </div>
        <!-- ================= SIDEBAR ================= -->
      </main>
      <aside class="sidebar">
        <div class="profile-card">
          <div class="profile-header-label">
            RÉCAPITULATIF VOYAGE
          </div>
          <h3 class="profile-name">
            Le voyage
          </h3>
          <div class="profile-avatar">
            <i class="fas fa-route"></i>
          </div>
          <div class="profile-info-section">
            <!-- TRAJET -->
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-map-marker-alt"></i>
              </span>
              <div>
                <span class="info-label">
                TRAJET
                </span>
                <span class="info-value">
                ${info.gareDepart.ville}
                →
                ${info.gareArrivee.ville}
                </span>
              </div>
            </div>
            <!-- DATE -->
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-calendar-alt"></i>
              </span>
              <div>
                <span class="info-label">
                DATE
                </span>
                <span class="info-value">
                ${info.voyage.dateHeureDepart.format(
                DateTimeFormatter.ofPattern(
                "EEEE d MMMM",
                Locale.FRENCH
                ))}
                </span>
              </div>
            </div>
            <!-- PASSAGERS -->
            <div class="profile-info-item">
              <span class="info-icon">
              <i class="fas fa-users"></i>
              </span>
              <div>
                <span class="info-label">
                PASSAGERS
                </span>
                <span class="info-value">
                ${info.nbPlaces}
                personne${info.nbPlaces > 1 ? 's':''}
                </span>
              </div>
            </div>
          </div>
          <!-- DETAILS VOYAGE -->
          <div class="profile-details">
            <div>
              <span class="info-label">
              COMPAGNIE
              </span>
              <strong>
              KOP-V
              </strong>
            </div>
            <div>
              <span class="info-label">
              HORAIRE
              </span>
              <strong>
              ${info.voyage.heureDepart}
              →
              ${info.voyage.heureArrivee}
              </strong>
            </div>
            <div>
              <span class="info-label">
              CLASSE
              </span>
              <strong>
              ${info.voyage.vehicule.categorie.libelle}
              </strong>
            </div>
          </div>
          <div class="advantages">
            <div class="advantage">
              <i class="fas fa-check-circle"></i>
              Place garantie
            </div>
            <div class="advantage">
              <i class="fas fa-check-circle"></i>
              Paiement sécurisé
            </div>
            <div class="advantage">
              <i class="fas fa-check-circle"></i>
              Réseau Madagascar
            </div>
          </div>
        </div>
      </aside>
    </div>
    <!-- ================= SCRIPT ================= -->
    <script>
        const maxSeatCount = ${info.nbPlaces};
        const price = ${info.voyage.tarif};

        document.addEventListener(
            "DOMContentLoaded",
            () => {
                const checkboxes = document.querySelectorAll('input[name="idPlaces"]');
                const count = document.getElementById('selected-seat-count');
                const total = document.getElementById('total-price');
                const list = document.querySelector('.selected-list');
                const button = document.querySelector('.next-btn');
                checkboxes.forEach(cb => {
                    cb.addEventListener(
                        "change",
                        () => {
                            let selected = [
                                ...document.querySelectorAll('input[name="idPlaces"]:checked')
                            ];
                            if (selected.length > maxSeatCount) {
                                cb.checked = false;
                                return;
                            }
                            count.textContent =
                                selected.length;
                            list.innerHTML = "";
                            selected.forEach(seat => {
                                const badge = document.createElement("span");
                                badge.className = "selected-seat";
                                badge.textContent = seat.dataset.numero;
                                list.appendChild(badge);
                            });
                            button.disabled = selected.length !== maxSeatCount;
                        });
                });
                checkboxes.forEach(cb => {
                    cb.addEventListener("change", () => {
                        const seat = cb.closest(".seat");
                        if (cb.checked) {
                            seat.classList.add("selected");
                        } else {
                            seat.classList.remove("selected");
                        }
                    });
                });
            });
    </script>
  </body>
</html>
