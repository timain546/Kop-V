<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Trajets" %>

<%
    List<Trajets> trajets = (List<Trajets>) request.getAttribute("listeTrajets");
    String messageErreur = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kopv - Feuille de Route Voyage</title>
        <link rel="stylesheet" href="/assets/css/global.css">
    <link rel="stylesheet" href="/assets/css/re-global.css">
    <script>!function(){var t=localStorage.getItem('kop-v-theme')||('matchMedia' in window&&matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light');document.documentElement.setAttribute('data-theme',t)}();</script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                <a href="/re/voyage/list" class="flex items-center gap-3 px-3 py-2.5  text-primary bg-emerald-50/60 font-bold text-sm transition">
                    <i class="fa-solid fa-route text-base"></i>
                    <span>Gestion Voyages</span>
                </a>
                <a href="/re/panne/list" class="flex items-center gap-3 px-3 py-2.5  text-muted hover:text-primary hover: font-semibold text-sm transition">
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

    <main class="flex-1 p-6 max-w-3xl mx-auto w-full space-y-6">
        
        <div class="section-header">
            <div>
                <div class="flex items-center gap-1.5 text-[11px] font-bold text-light uppercase tracking-wider mb-1">
                    <a href="liste-voyages.html" class="hover:text-primary transition">Voyages</a>
                    <i class="fa-solid fa-chevron-right text-[9px]"></i>
                    <span id="breadcrumb-action" class="text-muted">Programmation</span>
                </div>
                <h2 id="page-title" class="section-header-title">Planifier un nouveau Voyage</h2>
                <p id="page-desc" class="section-subtitle">Configurez une nouvelle rotation, affectez un véhicule libre et ouvrez les réservations</p>
            </div>
            
            <div id="mode-badge" class="bg-emerald-50 border border-emerald-100  px-3 py-1.5 flex items-center gap-2 text-primary text-xs font-bold uppercase tracking-wider">
                <i class="fa-solid fa-circle-plus"></i>
                <span>Nouveau Mode</span>
            </div>
        </div>

        <% if (messageErreur != null) { %>
            <div class="bg-rose-50 border border-rose-200  p-4 flex items-start gap-3 text-rose-800  animate-fade-in">
                <div class="bg-rose-500 text-white w-6 h-6 rounded-lg flex items-center justify-center flex-shrink-0 mt-0.5 shadow-md shadow-rose-100">
                    <i class="fa-solid fa-triangle-exclamation text-xs"></i>
                </div>
                <div class="flex-1 space-y-1">
                    <h4 class="font-bold text-xs uppercase tracking-wider text-rose-900">Échec de la planification</h4>
                    <p class="text-xs font-semibold opacity-90"><%= messageErreur %></p>
                </div>
            </div>
        <% } %>

        <div class=" border border-slate-100   overflow-hidden">
            <div class="/70 border-b border-slate-100 px-5 py-3.5">
                <h3 id="form-section-title" class="text-xs font-bold uppercase tracking-wider text-light flex items-center gap-2">
                    <i class="fa-solid fa-calendar-plus text-primary"></i>
                    <span>Informations de la feuille de route</span>
                </h3>
            </div>

            <form class="p-5 space-y-4 text-xs font-medium" action="/re/voyage/create" method="post">

                <div class="space-y-1.5">
                    <label class="font-bold text-muted uppercase tracking-wider">Sélectionner le Trajet Référence</label>
                    <div class="relative">
                        <select id="select-trajet" name="idTrajet" onchange="updateDuree(this)" class="w-full  border border-slate-200 focus:border-emerald-400 focus: px-3 py-2.5  outline-none transition font-semibold text-primary appearance-none cursor-pointer" required>
                            <option value="" disabled selected>-- Choisir une ligne active --</option>
                            <% if (trajets != null) { 
                                for(Trajets t : trajets) { %>
                                    <option value="<%= t.getId() %>">T-00<%= t.getId() %>: <%= t.getGareDepart().getVille() %> ➔ <%= t.getGareArrivee().getVille() %></option>
                                <% } 
                            } %>
                        </select>
                        <div class="absolute inset-y-0 right-3 flex items-center pointer-events-none text-light">
                            <i class="fa-solid fa-chevron-down"></i>
                        </div>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="space-y-1.5">
                        <label class="font-bold text-muted uppercase tracking-wider">Véhicule (Coopérateur)</label>
                        <div class="relative">
                            <select id="select-vehicule" name="idVehicule" disabled class="w-full bg-slate-100 border border-slate-200 focus:border-emerald-400 focus: px-3 py-2.5  outline-none transition font-semibold text-light appearance-none cursor-pointer disabled:opacity-70 disabled:cursor-not-allowed">
                                <option value="" disabled selected>-- Veuillez d'abord choisir une date --</option>
                            </select>
                            <div class="absolute inset-y-0 right-3 flex items-center pointer-events-none text-light">
                                <i class="fa-solid fa-chevron-down"></i>
                            </div>
                        </div>
                    </div>

                    <div class="space-y-1.5">
                        <label class="font-bold text-muted uppercase tracking-wider">Chauffeur Assigné</label>
                        <div class="relative">
                            <select id="select-chauffeur" name="idChauffeur" disabled class="w-full bg-slate-100 border border-slate-200 focus:border-emerald-400 focus: px-3 py-2.5  outline-none transition font-semibold text-light appearance-none cursor-pointer disabled:opacity-70 disabled:cursor-not-allowed">
                                <option value="" disabled selected>-- Veuillez d'abord choisir une date --</option>
                            </select>
                            <div class="absolute inset-y-0 right-3 flex items-center pointer-events-none text-light">
                                <i class="fa-solid fa-chevron-down"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div class="space-y-1.5">
                        <label class="font-bold text-muted uppercase tracking-wider">Date de Départ</label>
                        <input id="input-date" name="dateDepart" type="date" class="w-full  border border-slate-200 focus:border-emerald-400 focus: px-3 py-2  outline-none transition font-semibold text-primary text-center">
                    </div>

                    <div class="space-y-1.5">
                        <label class="font-bold text-muted uppercase tracking-wider">Heure de Départ</label>
                        <input id="input-heure" name="heureDepart" type="time" class="w-full  border border-slate-200 focus:border-emerald-400 focus: px-3 py-2  outline-none transition font-semibold text-primary text-center">
                    </div>

                    <div class="space-y-1.5">
                        <label class="font-bold text-muted uppercase tracking-wider">Durée estimée (minutes)</label>
                        <input id="input-duree" name="dureeEstimeeMinutes" type="number" min="0" class="w-full  border border-slate-200 focus:border-emerald-400 focus: px-3 py-2  outline-none transition font-semibold text-primary text-center">
                    </div>

                    <!-- <div class="space-y-1.5">
                        <label class="font-bold text-light uppercase tracking-wider flex items-center gap-1">
                            Durée de Référence
                        </label>
                        <div class="relative">
                            <input id="duree-input" type="text" value="--" readonly class="w-full bg-slate-100 border border-slate-200 text-light font-bold px-3 py-2  outline-none text-center select-none">
                            <span id="axe-badge" class="absolute right-2 top-2.5 hidden text-[9px] font-black uppercase text-primary bg-emerald-50 border border-emerald-100 px-1.5 py-0.2 rounded"></span>
                        </div>
                    </div> -->
                </div>

                <div class="/50 border border-slate-100 p-4  space-y-3">
                    <div class="flex items-center gap-2 border-b border-slate-100 pb-1.5">
                        <i class="fa-solid fa-hand-holding-dollar text-primary text-sm"></i>
                        <h4 class="font-bold text-primary">Tarif du Ticket</h4>
                    </div>
                    <div class="space-y-1.5 max-w-xs">
                        <label class="font-bold text-muted uppercase tracking-wider">Prix unitaire de la Place</label>
                        <div class="relative">
                            <input id="input-prix" type="number" name="tarif" min="0" placeholder="Ex: 35000" class="w-full  border border-slate-200 focus:border-emerald-400 px-3 py-2  outline-none transition font-bold text-primary pr-12">
                            <span class="absolute right-3 top-2 text-light font-bold text-[11px]">Ar</span>
                        </div>
                    </div>
                </div>

                <div class="/50 border border-slate-100 p-4  space-y-3">
                    <div class="flex items-center gap-2 border-b border-slate-100 pb-1.5">
                        <i class="fa-solid fa-hand-holding-dollar text-primary text-sm"></i>
                        <h4 class="font-bold text-primary">Montant carburant</h4>
                    </div>
                    <div class="space-y-1.5 max-w-xs">
                        <label class="font-bold text-muted uppercase tracking-wider">Prix carburant</label>
                        <div class="relative">
                            <input id="input-prix" type="number" name="carburant" min="0" placeholder="Ex: 35000" class="w-full  border border-slate-200 focus:border-emerald-400 px-3 py-2  outline-none transition font-bold text-primary pr-12">
                            <span class="absolute right-3 top-2 text-light font-bold text-[11px]">Ar</span>
                        </div>
                    </div>
                </div>

                <div class="pt-4 border-t border-slate-100 flex items-center justify-end gap-3">
                    <a href="liste-voyages.html" class="bg-slate-100 hover:bg-slate-200 text-secondary font-bold px-4 py-2.5  active:scale-95 transition">
                        Annuler
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i id="submit-icon" class="fa-solid fa-paper-plane text-[10px]"></i>
                        <span id="submit-text">Ouvrir et Publier le Voyage</span>
                    </button>
                </div>

            </form>
        </div>
    </div></div>
<script src="/assets/js/animations.js"></script>

    <script>
        function updateDuree(selectElement) {
            const selectedOption = selectElement.options[selectElement.selectedIndex];
            const dureeInput = document.getElementById('duree-input');
            const axeBadge = document.getElementById('axe-badge');
            
            if (selectedOption && selectedOption.value) {
                const minutes = selectedOption.value;
                const hours = Math.floor(minutes / 60);
                const remainingMinutes = minutes % 60;
                
                let displayTime = minutes + 'min';
                if (hours > 0) {
                    displayTime += ' ($' + hours + 'h' + (remainingMinutes > 0 ? remainingMinutes : '') + ')';
                }
                dureeInput.value = displayTime;
                
                const axe = selectedOption.getAttribute('data-axe');
                if (axe) {
                    axeBadge.innerText = axe;
                    axeBadge.classList.remove('hidden');
                }
            } else {
                dureeInput.value = "--";
                axeBadge.classList.add('hidden');
            }
        }

        document.addEventListener("DOMContentLoaded", () => {
            const dateInput = document.getElementById("input-date");
            const heureInput = document.getElementById("input-heure");

            const executerMiseAJour = () => {
                const dateSelectionnee = dateInput.value;
                const heureSelectionnee = heureInput.value;

                if (dateSelectionnee) {
                    chargerVehiculesDisponibles(dateSelectionnee, heureSelectionnee);
                    chargerChauffeursDisponibles(dateSelectionnee, heureSelectionnee);
                }
            };

            dateInput.addEventListener("change", executerMiseAJour);
            heureInput.addEventListener("change", executerMiseAJour);
        });

        function chargerVehiculesDisponibles(dateVoyage, heureVoyage) {
            const selectVehicule = document.getElementById("select-vehicule");
            
            selectVehicule.disabled = true;
            selectVehicule.classList.replace("text-primary", "text-light");
            selectVehicule.classList.replace("", "bg-slate-100");
            selectVehicule.innerHTML = `<option value="" disabled selected> Recherche de véhicules libres...</option>`;

            let url = 'http://localhost:8080/re/api/vehicule-dispo/list?date=' + dateVoyage;
            if (heureVoyage) {
                url += '&heure=' + heureVoyage;
            }

            fetch(url, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) throw new Error("Erreur serveur");
                return response.json(); 
            })
            .then(vehicules => {
                selectVehicule.innerHTML = `<option value="" disabled selected>-- Sélectionner un véhicule libre --</option>`;
                
                if (!vehicules || vehicules.length === 0) {
                    selectVehicule.innerHTML = `<option value="" disabled selected> Aucun véhicule disponible pour cette période</option>`;
                    return;
                }

                vehicules.forEach(v => {
                    const option = document.createElement("option");
                    option.value = v.id;
                    option.textContent = v.modele + ' - ' + v.immatriculation + ' (' + v.nombrePlaces + ' places)';
                    selectVehicule.appendChild(option);
                });

                selectVehicule.disabled = false;
                selectVehicule.classList.replace("text-light", "text-primary");
                selectVehicule.classList.replace("bg-slate-100", "");
            })
            .catch(error => {
                console.error("Erreur lors de la récupération :", error);
                selectVehicule.innerHTML = `<option value="" disabled selected>⚠ Erreur lors du chargement des données</option>`;
            });
        }

        function chargerChauffeursDisponibles(dateVoyage, heureVoyage) {
            const selectChauffeur = document.getElementById("select-chauffeur");
            
            selectChauffeur.disabled = true;
            selectChauffeur.classList.replace("text-primary", "text-light");
            selectChauffeur.classList.replace("", "bg-slate-100");
            selectChauffeur.innerHTML = `<option value="" disabled selected> Recherche de chauffeurs libres...</option>`;

            let url = 'http://localhost:8080/re/api/chauffeur-dispo/list?date=' + dateVoyage;
            if (heureVoyage) {
                url += '&heure=' + heureVoyage;
            }

            fetch(url, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) throw new Error("Erreur serveur");
                return response.json(); 
            })
            .then(chauffeurs => {
                selectChauffeur.innerHTML = `<option value="" disabled selected>-- Sélectionner un chauffeur libre --</option>`;
                
                if (!chauffeurs || chauffeurs.length === 0) {
                    selectChauffeur.innerHTML = `<option value="" disabled selected> Aucun chauffeur disponible pour cette période</option>`;
                    return;
                }

                chauffeurs.forEach(c => {
                    const option = document.createElement("option");
                    option.value = c.id;
                    option.textContent = c.nom + ' ' + c.prenom;
                    selectChauffeur.appendChild(option);
                });

                selectChauffeur.disabled = false;
                selectChauffeur.classList.replace("text-light", "text-primary");
                selectChauffeur.classList.replace("bg-slate-100", "");
            })
            .catch(error => {
                console.error("Erreur lors de la récupération :", error);
                selectChauffeur.innerHTML = `<option value="" disabled selected>⚠ Erreur lors du chargement des données</option>`;
            });
        }
    </script>
</body>
</html>