<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>

    <meta charset="UTF-8">
    <title>Passagers | KOP-V</title>

    <link rel="stylesheet" href="css/passagers.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

</head>

<body>

<header class="header">

    <div class="container-fluid px-5">

        <div class="header-content">

            <div class="logo">

                <i class="bi bi-bus-front-fill"></i>

                <span>KOP-<strong>V</strong></span>

            </div>

            <div class="steps">

                <div class="step completed">

                    <div class="circle">
                        <i class="bi bi-check-lg"></i>
                    </div>

                    <span>Recherche</span>

                </div>

                <div class="line"></div>

                <div class="step completed">

                    <div class="circle">
                        <i class="bi bi-check-lg"></i>
                    </div>

                    <span>Voyages</span>

                </div>

                <div class="line"></div>

                <div class="step completed">

                    <div class="circle">
                        <i class="bi bi-check-lg"></i>
                    </div>

                    <span>Places</span>

                </div>

                <div class="line"></div>

                <div class="step active">

                    <div class="circle">

                        <i class="bi bi-person-fill"></i>

                    </div>

                    <span>Passagers</span>

                </div>

            </div>

            <div class="help">

                <i class="bi bi-question-circle"></i>

                Aide +261 34 00 000 00

            </div>

        </div>

    </div>

</header>

<main class="container-fluid px-5 mt-5">

    <div class="row">

        <div class="col-lg-8">

            <div class="empty-box">

                <div class="empty-content">

                    <h2>Aucun voyage sélectionné</h2>

                    <a href="recherche.jsp" class="btn btn-retour">

                        Retour à la recherche

                    </a>

                </div>

            </div>

        </div>

        <div class="col-lg-4">

            <div class="resume">

                <div class="resume-header">

                    <small>RÉCAPITULATIF</small>

                    <h4>Votre voyage</h4>

                </div>

                <div class="resume-body">

                    <div class="resume-item">

                        <i class="bi bi-geo-alt"></i>

                        <div>

                            <span class="label">Trajet</span>

                            <strong>Antananarivo → Antsirabe</strong>

                        </div>

                    </div>

                    <div class="resume-item">

                        <i class="bi bi-calendar-event"></i>

                        <div>

                            <span class="label">Date</span>

                            <strong>Mardi 30 Juin</strong>

                        </div>

                    </div>

                    <div class="resume-item">

                        <i class="bi bi-people"></i>

                        <div>

                            <span class="label">Passagers</span>

                            <strong>1 personne</strong>

                        </div>

                    </div>

                    <div class="info-box">

                        Sélectionnez un voyage pour afficher le détail de votre réservation.

                    </div>

                </div>

                <div class="resume-footer">

                    Place garantie • Paiement sécurisé

                </div>

            </div>

        </div>

    </div>

</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>