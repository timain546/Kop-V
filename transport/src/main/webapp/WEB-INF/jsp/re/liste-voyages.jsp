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
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-slate-50 min-h-screen text-slate-800 flex select-none font-sans">

    <aside class="w-64 bg-white border-r border-emerald-100 flex flex-col justify-between h-screen sticky top-0 z-40 shadow-sm flex-shrink-0">
        <div>
            <div class="px-4 py-4 border-b border-emerald-50 flex items-center gap-2.5">
                <div class="bg-emerald-500 text-white w-9 h-9 rounded-xl flex items-center justify-center shadow-md shadow-emerald-100">
                    <i class="fa-solid fa-bus text-lg"></i>
                </div>
                <div>
                    <h1 class="text-sm font-black text-slate-800 tracking-tight">KOP-V</h1>
                    <p class="text-[10px] text-emerald-600 font-bold uppercase tracking-wider">Management</p>
                </div>
            </div>
            <nav class="p-3 space-y-1">
                <a href="/re/voyagelist" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-emerald-600 bg-emerald-50/60 font-bold text-sm transition">
                    <i class="fa-solid fa-route text-base"></i>
                    <span>Gestion Voyages</span>
                </a>
                <a href="/re/panne/list" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-sm transition">
                    <i class="fa-solid fa-triangle-exclamation text-base"></i>
                    <span>Suivi des Pannes</span>
                </a>
                <a href="/re/trajet/list" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-sm transition">
                    <i class="fa-solid fa-map-location-dot text-base"></i>
                    <span>CRUD Trajets</span>
                </a>
            </nav>
        </div>
    </aside>

    <main class="flex-1 p-6 max-w-5xl mx-auto w-full space-y-6">

        <div class="flex items-center justify-between">
            <div>
                <h2 class="text-xl font-bold text-slate-800">Feuilles de Route</h2>
                <p class="text-xs text-slate-400">Suivez, modifiez ou planifiez les départs de la coopérative</p>
            </div>
            <a href="/re/voyage/new" class="bg-emerald-500 hover:bg-emerald-600 text-white font-bold text-xs px-4 py-2.5 rounded-xl shadow-md shadow-emerald-100 flex items-center gap-2 active:scale-95 transition">
                <i class="fa-solid fa-calendar-plus text-[13px]"></i>
                <span>Planifier un voyage</span>
            </a>
        </div>

        <div class="bg-white border border-slate-100 rounded-xl shadow-sm overflow-hidden flex flex-col">
            <div class="bg-slate-50/70 border-b border-slate-100 px-4 py-3 flex justify-between items-center">
                <span class="text-[11px] font-bold uppercase tracking-wider text-slate-400">Rotations planifiées</span>
                <span class="bg-emerald-100 text-emerald-700 text-[10px] font-bold px-2 py-0.5 rounded-full"><%= nbActif.intValue() %> Voyages actifs</span>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-slate-50/30 border-b border-slate-100 text-[10px] font-bold uppercase tracking-wider text-slate-400">
                            <th class="py-3 px-4">Réf Voyage</th>
                            <th class="py-3 px-4">Axe / Trajet</th>
                            <th class="py-3 px-4">Logistique & Chauffeur</th>
                            <th class="py-3 px-4">Départ Planifié</th>
                            <th class="py-3 px-4 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100 text-sm">
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
                            <tr id="row-voyage-<%= idVoyage %>" class="hover:bg-slate-50/40 transition">
                                <td class="py-4 px-4">
                                    <div class="font-bold text-slate-700"><%= reference %></div>
                                    <div id="badge-container-<%= idVoyage %>">
                                        <% if(statut.equals("En cours")) { %>
                                            <span class="text-[9px] font-black uppercase text-amber-600 bg-amber-50 border border-amber-100 px-1.5 py-0.2 rounded mt-0.5 inline-block"><%= statut %></span>
                                        <% } else if(statut.equals("Terminé")) { %>
                                            <span class="text-[9px] font-black uppercase text-emerald-600 bg-emerald-50 border border-emerald-100 px-1.5 py-0.2 rounded mt-0.5 inline-block"><%= statut %></span>
                                        <% } else if(statut.equals("Annulé") || statut.equals("En panne")) { %>
                                            <span class="text-[9px] font-black uppercase text-red-600 bg-red-50 border border-red-100 px-1.5 py-0.2 rounded mt-0.5 inline-block"><%= statut %></span>
                                        <% } else { %>
                                            <span class="text-[9px] font-black uppercase text-blue-600 bg-blue-50 border border-blue-100 px-1.5 py-0.2 rounded mt-0.5 inline-block"><%= statut %></span>
                                        <% } %>
                                    </div>
                                </td>
                                <td class="py-4 px-4">
                                    <div class="font-bold text-slate-700 flex items-center gap-1.5">
                                        <span><%= villeDepart %></span>
                                        <i class="fa-solid fa-arrow-right text-[10px] text-slate-400"></i>
                                        <span><%= villeArrivee %></span>
                                    </div>
                                    <div class="text-[10px] font-bold text-emerald-600 mt-0.5">Duree — <%= duree %></div>
                                </td>
                                <td class="py-4 px-4 text-xs">
                                    <div class="font-semibold text-slate-700"><i class="fa-solid fa-van-shuttle mr-1 text-slate-400"></i><%= modeleVehicule %> (<%= immatriculation %>)</div>
                                    <div class="text-slate-400 mt-0.5"><i class="fa-solid fa-user-tie mr-1 text-[10px]"></i>Chauffeur: <%= nomChauffeur %></div>
                                </td>
                                <td class="py-4 px-4">
                                    <div class="font-bold text-slate-700"><%= dateDepart %></div>
                                    <div class="text-[11px] text-slate-400 font-medium">À <%= heureDepart %></div>
                                </td>
                                <td class="py-4 px-4 text-right">
                                    <div id="actions-container-<%= idVoyage %>" class="flex items-center justify-end gap-1.5">
                                        <% if (estInaccessible) { %>
                                            <div class="w-8 h-8 rounded-lg border border-slate-100 text-slate-300 bg-slate-50 flex items-center justify-center text-xs cursor-not-allowed" title="Modification impossible">
                                                <i class="fa-solid fa-pen"></i>
                                            </div>
                                            <div class="w-8 h-8 rounded-lg border border-slate-100 text-slate-300 bg-slate-50 flex items-center justify-center text-xs cursor-not-allowed" title="Annulation impossible">
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
    </main>

    <div id="cancel-modal" class="hidden fixed inset-0 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center z-50 p-4 transition duration-200">
        <div class="bg-white border border-slate-100 rounded-xl max-w-sm w-full p-5 text-center shadow-xl space-y-4">
            <div class="w-12 h-12 rounded-full bg-rose-50 text-rose-500 flex items-center justify-center mx-auto text-lg shadow-sm">
                <i class="fa-solid fa-triangle-exclamation"></i>
            </div>
            <div>
                <h4 class="text-sm font-bold text-slate-800">Annuler le voyage ?</h4>
                <p class="text-xs text-slate-400 mt-1">Êtes-vous sûr de vouloir annuler définitivement la feuille de route <span id="target-voyage-ref" class="font-bold text-slate-700"></span> ? Les réservations associées seront impactées.</p>
            </div>
            <div class="flex gap-2 text-xs font-bold pt-1">
                <button onclick="fermerModalAnnulation()" class="flex-1 bg-slate-100 hover:bg-slate-200 text-slate-600 py-2.5 rounded-xl transition active:scale-95">
                    Retour
                </button>
                <button id="confirm-cancel-btn" onclick="confirmerAnnulation()" class="flex-1 bg-rose-500 hover:bg-rose-600 text-white py-2.5 rounded-xl transition shadow-md shadow-rose-50 active:scale-95">
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
                    badgeContainer.innerHTML = `<span class="text-[9px] font-black uppercase text-red-600 bg-red-50 border border-red-100 px-1.5 py-0.2 rounded mt-0.5 inline-block">Annulé</span>`;
                }

                const actionsContainer = document.getElementById('actions-container-' + voyageIdSelectionne);
                if (actionsContainer) {
                    actionsContainer.innerHTML = `
                        <div class="w-8 h-8 rounded-lg border border-slate-100 text-slate-300 bg-slate-50 flex items-center justify-center text-xs cursor-not-allowed" title="Modification impossible">
                            <i class="fa-solid fa-pen"></i>
                        </div>
                        <div class="w-8 h-8 rounded-lg border border-slate-100 text-slate-300 bg-slate-50 flex items-center justify-center text-xs cursor-not-allowed" title="Annulation impossible">
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
