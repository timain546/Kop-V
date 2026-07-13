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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/stats.css">
    <script>!function(){var t=localStorage.getItem('kop-v-theme')||('matchMedia' in window&&matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light');document.documentElement.setAttribute('data-theme',t)}();</script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a class="nav-brand" href="${pageContext.request.contextPath}/admin/list">
                <i class="fas fa-bus"></i> KOP-V
            </a>
            <div class="nav-links">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/list">
                    <i class="fas fa-users"></i> Employés
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/ajouter">
                    <i class="fas fa-user-plus"></i> Ajouter
                </a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/stats">
                    <i class="fas fa-chart-bar"></i> Statistiques
                </a>
            </div>
            <button class="theme-toggle" onclick="toggleTheme()" title="Changer de thème">
                <i class="fas fa-sun theme-icon-light"></i>
                <i class="fas fa-moon theme-icon-dark"></i>
            </button>
        </div>
    </nav>
    <div class="container">
        <h1><i class="fas fa-chart-bar"></i> Statistiques - <%= annee %></h1>
        
        <div class="filter-form">
            <form action="stats" method="get">
                <label for="annee">Année:</label>
                <input type="number" id="annee" name="annee" min="2000" max="2100" value="<%= annee %>" required>
                <button type="submit">Afficher</button>
            </form>
        </div>
        
        <!-- Résumé -->
        <div class="stats-summary">
            <div class="stat-card recette">
                <div class="label">📈 Recette Annuelle</div>
                <div class="value"><%= totalRecetteAnnuelle %> Ar</div>
            </div>
            <div class="stat-card depense">
                <div class="label">📉 Dépense Annuelle</div>
                <div class="value"><%= totalDepensesAnnuelle %> Ar</div>
            </div>
            <div class="stat-card benefice">
                <div class="label">💰 Bénéfice Annuel</div>
                <div class="value"><%= totalBeneficeAnnuelle %> Ar</div>
            </div>
        </div>
        
        <!-- Graphiques -->
        <div class="charts-row">
            <div class="chart-container double">
                <h3>📊 Bénéfice Mensuel</h3>
                <canvas id="beneficeChart"></canvas>
            </div>
            <div class="chart-container">
                <h3>Representation Circulaire du recette</h3>
                <canvas id="pieChart"></canvas>
            </div>
        </div>
    </div>
    
    <script>
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
        
        // Graphique 1: Bénéfice mensuel
        new Chart(document.getElementById('beneficeChart'), {
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
        
        // Graphique 2: Camembert Dépense + Bénéfice = Recette
        new Chart(document.getElementById('pieChart'), {
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
            }
        });
    </script>
    <script src="${pageContext.request.contextPath}/assets/js/animations.js"></script>
</body>
</html>