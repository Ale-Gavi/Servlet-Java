<%--  
  Created by IntelliJ IDEA.
  User: alega
  Date: 23/05/2025
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="java.sql.*" %>  <%-- Import JDBC classes --%>
<%@ page import="com.example.java_project_servlet.DBConnection" %>  <%-- Import your DBConnection helper --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>  <%-- Set response content type and page language --%>

<%
    // Check if user is logged in by verifying session attributes "Username" and "Password"
    if (session.getAttribute("Username") != null && session.getAttribute("Password") != null) {
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./CSS/carrello.css">  <%-- Link to stylesheet --%>
    <title>Carrello</title>
</head>
<body class="darkMode">  <%-- Default to dark mode --%>
<div class="container">

    <div class="navBar">
        <div class="Back">
            <button id="back"><a href="shop.jsp">Torna Allo Shop</a></button>  <%-- Button to return to shop page --%>
        </div>

        <h1>Carrello</h1>  <%-- Page title --%>

        <div class="changeMode">
            <button onclick="DarkMode()" id="darkMode">☀️ - Light Mode</button>  <%-- Toggle dark/light mode button --%>
        </div>
    </div>

    <div class="items">
        <%
            // Retrieve the current user's ID from the session
            int idUtente = (int) session.getAttribute("Id");

            // Initialize total price accumulator
            double totale = 0;

            // Create DB connection
            DBConnection conn = new DBConnection();
            try {
                // Query to get all orders for current user joined with product details
                ResultSet rs = conn.selectQuery(
                        "SELECT P.Nome, P.Immagine, P.Quantita, O.ID, O.ID_utente, O.ID_Prodotto, O.Quantita, O.SubTotale " +
                                "FROM ordini O " +
                                "INNER JOIN prodotti P ON P.ID = O.ID_Prodotto " +
                                "WHERE O.ID_Utente = " + idUtente);

                // Loop through each order record
                while (rs.next()) {
                    String nomeProdotto = rs.getString("P.Nome");   // Product name
                    String immagine = rs.getString("P.Immagine");   // Image filename
                    double subtotale = rs.getDouble("O.SubTotale"); // Subtotal for the order
                    int idOrdine = rs.getInt("O.ID");                // Order ID

                    totale += subtotale;  // Add to total price
        %>
        <div class="itemCard">
            <%-- Display product image --%>
            <img src="./Assets/Items/<%=immagine%>.png" alt="<%=nomeProdotto%>">

            <div class="cardContent">
                <div class="prezzo">
                    <span>Prezzo: </span> € <%= String.format("%.2f", subtotale) %> <%-- Format price with 2 decimals --%>
                </div>

                <%-- Form to update quantity or remove item --%>
                <form method="post" action="aggiornaOrdine">
                    <input type="hidden" name="id_ordine" value="<%=idOrdine%>">  <%-- Hidden field with order ID --%>

                    <div class="spinner-container">
                        <%-- Button to decrease quantity --%>
                        <button class="spinner-button" type="button" onclick="decrease(this)">−</button>

                        <%-- Quantity input field with min 1 and max as product stock quantity --%>
                        <input type="number" name="quantita" class="spinner-input"
                               value="<%= rs.getInt("O.Quantita")%>"
                               min="1" max="<%=rs.getInt("P.Quantita")%>">

                        <%-- Button to increase quantity --%>
                        <button class="spinner-button" type="button" onclick="increase(this)">+</button>
                    </div>

                    <div class="submit">
                        <%-- Submit buttons for updating quantity or removing order --%>
                        <input type="submit" name="action" value="🔄 Aggiorna Quantità">
                        <input type="submit" name="action" formaction="rimuoviOrdine" value="❌ Rimuovi">
                    </div>
                </form>

            </div>
        </div>
        <%
                } // end while loop for each order
            } catch (SQLException e) {
                e.printStackTrace();  // Log SQL errors
            }
        %>

    </div>

    <div class="footer">
        <div class="acquisto">
            <%-- Display the total price formatted --%>
            <h3>Totale: € <%= String.format("%.2f", totale) %></h3>

            <%-- Button to open checkout modal --%>
            <button id="checkoutBtn"><img src="./Assets/shopping-cart.png" alt=""> Procedi al Checkout</button>
        </div>
    </div>
</div>
</body>

<%-- Checkout modal overlay --%>
<div id="checkoutOverlay" class="overlay hidden">
    <div class="checkoutModal">
        <h2>Checkout</h2>

        <%-- Checkout form for user info and payment method --%>
        <form action="#" method="post">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required>

            <label for="indirizzo">Indirizzo:</label>
            <input type="text" id="indirizzo" name="indirizzo" required>

            <label for="metodoPagamento">Metodo di pagamento:</label>
            <select id="metodoPagamento" name="metodoPagamento">
                <option value="carta">Carta di credito</option>
                <option value="paypal">PayPal</option>
                <option value="contanti">Contanti alla consegna</option>
            </select>

            <div class="checkoutActions">
                <button type="submit">Conferma Ordine</button>
                <button type="button" id="closeCheckout">Annulla</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Toggle between dark mode and light mode
    const DarkMode = () => {
        const body = document.body;
        body.classList.toggle('darkMode');

        if (body.classList.contains('darkMode')) {
            document.getElementById('darkMode').textContent = '☀️ - Light Mode';
        } else {
            document.getElementById('darkMode').textContent = '🌙 - Dark Mode';
        }
    }

    // Increase quantity value by 1, respecting the max limit
    function increase(button) {
        const input = button.parentElement.querySelector('.spinner-input');
        let value = parseInt(input.value);
        const max = parseInt(input.max);
        if (value < max) {
            input.value = value + 1;
        }
    }

    // Decrease quantity value by 1, respecting the min limit
    function decrease(button) {
        const input = button.parentElement.querySelector('.spinner-input');
        let value = parseInt(input.value);
        const min = parseInt(input.min);
        if (value > min) {
            input.value = value - 1;
        }
    }

    // Show the checkout modal when checkout button is clicked
    document.getElementById('checkoutBtn').addEventListener('click', () => {
        document.getElementById('checkoutOverlay').classList.remove('hidden');
    });

    // Hide the checkout modal when cancel button is clicked
    document.getElementById('closeCheckout').addEventListener('click', () => {
        document.getElementById('checkoutOverlay').classList.add('hidden');
    });
</script>
</html>

<%
    } // End of logged-in check
%>
