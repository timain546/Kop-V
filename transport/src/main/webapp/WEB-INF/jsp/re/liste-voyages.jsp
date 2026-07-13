<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="com.cooperative.transport.entities.Voyages" %>
<%@ page import="com.cooperative.transport.entities.Trajets" %>
<%@ page import="com.cooperative.transport.entities.Utilisateurs" %>
<%@ page import="com.cooperative.transport.entities.Vehicules" %>

<%
    Integer nbActif = (Integer) request.getAttribute("nbActif");
    List<Voyages> voyages = (List<Voyages>) request.getAttribute("listeVoyages");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kopv - Liste des Voyages</title>
        <link rel="stylesheet" href="/assets/css/global.css">
    <link rel="stylesheet" href="/assets/css/re-global.css">
    <script>!function(){var t=localStorage.getItem('kop-v-theme')||('matchMedia' in window&&matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light');document.documentElement.setAttribute('data-theme',t)}();</script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a class="nav-brand" href="/re/voyage/list">
                <i class="fas fa-bus"></i> KOP-V
            </a>
            <div class="nav-links">
                <a class="nav-link active" href="/re/voyage/list">
                    <i class="fas fa-route"></i> Voyages
                </a>
                <a class="nav-link " href="/re/panne/list">
                    <i class="fas fa-triangle-exclamation"></i> Pannes
                </a>
                <a class="nav-link " href="/re/trajet/list">
                    <i class="fas fa-map-location-dot"></i> Trajets
                </a>
            </div>
            <div class="nav-links">
                <span class="status-badge status-paye" style="margin-right:12px;">
                    <i class="fas fa-user-tie"></i> RE Exploitant
                </span>
                <button class="theme-toggle" onclick="toggleTheme()" title="Changer de thème">
                    <i class="fas fa-sun theme-icon-light"></i>
                    <i class="fas fa-moon theme-icon-dark"></i>
                </button>
            </div>
        </div>
    </nav>
    <div class="page-container re-container">
        <div class="main-content">

        <div class="section-header">
            <div>
                <h2 class="section-header-title">Feuilles de Route</h2>
                <p class="section-subtitle">Suivez, modifiez ou planifiez les départs de la coopérative</p>
            </div>
            <a href="/re/voyage/new" class="btn btn-primary">
                <i class="fa-solid fa-calendar-plus text-[13px]"></i>
                <span>Planifier un voyage</span>
            </a>
        </div>

        <div class="section-card">
            <div class="/70 border-b border-slate-100 px-4 py-3 flex justify-between items-center">
                <span class="text-[11px] font-bold uppercase tracking-wider text-light">Rotations planifiées</span>
                <span class="bg-emerald-100 text-primary-dark text-[10px] font-bold px-2 py-0.5 rounded-full"><%= nbActif.intValue() %> Voyages actifs</span>
            </div>

            <div class="overflow-x-auto">
                <table >
                    <thead>
                        <tr >
                            <th class="py-3 px-4">Réf Voyage</th>
                            <th class="py-3 px-4">Axe / Trajet</th>
                            <th class="py-3 px-4">Logistique & Chauffeur</th>
                            <th class="py-3 px-4">Départ Planifié</th>
                            <th class="py-3 px-4 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody >
                        <%
                            for(Voyages v : voyages) {
                                int idVoyage = v.getId();
                                String reference = "V-00" + idVoyage;
                                String statut = v.getStatutActuel().getLibelle();
                                Trajets trajet = v.getTrajet();
                                String villeDepart = trajet.getGareDepart().getVille();
                                String villeArrivee = trajet.getGareArrivee().getVille();
                                String duree = v.getDureeEstimeeMinutes() + " min";

                                Vehicules vehicule = v.getVehicule();
                                String modeleVehicule = vehicule.getModele();
                                String immatriculation = vehicule.getImmatriculation();

                                Utilisateurs chauffeur = v.getChauffeur();
                                String nomChauffeur = chauffeur.getNom() + " " + chauffeur.getPrenom();

                                LocalDateTime dateHeureDepart = v.getDateHeureDepart();
                                String dateDepart = dateHeureDepart.toLocalDate().toString();
                                String heureDepart = dateHeureDepart.toLocalTime().toString();

                                boolean estInaccessible = statut.equals("En cours") || statut.equals("Terminé") || statut.equals("Annulé");
                        %>
                            <tr id="row-voyage-<%= idVoyage %>" class="hover:/40 transition">
                                <td class="py-4 px-4">
                                    <div class="font-bold text-primary"><%= reference %></div>
                                    <div id="badge-container-<%= idVoyage %>">
                                        <% if(statut.equals("En cours")) { %>
                                            <span class="status-badge status-en-cours"><%= statut %></span>
                                        <% } else if(statut.equals("Terminé")) { %>
                                            <span class="text-[9px] font-black uppercase text-primary bg-emerald-50 border border-emerald-100 px-1.5 py-0.2 rounded mt-0.5 inline-block"><%= statut %></span>
                                        <% } else if(statut.equals("Annulé") || statut.equals("En panne")) { %>
                                            <span class="status-badge status-panne"><%= statut %></span>
                                        <% } else { %>
                                            <span class="status-badge status-a-venir"><%= statut %></span>
                                        <% } %>
                                    </div>
                                </td>
                                <td class="py-4 px-4">
                                    <div class="font-bold text-primary flex items-center gap-1.5">
                                        <span><%= villeDepart %></span>
                                        <i class="fa-solid fa-arrow-right text-[10px] text-light"></i>
                                        <span><%= villeArrivee %></span>
                                    </div>
                                    <div class="text-[10px] font-bold text-primary mt-0.5">Duree — <%= duree %></div>
                                </td>
                                <td class="py-4 px-4 text-xs">
                                    <div class="font-semibold text-primary"><i class="fa-solid fa-van-shuttle mr-1 text-light"></i><%= modeleVehicule %> (<%= immatriculation %>)</div>
                                    <div class="text-light mt-0.5"><i class="fa-solid fa-user-tie mr-1 text-[10px]"></i>Chauffeur: <%= nomChauffeur %></div>
                                </td>
                                <td class="py-4 px-4">
                                    <div class="font-bold text-primary"><%= dateDepart %></div>
                                    <div class="text-[11px] text-light font-medium">À <%= heureDepart %></div>
                                </td>
                                <td class="py-4 px-4 text-right">
                                    <div id="actions-container-<%= idVoyage %>" class="flex items-center justify-end gap-1.5">
                                        <% if (estInaccessible) { %>
                                            <div class="w-8 h-8 rounded-lg border border-slate-100 text-slate-300  flex items-center justify-center text-xs cursor-not-allowed" title="Modification impossible">
                                                <i class="fa-solid fa-pen"></i>
                                            </div>
                                            <div class="w-8 h-8 rounded-lg border border-slate-100 text-slate-300  flex items-center justify-center text-xs cursor-not-allowed" title="Annulation impossible">
                                                <i class="fa-solid fa-ban"></i>
                                            </div>
                                        <% } else { %>
                                            <button onclick="ouvrirModalAnnulation(<%= idVoyage %>, '<%= reference %>')" class="btn-cancel-<%= idVoyage %> w-8 h-8 rounded-lg border border-rose-100 text-rose-500 bg-rose-50/30 hover:bg-rose-50 flex items-center justify-center text-xs active:scale-95 transition" title="Annuler le voyage">
                                                <i class="fa-solid fa-ban"></i>
                                            </button>
                                        <% } %>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div></div>
<script src="/assets/js/animations.js"></script>

    <div id="cancel-modal" class="hidden fixed inset-0 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center z-50 p-4 transition duration-200">
        <div class=" border border-slate-100  max-w-sm w-full p-5 text-center shadow-xl space-y-4">
            <div class="w-12 h-12 rounded-full bg-rose-50 text-rose-500 flex items-center justify-center mx-auto text-lg ">
                <i class="fa-solid fa-triangle-exclamation"></i>
            </div>
            <div>
                <h4 class="text-sm font-bold text-primary">Annuler le voyage ?</h4>
                <p class="text-xs text-light mt-1">Êtes-vous sûr de vouloir annuler définitivement la feuille de route <span id="target-voyage-ref" class="font-bold text-primary"></span> ? Les réservations associées seront impactées.</p>
            </div>
            <div class="flex gap-2 text-xs font-bold pt-1">
                <button onclick="fermerModalAnnulation()" class="flex-1 bg-slate-100 hover:bg-slate-200 text-secondary py-2.5  transition active:scale-95">
                    Retour
                </button>
                <button id="confirm-cancel-btn" onclick="confirmerAnnulation()" class="flex-1 bg-rose-500 hover:bg-rose-600 text-white py-2.5  transition shadow-md shadow-rose-50 active:scale-95">
                    Oui, annuler le voyage
                </button>
            </div>
        </div>
    </div>

    <script>
        let voyageIdSelectionne = null;

        function ouvrirModalAnnulation(id, reference) {
            voyageIdSelectionne = id;
            document.getElementById('target-voyage-ref').innerText = reference;
            document.getElementById('cancel-modal').classList.remove('hidden');
        }

        function fermerModalAnnulation() {
            document.getElementById('cancel-modal').classList.add('hidden');
            voyageIdSelectionne = null;
        }

        function confirmerAnnulation() {
            if (!voyageIdSelectionne) return;

            const btnConfirm = document.getElementById('confirm-cancel-btn');
            btnConfirm.disabled = true;
            btnConfirm.innerText = "Traitement...";

            fetch('http://localhost:8080/re/api/voyage/annuler/' + voyageIdSelectionne, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                return response.json().then(data => {
                    if (!response.ok) {
                        return Promise.reject(data.message || "Erreur lors de l'annulation de la feuille de route.");
                    }
                    return data;
                });
            })
            .then(data => {
                alert(data.message);

                const badgeContainer = document.getElementById('badge-container-' + voyageIdSelectionne);
                if (badgeContainer) {
                    badgeContainer.innerHTML = `<span class="status-badge status-panne">Annulé</span>`;
                }

                const actionsContainer = document.getElementById('actions-container-' + voyageIdSelectionne);
                if (actionsContainer) {
                    actionsContainer.innerHTML = `
                        <div class="w-8 h-8 rounded-lg border border-slate-100 text-slate-300  flex items-center justify-center text-xs cursor-not-allowed" title="Modification impossible">
                            <i class="fa-solid fa-pen"></i>
                        </div>
                        <div class="w-8 h-8 rounded-lg border border-slate-100 text-slate-300  flex items-center justify-center text-xs cursor-not-allowed" title="Annulation impossible">
                            <i class="fa-solid fa-ban"></i>
                        </div>
                    `;
                }
            })
            .catch(errorMessage => {
                console.error("Erreur AJAX :", errorMessage);
                alert(errorMessage);
            })
            .finally(() => {
                btnConfirm.disabled = false;
                btnConfirm.innerText = "Oui, annuler le voyage";
                fermerModalAnnulation();
            });
        }
    </script>
</body>
</html>
