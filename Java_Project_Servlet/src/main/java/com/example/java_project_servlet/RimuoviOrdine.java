package com.example.java_project_servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RimuoviOrdine", value = "/rimuoviOrdine") // Servlet mapped to URL /rimuoviOrdine
public class RimuoviOrdine extends HttpServlet {
    // Handles POST requests to remove an order
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the order ID from the request parameter named "id_ordine"
        int idProdotto = Integer.parseInt(request.getParameter("id_ordine"));

        // Create a new database connection instance
        DBConnection conn = new DBConnection();

        // Execute a DELETE SQL statement to remove the order by ID from the "ordini"
        // table
        boolean ok = conn.updateQuery("delete from ordini where ID = " + idProdotto);

        // Print the ID of the deleted order to server console (for debugging)
        System.out.println(idProdotto);

        // Redirect the client back to the shopping cart page after deletion
        response.sendRedirect("carrello.jsp");
    }
}
