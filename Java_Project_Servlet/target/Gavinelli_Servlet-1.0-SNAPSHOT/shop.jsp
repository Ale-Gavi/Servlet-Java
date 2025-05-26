<%@ page import="java.sql.*" %>
<%@ page import="com.example.gavinelli_servlet.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("Username") != null && session.getAttribute("Password") != null) {

%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./CSS/shop.css">
    <title>Shop</title>
</head>
<body class="darkMode">

<div class="hiddenMenu" id="hiddenMenu">
    <ul>
        <li><a href="#" class="current">Link</a></li>
        <li><a href="#">Link</a></li>
        <li><a href="#">Link</a></li>
        <li><a href="#">Link</a></li>
        <li><a href="#">Link</a></li>
    </ul>

    <div class="changeMode">
        <button onclick="DarkMode()" id="darkMode">☀️ - Light Mode</button>
    </div>
    <div class="logOut">
        <p>Benvenuto: <%=session.getAttribute("Username")%></p>
        <a href="Logout.jsp">Logout</a>
    </div>
</div>

<div class="blurOverlay" id="blurOverlay"></div>

<div class="container">
    <div class="navBar">
        <div class="menu" onclick="menuFunction(this)">
            <div class="bar1"></div>
            <div class="bar2"></div>
            <div class="bar3"></div>
        </div>
        <div class="title">
            <h1>Negozio</h1>
        </div>
        <div class="cart">
            <a href="carrello.jsp"><img src="./Assets/shopping-cart.png" alt="cartIcon"></a>
        </div>
    </div>

    <div class="items">
<%
    DBConnection connection = new DBConnection();

    ResultSet rs = connection.selectQuery("select * from prodotti");

    while (rs.next()) {
        if(rs.getBoolean("Disponibilita")){


%>
<div class="itemCard">
    <img src="./Assets/Items/<%=rs.getString("Immagine")%>.png" alt="<%=rs.getString("Nome")%>">
    <div class="cardContent">
        <div class="descrizione">
            <span>Descrizione: </span>
            <p><%=rs.getString("Descrizione")%></p>
        </div>
        <div class="prezzo">
            <span>Prezzo: </span> <%=rs.getDouble("Prezzo")%>
        </div>
        <form action="addToCart" method="post">
            <div class="hiddenInput">
                <input type="hidden" name="idObj" id="idObj" value="<%=rs.getInt("ID")%>">
            </div>
            <div class="spinner-container">
                <button class="spinner-button" type="button" onclick="decrease(this)">−</button>
                <input type="number" name="quantita" class="spinner-input" value="1" min="1"
                       max="<%=rs.getInt("Quantita")%>" step="1">
                <button class="spinner-button" type="button" onclick="increase(this)">+</button>
            </div>
            <div class="submit">
                <input type="submit" name="submit" id="submit" value="Aggiungi Al Carrello">
            </div>
        </form>
    </div>
</div>
<%
        }
    }
%>
    </div>
</div>
</body>

<script>
    function menuFunction(x) {
        x.classList.toggle("change");

        const menu = document.getElementById('hiddenMenu');
        const blurOverlay = document.getElementById('blurOverlay');

        menu.classList.toggle("open");
        blurOverlay.classList.toggle("active");
    }


    document.getElementById('blurOverlay').addEventListener('click', () => {
        document.getElementById('hiddenMenu').classList.remove('open');
        document.getElementById('blurOverlay').classList.remove('active');

        // Rimuovi l'animazione hamburger
        const menuIcon = document.querySelector('.menu.change');
        if (menuIcon) menuIcon.classList.remove('change');
    });


    const DarkMode = () => {

        const body = document.body;
        body.classList.toggle('darkMode');

        if (body.classList.contains('darkMode')) {
            document.getElementById('darkMode').textContent = '☀️ - Light Mode';

        } else {

            document.getElementById('darkMode').textContent = '🌙 - Dark Mode';
        }
    }

    const input = document.getElementById('custom-spinner');

    function increase(button) {
        const input = button.parentElement.querySelector('.spinner-input');
        let value = parseInt(input.value);
        const max = parseInt(input.max);
        if (value < max) {
            input.value = value + 1;
        }
    }

    function decrease(button) {
        const input = button.parentElement.querySelector('.spinner-input');
        let value = parseInt(input.value);
        const min = parseInt(input.min);
        if (value > min) {
            input.value = value - 1;
        }
    }
</script>
</html>

<%
    }
%>