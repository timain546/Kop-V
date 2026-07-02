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
        <title>Voyages disponibles - KOP-V</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/resultats.css">
    </head>
    <body>
        <div class="page">
            <!-- ================= HEADER ================= -->
            <header class="topbar">
                <div class="logo">
                    <div class="logo-icon">
                        <i class="bi bi-bus-front-fill"></i>
                    </div>
                    <span>KOP<span class="green">—V</span></span>
                </div>
                <div class="steps">
                    <div class="step completed">
                        <i class="bi bi-check-lg"></i>
                        Recherche
                    </div>
                    <div class="separator"></div>
                    <div class="step active">
                        <i class="bi bi-bus-front"></i>
                        Voyages
                    </div>
                    <div class="separator"></div>
                    <div class="step">
                        <i class="bi bi-credit-card"></i>
                        Places
                    </div>
                    <div class="separator"></div>
                    <div class="step">
                        <i class="bi bi-person"></i>
                        Passagers
                    </div>
                </div>
                <div class="help">
                    Aide ? +261 34 00 000 00
                </div>
            </header>
            <!-- ================= CONTENU ================= -->
            <main class="content">
                <section class="left-panel">
                    <div class="step-title">
                        <span>ÉTAPE 2 / 4</span>
                        <h1>${info.gareDepart.ville} → ${info.gareArrivee.ville}</h1>
                        <p>${voyages.size()} voyages disponibles · entre
                            ${info.dateMin.format(DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.FRENCH))}
                            et
                            ${info.dateMax.format(DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.FRENCH))}
                        </p>
                    </div>
                    <a href="${pageContext.request.contextPath}/guichet/reservation/new" class="modify-search">
                        ← Modifier la recherche
                    </a>
                    <!-- ================= TRI ================= -->
                    <div class="toolbar">
                        <div class="sorting">
                            <span class="label">
                            <i class="bi bi-filter"></i>
                            Trier
                            </span>
                            <button class="selected">Horaire</button>
                            <button>Prix</button>
                            <button>Durée</button>
                        </div>
                        <div class="classes">
                            <span class="label">
                            <i class="bi bi-funnel"></i>
                            Classe
                            </span>
                            <button class="selected">Toutes</button>
                            <button>Standard</button>
                            <button>Confort</button>
                            <button>VIP</button>
                        </div>
                    </div>
                    <!-- ================= LISTE DES VOYAGES ================= -->
                    <div class="voyages">
                        <c:forEach var="voyage" items="${voyages}">
                            <article class="voyage-card">
                                <div class="company">
                                    <div class="bus-icon">
                                        <i class="bi bi-bus-front-fill"></i>
                                    </div>
                                    <div>
                                        <h3>KOP-V ${fn:toUpperCase(voyage.categorieVehicule)}</h3>
                                        <span>Véhicule à ${voyage.nbPlacesTotales} places</span>
                                    </div>
                                </div>
                                <div class="departure">
                                    <h2>${voyage.heureDepart}</h2>
                                    <span>${voyage.gareDepart}</span>
                                </div>
                                <div class="timeline">
                                    <div class="line"></div>
                                    <div class="duration">
                                        <i class="bi bi-clock"></i>
                                        ${Double.valueOf(voyage.duree / 60).intValue()}h ${voyage.duree % 60}min
                                    </div>
                                    <div class="badge ${voyage.categorieVehicule}">
                                        ${fn:toUpperCase(voyage.categorieVehicule)}
                                    </div>
                                </div>
                                <div class="arrival">
                                    <h2>${voyage.heureArrivee}</h2>
                                    <span>${voyage.gareArrivee}</span>
                                </div>
                                <div class="price">
                                    <h2>
                                        <fmt:formatNumber value="${voyage.tarif}" pattern="#,##0"/>
                                        Ar</h2>
                                    <span class="${info.nbPlaces + 3 >= voyage.nbPlacesDisponibles ? 'warning' : ''}">
                                        ${voyage.nbPlacesDisponibles} places restantes
                                    </span>
                                    <form method="post" action="#">
                                        <input type="hidden" name="voyage" value="${voyage.id}">
                                        <button type="submit">
                                            Choisir
                                            <i class="bi bi-arrow-right"></i>
                                        </button>
                                    </form>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </section>
                <!-- ================= SIDEBAR ================= -->
                <aside class="summary">
                    <div class="summary-header">
                        <span>RÉCAPITULATIF</span>
                        <h2>Votre voyage</h2>
                    </div>
                    <div class="summary-body">
                        <div class="item">
                            <i class="bi bi-geo-alt"></i>
                            <div>
                                <small>TRAJET</small>
                                <strong>Antananarivo → Antsirabe</strong>
                            </div>
                        </div>
                        <div class="item">
                            <i class="bi bi-calendar3"></i>
                            <div>
                                <small>DATE</small>
                                <strong>mar. 30 juin</strong>
                            </div>
                        </div>
                        <div class="item">
                            <i class="bi bi-people"></i>
                            <div>
                                <small>PASSAGERS</small>
                                <strong>1 personne</strong>
                            </div>
                        </div>
                        <hr>
                        <div class="company-selected">
                            <small>COMPAGNIE</small>
                            <h3>KOP-V Express</h3>
                            <span>05:30 — 10:15 · Standard</span>
                        </div>
                        <hr>
                        <div class="total">
                            <span>TOTAL</span>
                            <h2>25 000 Ar</h2>
                        </div>
                        <p class="footer-note">
                            Place garantie · Paiement sécurisé ·
                            Annulation possible jusqu'à 24h avant départ.
                        </p>
                    </div>
                </aside>
            </main>
        </div>
    </body>
</html>
