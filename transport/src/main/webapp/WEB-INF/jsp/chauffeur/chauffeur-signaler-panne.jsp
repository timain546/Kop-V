<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOP-V - Signaler une panne</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="/assets/css/chauffeur-dashboard.css">
    <link rel="stylesheet" href="/assets/css/chauffeur-panne.css">
</head>
<body>

    <nav class="navbar">
        <div class="nav-container">
            <a class="nav-brand" href="/chauffeur/dashboard">
                <i class="fas fa-bus"></i> KOP-V
            </a>
            <div class="nav-links">
                <a class="nav-link" href="/chauffeur/dashboard">
                    <i class="fas fa-tachometer-alt"></i> Tableau de bord
                </a>
                <a class="nav-link" href="/chauffeur/voyages">
                    <i class="fas fa-route"></i> Mes voyages
                </a>
                <a class="nav-link active" href="/chauffeur/signaler-panne">
                    <i class="fas fa-exclamation-triangle"></i> Signaler panne
                </a>
                <a class="nav-link" href="/logout">
                    <i class="fas fa-sign-out-alt"></i> Déconnexion
                </a>
            </div>
        </div>
    </nav>

    <div class="panne-page-container">
        <div class="panne-content">
            <div class="panne-form-section">

                <form id="panneForm" class="panne-form">
                    <input type="hidden" id="voyageId" name="voyageId" required value="${not empty voyages ? voyages[0].id : ''}" />
                    
                    <input type="hidden" id="gps" name="gps" />

                    <div class="form-group">
                        <div class="bg-white border border-slate-200 rounded-xl shadow-sm overflow-hidden p-1 mb-4">
                            <div class="px-3 py-2 border-b border-slate-100 flex justify-between items-center bg-slate-50/50">
                                <span class="text-[11px] font-bold uppercase tracking-wider text-slate-500 flex items-center gap-1.5">
                                    <i class="fa-solid fa-earth-africa text-emerald-500"></i> Localisation de l'incident
                                </span>
                                <span class="text-[10px] text-emerald-600 font-semibold flex items-center gap-1">
                                    <span class="w-2 h-2 rounded-full bg-emerald-500 inline-block animate-pulse"></span> Cliquez sur la carte pour placer un repère
                                </span>
                            </div>
                            <div id="map" class="w-full h-80 z-10 rounded-b-lg"></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lieu">
                            <i class="fas fa-map-marker-alt"></i> Point kilométrique / Lieu / Description repère <span class="required">*</span>
                        </label>
                        <input type="text" id="lieu" name="lieu" placeholder="Ex: PK 85, entre Ambatolampy et Antsirabe ou coordonnées" required />
                    </div>

                    <div class="form-group">
                        <label for="motifPanne">
                            <i class="fas fa-cogs"></i> Motif de la panne <span class="required">*</span>
                        </label>
                        <select id="motifPanne" name="motifPanneLibelle" required>
                            <option value="">-- Sélectionner un motif --</option>
                            <c:forEach var="motif" items="${motifsPanne}">
                                <option value="${motif.libelle}">${motif.libelle}</option>
                            </c:forEach>
                            <c:if test="${empty motifsPanne}">
                                <option value="Panne moteur">Panne moteur</option>
                                <option value="Crevaison">Crevaison</option>
                                <option value="Problème électrique">Problème électrique</option>
                                <option value="Surchauffe">Surchauffe</option>
                                <option value="Autre">Autre</option>
                            </c:if>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="description">
                            <i class="fas fa-align-left"></i> Description détaillée
                        </label>
                        <textarea id="description" name="description" rows="4" placeholder="Décrivez la panne en détail (symptômes, circonstances...)"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="photoUrl">
                            <i class="fas fa-camera"></i> Photo (URL)
                        </label>
                        <input type="url" id="photoUrl" name="photoUrl" placeholder="https://exemple.com/photo.jpg" />
                    </div>

                    <div class="form-actions">
                        <a href="/chauffeur/dashboard" class="btn btn-cancel">
                            <i class="fas fa-arrow-left"></i> Retour
                        </a>
                        <button type="submit" class="btn btn-submit" id="submitBtn">
                            <i class="fas fa-paper-plane"></i> Envoyer le signalement
                        </button>
                    </div>
                </form>
            </div>

            <div class="panne-info-section">
                <div class="info-card">
                    <div class="info-card-header">
                        <i class="fas fa-info-circle"></i>
                        <h3>Informations</h3>
                    </div>
                    <div class="info-card-body">
                        <div class="info-point">
                            <div class="info-point-icon"><i class="fas fa-check"></i></div>
                            <div>
                                <strong>Signalement automatique</strong>
                                <p>Le statut du voyage sera automatiquement mis à jour en "En panne".</p>
                            </div>
                        </div>
                        <div class="info-point">
                            <div class="info-point-icon"><i class="fas fa-map-pin"></i></div>
                            <div>
                                <strong>Point kilométrique</strong>
                                <p>Indiquez le plus précisément possible votre localisation sur le trajet ou utilisez la carte.</p>
                            </div>
                        </div>
                        <div class="info-point">
                            <div class="info-point-icon"><i class="fas fa-phone"></i></div>
                            <div>
                                <strong>Assistance</strong>
                                <p>En cas d'urgence, contactez le centre d'opérations au <strong>+261 34 00 000 00</strong>.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="info-card" style="margin-top: 20px;">
                    <div class="info-card-header">
                        <i class="fas fa-history"></i>
                        <h3>Voyages disponibles</h3>
                    </div>
                    <div class="info-card-body">
                        <c:if test="${not empty voyages}">
                            <c:forEach var="voyage" items="${voyages}" varStatus="status">
                                <div class="mini-voyage-card ${status.first ? 'selected-voyage' : ''}" id="card-voyage-${voyage.id}" onclick="selectVoyage('${voyage.id}')" style="cursor: pointer;">
                                    <div class="mini-voyage-route">
                                        <c:choose>
                                            <c:when test="${not empty voyage.gareDepartVille and not empty voyage.gareArriveeVille}">
                                                ${voyage.gareDepartVille} → ${voyage.gareArriveeVille}
                                            </c:when>
                                            <c:otherwise>
                                                ${voyage.gareDepart} → ${voyage.gareArrivee}
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="mini-voyage-meta">
                                        T-${voyage.id} · ${voyage.vehiculeImmatriculation}
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty voyages}">
                            <div class="no-voyages-msg">
                                <i class="fas fa-check-circle"></i>
                                <p>Aucun voyage actif disponible</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-overlay" id="successModal">
            <div class="modal-content">
                <div class="modal-icon success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h2>Panne signalée !</h2>
                <p>Votre signalement a été enregistré avec succès. Le statut du voyage a été mis à jour.</p>
                <a href="/chauffeur/dashboard" class="btn btn-success">
                    <i class="fas fa-home"></i> Retour au tableau de bord
                </a>
            </div>
        </div>

        <div class="modal-overlay" id="errorModal">
            <div class="modal-content">
                <div class="modal-icon error">
                    <i class="fas fa-times-circle"></i>
                </div>
                <h2>Erreur</h2>
                <p id="errorMessage">Une erreur est survenue lors du signalement.</p>
                <button class="btn btn-danger" onclick="document.getElementById('errorModal').classList.remove('show')">
                    <i class="fas fa-redo"></i> Réessayer
                </button>
            </div>
        </div>
    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <script>
        // 1. Initialisation de la carte Leaflet
        // Coordonnées de départ centrées par défaut sur Madagascar (Antananarivo : -18.9333, 47.5167)
        const map = L.map('map').setView([-18.913684, 47.536392], 7);

        // Ajout de la couche de tuiles OpenStreetMap
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        let marker = null;

        // Gestion du clic sur la carte pour définir la position GPS
        map.on('click', function(e) {
            const lat = e.latlng.lat;
            const lng = e.latlng.lng;

            // Déplacer ou créer le marqueur
            if (marker) {
                marker.setLatLng(e.latlng);
            } else {
                marker = L.marker(e.latlng, { draggable: true }).addTo(map);
                marker.on('dragend', function(event) {
                    const changedPos = event.target.getLatLng();
                    updateGpsFields(changedPos.lat, changedPos.lng);
                });
            }

            updateGpsFields(lat, lng);
        });

        // Fonction pour formater le point géométrique pour Hibernate Spatial / PostGIS et le champ texte
        function updateGpsFields(lat, lng) {
            // Format d'écriture standard WKT (Well-Known Text): POINT(Longitude Latitude)
            // Attention: l'ordre spatial standard c'est Longitude puis Latitude
            const wktString = `POINT(${lng} ${lat})`;
            document.getElementById('gps').value = wktString;
            
            // Pré-remplit ou concatène le champ d'informations textuelles pour donner un feedback au chauffeur
            document.getElementById('lieu').value = `Coordonnées GPS: [${lat.toFixed(5)}, ${lng.toFixed(5)}]`;
        }

        // 2. Gestion de la sélection visuelle des cartes de voyages à droite
        function selectVoyage(id) {
            document.getElementById('voyageId').value = id;
            
            // Retirer la classe sélectionnée de toutes les cartes
            document.querySelectorAll('.mini-voyage-card').forEach(card => {
                card.classList.remove('selected-voyage');
            });
            
            // Ajouter la classe sélectionnée à la carte active
            const activeCard = document.getElementById('card-voyage-' + id);
            if(activeCard) {
                activeCard.classList.add('selected-voyage');
            }
        }

        // 3. Soumission Ajax du Formulaire de Panne
        document.getElementById('panneForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const voyageIdValue = document.getElementById('voyageId').value;
            if (!voyageIdValue) {
                alert("Veuillez sélectionner un voyage actif sur le panneau de droite avant de soumettre.");
                return;
            }

            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Envoi en cours...';

            // On construit le payload d'envoi. Si ton contrôleur attend le point dans 'lieu' 
            // ou un champ 'gps' découplé, tu peux adapter ici :
            const data = {
                voyageId: voyageIdValue,
                lieu: document.getElementById('lieu').value,
                gps: document.getElementById('gps').value, // Transmet le format "POINT(lng lat)"
                motifPanneLibelle: document.getElementById('motifPanne').value,
                description: document.getElementById('description').value,
                photoUrl: document.getElementById('photoUrl').value
            };

            fetch('/api/chauffeur/pannes', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Chauffeur-Id': '${chauffeurId}'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => { throw new Error(err.error || 'Erreur serveur'); });
                }
                return response.json();
            })
            .then(result => {
                document.getElementById('successModal').classList.add('show');
            })
            .catch(error => {
                document.getElementById('errorMessage').textContent = error.message;
                document.getElementById('errorModal').classList.add('show');
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Envoyer le signalement';
            });
        });

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


        // function tracerTrajet(idVoyage, traceWkt) {
        //     nettoyerCarte();
        // }
    </script>
</body>
</html>