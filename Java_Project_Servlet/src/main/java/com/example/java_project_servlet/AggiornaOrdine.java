package com.example.java_project_servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "AggiornaOrdine", value = "/aggiornaOrdine")
public class AggiornaOrdine extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Parse the order ID and new quantity from the POST request parameters
        int idOrdine = Integer.parseInt(request.getParameter("id_ordine"));
        int nuovaQuantita = Integer.parseInt(request.getParameter("quantita"));

        // Get the current HTTP session and retrieve the user ID
        HttpSession session = request.getSession();
        int idUtente = (int) session.getAttribute("Id");

        // Create a new database connection object
        DBConnection conn = new DBConnection();

        try {
            // Retrieve the existing order to get product ID and previous quantity
            ResultSet ordineRes = conn.selectQuery("SELECT ID_Prodotto, Quantita FROM ordini WHERE ID = " + idOrdine);
            if (ordineRes.next()) {
                int idProdotto = ordineRes.getInt("ID_Prodotto");
                int quantitaPrecedente = ordineRes.getInt("Quantita");

                // Retrieve the current available quantity and price of the product
                ResultSet prodottoRes = conn
                        .selectQuery("SELECT Prezzo, Quantita FROM prodotti WHERE ID = " + idProdotto);
                if (prodottoRes.next()) {
                    double prezzo = prodottoRes.getDouble("Prezzo");
                    int quantitaDisponibile = prodottoRes.getInt("Quantita");

                    // Calculate the difference between new and old quantity
                    int differenza = nuovaQuantita - quantitaPrecedente;
                    int nuovaQuantitaProdotto = quantitaDisponibile - differenza;

                    // If the new quantity exceeds availability, redirect with error
                    if (nuovaQuantitaProdotto < 0) {
                        response.sendRedirect("carrello.jsp?error=quantita_superiore");
                        return;
                    }

                    // Update the product quantity in the database
                    // Also set availability to 0 if quantity reaches zero
                    conn.updateQuery("UPDATE prodotti SET Quantita = " + nuovaQuantitaProdotto +
                            (nuovaQuantitaProdotto == 0 ? ", Disponibilita = 0" : "") +
                            " WHERE ID = " + idProdotto);

                    // Calculate the new subtotal for the order
                    double nuovoSubTotale = prezzo * nuovaQuantita;

                    // Update the order record with new quantity and subtotal
                    String updateOrdine = "UPDATE ordini SET Quantita = " + nuovaQuantita +
                            ", SubTotale = " + nuovoSubTotale +
                            " WHERE ID = " + idOrdine;
                    conn.updateQuery(updateOrdine);
                }
            }

        } catch (SQLException e) {
            // Print SQL exceptions to the console for debugging
            e.printStackTrace();
        }

        // After updating, redirect the user back to the shopping cart page
        response.sendRedirect("carrello.jsp");
    }
}
