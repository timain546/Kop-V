<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur système</title>
    <style>
        body { font-family: 'Outfit', sans-serif; background-color: #121212; color: #ffffff; padding: 2rem; }
        .error-container { background: rgba(255, 0, 0, 0.1); border: 1px solid red; padding: 2rem; border-radius: 8px; }
        h1 { color: #ff5252; }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Oups, une erreur s'est produite !</h1>
        <p><strong>Status :</strong> \${status}</p>
        <p><strong>Erreur :</strong> \${error}</p>
        <p><strong>Message :</strong> \${message}</p>
        <p><strong>Exception :</strong> \${exception}</p>
        <hr>
        <p><em>Trace :</em></p>
        <pre style="color: #bbb; overflow-x: auto;">\${trace}</pre>
        <br/>
        <a href="javascript:history.back()" style="color: #4CAF50; text-decoration: none;">&larr; Retour</a>
    </div>
</body>
</html>
