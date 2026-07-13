<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOP-V - Tableau de bord Chauffeur</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/assets/css/global.css">
    <link rel="stylesheet" href="/assets/css/chauffeur-dashboard.css">
    <script>!function(){var t=localStorage.getItem('kop-v-theme')||('matchMedia' in window&&matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light');document.documentElement.setAttribute('data-theme',t)}();</script>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar">
        <div class="nav-container">
            <a class="nav-brand" href="/chauffeur/dashboard">
                <i class="fas fa-bus"></i> KOP-V
            </a>
            <div class="nav-links">
                <a class="nav-link active" href="/chauffeur/dashboard">
                    <i class="fas fa-tachometer-alt"></i> Tableau de bord
                </a>
                <a class="nav-link" href="/chauffeur/voyages">
                    <i class="fas fa-route"></i> Mes voyages
                </a>
                <a class="nav-link" href="/chauffeur/signaler-panne">
                    <i class="fas fa-exclamation-triangle"></i> Signaler panne
                </a>
            </div>
            <button class="theme-toggle" onclick="toggleTheme()" title="Changer de thème">
                <i class="fas fa-sun theme-icon-light"></i>
                <i class="fas fa-moon theme-icon-dark"></i>
            </button>
        </div>
    </nav>

    <div class="page-container">
        <div class="main-content">
            <!-- Header -->
            <div class="page-header">
                <div class="header-left">
                    <span class="header-label">TABLEAU DE BORD</span>
                    <h1>
                        <c:if test="${not empty chauffeur}">
                            Bonjour, ${chauffeur.nom} ${chauffeur.prenom}
                        </c:if>
                        <c:if test="${empty chauffeur}">
                            Bonjour, Chauffeur
                        </c:if>
                    </h1>
                    <p class="header-subtitle">Voici l'aperçu de vos voyages et performances.</p>
                </div>
                <a href="/chauffeur/voyages" class="btn btn-export">
                    <i class="fas fa-list"></i> Voir tous les voyages
                </a>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-label">VOYAGES TOTAUX</span>
                        <div class="stat-icon icon-blue"><i class="fas fa-road"></i></div>
                    </div>
                    <div class="stat-value">${allVoyages.size()}</div>
                    <div class="stat-sub">${upcomingVoyages.size()} à venir</div>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-label">PASSAGERS TRANSPORTÉS</span>
                        <div class="stat-icon icon-green"><i class="fas fa-users"></i></div>
                    </div>
                    <div class="stat-value">
                        <c:set var="totalPassagers" value="0" />
                        <c:forEach var="v" items="${allVoyages}">
                            <c:if test="${v.statutLibelle == 'terminé'}">
                                <c:set var="totalPassagers" value="${totalPassagers + (v.vehiculeNombrePlaces != null ? v.vehiculeNombrePlaces : 0)}" />
                            </c:if>
                        </c:forEach>
                        ${totalPassagers}
                    </div>
                    <div class="stat-sub">voyages terminés</div>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-label">REVENUS GÉNÉRÉS</span>
                        <div class="stat-icon icon-yellow"><i class="fas fa-coins"></i></div>
                    </div>
                    <div class="stat-value">
                        <c:set var="totalTarif" value="0" />
                        <c:forEach var="v" items="${allVoyages}">
                            <c:if test="${not empty v.tarif}">
                                <c:set var="totalTarif" value="${totalTarif + v.tarif}" />
                            </c:if>
                        </c:forEach>
                        <fmt:formatNumber value="${totalTarif}" type="number" maxFractionDigits="0" /> Ar
                    </div>
                    <div class="stat-sub">Voyages terminés</div>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-label">KM PARCOURUS</span>
                        <div class="stat-icon icon-purple"><i class="fas fa-tachometer-alt"></i></div>
                    </div>
                    <div class="stat-value">
                        <c:set var="totalKm" value="0" />
                        <c:forEach var="v" items="${allVoyages}">
                            <c:if test="${not empty v.distanceKm}">
                                <c:set var="totalKm" value="${totalKm + v.distanceKm}" />
                            </c:if>
                        </c:forEach>
                        <fmt:formatNumber value="${totalKm}" type="number" maxFractionDigits="0" />
                    </div>
                    <div class="stat-sub">km au total</div>
                </div>
            </div>

            <!-- Voyages Section -->
            <div class="section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fas fa-route"></i> Mes voyages</h2>
                        <p class="section-subtitle">Suivez le statut de chacun de vos trajets</p>
                    </div>
                    <div class="filter-tabs">
                        <span class="filter-tab active" data-filter="all">Tous (${allVoyages.size()})</span>
                        <c:set var="countEnCours" value="0" />
                        <c:set var="countAVenir" value="0" />
                        <c:set var="countTermines" value="0" />
                        <c:forEach var="v" items="${allVoyages}">
                            <c:choose>
                                <c:when test="${v.statutLibelle == 'en cours'}"><c:set var="countEnCours" value="${countEnCours + 1}" /></c:when>
                                <c:when test="${v.statutLibelle == 'terminé'}"><c:set var="countTermines" value="${countTermines + 1}" /></c:when>
                            </c:choose>
                        </c:forEach>
                        <c:set var="countAVenir" value="${upcomingVoyages.size()}" />
                        <span class="filter-tab" data-filter="en cours">En cours (${countEnCours})</span>
                        <span class="filter-tab" data-filter="a_venir">À venir (${countAVenir})</span>
                        <span class="filter-tab" data-filter="terminé">Arrivés (${countTermines})</span>
                    </div>
                </div>

                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Rechercher ville, ID, plaque...">
                </div>

                <div class="voyages-list" id="voyagesList">
                    <c:if test="${not empty allVoyages}">
                        <c:forEach var="voyage" items="${allVoyages}" varStatus="loop">
                            <div class="voyage-card" data-statut="${voyage.statutLibelle}" style="animation-delay: ${loop.index * 0.05}s;">
                                <div class="voyage-icon">
                                    <i class="fas fa-bus"></i>
                                </div>
                                <div class="voyage-details">
                                    <div class="voyage-route">
                                        <c:choose>
                                            <c:when test="${not empty voyage.gareDepartVille and not empty voyage.gareArriveeVille}">
                                                <strong>${voyage.gareDepartVille}</strong> — <strong>${voyage.gareArriveeVille}</strong>
                                            </c:when>
                                            <c:when test="${not empty voyage.gareDepart and not empty voyage.gareArrivee}">
                                                <strong>${voyage.gareDepart}</strong> — <strong>${voyage.gareArrivee}</strong>
                                            </c:when>
                                            <c:otherwise>
                                                <strong>Voyage #${voyage.id}</strong>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="voyage-id">T-${voyage.id}</span>
                                    </div>
                                    <div class="voyage-meta">
                                        <fmt:formatDate value="${voyage.dateHeureDepartAsDate}" pattern="EEE dd MMM" />
                                        · <fmt:formatDate value="${voyage.dateHeureDepartAsDate}" pattern="HH:mm" />
                                        – <c:if test="${not empty voyage.dureeEstimeeMinutes}">
                                            <fmt:formatDate value="${voyage.dateHeureDepartAsDate}" pattern="HH:mm" />
                                        </c:if>
                                        · ${voyage.vehiculeModele}
                                        <c:if test="${not empty voyage.vehiculeCategorie}">
                                            ${voyage.vehiculeCategorie}
                                        </c:if>
                                        (${voyage.vehiculeImmatriculation})
                                    </div>
                                </div>
                                <div class="voyage-stats">
                                    <span class="voyage-stat">
                                        <i class="fas fa-chair"></i>
                                        ${voyage.vehiculeNombrePlaces != null ? voyage.vehiculeNombrePlaces : '-'} places
                                    </span>
                                    <span class="voyage-stat voyage-tarif">
                                        <fmt:formatNumber value="${voyage.tarif}" type="number" maxFractionDigits="0" /> Ar
                                    </span>
                                </div>
                                <div class="voyage-actions">
                                    <c:choose>
                                        <c:when test="${voyage.statutLibelle == 'en cours'}">
                                            <span class="status-badge status-en-cours"><i class="fas fa-circle"></i> En cours</span>
                                            <div class="action-buttons">
                                                <button class="btn btn-success btn-sm" onclick="signalerArrivee(${voyage.id})">
                                                    <i class="fas fa-flag-checkered"></i> Arrivée
                                                </button>
                                                <a href="/chauffeur/signaler-panne?voyageId=${voyage.id}" class="btn btn-danger btn-sm">
                                                    <i class="fas fa-exclamation-triangle"></i> Panne
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:when test="${voyage.statutLibelle == 'terminé'}">
                                            <span class="status-badge status-termine"><i class="fas fa-check-circle"></i> Arrivé</span>
                                        </c:when>
                                        <c:when test="${voyage.statutLibelle == 'en panne'}">
                                            <span class="status-badge status-panne"><i class="fas fa-exclamation-circle"></i> En panne</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-a-venir"><i class="fas fa-clock"></i> À venir</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty allVoyages}">
                        <div class="empty-state">
                            <i class="fas fa-route"></i>
                            <p>Aucun voyage trouvé</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Sidebar Profile -->
        <div class="sidebar">
            <div class="profile-card">
                <div class="profile-header-label">PROFIL CHAUFFEUR</div>
                <h3 class="profile-name">
                    <c:if test="${not empty chauffeur}">${chauffeur.nom} ${chauffeur.prenom}</c:if>
                    <c:if test="${empty chauffeur}">Chauffeur</c:if>
                </h3>
                <div class="profile-avatar">
                    <c:if test="${not empty chauffeur}">
                        ${chauffeur.nom.substring(0,1).toUpperCase()}${chauffeur.prenom.substring(0,1).toUpperCase()}
                    </c:if>
                    <c:if test="${empty chauffeur}">CJ</c:if>
                </div>
                <div class="profile-role">Chauffeur senior</div>
                <div class="profile-rating">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                    <span>4.9</span>
                </div>
                <div class="profile-badge"><i class="fas fa-check-circle"></i> Vérifié KOP-V</div>

                <div class="profile-info-section">
                    <div class="profile-info-item">
                        <span class="info-icon"><i class="fas fa-id-card"></i></span>
                        <div>
                            <span class="info-label">MATRICULE</span>
                            <span class="info-value">KV-CH-${chauffeurId}</span>
                        </div>
                    </div>
                    <div class="profile-info-item">
                        <span class="info-icon"><i class="fas fa-envelope"></i></span>
                        <div>
                            <span class="info-label">EMAIL</span>
                            <span class="info-value">
                                <c:if test="${not empty chauffeur}">${chauffeur.email}</c:if>
                                <c:if test="${empty chauffeur}">-</c:if>
                            </span>
                        </div>
                    </div>
                    <div class="profile-info-item">
                        <span class="info-icon"><i class="fas fa-map-marker-alt"></i></span>
                        <div>
                            <span class="info-label">BASE</span>
                            <span class="info-value">Gare KOP-V, Tana</span>
                        </div>
                    </div>
                </div>

                <div class="profile-stats">
                    <div class="profile-stat">
                        <span class="profile-stat-label">KM PARCOURUS</span>
                        <span class="profile-stat-value"><fmt:formatNumber value="${totalKm}" type="number" maxFractionDigits="0" /></span>
                    </div>
                    <div class="profile-stat">
                        <span class="profile-stat-label">SANS INCIDENT</span>
                        <span class="profile-stat-value">
                            <c:set var="joursIncident" value="${allVoyages.size() > 0 ? allVoyages.size() * 30 : 0}" />
                            ${joursIncident} j
                        </span>
                    </div>
                </div>

                <a href="#" class="btn btn-profile">Modifier mon profil</a>
            </div>
        </div>
    </div>

    <script>
        // Search filter
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const cards = document.querySelectorAll('.voyage-card');
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });

        // Tab filter
        document.querySelectorAll('.filter-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                const filter = this.dataset.filter;
                const cards = document.querySelectorAll('.voyage-card');
                cards.forEach(card => {
                    if (filter === 'all') {
                        card.style.display = '';
                    } else if (filter === 'a_venir') {
                        const statut = card.dataset.statut;
                        card.style.display = (!statut || statut === '' || statut === 'null') ? '' : 'none';
                    } else {
                        card.style.display = card.dataset.statut === filter ? '' : 'none';
                    }
                });
            });
        });

        // Signaler arrivée
        function signalerArrivee(voyageId) {
            if (confirm("Confirmer l'arrivée à destination ?")) {
                fetch('/api/chauffeur/voyages/' + voyageId + '/arrivee', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-Chauffeur-Id': '${chauffeurId}'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    alert('Arrivée signalée avec succès !');
                    location.reload();
                })
                .catch(error => {
                    alert('Erreur lors du signalement');
                });
            }
        }
    </script>
    <script src="/assets/js/animations.js"></script>
</body>
</html>
