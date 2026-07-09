<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Trajets" %>
<%@ page import="com.cooperative.transport.entities.Gares" %>

<%
    List<Trajets> trajets = (List<Trajets>) request.getAttribute("trajets");
    List<Gares> gares = (List<Gares>) request.getAttribute("gares");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kopv - CRUD Trajets Statiques Ultra-Rapides</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
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
                <a href="/re/voyage/list" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-sm transition">
                    <i class="fa-solid fa-route text-base"></i>
                    <span>Gestion Voyages</span>
                </a>
                <a href="/re/panne/list" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-sm transition">
                    <i class="fa-solid fa-triangle-exclamation text-base"></i>
                    <span>Suivi des Pannes</span>
                    <span class="ml-auto bg-rose-100 text-rose-600 text-[10px] font-bold px-2 py-0.5 rounded-full">2</span>
                </a>
                <a href="/re/trajet/list" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-emerald-600 bg-emerald-50/60 font-bold text-sm transition">
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
                <div class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center text-slate-600 font-bold text-xs">RE</div>
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

    <main class="flex-1 p-6 max-w-7xl mx-auto w-full space-y-6">

        <div>
            <h2 class="text-xl font-bold text-slate-800">Configuration des Trajets Prédéfinis (SIG)</h2>
            <p class="text-xs text-slate-400">Sélectionnez vos gares : les tracés des routes nationales (RN2, RN7) s'affichent instantanément sans aucun calcul.</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">

            <div class="bg-white border border-slate-100 rounded-xl shadow-sm p-4 space-y-4 lg:col-span-1">
                <div class="border-b border-slate-100 pb-2">
                    <h3 id="form-title" class="text-sm font-bold text-slate-700 flex items-center gap-2">
                        <i class="fa-solid fa-circle-plus text-emerald-500"></i>
                        <span>Ajouter un nouveau trajet</span>
                    </h3>
                </div>

                <div id="form-feedback" class="hidden text-xs p-3 rounded-xl font-medium border"></div>

                <form class="space-y-3.5 text-xs" id="form-trajet">
                    <div class="space-y-1.5">
                        <label class="font-bold text-slate-500 uppercase tracking-wider">Gare de départ</label>
                        <div class="relative">
                            <select id="select-gare-depart" class="w-full bg-slate-50 border border-slate-200 focus:border-emerald-400 focus:bg-white px-3 py-2.5 rounded-xl outline-none transition font-semibold text-slate-700 appearance-none cursor-pointer" required>
                                <option value="" disabled selected>-- Choisir une gare de départ --</option>
                                <% for(Gares g : gares) { %>
                                    <option value="<%= g.getId() %>"><%= g.getNom() %> (<%= g.getVille() %>)</option>
                                <% } %>
                            </select>
                            <div class="absolute inset-y-0 right-3 flex items-center pointer-events-none text-slate-400">
                                <i class="fa-solid fa-chevron-down"></i>
                            </div>
                        </div>
                    </div>

                    <div class="space-y-1.5">
                        <label class="font-bold text-slate-500 uppercase tracking-wider">Gare de destination</label>
                        <div class="relative">
                            <select id="select-gare-arrivee" class="w-full bg-slate-50 border border-slate-200 focus:border-emerald-400 focus:bg-white px-3 py-2.5 rounded-xl outline-none transition font-semibold text-slate-700 appearance-none cursor-pointer" required>
                                <option value="" disabled selected>-- Choisir une gare d'arrivée --</option>
                                <% for(Gares g : gares) { %>
                                    <option value="<%= g.getId() %>"><%= g.getNom() %> (<%= g.getVille() %>)</option>
                                <% } %>
                            </select>
                            <div class="absolute inset-y-0 right-3 flex items-center pointer-events-none text-slate-400">
                                <i class="fa-solid fa-chevron-down"></i>
                            </div>
                        </div>
                    </div>

                    <div class="space-y-1">
                        <label class="font-bold text-slate-500 uppercase tracking-wider">Distance fixe (km)</label>
                        <input type="number" step="0.01" id="input-distance" min="0" class="w-full bg-slate-100 border border-slate-200 px-3 py-2 rounded-xl outline-none font-medium text-slate-600" readonly placeholder="Distance automatique...">
                    </div>

                    <div class="pt-2 flex gap-2">
                        <button type="submit" class="flex-1 bg-emerald-500 hover:bg-emerald-600 text-white font-bold py-2.5 rounded-xl shadow-md shadow-emerald-50 active:scale-95 transition">
                            Enregistrer la ligne
                        </button>
                        <button type="button" onclick="annulerEdition()" class="bg-slate-100 hover:bg-slate-200 text-slate-500 font-bold px-3 py-2.5 rounded-xl active:scale-95 transition" title="Annuler">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                </form>
            </div>

            <div class="lg:col-span-2 space-y-6">
                
                <div class="bg-white border border-slate-100 rounded-xl shadow-sm overflow-hidden p-1">
                    <div class="px-3 py-2 border-b border-slate-100 flex justify-between items-center bg-slate-50/50">
                        <span class="text-[11px] font-bold uppercase tracking-wider text-slate-500 flex items-center gap-1.5">
                            <i class="fa-solid fa-earth-africa text-emerald-500"></i> Affichage Instantané des Routes RN2 / RN7
                        </span>
                        <span class="text-[10px] text-emerald-600 font-semibold flex items-center gap-1">
                            <span class="w-2 h-2 rounded-full bg-emerald-500 inline-block animate-pulse"></span> Mode local ultra-rapide
                        </span>
                    </div>
                    <div id="map" class="w-full h-80 z-10 rounded-b-lg"></div>
                </div>

                <div class="bg-white border border-slate-100 rounded-xl shadow-sm overflow-hidden flex flex-col">
                    <div class="bg-slate-50/70 border-b border-slate-100 px-4 py-3 flex justify-between items-center">
                        <span class="text-[11px] font-bold uppercase tracking-wider text-slate-400">Liste des trajets actifs</span>
                        <span class="bg-emerald-100 text-emerald-700 text-[10px] font-bold px-2 py-0.5 rounded-full"><%= trajets.size() %> Lignes</span>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-slate-50/30 border-b border-slate-100 text-[10px] font-bold uppercase tracking-wider text-slate-400">
                                    <th class="py-3 px-4">Ligne</th>
                                    <th class="py-3 px-4">Itinéraire</th>
                                    <th class="py-3 px-4">Distance</th>
                                    <th class="py-3 px-4 text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 text-sm">
                                <% for(Trajets t : trajets) { %>
                                    <tr class="hover:bg-slate-50/40 transition" id="row-trajet-<%= t.getId() %>">
                                        <td class="py-3.5 px-4 font-bold text-slate-700">T-00<%= t.getId() %></td>
                                        <td class="py-3.5 px-4">
                                            <div class="font-semibold text-slate-700 flex items-center gap-1.5">
                                                <span><%= t.getGareDepart().getVille() %></span>
                                                <i class="fa-solid fa-arrow-right text-[10px] text-slate-400"></i>
                                                <span><%= t.getGareArrivee().getVille() %></span>
                                            </div>
                                        </td>
                                        <td class="py-3.5 px-4 text-slate-600 font-medium"><%= t.getDistanceKm().intValue() %> km</td>
                                        <td class="py-3.5 px-4 text-right">
                                            <div class="flex items-center justify-end gap-1.5">
                                                <button onclick="chargerDonneesEdition(<%= t.getId() %>, <%= t.getGareDepart().getId() %>, <%= t.getGareArrivee().getId() %>, <%= t.getDistanceKm() %>, '<%= t.getTraceAsWkt() %>')" 
                                                        class="w-8 h-8 rounded-lg border border-slate-200 text-slate-500 bg-white hover:bg-slate-50 flex items-center justify-center text-xs active:scale-95 transition">
                                                    <i class="fa-solid fa-pen"></i>
                                                </button>
                                                <button onclick="supprimerTrajet(<%= t.getId() %>)" class="w-8 h-8 rounded-lg border border-rose-100 text-rose-500 bg-rose-50/30 hover:bg-rose-50 flex items-center justify-center text-xs active:scale-95 transition">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </main>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <script>
        let idTrajetEnCours = null;
        let map;
        let currentPolylineLayer = null;
        let routeCoordinates = [];

        const ROUTES_PREDEFINIES = {
            // Antananarivo (1) -> Toamasina (2) via la RN2
            "1-2": {
                distance: 358.50,
                coords: [
                    [-18.8792, 47.5162], [-18.9105, 47.7852], [-18.9412, 48.0124], 
                    [-18.9348, 48.2215], [-18.9512, 48.4210], [-18.8105, 48.5632], 
                    [-18.5214, 48.8145], [-18.3325, 49.0214], [-18.2104, 49.2015], 
                    [-18.1610, 49.3852], [-18.1500, 49.4000]
                ]
            },
            // Toamasina (2) -> Antananarivo (1) [Retour]
            "2-1": {
                distance: 358.50,
                coords: [
                    [-18.1500, 49.4000], [-18.1610, 49.3852], [-18.2104, 49.2015], 
                    [-18.3325, 49.0214], [-18.5214, 48.8145], [-18.8105, 48.5632], 
                    [-18.9512, 48.4210], [-18.9348, 48.2215], [-18.9412, 48.0124], 
                    [-18.9105, 47.7852], [-18.8792, 47.5162]
                ]
            },
            // Toamasina (2) -> Antsirabe (3) via RN2 + RN7
            "2-3": {
                distance: 527.30,
                coords: [
                    [-18.1500, 49.4000], [-18.1610, 49.3852], [-18.2104, 49.2015], 
                    [-18.3325, 49.0214], [-18.5214, 48.8145], [-18.8105, 48.5632], 
                    [-18.9512, 48.4210], [-18.9348, 48.2215], [-18.9412, 48.0124], 
                    [-18.9105, 47.7852], [-18.8792, 47.5162], [-19.0512, 47.4812], 
                    [-19.2214, 47.4210], [-19.4521, 47.3105], [-19.6201, 47.2104], 
                    [-19.7852, 47.0852], [-19.8667, 47.0333]
                ]
            },
            // Antsirabe (3) -> Toamasina (2) [Retour]
            "3-2": {
                distance: 527.30,
                coords: [
                    [-19.8667, 47.0333], [-19.7852, 47.0852], [-19.6201, 47.2104], 
                    [-19.4521, 47.3105], [-19.2214, 47.4210], [-19.0512, 47.4812], 
                    [-18.8792, 47.5162], [-18.9105, 47.7852], [-18.9412, 48.0124], 
                    [-18.9348, 48.2215], [-18.9512, 48.4210], [-18.8105, 48.5632], 
                    [-18.5214, 48.8145], [-18.3325, 49.0214], [-18.2104, 49.2015], 
                    [-18.1610, 49.3852], [-18.1500, 49.4000]
                ]
            },
            // Antsirabe (3) -> Antananarivo (1) via la RN7
            "3-1": {
                distance: 168.80,
                coords: [
                    [-19.8667, 47.0333], [-19.7852, 47.0852], [-19.6201, 47.2104], 
                    [-19.4521, 47.3105], [-19.2214, 47.4210], [-19.0512, 47.4812], 
                    [-18.8792, 47.5162]
                ]
            },
            // Antananarivo (1) -> Antsirabe (3) [Retour]
            "1-3": {
                distance: 168.80,
                coords: [
                    [-18.8792, 47.5162], [-19.0512, 47.4812], [-19.2214, 47.4210], 
                    [-19.4521, 47.3105], [-19.6201, 47.2104], [-19.7852, 47.0852], 
                    [-19.8667, 47.0333]
                ]
            }
        };

        document.addEventListener("DOMContentLoaded", function() {
            // Init carte centrée sur Mada
            map = L.map('map').setView([-18.91, 47.52], 7);
            
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors'
            }).addTo(map);

            // Écouteurs instantanés sur changement de sélection
            document.getElementById("select-gare-depart").addEventListener("change", tracerRouteAutomatiqueLocale);
            document.getElementById("select-gare-arrivee").addEventListener("change", tracerRouteAutomatiqueLocale);
        });

        // Fonction maîtresse : Trace instantanément la route locale pré-calculée
        function tracerRouteAutomatiqueLocale() {
            nettoyerCalqueStatique();

            const idDepart = document.getElementById("select-gare-depart").value;
            const idArrivee = document.getElementById("select-gare-arrivee").value;

            if (!idDepart || !idArrivee) return;

            if (idDepart === idArrivee) {
                afficherMessage("La gare de départ et d'arrivée ne peuvent pas être identiques.", "error");
                document.getElementById("input-distance").value = "";
                return;
            }

            const cleRoute = idDepart + "-" + idArrivee;
            const routeTrouvee = ROUTES_PREDEFINIES[cleRoute];

            if (routeTrouvee) {
                document.getElementById("input-distance").value = routeTrouvee.distance;
                
                // Stockage des coordonnées inversées au format standard Leaflet ({lat, lng})
                routeCoordinates = routeTrouvee.coords.map(c => ({ lat: c[0], lng: c[1] }));

                // Tracé vert émeraude immédiat à l'écran
                currentPolylineLayer = L.polyline(routeTrouvee.coords, { color: '#10b981', weight: 5, opacity: 0.85 }).addTo(map);
                map.fitBounds(currentPolylineLayer.getBounds());
            } else {
                afficherMessage("Aucun tracé prédéfini trouvé pour cet axe.", "error");
                document.getElementById("input-distance").value = "";
            }
        }

        function nettoyerCalqueStatique() {
            if (currentPolylineLayer) {
                map.removeLayer(currentPolylineLayer);
                currentPolylineLayer = null;
            }
            routeCoordinates = [];
        }

        // Mode Édition : Récupère la polyligne existante (WKT PostGIS) et l'affiche en Orange
        function chargerDonneesEdition(id, idGareDepart, idGareArrivee, distance, traceWkt) {
            masquerMessage();
            nettoyerCalqueStatique();
            idTrajetEnCours = id;

            document.getElementById("form-title").innerHTML = '<i class="fa-solid fa-pen text-amber-500"> </i><span>Modifier le trajet T-00' + id + '</span>';

            document.getElementById("select-gare-depart").value = idGareDepart;
            document.getElementById("select-gare-arrivee").value = idGareArrivee;
            document.getElementById("input-distance").value = distance;
            
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

        function annulerEdition() {
            idTrajetEnCours = null;
            nettoyerCalqueStatique();
            document.getElementById("form-title").innerHTML = `
                <i class="fa-solid fa-circle-plus text-emerald-500"></i> 
                <span>Ajouter un nouveau trajet</span>
            `;
            document.getElementById("form-trajet").reset();
            masquerMessage();
        }

        function afficherMessage(message, type = 'error') {
            const feedbackDiv = document.getElementById("form-feedback");
            if (!feedbackDiv) { alert(message); return; }
            feedbackDiv.innerText = message;
            feedbackDiv.classList.remove("hidden", "bg-rose-50", "border-rose-200", "text-rose-600", "bg-emerald-50", "border-emerald-200", "text-emerald-600");
            if (type === 'error') feedbackDiv.classList.add("bg-rose-50", "border-rose-200", "text-rose-600");
            else if (type === 'success') feedbackDiv.classList.add("bg-emerald-50", "border-emerald-200", "text-emerald-600");
        }

        function masquerMessage() {
            const feedbackDiv = document.getElementById("form-feedback");
            if (feedbackDiv) feedbackDiv.classList.add("hidden");
        }

        // Soumission globale du formulaire avec agrégation WKT
        document.getElementById("form-trajet").addEventListener("submit", function(e) {
            e.preventDefault();
            masquerMessage();

            if (routeCoordinates.length === 0) {
                afficherMessage("Veuillez sélectionner un axe valide pour afficher la route.", "error");
                return;
            }

            // Génération conforme de la géométrie au format attendu par PostGIS: Longitude Latitude
            const pointsWkt = routeCoordinates.map(c => c.lng + " " + c.lat).join(", ");
            const wktLineString = 'LINESTRING(' + pointsWkt + ')';

            const data = {
                gareDepart: parseInt(document.getElementById("select-gare-depart").value),
                gareArrivee: parseInt(document.getElementById("select-gare-arrivee").value),
                distanceKm: parseFloat(document.getElementById("input-distance").value),
                traceWkt: wktLineString
            };

            if (idTrajetEnCours !== null) enregistrerModification(idTrajetEnCours, data);
            else enregistrerCreation(data);
        });

        function enregistrerCreation(nouveauTrajet) {
            fetch("http://localhost:8080/re/api/trajet/create", {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(nouveauTrajet)
            })
            .then(response => response.json().then(data => !response.ok ? Promise.reject(data.message) : data))
            .then(data => {
                afficherMessage(data.message, 'success');
                setTimeout(() => window.location.href = "/re/trajet/list", 1000);
            })
            .catch(err => { afficherMessage(err, 'error'); });
        }

        function enregistrerModification(id, trajetModifie) {
            fetch("http://localhost:8080/re/api/trajet/edit/" + id, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(trajetModifie)
            })
            .then(response => response.json().then(data => !response.ok ? Promise.reject(data.message) : data))
            .then(data => {
                afficherMessage(data.message, 'success');
                setTimeout(() => window.location.href = "/re/trajet/list", 1000);
            })
            .catch(err => { afficherMessage(err, 'error'); });
        }

        function supprimerTrajet(selectedTrajet) {
            if(!confirm("Voulez-vous vraiment supprimer ce trajet ?")) return;
            masquerMessage();
            fetch("http://localhost:8080/re/api/trajet/delete/" + selectedTrajet, { method: 'GET' })
            .then(response => response.json().then(data => !response.ok ? Promise.reject(data.message) : data))
            .then(data => {
                afficherMessage(data.message, 'success');
                const line = document.getElementById("row-trajet-" + selectedTrajet);
                if(line) line.remove();
            })
            .catch(err => { afficherMessage(err, 'error'); });
        }
    </script>
</body>
</html>