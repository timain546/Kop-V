<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="fr">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>KOP-V | Réserver un voyage</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar navbar-expand-lg bg-white shadow-sm">

<div class="container">

<a class="navbar-brand fw-bold text-success fs-3" href="#">
<i class="bi bi-bus-front-fill"></i>
KOP<span class="text-dark">-</span>V
</a>

<button class="navbar-toggler"
data-bs-toggle="collapse"
data-bs-target="#menu">
<span class="navbar-toggler-icon"></span>
</button>

<div class="collapse navbar-collapse" id="menu">

<ul class="navbar-nav mx-auto">

<li class="nav-item">
<a class="nav-link active" href="#">
<i class="bi bi-search"></i>
Recherche
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="#">
<i class="bi bi-bus-front"></i>
Voyages
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="#">
<i class="bi bi-geo-alt"></i>
Places
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="#">
<i class="bi bi-people"></i>
Passagers
</a>
</li>

</ul>

<span class="small">
Aide : +261 34 00 000 00
</span>

</div>

</div>

</nav>

<!-- ================= CONTENU ================= -->

<div class="container mt-5">

<div class="row">

<!-- ================= GAUCHE ================= -->

<div class="col-lg-8">

<p class="text-success fw-bold text-uppercase">
Réservation
</p>

<h1 class="fw-bold">
Où souhaitez-vous voyager aujourd'hui ?
</h1>

<p class="text-muted">
Choisissez votre itinéraire et trouvez un voyage fiable,
à l'heure et confortable.
</p>

<!-- ================= FORMULAIRE ================= -->

<div class="search-card mt-4">

<form action="RechercheVoyage" method="post">

<div class="row g-3">

<div class="col-md-4">

<label class="form-label">
Ville de départ
</label>

<select class="form-select">

    <option>Antananarivo</option>
    <option>Antsirabe</option>
    <option>Toamasina</option>
    <option>Fianarantsoa</option>

</select>

</div>

<div class="col-md-4">

<label class="form-label">
Ville d'arrivée
</label>

<select class="form-select" name="arrivee">

<c:forEach var="ville" items="${villes}">
<option value="${ville.id}">
${ville.nom}
</option>
</c:forEach>

</select>

</div>

<div class="col-md-2">

<label class="form-label">
Date
</label>

<input
type="date"
name="date"
class="form-control">

</div>

<div class="col-md-2">

<label class="form-label">
Passagers
</label>

<input
type="number"
class="form-control"
name="passagers"
value="1"
min="1">

</div>

</div>

<div class="d-grid mt-4">

<button class="btn btn-success btn-lg">

<i class="bi bi-search"></i>

Rechercher un voyage

</button>

</div>

</form>

</div>

<!-- ================= TRAJETS ================= -->

<h5 class="mt-5 mb-3 text-uppercase">

Trajets populaires

</h5>

<div class="row">

<div class="col-md-4">

<div class="popular-card">

<h6>Antananarivo ↔ Antsirabe</h6>

<p>à partir de 25 000 Ar</p>

</div>

</div>

<div class="col-md-4">

<div class="popular-card">

<h6>Antananarivo ↔ Toamasina</h6>

<p>à partir de 45 000 Ar</p>

</div>

</div>

<div class="col-md-4">

<div class="popular-card">

<h6>Antananarivo ↔ Fianarantsoa</h6>

<p>à partir de 38 000 Ar</p>

</div>

</div>

</div>

<!-- ================= AVANTAGES ================= -->

<div class="row mt-4">

<div class="col-md-4">

<div class="feature-card">

<i class="bi bi-shield-check fs-2 text-success"></i>

<h5>Place garantie</h5>

<p>

Votre siège est réservé.

</p>

</div>

</div>

<div class="col-md-4">

<div class="feature-card">

<i class="bi bi-clock fs-2 text-success"></i>

<h5>Départ à l'heure</h5>

<p>

Ponctualité assurée.

</p>

</div>

</div>

<div class="col-md-4">

<div class="feature-card">

<i class="bi bi-phone fs-2 text-success"></i>

<h5>Service moderne</h5>

<p>

Billets numériques.

</p>

</div>

</div>

</div>

</div>

<!-- ================= RECAP ================= -->

<div class="col-lg-4">

<div class="summary-card">

<div class="summary-header">

<h4>Votre voyage</h4>

</div>

<div class="summary-body">

<p>

<i class="bi bi-geo-alt"></i>

Antananarivo → Antsirabe

</p>

<hr>

<p>

<i class="bi bi-calendar"></i>

30/06/2026

</p>

<hr>

<p>

<i class="bi bi-people"></i>

1 personne

</p>

<div class="alert alert-success mt-4">

Sélectionnez un voyage pour voir le prix.

</div>

</div>

</div>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>