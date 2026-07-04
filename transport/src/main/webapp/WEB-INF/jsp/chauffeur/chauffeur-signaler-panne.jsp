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
    <link rel="stylesheet" href="/assets/css/chauffeur-dashboard.css">
    <link rel="stylesheet" href="/assets/css/chauffeur-panne.css">
</head>
<body>

    <!-- Navbar -->
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
            </div>
        </div>
    </nav>

    <div class="panne-page-container">
        <div class="panne-content">
            <!-- Left: Form -->
            <div class="panne-form-section">
                <div class="form-header">
                    <div class="form-icon-header">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <h1>Signaler une panne</h1>
                    <p>Remplissez le formulaire ci-dessous pour signaler une panne sur votre véhicule. Le statut du voyage sera automatiquement mis à jour.</p>
                </div>

                <form id="panneForm" class="panne-form">
                    <!-- Voyage -->
                    <div class="form-group">
                        <label for="voyageId">
                            <i class="fas fa-route"></i> Voyage concerné <span class="required">*</span>
                        </label>
                        <select id="voyageId" name="voyageId" required>
                            <option value="">-- Sélectionner un voyage --</option>
                            <c:forEach var="voyage" items="${voyages}">
                                <option value="${voyage.id}"
                                    ${selectedVoyageId != null && selectedVoyageId == voyage.id ? 'selected' : ''}>
                                    <c:choose>
                                        <c:when test="${not empty voyage.gareDepartVille and not empty voyage.gareArriveeVille}">
                                            ${voyage.gareDepartVille} → ${voyage.gareArriveeVille}
                                        </c:when>
                                        <c:otherwise>
                                            ${voyage.gareDepart} → ${voyage.gareArrivee}
                                        </c:otherwise>
                                    </c:choose>
                                    (T-${voyage.id}) — ${voyage.vehiculeImmatriculation}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Lieu / Point kilométrique -->
                    <div class="form-group">
                        <label for="lieu">
                            <i class="fas fa-map-marker-alt"></i> Point kilométrique / Lieu <span class="required">*</span>
                        </label>
                        <input type="text" id="lieu" name="lieu" placeholder="Ex: PK 85, entre Ambatolampy et Antsirabe" required />
                    </div>

                    <!-- Motif de panne -->
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

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description">
                            <i class="fas fa-align-left"></i> Description détaillée
                        </label>
                        <textarea id="description" name="description" rows="4" placeholder="Décrivez la panne en détail (symptômes, circonstances...)"></textarea>
                    </div>

                    <!-- Photo URL -->
                    <div class="form-group">
                        <label for="photoUrl">
                            <i class="fas fa-camera"></i> Photo (URL)
                        </label>
                        <input type="url" id="photoUrl" name="photoUrl" placeholder="https://exemple.com/photo.jpg" />
                    </div>

                    <!-- Actions -->
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

            <!-- Right: Info Card -->
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
                                <p>Indiquez le plus précisément possible votre localisation sur le trajet.</p>
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

                <!-- Recent pannes -->
                <div class="info-card" style="margin-top: 20px;">
                    <div class="info-card-header">
                        <i class="fas fa-history"></i>
                        <h3>Voyages disponibles</h3>
                    </div>
                    <div class="info-card-body">
                        <c:if test="${not empty voyages}">
                            <c:forEach var="voyage" items="${voyages}">
                                <div class="mini-voyage-card" onclick="document.getElementById('voyageId').value='${voyage.id}'">
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

        <!-- Success Modal -->
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

        <!-- Error Modal -->
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

    <script>
        document.getElementById('panneForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Envoi en cours...';

            const data = {
                voyageId: document.getElementById('voyageId').value,
                lieu: document.getElementById('lieu').value,
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
    </script>
</body>
</html>
