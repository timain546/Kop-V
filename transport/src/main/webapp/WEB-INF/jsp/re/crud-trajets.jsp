<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Trajets" %>

<%
    List<Trajets> trajets = (List<Trajets>) request.getAttribute("trajets");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kopv - CRUD Trajets</title>
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
                <a href="/re/voyage/list" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-sm transition">
                    <i class="fa-solid fa-route text-base"></i>
                    <span>Gestion Voyages</span>
                </a>
                <a href="carte-pannes.html" class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-sm transition">
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

    <main class="flex-1 p-6 max-w-6xl mx-auto w-full space-y-6">
        
        <div>
            <h2 class="text-xl font-bold text-slate-800">Configuration des Trajets</h2>
            <p class="text-xs text-slate-400">Définissez les axes routiers, les gares de départ/destination et la durée estimée des trajets</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">
            
            <div class="bg-white border border-slate-100 rounded-xl shadow-sm p-4 space-y-4 lg:col-span-1">
                <div class="border-b border-slate-100 pb-2">
                    <h3 id="form-title" class="text-sm font-bold text-slate-700 flex items-center gap-2">
                        <i class="fa-solid fa-circle-plus text-emerald-500"></i>
                        <span>Ajouter un nouveau trajet</span>
                    </h3>
                </div>

                <% if (messageErreur != null) { %>
                    <div class="bg-rose-50 border border-rose-200 rounded-xl p-4 flex items-start gap-3 text-rose-800 shadow-sm animate-fade-in">
                        <div class="bg-rose-500 text-white w-6 h-6 rounded-lg flex items-center justify-center flex-shrink-0 mt-0.5 shadow-md shadow-rose-100">
                            <i class="fa-solid fa-triangle-exclamation text-xs"></i>
                        </div>
                        <div class="flex-1 space-y-1">
                            <h4 class="font-bold text-xs uppercase tracking-wider text-rose-900">Échec de la modification / insertion</h4>
                            <p class="text-xs font-semibold opacity-90"><%= messageErreur %></p>
                        </div>
                    </div>
                <% } %>

                <form class="space-y-3.5 text-xs">
                    <div class="space-y-1">
                        <label class="font-bold text-slate-500 uppercase tracking-wider">Ville de Départ</label>
                        <input type="text" placeholder="Ex: Antananarivo" class="w-full bg-slate-50 border border-slate-200 focus:border-emerald-400 focus:bg-white px-3 py-2 rounded-xl outline-none transition font-medium">
                    </div>

                    <div class="space-y-1">
                        <label class="font-bold text-slate-500 uppercase tracking-wider">Ville de Destination</label>
                        <input type="text" placeholder="Ex: Toamasina" class="w-full bg-slate-50 border border-slate-200 focus:border-emerald-400 focus:bg-white px-3 py-2 rounded-xl outline-none transition font-medium">
                    </div>

                    <div class="space-y-1">
                        <label class="font-bold text-slate-500 uppercase tracking-wider">Axe Routier (Route Nationale)</label>
                        <input type="text" placeholder="Ex: RN2" class="w-full bg-slate-50 border border-slate-200 focus:border-emerald-400 focus:bg-white px-3 py-2 rounded-xl outline-none transition font-medium">
                    </div>

                    <div class="space-y-1">
                        <label class="font-bold text-slate-500 uppercase tracking-wider">Durée estimée (en minutes)</label>
                        <div class="relative">
                            <input type="number" placeholder="Ex: 420" class="w-full bg-slate-50 border border-slate-200 focus:border-emerald-400 focus:bg-white px-3 py-2 rounded-xl outline-none transition font-medium pr-12">
                            <span class="absolute right-3 top-2.5 text-slate-400 font-semibold text-[11px]">min</span>
                        </div>
                    </div>

                    <div class="pt-2 flex gap-2">
                        <button type="submit" class="flex-1 bg-emerald-500 hover:bg-emerald-600 text-white font-bold py-2.5 rounded-xl shadow-md shadow-emerald-50 active:scale-95 transition">
                            Enregistrer
                        </button>
                        <button type="button" onclick="annulerEdition()" class="bg-slate-100 hover:bg-slate-200 text-slate-500 font-bold px-3 py-2.5 rounded-xl active:scale-95 transition" title="Annuler">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                </form>
            </div>

            <div class="bg-white border border-slate-100 rounded-xl shadow-sm overflow-hidden lg:col-span-2 flex flex-col">
                <div class="bg-slate-50/70 border-b border-slate-100 px-4 py-3 flex justify-between items-center">
                    <span class="text-[11px] font-bold uppercase tracking-wider text-slate-400">Liste des trajets actifs</span>
                    <span class="bg-emerald-100 text-emerald-700 text-[10px] font-bold px-2 py-0.5 rounded-full">4 Lignes</span>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-slate-50/30 border-b border-slate-100 text-[10px] font-bold uppercase tracking-wider text-slate-400">
                                <th class="py-3 px-4">Ligne & Axe</th>
                                <th class="py-3 px-4">Itinéraire</th>
                                <th class="py-3 px-4">Durée Configurée</th>
                                <th class="py-3 px-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 text-sm">
                            
                            <% for(Trajets t : trajets) { %>
                                <tr class="hover:bg-slate-50/40 transition" id="row-trajet-<%= t.getId() %>">
                                    <td class="py-3.5 px-4">
                                        <div class="font-bold text-slate-700">T-00<%= t.getId() %></div>
                                    </td>
                                    <td class="py-3.5 px-4">
                                        <div class="font-semibold text-slate-700 flex items-center gap-1.5">
                                            <span><%= t.getGareDepart().getVille() %></span>
                                            <i class="fa-solid fa-arrow-right text-[10px] text-slate-400"></i>
                                            <span><%= t.getGareArrivee().getVille() %></span>
                                        </div>
                                    </td>
                                    <td class="py-3.5 px-4 text-slate-600 font-medium">
                                        <div><%= t.getDistanceKm().intValue() %> min</div>
                                    </td>
                                    <td class="py-3.5 px-4 text-right">
                                        <div class="flex items-center justify-end gap-1.5">
                                            <button class="w-8 h-8 rounded-lg border border-slate-200 text-slate-500 bg-white hover:bg-slate-50 flex items-center justify-center text-xs active:scale-95 transition" title="Modifier">
                                                <i class="fa-solid fa-pen"></i>
                                            </button>
                                            <button onclick="supprimerTrajet(<%= t.getId() %>)" class="w-8 h-8 rounded-lg border border-rose-100 text-rose-500 bg-rose-50/30 hover:bg-rose-50 flex items-center justify-center text-xs active:scale-95 transition" title="Supprimer">
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
    </main>

    <script>
        function supprimerTrajet(selectedTrajet) {
            let url = "http://localhost:8080/re/api/trajet/delete/" + selectedTrajet;
            fetch(url, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                return response.json().then(data => {
                    if(!response.ok) {
                        return Promise.reject(data.message || "Erreur lors de l'annulation de la feuille de route.");
                    }
                    return data;
                })
            })
            .then(data => {
                alert(data.message);
                const ligneEffacer = document.getElementById("row-trajet-" + selectedTrajet);
                ligneEffacer.remove();
            })
            .catch(errorMessage => {
                console.error("Erreur AJAX:" + errorMessage);
                alert(errorMessage);
            })
        }
    </script>
</body>
</html>
