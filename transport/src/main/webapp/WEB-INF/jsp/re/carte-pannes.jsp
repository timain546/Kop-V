<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Pannes" %>
<%@ page import="com.cooperative.transport.entities.Voyages" %>
<%@ page import="com.cooperative.transport.entities.Vehicules" %>
<%@ page import="com.cooperative.transport.entities.Trajets" %>

<%
    List<Pannes> pannes = (List<Pannes>) request.getAttribute("pannes");
    Integer nbPanneEnAttente = (Integer) request.getAttribute("nbPanneEnAttente");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kopv - Suivi des Pannes & SIG</title>
        <link rel="stylesheet" href="/assets/css/global.css">
    <link rel="stylesheet" href="/assets/css/re-global.css">
    <script>!function(){var t=localStorage.getItem('kop-v-theme')||('matchMedia' in window&&matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light');document.documentElement.setAttribute('data-theme',t)}();</script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
</head>
<body class=" min-h-screen text-primary flex select-none font-sans">

    <aside class="w-64  border-r border-emerald-100 flex flex-col justify-between h-screen sticky top-0 z-40  flex-shrink-0">
        <div>
            <div class="px-4 py-4 border-b border-emerald-50 flex items-center gap-2.5">
                <div class="bg-emerald-500 text-white w-9 h-9  flex items-center justify-center shadow-md shadow-emerald-100">
                    <i class="fa-solid fa-bus text-lg"></i>
                </div>
                <div>
                    <h1 class="text-sm font-black text-primary tracking-tight">KOP-V</h1>
                    <p class="text-[10px] text-primary font-bold uppercase tracking-wider">Management</p>
                </div>
            </div>

            <nav class="p-3 space-y-1">
                <a href="/re/voyage/list" class="flex items-center gap-3 px-3 py-2.5  text-muted hover:text-primary hover: font-semibold text-sm transition">
                    <i class="fa-solid fa-route text-base"></i>
                    <span>Gestion Voyages</span>
                </a>
                <a href="/re/panne/list" class="flex items-center gap-3 px-3 py-2.5  text-primary bg-emerald-50/60 font-bold text-sm transition">
                    <i class="fa-solid fa-triangle-exclamation text-base"></i>
                    <span>Suivi des Pannes</span>
                </a>
                <a href="/re/trajet/list" class="flex items-center gap-3 px-3 py-2.5  text-muted hover:text-primary hover: font-semibold text-sm transition">
                    <i class="fa-solid fa-map-location-dot text-base"></i>
                    <span>CRUD Trajets</span>
                </a>
            </nav>
        </div>

        <div class="p-4 border-t border-slate-100 flex items-center justify-between">
            <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center text-secondary font-bold text-xs">
                    RE
                </div>
                <div class="truncate max-w-[120px]">
                    <p class="text-xs font-bold text-primary truncate">RE</p>
                    <p class="text-[10px] text-light truncate">Exploitant</p>
                </div>
            </div>
            <button class="w-8 h-8  bg-rose-50 text-rose-500 flex items-center justify-center text-sm active:scale-95 transition">
                <i class="fa-solid fa-power-off"></i>
            </button>
        </div>
    </aside>

    <main class="flex-1 p-6 max-w-6xl mx-auto w-full flex flex-col space-y-6">
        
        <div class="flex items-center justify-between flex-shrink-0">
            <div>
                <h2 class="section-header-title">Gestion des Incidents & SIG</h2>
                <p class="section-subtitle">Localisation des détresses géospatiales et affectation des secours</p>
            </div>
            <div class="bg-rose-50 border border-rose-100  px-3 py-1.5 flex items-center gap-2 text-rose-600">
                <i class="fa-solid fa-circle text-[8px] animate-pulse"></i>
                <span class="text-xs font-bold uppercase tracking-wider" id="nbPanneEnAttente"><%= nbPanneEnAttente.intValue() %> Pannes en attente</span>
            </div>
        </div>

        <div class=" border border-slate-100   overflow-hidden h-[380px] relative z-10 flex-shrink-0">
            <div id="map" class="w-full h-full bg-slate-100"></div>
        </div>

        <div class=" border border-slate-100   flex flex-col overflow-hidden">
            <div class="/70 border-b border-slate-100 px-4 py-3 flex justify-between items-center flex-shrink-0">
                <span class="text-[11px] font-bold uppercase tracking-wider text-light">Pannes signalées sur le réseau</span>
                <span class="text-[10px] font-semibold text-light">Cliquez sur une ligne pour centrer la carte</span>
            </div>
            
            <div class="divide-y divide-slate-100">
                <%
                    for(Pannes p : pannes) {
                        String statutReparation = p.getStatutReparationActuel().getLibelle();
                        Voyages voyage = p.getVoyage();
                        Vehicules vehicule = voyage.getVehicule();
                        Trajets trajet = voyage.getTrajet();

                        String lieuWkt = p.getLieuAsWkt();
                %>
                    <div onclick="selectionnerPanne('<%= p.getId() %>', '<%= lieuWkt %>', '<%= trajet.getTraceAsWkt() %>')" class="p-4 flex flex-col sm:flex-row sm:items-center sm:justify-between hover:/80 cursor-pointer transition active:bg-slate-100 gap-4">
                        <div class="flex items-center gap-4 flex-1">
                            <% if(statutReparation.equalsIgnoreCase("en panne")) { %>
                                <div class="w-9 h-9  bg-rose-50 text-rose-500 flex items-center justify-center flex-shrink-0 text-sm" id="panne-<%= p.getId() %>">
                                    <i class="fa-solid fa-triangle-exclamation"></i>
                                </div>
                            <% } else { %>
                                <div class="w-9 h-9  bg-amber-50 text-amber-500 flex items-center justify-center flex-shrink-0 text-sm" id="panne-<%= p.getId() %>">
                                    <i class="fa-solid fa-screwdriver-wrench"></i>
                                </div>
                            <% } %>
                            <div>
                                <div class="flex items-center gap-2 flex-wrap">
                                    <span class="font-bold text-sm text-primary">Voyage V-00<%= p.getVoyage().getId() %></span>
                                    <% if(statutReparation.equalsIgnoreCase("en panne")) { %>
                                        <span class="text-[10px] font-bold text-rose-600 bg-rose-50 border border-rose-100 px-2 py-0.2 rounded-md" id="statut-panne-<%= p.getId() %>">En panne</span>
                                    <% } else { %>
                                        <span class="text-[10px] font-bold text-amber-700 bg-amber-50 border border-amber-100 px-2 py-0.2 rounded-md" id="statut-panne-<%= p.getId() %>">En cours de dépannage</span>
                                    <% } %>
                                </div>
                                
                                <p class="text-xs font-semibold text-muted mt-0.5"><%= trajet.getGareDepart().getVille() %> ➔ <%= trajet.getGareArrivee().getVille() %> (<%= vehicule.getModele() %> <%= vehicule.getImmatriculation() %>)</p>
                                <p class="text-[11px] text-light flex items-center gap-1 mt-0.5">
                                    <i class="fa-solid fa-location-dot text-rose-400"></i> GPS: <%= (lieuWkt != null ? lieuWkt : "Non localisé")  %>
                                </p>
                            </div>
                        </div>
                        <div class="flex items-center justify-between sm:justify-end gap-3 sm:border-t-0 pt-2 sm:pt-0 border-t border-slate-50" id="action-panne-<%= p.getId() %>">
                            <% if(statutReparation.equalsIgnoreCase("en panne")) { %>
                                <button onclick="event.stopPropagation(); prendreEnCharge(<%= p.getId() %>);" class="btn btn-primary">
                                    Prendre en charge
                                </button>
                            <% } else { %>
                                <div class="text-[11px] font-bold text-light bg-slate-100 px-2 py-1 rounded-lg border border-slate-200 whitespace-nowrap">
                                    Attente Chauffeur
                                </div>
                            <% } %>
                        </div>
                    </div>
                <% } %>

            </div>
        </div>
    </div></div>
<script src="/assets/js/animations.js"></script>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    
    <script>
        // Initialisation de la carte centrée sur Madagascar
        const map = L.map('map').setView([-18.8792, 47.5079], 6);

        // Ajout du fond de carte OpenStreetMap (Thème clair et épuré)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Variables pour stocker les calques actifs
        let currentPolylineLayer = null;
        let currentMarkerLayer = null;
        let routeCoordinates = [];

        function nettoyerCalqueStatique() {

            if (currentPolylineLayer) {
                map.removeLayer(currentPolylineLayer);
                currentPolylineLayer = null;
            }
            routeCoordinates = [];
        }

        function nettoyerMarkerStatique() {

            if (currentMarkerLayer) {
                map.removeLayer(currentMarkerLayer);
                currentMarkerLayer = null;
            }
        }

        function nettoyerCarte() {
            if (currentPolylineLayer) {
                map.removeLayer(currentPolylineLayer);
                currentPolylineLayer = null;
            }
            if (currentMarkerLayer) {
                map.removeLayer(currentMarkerLayer);
                currentMarkerLayer = null;
            }
        }

        function selectionnerPanne(idPanne, lieuWkt, traceWkt) {
            nettoyerCarte();

            let coordonneesPanne = null;
            let boundsTrajet = null;

            if (traceWkt && traceWkt !== 'null' && traceWkt.includes("LINESTRING")) {
                try {
                    let cleanWkt = traceWkt.includes(";") ? traceWkt.split(";")[1] : traceWkt;
                    const startIdx = cleanWkt.indexOf("(");
                    const endIdx = cleanWkt.lastIndexOf(")");
                    
                    if (startIdx !== -1 && endIdx !== -1) {
                        const coordString = cleanWkt.substring(startIdx + 1, endIdx);
                        const pairs = coordString.split(",").map(p => p.trim()).filter(p => p.length > 0);
                        
                        const latLngs = pairs.map(p => {
                            const parts = p.split(/\s+/);
                            return L.latLng(parseFloat(parts[1]), parseFloat(parts[0]));
                        }).filter(c => !isNaN(c.lat) && !isNaN(c.lng));

                        if (latLngs.length >= 2) {
                            currentPolylineLayer = L.polyline(latLngs, { color: '#f59e0b', weight: 5, opacity: 0.9 }).addTo(map);
                            boundsTrajet = currentPolylineLayer.getBounds();
                        }
                    }
                } catch (error) {
                    console.error("Erreur parsing tracé :", error);
                }
            }

            if (lieuWkt && lieuWkt !== 'null' && lieuWkt.includes("POINT")) {
                try {
                    let cleanWkt = lieuWkt.includes(";") ? lieuWkt.split(";")[1] : lieuWkt;
                    const first = cleanWkt.indexOf("(");
                    const last = cleanWkt.lastIndexOf(")");

                    if (first !== -1 && last !== -1) {
                        const coordonnees = cleanWkt.substring(first + 1, last).trim();
                        const parts = coordonnees.split(/\s+/);
                        
                        if (parts.length >= 2) {
                            const long = parseFloat(parts[0]);
                            const lat = parseFloat(parts[1]);

                            if (!isNaN(long) && !isNaN(lat)) {
                                coordonneesPanne = [lat, long];
                                currentMarkerLayer = L.marker(coordonneesPanne).addTo(map);
                                currentMarkerLayer.bindPopup('<b>Incident V-00' + idPanne + '</b><br>Panne localisée ici.');
                            }
                        }
                    }
                } catch (error) {
                    console.error("Erreur marqueur de panne :", error);
                }
            }

            if (coordonneesPanne) {
                map.flyTo(coordonneesPanne, 14, {
                    animate: true,
                    duration: 1.2
                });
                setTimeout(() => {
                    if (currentMarkerLayer) currentMarkerLayer.openPopup();
                }, 1200);
            } else if (boundsTrajet) {
                map.fitBounds(boundsTrajet, { animate: true, duration: 1.2 });
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
                badge.className = "w-9 h-9  bg-amber-50 text-amber-500 flex items-center justify-center flex-shrink-0 text-sm";
                badge.innerHTML = '<i class="fa-solid fa-screwdriver-wrench"></i>';

                const statutBadge = document.getElementById("statut-panne-" + idPanne);
                statutBadge.className = "text-[10px] font-bold text-amber-700 bg-amber-50 border border-amber-100 px-2 py-0.2 rounded-md";
                statutBadge.textContent = "En cours de dépannage";

                const actionDiv = document.getElementById("action-panne-" + idPanne);
                actionDiv.innerHTML = '<div class="text-[11px] font-bold text-light bg-slate-100 px-2 py-1 rounded-lg border border-slate-200 whitespace-nowrap">Attente Chauffeur</div>';

                const nbPanneEnAttenteSpan = document.getElementById("nbPanneEnAttente");
                let nbPanneEnAttente = parseInt(nbPanneEnAttenteSpan.textContent);
                if (!isNaN(nbPanneEnAttente) && nbPanneEnAttente > 0) {
                    nbPanneEnAttente--;
                    nbPanneEnAttenteSpan.textContent = nbPanneEnAttente + " Pannes en attente";
                }
            })
            .catch(errorMessage => {
                console.log("Erreur AJAX:" + errorMessage);
                alert(errorMessage);
            });
        }
    </script>
</body>
</html>
