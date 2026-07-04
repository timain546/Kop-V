<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cooperative.transport.entities.StatistiqueMensuelle" %>
<%
    StatistiqueMensuelle stats = (StatistiqueMensuelle) request.getAttribute("stats");
    String titre = (String) request.getAttribute("titre");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= titre %></title>
    <link rel="stylesheet" href="../assets/css/stats.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><%= titre %></h1>
            <div class="header-actions">
                <a href="<%= request.getContextPath() %>/dashboard" class="btn-retour">Retour</a>
            </div>
        </div>

        <div class="stats-card">
            <div class="stat-item">
                <span class="stat-label">📅 Mois</span>
                <span class="stat-value"><%= stats.getMois() %>/<%= stats.getAnnee() %></span>
            </div>
            <div class="stat-item">
                <span class="stat-label">💰 Recette totale</span>
                <span class="stat-value recette"><%= stats.getRecetteTotale() %> Ar</span>
            </div>
            <div class="stat-item">
                <span class="stat-label">📊 Moyenne journalière</span>
                <span class="stat-value"><%= stats.getMoyenneJournaliere() %> Ar</span>
            </div>
            <div class="stat-item">
                <span class="stat-label">🚐 Nombre de voyages</span>
                <span class="stat-value"><%= stats.getNbVoyagesTotal() %></span>
            </div>
            <div class="stat-item">
                <span class="stat-label">👤 Nombre de clients</span>
                <span class="stat-value"><%= stats.getNbClientsTotal() %></span>
            </div>
            <div class="stat-item">
                <span class="stat-label">📈 Évolution</span>
                <span class="stat-value <%= stats.getEvolution() != null && stats.getEvolution().doubleValue() >= 0 ? "evolution-positive" : "evolution-negative" %>">
                    <%= stats.getEvolution() != null ? stats.getEvolution() + "%" : "0%" %>
                </span>
            </div>
        </div>
    </div>
</body>
</html>