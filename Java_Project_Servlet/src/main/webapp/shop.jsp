<%@ page import="java.sql.*" %>  <%-- Import Java SQL package for database operations --%>
<%@ page import="com.example.java_project_servlet.DBConnection" %>  <%-- Import custom DBConnection class --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>  <%-- Set response content type and language --%>

<%
    // Check if the user is logged in by verifying session attributes "Username" and "Password"
    if (session.getAttribute("Username") != null && session.getAttribute("Password") != null) {
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">  <%-- Character encoding --%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  <%-- Responsive design meta tag --%>
    <link rel="stylesheet" href="./CSS/shop.css">  <%-- Link to external stylesheet --%>
    <title>Shop</title>  <%-- Page title --%>
</head>
<body class="darkMode">  <%-- Default page mode set to darkMode --%>

<!-- Hidden slide-out menu -->
<div class="hiddenMenu" id="hiddenMenu">
    <ul>
        <%-- Placeholder navigation links --%>
        <li><a href="#" class="current">Link</a></li>
        <li><a href="#">Link</a></li>
        <li><a href="#">Link</a></li>
        <li><a href="#">Link</a></li>
        <li><a href="#">Link</a></li>
    </ul>

    <div class="changeMode">
        <%-- Button to toggle light/dark mode --%>
        <button onclick="DarkMode()" id="darkMode">☀️ - Light Mode</button>
    </div>
    <div class="logOut">
        <%-- Display welcome message with logged-in username from session --%>
        <p>Benvenuto: <%=session.getAttribute("Username")%></p>
        <%-- Link to logout page --%>
        <a href="Logout.jsp">Logout</a>
    </div>
</div>

<div class="blurOverlay" id="blurOverlay"></div>  <%-- Background overlay when menu is open --%>

<div class="container">
    <!-- Top navigation bar -->
    <div class="navBar">
        <%-- Hamburger menu icon for toggling the hidden menu --%>
        <div class="menu" onclick="menuFunction(this)">
            <div class="bar1"></div>
            <div class="bar2"></div>
            <div class="bar3"></div>
        </div>
        <div class="title">
            <h1>Negozio</h1>  <%-- Store title --%>
        </div>
        <div class="cart">
            <%-- Link to shopping cart page with icon --%>
            <a href="carrello.jsp"><img src="./Assets/shopping-cart.png" alt="cartIcon"></a>
        </div>
    </div>

    <div class="items">
<%
    // Create new DB connection object
    DBConnection connection = new DBConnection();

    // Execute SQL query to retrieve all products
    ResultSet rs = connection.selectQuery("select * from prodotti");

    // Iterate over the result set to display each product
    while (rs.next()) {
        // Only display products marked as available
        if(rs.getBoolean("Disponibilita")){
%>
<div class="itemCard">
    <%-- Product image --%>
    <img src="./Assets/Items/<%=rs.getString("Immagine")%>.png" alt="<%=rs.getString("Nome")%>">
    <div class="cardContent">
        <div class="descrizione">
            <span>Descrizione: </span>
            <%-- Product description text --%>
            <p><%=rs.getString("Descrizione")%></p>
        </div>
        <div class="prezzo">
            <span>Prezzo: </span> <%=rs.getDouble("Prezzo")%>  <%-- Product price --%>
        </div>
        <%-- Form to add product to cart --%>
        <form action="addToCart" method="post">
            <div class="hiddenInput">
                <%-- Hidden input holding product ID --%>
                <input type="hidden" name="idObj" id="idObj" value="<%=rs.getInt("ID")%>">
            </div>
            <div class="spinner-container">
                <%-- Quantity selection buttons and input --%>
                <button class="spinner-button" type="button" onclick="decrease(this)">−</button>
                <input type="number" name="quantita" class="spinner-input" value="1" min="1"
                       max="<%=rs.getInt("Quantita")%>" step="1">
                <button class="spinner-button" type="button" onclick="increase(this)">+</button>
            </div>
            <div class="submit">
                <%-- Submit button to add product to cart --%>
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
    // Toggle hamburger menu open/close and blur background
    function menuFunction(x) {
        x.classList.toggle("change");

        const menu = document.getElementById('hiddenMenu');
        const blurOverlay = document.getElementById('blurOverlay');

        menu.classList.toggle("open");
        blurOverlay.classList.toggle("active");
    }

    // Close menu and blur when clicking outside menu area
    document.getElementById('blurOverlay').addEventListener('click', () => {
        document.getElementById('hiddenMenu').classList.remove('open');
        document.getElementById('blurOverlay').classList.remove('active');

        // Remove hamburger animation
        const menuIcon = document.querySelector('.menu.change');
        if (menuIcon) menuIcon.classList.remove('change');
    });

    // Toggle dark/light mode on the body and change button label accordingly
    const DarkMode = () => {
        const body = document.body;
        body.classList.toggle('darkMode');

        if (body.classList.contains('darkMode')) {
            document.getElementById('darkMode').textContent = '☀️ - Light Mode';
        } else {
            document.getElementById('darkMode').textContent = '🌙 - Dark Mode';
        }
    }

    // Increase quantity input value by 1, respecting max limit
    function increase(button) {
        const input = button.parentElement.querySelector('.spinner-input');
        let value = parseInt(input.value);
        const max = parseInt(input.max);
        if (value < max) {
            input.value = value + 1;
        }
    }

    // Decrease quantity input value by 1, respecting min limit
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
    }  // End of session check
%>
