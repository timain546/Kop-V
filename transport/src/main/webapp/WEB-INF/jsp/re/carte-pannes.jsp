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
                <%
                    for(Pannes p : pannes) {
                        String statutReparation = p.getStatutReparationActuel().getLibelle();
                        Voyages voyage = p.getVoyage();
                        Vehicules vehicule = voyage.getVehicule();
                        Trajets trajet = voyage.getTrajet();
                %>
                    <div onclick="focusPanne('<%= trajet.getTraceAsWkt() %>')" class="p-4 flex flex-col sm:flex-row sm:items-center sm:justify-between hover:bg-slate-50/80 cursor-pointer transition active:bg-slate-100 gap-4">
                        <div class="flex items-center gap-4 flex-1">
                            <% if(statutReparation.equalsIgnoreCase("en panne")) { %>
                                <div class="w-9 h-9 rounded-xl bg-rose-50 text-rose-500 flex items-center justify-center flex-shrink-0 text-sm" id="panne-<%= p.getId() %>">
                                    <i class="fa-solid fa-triangle-exclamation"></i>
                                </div>
                            <% } else { %>
                                <div class="w-9 h-9 rounded-xl bg-amber-50 text-amber-500 flex items-center justify-center flex-shrink-0 text-sm" id="panne-<%= p.getId() %>">
                                    <i class="fa-solid fa-screwdriver-wrench"></i>
                                </div>
                            <% } %>
                            <div>
                                <div class="flex items-center gap-2 flex-wrap">
                                    <span class="font-bold text-sm text-slate-700">Voyage V-00<%= p.getVoyage().getId() %></span>
                                    <% if(statutReparation.equalsIgnoreCase("en panne")) { %>
                                        <span class="text-[10px] font-bold text-rose-600 bg-rose-50 border border-rose-100 px-2 py-0.2 rounded-md" id="statut-panne-<%= p.getId() %>">En panne</span>
                                    <% } else { %>
                                        <span class="text-[10px] font-bold text-amber-700 bg-amber-50 border border-amber-100 px-2 py-0.2 rounded-md" id="statut-panne-<%= p.getId() %>">En cours de dépannage</span>
                                    <% } %>
                                </div>
                                
                                <p class="text-xs font-semibold text-slate-500 mt-0.5"><%= trajet.getGareDepart().getVille() %> ➔ <%= trajet.getGareArrivee().getVille() %> (<%= vehicule.getModele() %> <%= vehicule.getImmatriculation() %>)</p>
                                <p class="text-[11px] text-slate-400 flex items-center gap-1 mt-0.5">
                                    <i class="fa-solid fa-location-dot text-rose-400"></i> GPS: -21.4526, 47.0857 (RN7)
                                </p>
                            </div>
                        </div>
                        <div class="flex items-center justify-between sm:justify-end gap-3 sm:border-t-0 pt-2 sm:pt-0 border-t border-slate-50" id="action-panne-<%= p.getId() %>">
                            <% if(statutReparation.equalsIgnoreCase("en panne")) { %>
                                <button onclick="event.stopPropagation(); prendreEnCharge(<%= p.getId() %>);" class="bg-emerald-500 hover:bg-emerald-600 text-white font-bold text-xs px-3 py-2 rounded-xl shadow-sm active:scale-95 transition whitespace-nowrap">
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
        let currentPolylineLayer = null;
        let routeCoordinates = [];

        function nettoyerCalqueStatique() {
            if (currentPolylineLayer) {
                map.removeLayer(currentPolylineLayer);
                currentPolylineLayer = null;
            }
            routeCoordinates = [];
        }

        // Fonction appelée lors du clic sur une ligne de panne
        function focusPanne(traceWkt) {
            nettoyerCalqueStatique();

            if (traceWkt && traceWkt !== 'null' && traceWkt.includes("LINESTRING")) {
                try {
                    let cleanWkt = traceWkt;
                    if (cleanWkt.includes(";")) cleanWkt = cleanWkt.split(";")[1];

                    const startIdx = cleanWkt.indexOf("(");
                    const endIdx = cleanWkt.lastIndexOf(")");
                    
                    if (startIdx !== -1 && endIdx !== -1) {
                        const coordString = cleanWkt.substring(startIdx + 1, endIdx);
                        const pairs = coordString.split(",").map(p => p.trim()).filter(p => p.length > 0);
                        
                        const latLngs = pairs.map(p => {
                            const parts = p.split(/\s+/);
                            return L.latLng(parseFloat(parts[1]), parseFloat(parts[0])); // Conversion Lng/Lat standard PostGIS
                        }).filter(c => !isNaN(c.lat) && !isNaN(c.lng));

                        if (latLngs.length >= 2) {
                            routeCoordinates = latLngs.map(l => ({ lat: l.lat, lng: l.lng }));
                            
                            // Affichage immédiat en Orange du tracé déjà sauvegardé en BDD
                            currentPolylineLayer = L.polyline(latLngs, { color: '#f59e0b', weight: 5, opacity: 0.9 }).addTo(map);
                            map.fitBounds(currentPolylineLayer.getBounds());
                        }
                    }
                } catch (error) {
                    console.error("Erreur parsing tracé fixe :", error);
                }
            }
        }

        function prendreEnCharge(idPanne) {
            const url = "http://localhost:8080/re/api/panne/prendre-en-charge/" + idPanne;

            fetch(url, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json().then(data => !response.ok ? Promise.reject(data.message) : data))
            .then(data => {
                alert(data.message);

                const badge = document.getElementById("panne-" + idPanne);
                badge.className = "w-9 h-9 rounded-xl bg-amber-50 text-amber-500 flex items-center justify-center flex-shrink-0 text-sm";
                badge.innerHTML = '<i class="fa-solid fa-screwdriver-wrench"></i>';

                const statutBadge = document.getElementById("statut-panne-" + idPanne);
                statutBadge.className = "text-[10px] font-bold text-amber-700 bg-amber-50 border border-amber-100 px-2 py-0.2 rounded-md";
                statutBadge.textContent = "En cours de dépannage";

                const actionDiv = document.getElementById("action-panne-" + idPanne);
                actionDiv.innerHTML = '<div class="text-[11px] font-bold text-slate-400 bg-slate-100 px-2 py-1 rounded-lg border border-slate-200 whitespace-nowrap">Attente Chauffeur</div>';
            })
            .catch(errorMessage => {
                console.log("Erreur AJAX:" + errorMessage);
                alert(errorMessage);
            });
        }
    </script>
</body>
</html>
