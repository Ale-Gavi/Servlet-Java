<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./CSS/index.css">

    <title>Homepage Progetto</title>
</head>
<body class="darkMode">
<div class="container">
    <div class="topNav">
        <div class="titles">
            <h1>Homepage Progetto</h1>
            <h2>Alessandro Gavinelli - 5FIN</h2>
        </div>
        <div class="changeMode">
            <button onclick="DarkMode()" id="darkMode">☀️ - Light Mode</button>
        </div>
    </div>

    <div class="main">
        <p>Questo è il progetto di TPSIT sviluppato usando Java Servlet e JSP con Tomcat.</p>

        <button><a href="login">Accedi</a></button>
    </div>

    <div class="footer">
        <p>Questo progetto è a scopo didattico</p>
    </div>
</div>
</body>

<script>
    const DarkMode = () => {
        const body = document.body;
        body.classList.toggle('darkMode');

        if (body.classList.contains('darkMode')) {
            document.getElementById('darkMode').textContent = '☀️ - Light Mode';

        } else {

            document.getElementById('darkMode').textContent = '🌙 - Dark Mode';
        }
    }
</script>
</html>