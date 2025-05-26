package com.example.java_project_servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "AddToCart", value = "/addToCart")
public class AddToCart extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the product ID and quantity from the POST request parameters
        int idProdotto = Integer.parseInt(request.getParameter("idObj"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));

        // Get the current HTTP session
        HttpSession session = request.getSession();

        // Retrieve the user ID stored in the session attribute "Id"
        int IdUtente = (int) session.getAttribute("Id");

        // Create a new database connection object
        DBConnection conn = new DBConnection();

        try {
            // Query the database to get the price and available quantity of the requested
            // product
            ResultSet res = conn.selectQuery("select Prezzo, Quantita from prodotti where ID = " + idProdotto);

            // Process the result set (there should be only one product with this ID)
            while (res.next()) {

                // Calculate the subtotal for the order (price * quantity requested)
                double subTotale = res.getDouble("Prezzo") * quantita;

                // Get the remaining quantity available in stock
                int QuantitaRestante = res.getInt("Quantita");

                // If after the purchase the quantity reaches zero, mark product as unavailable
                if ((QuantitaRestante - quantita) == 0) {
                    conn.updateQuery("Update Prodotti set Disponibilita = 0 where ID = " + idProdotto);
                } else {
                    // Otherwise, update the remaining quantity in the product table
                    conn.updateQuery("Update Prodotti set Quantita = " + (QuantitaRestante - quantita) + " where ID = "
                            + idProdotto);
                }

                // Insert the order details into the "ordini" table: user ID, product ID,
                // quantity, and subtotal
                String query = "INSERT INTO ordini(ID_Utente, ID_Prodotto, Quantita, SubTotale) " +
                        "VALUES (" + IdUtente + ", " + idProdotto + ", " + quantita + ", " + subTotale + ")";

                conn.insertQuery(query);

                // Optional: Print the user ID to the server console for debugging
                System.out.println(IdUtente);
            }
        } catch (SQLException e) {
            // Handle any SQL exceptions by printing the stack trace
            e.printStackTrace();
        }

        // After processing, redirect the user back to the shop page
        response.sendRedirect("shop.jsp");
    }
}
