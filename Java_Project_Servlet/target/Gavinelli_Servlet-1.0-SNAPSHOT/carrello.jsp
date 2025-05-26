<%--
  Created by IntelliJ IDEA.
  User: alega
  Date: 23/05/2025
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
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
    <link rel="stylesheet" href="./CSS/carrello.css">
    <title>Carrello</title>
</head>
<body class="darkMode">
<div class="container">

    <div class="navBar">
        <div class="Back">
            <button id="back"><a href="shop.jsp">Torna Allo Shop</a></button>
        </div>

        <h1>Carrello</h1>

        <div class="changeMode">
            <button onclick="DarkMode()" id="darkMode">☀️ - Light Mode</button>
        </div>
    </div>

    <div class="items">
        <%
            int idUtente = (int) session.getAttribute("Id");

            double totale = 0;

            DBConnection conn = new DBConnection();
            try {
                ResultSet rs = conn.selectQuery(
                        "SELECT P.Nome, P.Immagine, P.Quantita, O.ID, O.ID_utente, O.ID_Prodotto, O.Quantita, O.SubTotale " +
                                "FROM ordini O " +
                                "INNER JOIN prodotti P ON P.ID = O.ID_Prodotto " +
                                "WHERE O.ID_Utente = " + idUtente);
                while (rs.next()) {
                    String nomeProdotto = rs.getString("P.Nome");
                    String immagine = rs.getString("P.Immagine");
                    double subtotale = rs.getDouble("O.SubTotale");
                    int idOrdine = rs.getInt("O.ID");
                    totale += subtotale;



        %>
        <div class="itemCard">
            <img src="./Assets/Items/<%=immagine%>.png" alt="<%=nomeProdotto%>">
            <div class="cardContent">
                <div class="prezzo">
                    <span>Prezzo: </span> € <%= String.format("%.2f", subtotale) %>
                </div>
                <form method="post" action="aggiornaOrdine">
                    <input type="hidden" name="id_ordine" value="<%=idOrdine%>">

                    <div class="spinner-container">
                        <button class="spinner-button" type="button" onclick="decrease(this)">−</button>
                        <input type="number" name="quantita" class="spinner-input"
                               value="<%= rs.getInt("O.Quantita")%>"
                               min="1" max="<%=rs.getInt("P.Quantita")%>">
                        <button class="spinner-button" type="button" onclick="increase(this)">+</button>
                    </div>

                    <div class="submit">
                        <input type="submit" name="action" value="🔄 Aggiorna Quantità">
                        <input type="submit" name="action" formaction="rimuoviOrdine" value="❌ Rimuovi">
                    </div>
                </form>

            </div>
        </div>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>

    </div>
    <div class="footer">
        <div class="acquisto">
            <h3>Totale: € <%= String.format("%.2f", totale) %></h3>
            <button id="checkoutBtn"><img src="./Assets/shopping-cart.png" alt=""> Procedi al Checkout</button>
        </div>
    </div>
</div>
</body>

<div id="checkoutOverlay" class="overlay hidden">
    <div class="checkoutModal">
        <h2>Checkout</h2>
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

    document.getElementById('checkoutBtn').addEventListener('click', () => {
        document.getElementById('checkoutOverlay').classList.remove('hidden');
    });

    document.getElementById('closeCheckout').addEventListener('click', () => {
        document.getElementById('checkoutOverlay').classList.add('hidden');
    });

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
