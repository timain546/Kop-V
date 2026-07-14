<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>

<%
    List<BigDecimal> totalRecetteParMois = (List<BigDecimal>) request.getAttribute("totalRecetteParMois");
    List<BigDecimal> totalDepensesParMois = (List<BigDecimal>) request.getAttribute("totalDepensesParMois");
    List<BigDecimal> totalBeneficeParMois = (List<BigDecimal>) request.getAttribute("totalBeneficeParMois");
    int annee = (int) request.getAttribute("annee");
    
    String[] moisNoms = {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin", 
                         "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};
    
    // Totaux annuels
    BigDecimal totalRecetteAnnuelle = BigDecimal.ZERO;
    BigDecimal totalDepensesAnnuelle = BigDecimal.ZERO;
    BigDecimal totalBeneficeAnnuelle = BigDecimal.ZERO;
    
    for (int i = 0; i < 12; i++) {
        if (totalRecetteParMois != null && i < totalRecetteParMois.size()) {
            totalRecetteAnnuelle = totalRecetteAnnuelle.add(totalRecetteParMois.get(i) != null ? totalRecetteParMois.get(i) : BigDecimal.ZERO);
        }
        if (totalDepensesParMois != null && i < totalDepensesParMois.size()) {
            totalDepensesAnnuelle = totalDepensesAnnuelle.add(totalDepensesParMois.get(i) != null ? totalDepensesParMois.get(i) : BigDecimal.ZERO);
        }
        if (totalBeneficeParMois != null && i < totalBeneficeParMois.size()) {
            totalBeneficeAnnuelle = totalBeneficeAnnuelle.add(totalBeneficeParMois.get(i) != null ? totalBeneficeParMois.get(i) : BigDecimal.ZERO);
        }
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Statistiques</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/stats.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/sidebar.css">
</head>
<body>
    <!-- Sidebar -->
    <button class="sidebar-toggle" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>
    <div class="sidebar-overlay" onclick="toggleSidebar()"></div>
    
    <div class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-icon"><i class="fa-solid fa-van-shuttle me-2 opacity-75"></i></span>
            <h2>KopV</h2>
            <span>statistique</span>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="${pageContext.request.contextPath}/admin/employes/list">
                    <span class="menu-icon"><i class="fas fa-users"></i></span>
                    Employés
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/stats" class="active">
                    <span class="menu-icon"><i class="fas fa-chart-bar"></i></span>
                    Statistiques
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/employes/form">
                    <span class="menu-icon"><i class="fas fa-user-plus"></i></span>
                    Ajouter
                </a>
            </li>
            <li class="menu-divider"></li>
            <li>
                <a href="${pageContext.request.contextPath}/logout">
                    <span class="menu-icon"><i class="fas fa-sign-out-alt"></i></span>
                    Déconnexion
                </a>
            </li>
        </ul>
        <div class="sidebar-footer">
            &copy; 2026 Kopv
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <h1><i class="fas fa-chart-bar" style="color: #3498db;"></i> Statistiques - <%= annee %></h1>
            
            <div class="filter-form">
                <form action="stats" method="get">
                    <label for="annee"><i class="fas fa-calendar-alt"></i> Année:</label>
                    <input type="number" id="annee" name="annee" min="2000" max="2100" value="<%= annee %>" required>
                    <button type="submit">Afficher</button>
                </form>
            </div>
            
            <!-- Résumé -->
            <div class="stats-summary">
                <div class="stat-card recette">
                    <div class="label"><i class="fas fa-arrow-up"></i> Recette Annuelle</div>
                    <div class="value"><%= totalRecetteAnnuelle %> Ar</div>
                </div>
                <div class="stat-card depense">
                    <div class="label"><i class="fas fa-arrow-down"></i> Dépense Annuelle</div>
                    <div class="value"><%= totalDepensesAnnuelle %> Ar</div>
                </div>
                <div class="stat-card benefice">
                    <div class="label"><i class="fas fa-coins"></i> Bénéfice Annuel</div>
                    <div class="value"><%= totalBeneficeAnnuelle %> Ar</div>
                </div>
            </div>
            
            <!-- Graphiques -->
            <div class="charts-row">
                <div class="chart-container double">
                    <h3><i class="fas fa-chart-line" style="color: #2ecc71;"></i> Bénéfice Mensuel</h3>
                    <canvas id="beneficeChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3><i class="fas fa-chart-pie" style="color: #3498db;"></i> Représentation Circulaire de la Recette</h3>
                    <canvas id="pieChart"></canvas>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            const overlay = document.querySelector('.sidebar-overlay');
            sidebar.classList.toggle('open');
            overlay.classList.toggle('active');
        }

        // Attendre que le DOM soit complètement chargé
        document.addEventListener('DOMContentLoaded', function() {
            const moisNoms = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 
                              'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
            
            const totalRecette = [
                <% for (int i = 0; i < 12; i++) { %>
                    <%= (totalRecetteParMois != null && i < totalRecetteParMois.size() && totalRecetteParMois.get(i) != null) ? totalRecetteParMois.get(i) : 0 %><%= (i < 11) ? "," : "" %>
                <% } %>
            ];
            
            const totalDepenses = [
                <% for (int i = 0; i < 12; i++) { %>
                    <%= (totalDepensesParMois != null && i < totalDepensesParMois.size() && totalDepensesParMois.get(i) != null) ? totalDepensesParMois.get(i) : 0 %><%= (i < 11) ? "," : "" %>
                <% } %>
            ];
            
            const totalBenefice = [
                <% for (int i = 0; i < 12; i++) { %>
                    <%= (totalBeneficeParMois != null && i < totalBeneficeParMois.size() && totalBeneficeParMois.get(i) != null) ? totalBeneficeParMois.get(i) : 0 %><%= (i < 11) ? "," : "" %>
                <% } %>
            ];
            
            const totalRecetteAnnuelle = totalRecette.reduce((a, b) => a + b, 0);
            const totalDepensesAnnuelle = totalDepenses.reduce((a, b) => a + b, 0);
            const totalBeneficeAnnuelle = totalBenefice.reduce((a, b) => a + b, 0);
            
            // Vérifier si les données existent
            console.log('Total Recette:', totalRecette);
            console.log('Total Depenses:', totalDepenses);
            console.log('Total Benefice:', totalBenefice);
            
            // Graphique 1: Bénéfice mensuel
            const ctx1 = document.getElementById('beneficeChart');
            if (ctx1) {
                new Chart(ctx1, {
                    type: 'bar',
                    data: {
                        labels: moisNoms,
                        datasets: [{
                            label: 'Bénéfice (Ar)',
                            data: totalBenefice,
                            backgroundColor: totalBenefice.map(v => v >= 0 ? 'rgba(46, 204, 113, 0.8)' : 'rgba(231, 76, 60, 0.8)'),
                            borderColor: totalBenefice.map(v => v >= 0 ? '#27ae60' : '#c0392b'),
                            borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        plugins: {
                            legend: { display: false },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return context.parsed.y + ' Ar';
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return value + ' Ar';
                                    }
                                }
                            }
                        }
                    }
                });
            }
            
            // Graphique 2: Camembert Dépense + Bénéfice = Recette
            const ctx2 = document.getElementById('pieChart');
            if (ctx2) {
                new Chart(ctx2, {
                    type: 'pie',
                    data: {
                        labels: ['Dépense', 'Bénéfice'],
                        datasets: [{
                            data: [totalDepensesAnnuelle, totalBeneficeAnnuelle],
                            backgroundColor: [
                                'rgba(231, 76, 60, 0.8)',
                                'rgba(52, 152, 219, 0.8)'
                            ],
                            borderColor: ['#c0392b', '#2980b9'],
                            borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        plugins: {
                            legend: { position: 'bottom' },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        var total = context.dataset.data.reduce(function(a, b) { return a + b; }, 0);
                                        var percentage = total > 0 ? Math.round((context.parsed / total) * 100) : 0;
                                        return context.label + ': ' + context.parsed + ' Ar (' + percentage + '%)';
                                    }
                                }
                            }
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>