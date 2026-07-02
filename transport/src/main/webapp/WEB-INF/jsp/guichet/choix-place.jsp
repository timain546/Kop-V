<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="fr">
<head>

    <meta charset="UTF-8">

    <title>Choix des places — KOP-V</title>

    <link rel="stylesheet" href="css/places.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

</head>

<body>

<header class="topbar">

    <div class="container">

        <div class="topbar-content">

            <div class="logo">

                <div class="logo-icon">

                    <i class="bi bi-bus-front-fill"></i>

                </div>

                <h3>KOP<span>—V</span></h3>

            </div>

            <div class="steps">

                <div class="step done">

                    <i class="bi bi-check-lg"></i>

                    Recherche

                </div>

                <div class="separator"></div>

                <div class="step done">

                    <i class="bi bi-check-lg"></i>

                    Voyages

                </div>

                <div class="separator"></div>

                <div class="step active">

                    <i class="bi bi-car-front"></i>

                    Places

                </div>

                <div class="separator"></div>

                <div class="step">

                    <i class="bi bi-person-circle"></i>

                    Passagers

                </div>

            </div>

            <div class="support">

                Aide ? <strong>+261 34 00 000 00</strong>

            </div>

        </div>

    </div>

</header>

<main class="container page">

    <div class="row">

        <div class="col-lg-8">

            <div class="empty-card">

                <h2>Aucun voyage sélectionné</h2>

                <p>

                    Veuillez d'abord choisir un voyage.

                </p>

                <a href="recherche.jsp" class="btn btn-success">

                    Retour à la recherche

                </a>

            </div>

        </div>

        <div class="col-lg-4">

            <aside class="summary">

                <div class="summary-header">

                    <small>RÉCAPITULATIF</small>

                    <h4>Votre voyage</h4>

                </div>

                <div class="summary-body">

                    <div class="summary-item">

                        <i class="bi bi-geo-alt"></i>

                        <div>

                            <span>TRAJET</span>

                            <strong>Antananarivo → Antsirabe</strong>

                        </div>

                    </div>

                    <div class="summary-item">

                        <i class="bi bi-calendar-event"></i>

                        <div>

                            <span>DATE</span>

                            <strong>mar. 30 juin</strong>

                        </div>

                    </div>

                    <div class="summary-item">

                        <i class="bi bi-people"></i>

                        <div>

                            <span>PASSAGERS</span>

                            <strong>1 personne</strong>

                        </div>

                    </div>

                    <div class="summary-message">

                        Sélectionnez un voyage pour voir le détail et le prix total.

                    </div>

                </div>

                <div class="summary-footer">

                    Place garantie · Paiement sécurisé · Annulation possible jusqu'à 24h avant départ.

                </div>

            </aside>

        </div>

    </div>

</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>