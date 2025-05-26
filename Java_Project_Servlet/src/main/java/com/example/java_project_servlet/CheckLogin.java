package com.example.java_project_servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "CheckLogin", value = "/CheckLogin")
public class CheckLogin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Currently no implementation for GET requests
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve username and password submitted from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Get the current HTTP session
        HttpSession session = request.getSession();

        // Create a new database connection
        DBConnection conn = new DBConnection();

        try {
            // Query the database to get user data matching the given username
            ResultSet res = conn.selectQuery("select * from utenti where username = '" + username + "'");

            // Loop through the results (there should be at most one user per username)
            while (res.next()) {
                // Check if the password from the database matches the one provided
                if (res.getString("Password").equals(password)) {

                    // If password matches, save user details in the session
                    session.setAttribute("Username", username);
                    session.setAttribute("Password", password);
                    session.setAttribute("Id", res.getInt("ID"));

                    // Forward the user to the main shop page
                    RequestDispatcher dispatcher = request.getRequestDispatcher("shop.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // If password does not match, forward to an error page
                    RequestDispatcher dispatcher = request.getRequestDispatcher("ErrorPage.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (SQLException e) {
            // Print any SQL exceptions for debugging
            e.printStackTrace();
        }
    }
}
