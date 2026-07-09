<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Pannes" %>
<%@ page import="com.cooperative.transport.entities.Voyages" %>
<%@ page import="com.cooperative.transport.entities.Vehicules" %>
<%@ page import="com.cooperative.transport.entities.Trajets" %>

<%
    List<Pannes> pannes = (List<Pannes>) request.getAttribute("pannes");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kopv - Suivi des Pannes & SIG</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
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
                <a href="liste-voyages.html" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-sm transition">
                    <i class="fa-solid fa-route text-base"></i>
                    <span>Gestion Voyages</span>
                </a>
                <a href="carte-pannes.html" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-emerald-600 bg-emerald-50/60 font-bold text-sm transition">
                    <i class="fa-solid fa-triangle-exclamation text-base"></i>
                    <span>Suivi des Pannes</span>
                    <span class="ml-auto bg-rose-100 text-rose-600 text-[10px] font-bold px-2 py-0.5 rounded-full">2</span>
                </a>
                <a href="crud-trajets.html" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-sm transition">
                    <i class="fa-solid fa-map-location-dot text-base"></i>
                    <span>CRUD Trajets</span>
                </a>
                <a href="notifications.html" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-sm transition">
                    <i class="fa-solid fa-bell text-base"></i>
                    <span>Notifications</span>
                    <span class="ml-auto bg-emerald-100 text-emerald-700 text-[10px] font-bold px-2 py-0.5 rounded-full">5</span>
                </a>
            </nav>
        </div>

        <div class="p-4 border-t border-slate-100 flex items-center justify-between">
            <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center text-slate-600 font-bold text-xs">
                    RE
                </div>
                <div class="truncate max-w-[120px]">
                    <p class="text-xs font-bold text-slate-700 truncate">RE</p>
                    <p class="text-[10px] text-slate-400 truncate">Exploitant</p>
                </div>
            </div>
            <button class="w-8 h-8 rounded-xl bg-rose-50 text-rose-500 flex items-center justify-center text-sm active:scale-95 transition">
                <i class="fa-solid fa-power-off"></i>
            </button>
        </div>
    </aside>

    <main class="flex-1 p-6 max-w-6xl mx-auto w-full flex flex-col space-y-6">
        
        <div class="flex items-center justify-between flex-shrink-0">
            <div>
                <h2 class="text-xl font-bold text-slate-800">Gestion des Incidents & SIG</h2>
                <p class="text-xs text-slate-400">Localisation des détresses géospatiales et affectation des secours</p>
            </div>
            <div class="bg-rose-50 border border-rose-100 rounded-xl px-3 py-1.5 flex items-center gap-2 text-rose-600">
                <i class="fa-solid fa-circle text-[8px] animate-pulse"></i>
                <span class="text-xs font-bold uppercase tracking-wider">2 Pannes en attente</span>
            </div>
        </div>

        <div class="bg-white border border-slate-100 rounded-xl shadow-sm overflow-hidden h-[380px] relative z-10 flex-shrink-0">
            <div id="map" class="w-full h-full bg-slate-100"></div>
        </div>

        <div class="bg-white border border-slate-100 rounded-xl shadow-sm flex flex-col overflow-hidden">
            <div class="bg-slate-50/70 border-b border-slate-100 px-4 py-3 flex justify-between items-center flex-shrink-0">
                <span class="text-[11px] font-bold uppercase tracking-wider text-slate-400">Pannes signalées sur le réseau</span>
                <span class="text-[10px] font-semibold text-slate-400">Cliquez sur une ligne pour centrer la carte</span>
            </div>
            
            <div class="divide-y divide-slate-100">
                <% for(Pannes p : pannes) { %>
                    <div onclick="focusPanne(-21.4526, 47.0857, 'RN7 - Proche Fianarantsoa', 'V-00839')" class="p-4 flex flex-col sm:flex-row sm:items-center sm:justify-between hover:bg-slate-50/80 cursor-pointer transition active:bg-slate-100 gap-4">
                        <div class="flex items-center gap-4 flex-1">
                            <div class="w-9 h-9 rounded-xl bg-rose-50 text-rose-500 flex items-center justify-center flex-shrink-0 text-sm">
                                <i class="fa-solid fa-triangle-exclamation"></i>
                            </div>
                            <div>
                                <div class="flex items-center gap-2 flex-wrap">
                                    <span class="font-bold text-sm text-slate-700">Voyage V-00<%= p.getVoyage().getId() %></span>
                                    <%
                                        String statutReparation = p.getStatutReparationActuel().getLibelle();
                                        if(statutReparation.equalsIgnoreCase("en panne")) {
                                    %>
                                        <span class="text-[10px] font-bold text-rose-600 bg-rose-50 border border-rose-100 px-2 py-0.2 rounded-md">En panne</span>
                                    <% } else { %>
                                        <span class="text-[10px] font-bold text-amber-700 bg-amber-50 border border-amber-100 px-2 py-0.2 rounded-md">En cours de dépannage</span>
                                    <% } %>
                                </div>
                                <%
                                    Voyages voyage = p.getVoyage();
                                    Vehicules vehicule = voyage.getVehicule();
                                    Trajets trajet = voyage.getTrajet();
                                %>
                                <p class="text-xs font-semibold text-slate-500 mt-0.5"><%= trajet.getGareDepart().getVille() %> ➔ <%= trajet.getGareArrivee().getVille() %> (<%= vehicule.getModele() %> <%= vehicule.getImmatriculation() %>)</p>
                                <p class="text-[11px] text-slate-400 flex items-center gap-1 mt-0.5">
                                    <i class="fa-solid fa-location-dot text-rose-400"></i> GPS: -21.4526, 47.0857 (RN7)
                                </p>
                            </div>
                        </div>
                        <div class="flex items-center justify-between sm:justify-end gap-3 sm:border-t-0 pt-2 sm:pt-0 border-t border-slate-50">
                            <span class="text-[11px] font-medium text-slate-400">Il y a 12 min</span>
                            <% if(statutReparation.equalsIgnoreCase("en panne")) { %>
                                <button onclick="event.stopPropagation(); prendreEnCharge(this);" class="bg-emerald-500 hover:bg-emerald-600 text-white font-bold text-xs px-3 py-2 rounded-xl shadow-sm active:scale-95 transition whitespace-nowrap">
                                    Prendre en charge
                                </button>
                            <% } else { %>
                                <div class="text-[11px] font-bold text-slate-400 bg-slate-100 px-2 py-1 rounded-lg border border-slate-200 whitespace-nowrap">
                                    Attente Chauffeur
                                </div>
                            <% } %>
                        </div>
                    </div>
                <% } %>

            </div>
        </div>
    </main>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    
    <script>
        // Initialisation de la carte centrée sur Madagascar
        const map = L.map('map').setView([-18.8792, 47.5079], 6);

        // Ajout du fond de carte OpenStreetMap (Thème clair et épuré)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Variable pour stocker le marqueur de panne actif
        let currentMarker = null;
        let currentPolyline = null;

        // Fonction appelée lors du clic sur une ligne de panne
        function focusPanne(lat, lng, lieu, refVoyage) {
            // Repositionner la carte avec une animation fluide
            map.setView([lat, lng], 11);

            // Supprimer l'ancien marqueur s'il existe
            if (currentMarker) map.removeLayer(currentMarker);
            if (currentPolyline) map.removeLayer(currentPolyline);

            // Ajouter le marqueur de la panne (Rouge)
            currentMarker = L.marker([lat, lng]).addTo(map)
                .bindPopup(`<b>Panne sur le ${refVoyage}</b><br>${lieu}`)
                .openPopup();

            // Simulation visuelle du tracé du trajet (Ligne verte claire)
            const pointsTrajet = [
                [lat + 0.5, lng - 0.5],
                [lat, lng], // Le point de panne
                [lat - 0.5, lng + 0.5]
            ];
            currentPolyline = L.polyline(pointsTrajet, {color: '#10b981', weight: 4, opacity: 0.7}).addTo(map);

            // Scroller en douceur vers la carte pour qu'elle soit bien visible si l'utilisateur a défilé vers le bas
            document.getElementById('map').scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        // Fonction pour changer le statut côté RE ("Prendre en charge")
        function prendreEnCharge(button) {
            const container = button.closest('.flex');
            const badge = container.querySelector('.bg-rose-50');
            const iconContainer = container.querySelector('.bg-rose-50');

            // Transformation visuelle dynamique pour simuler l'état "En cours de dépannage"
            badge.className = "text-[10px] font-bold text-amber-700 bg-amber-50 border border-amber-100 px-2 py-0.2 rounded-md";
            badge.innerText = "En cours de dépannage";
            
            iconContainer.className = "w-9 h-9 rounded-xl bg-amber-50 text-amber-500 flex items-center justify-center flex-shrink-0 text-sm";
            iconContainer.innerHTML = '<i class="fa-solid fa-screwdriver-wrench"></i>';

            // Remplacement du bouton par un texte indicatif
            button.outerHTML = '<div class="text-[11px] font-bold text-slate-400 bg-slate-100 px-2 py-1 rounded-lg border border-slate-200 whitespace-nowrap">Attente Chauffeur</div>';
        }
    </script>
</body>
</html>
