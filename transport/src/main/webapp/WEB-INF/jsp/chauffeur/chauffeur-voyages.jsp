<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.StatutVoyage" %>

<%
    List<StatutVoyage> statuts = (List<StatutVoyage>) request.getAttribute("listeStatuts");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOP-V - Mes Voyages</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/assets/css/chauffeur-dashboard.css">
    <link rel="stylesheet" href="/assets/css/chauffeur-voyages.css">
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar">
        <div class="nav-container">
            <a class="nav-brand" href="/chauffeur/dashboard">
                <i class="fas fa-bus"></i> KOP-V
            </a>
            <div class="nav-links">
                <a class="nav-link" href="/chauffeur/dashboard">
                    <i class="fas fa-tachometer-alt"></i> Tableau de bord
                </a>
                <a class="nav-link active" href="/chauffeur/voyages">
                    <i class="fas fa-route"></i> Mes voyages
                </a>
            </div>
        </div>
    </nav>

    <div class="voyages-page-container">
        <!-- Header -->
        <div class="voyages-header">
            <div>
                <span class="header-label">MES VOYAGES</span>
                <h1>Liste de vos voyages</h1>
                <p class="header-subtitle">Consultez, filtrez et gérez tous vos voyages.</p>
            </div>
        </div>

        <!-- Filters row -->
        <div class="filters-section">
            <div class="filter-tabs-voyages">
                <a href="/chauffeur/voyages" class="filter-tab-v ${empty statut ? 'active' : ''}">
                    <i class="fas fa-list"></i> Tous
                </a>
                <%
                    if(statuts != null) {
                        for(StatutVoyage s : statuts) {
                            String libelleStatut = s.getLibelle();
                            request.setAttribute("currentLibelle", libelleStatut);
                %>
                    <a href="/chauffeur/voyages?statut=<%= libelleStatut %>" class="filter-tab-v ${statut == currentLibelle ? 'active' : ''}">
                        
                        <% if(libelleStatut.equalsIgnoreCase("En cours")) { %>
                            <i class="fas fa-spinner"></i>
                        <% } else if(libelleStatut.equalsIgnoreCase("Plannifié")) { %>
                            <i class="fas fa-clock"></i>
                        <% } else if(libelleStatut.equalsIgnoreCase("Terminé")) { %>
                            <i class="fas fa-check-circle"></i>
                        <% } else if(libelleStatut.equalsIgnoreCase("En panne")) { %>
                            <i class="fas fa-exclamation-circle"></i>
                        <% } else if(libelleStatut.equalsIgnoreCase("Annulé")) { %>
                            <i class="fas fa-times-circle"></i>
                        <% } %> 
                        <%= libelleStatut %>
                    </a>
                <% 
                        }
                    } 
                %>

            </div>
            <form class="search-form" action="/chauffeur/voyages" method="get">
                <c:if test="${not empty statut}">
                    <input type="hidden" name="statut" value="${statut}" />
                </c:if>
                <div class="search-bar-voyages">
                    <i class="fas fa-search"></i>
                    <input type="text" name="search" value="${search}" placeholder="Rechercher ville, ID, plaque..." />
                    <button type="submit" class="search-btn"><i class="fas fa-arrow-right"></i></button>
                </div>
            </form>
        </div>

        <!-- Results count -->
        <div class="results-info">
            <span class="results-count">
                <c:choose>
                    <c:when test="${voyages.size() > 1}">${voyages.size()} voyages trouvés</c:when>
                    <c:when test="${voyages.size() == 1}">1 voyage trouvé</c:when>
                    <c:otherwise>Aucun voyage trouvé</c:otherwise>
                </c:choose>
            </span>
            <c:if test="${not empty search}">
                <span class="search-active">
                    Recherche: "<strong>${search}</strong>"
                    <a href="/chauffeur/voyages${not empty statut ? '?statut='.concat(statut) : ''}" class="clear-search"><i class="fas fa-times"></i></a>
                </span>
            </c:if>
        </div>

        <!-- Voyages Table-style list -->
        <div class="voyages-table-container">
            <c:if test="${not empty voyages}">
                <c:forEach var="voyage" items="${voyages}" varStatus="loop">
                    <div class="voyage-row" style="animation-delay: ${loop.index * 0.04}s;">
                        <!-- Bus icon -->
                        <div class="row-icon">
                            <i class="fas fa-bus"></i>
                        </div>

                        <!-- Route info -->
                        <div class="row-route">
                            <div class="route-cities">
                                <c:choose>
                                    <c:when test="${not empty voyage.gareDepartVille and not empty voyage.gareArriveeVille}">
                                        <strong>${voyage.gareDepartVille}</strong>
                                        <span class="route-arrow">—</span>
                                        <strong>${voyage.gareArriveeVille}</strong>
                                    </c:when>
                                    <c:when test="${not empty voyage.gareDepart and not empty voyage.gareArrivee}">
                                        <strong>${voyage.gareDepart}</strong>
                                        <span class="route-arrow">—</span>
                                        <strong>${voyage.gareArrivee}</strong>
                                    </c:when>
                                    <c:otherwise>
                                        <strong>Voyage #${voyage.id}</strong>
                                    </c:otherwise>
                                </c:choose>
                                <span class="voyage-id-tag">V-00${voyage.id}</span>
                            </div>
                            <div class="route-details">
                                <span>
                                    <i class="fas fa-calendar-alt"></i>
                                    <fmt:formatDate value="${voyage.dateHeureDepartAsDate}" pattern="EEE dd MMM yyyy" />
                                </span>
                                <span>
                                    <i class="fas fa-clock"></i>
                                    <fmt:formatDate value="${voyage.dateHeureDepartAsDate}" pattern="HH:mm" />
                                </span>
                                <span>
                                    <i class="fas fa-car"></i>
                                    ${voyage.vehiculeModele}
                                    <c:if test="${not empty voyage.vehiculeCategorie}">
                                        · ${voyage.vehiculeCategorie}
                                    </c:if>
                                </span>
                                <span>
                                    <i class="fas fa-hashtag"></i>
                                    ${voyage.vehiculeImmatriculation}
                                </span>
                            </div>
                        </div>

                        <!-- Stats -->
                        <div class="row-stats">
                            <c:if test="${not empty voyage.distanceKm}">
                                <span class="row-stat">
                                    <i class="fas fa-road"></i>
                                    <fmt:formatNumber value="${voyage.distanceKm}" type="number" maxFractionDigits="0" /> km
                                </span>
                            </c:if>
                            <span class="row-stat">
                                <i class="fas fa-chair"></i>
                                ${voyage.vehiculeNombrePlaces != null ? voyage.vehiculeNombrePlaces : '-'} pl.
                            </span>
                        </div>

                        <!-- Tarif -->
                        <div class="row-tarif">
                            <fmt:formatNumber value="${voyage.tarif}" type="number" maxFractionDigits="0" /> Ar
                        </div>

                        <div class="row-status-actions">
                            <c:choose>
                                <c:when test="${voyage.statutLibelle == 'En cours'}">
                                    <span class="status-badge status-en-cours"><i class="fas fa-circle"></i> En cours</span>
                                    <div class="row-actions">
                                        <button class="btn btn-success btn-sm" onclick="signalerArrivee(${voyage.id})">
                                            <i class="fas fa-flag-checkered"></i> Arrivée
                                        </button>
                                        <button class="btn btn-danger btn-sm" onclick="signalerPanne(${voyage.id})">
                                            <i class="fas fa-exclamation-triangle"></i> Panne
                                        </button>
                                    </div>
                                </c:when>
                                <c:when test="${voyage.statutLibelle == 'Terminé'}">
                                    <span class="status-badge status-termine"><i class="fas fa-check-circle"></i> Terminé</span>
                                </c:when>
                                <c:when test="${voyage.statutLibelle == 'En panne'}">
                                    <span class="status-badge status-panne"><i class="fas fa-exclamation-circle"></i> En panne</span>
                                    <div class="row-actions">
                                        <button class="btn btn-orange btn-sm" onclick="terminerReparation(${voyage.id})">
                                            <i class="fas fa-tools"></i> Résolu
                                        </button>
                                    </div>
                                </c:when>
                                <c:when test="${voyage.statutLibelle == 'Plannifié'}">
                                    <span class="status-badge status-plannifie"><i class="fas fa-clock"></i> Plannifié</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-annule"><i class="fas fa-times-circle"></i> Annulé</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty voyages}">
                <div class="empty-state-voyages">
                    <i class="fas fa-route"></i>
                    <h3>Aucun voyage trouvé</h3>
                    <p>Aucun voyage ne correspond à vos critères de recherche.</p>
                    <a href="/chauffeur/voyages" class="btn btn-success">
                        <i class="fas fa-list"></i> Voir tous les voyages
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Scripts JavaScript mis à jour -->
    <script>
        function signalerArrivee(voyageId) {
            if (confirm("Confirmer l'arrivée à destination ?")) {
                executerAction(voyageId, 'arrivee', 'Arrivée signalée avec succès !');
            }
        }

        function signalerPanne(voyageId) {
            if (confirm("Signaler que ce véhicule est en panne sur ce trajet ?")) {
                executerAction(voyageId, 'panne', 'Panne signalée avec succès.');
            }
        }

        function terminerReparation(voyageId) {
            if (confirm("Confirmer la fin des réparations et la reprise/clôture ?")) {
                executerAction(voyageId, 'resolu', 'Statut mis à jour avec succès !');
            }
        }

        // Fonction générique pour factoriser les requêtes Fetch
        function executerAction(voyageId, endpoint, messageSucces) {
            fetch('/api/chauffeur/voyages/' + voyageId + '/' + endpoint, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Chauffeur-Id': '${chauffeurId}'
                }
            })
            .then(response => {
                if(response.ok) {
                    showToast(messageSucces, 'success');
                    setTimeout(() => location.reload(), 1200);
                } else {
                    showToast('Erreur lors de l\'action', 'error');
                }
            })
            .catch(error => {
                showToast('Erreur de connexion réseau', 'error');
            });
        }

        function showToast(message, type) {
            const toast = document.createElement('div');
            toast.className = 'toast toast-' + type;
            toast.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + message;
            document.body.appendChild(toast);
            setTimeout(() => toast.classList.add('show'), 10);
            setTimeout(() => {
                toast.classList.remove('show');
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }
    </script>
</body>
</html>