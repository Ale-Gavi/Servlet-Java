package com.example.java_project_servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "Login", value = "/login") // Servlet mapped to /login URL
public class HelloServlet extends HttpServlet {
    private String message;

    // Called once when servlet is first initialized by the server
    public void init() {
        message = "Hello World!"; // Just a sample message (not used further here)
    }

    // Handles GET requests (e.g., when user navigates to /login)
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Set the response content type to HTML with UTF-8 encoding
        response.setContentType("text/html; charset=utf-8");

        // Get a PrintWriter to send output (HTML) to the client
        PrintWriter out = response.getWriter();

        // Write the full HTML page for the login form
        out.println("<!DOCTYPE html>\n" +
                "<html lang=\"it\">\n" +
                "<head>\n" +
                "  <meta charset=\"UTF-8\" />\n" +
                "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n" +
                "  <title>Login</title>\n" +
                "  <link rel=\"stylesheet\" href=\"./CSS/login.css\" />\n" + // Link to external CSS for styling
                "</head>\n" +
                "<body class=\"darkMode\">\n" + // Default body has dark mode enabled
                "    <div class=\"content\">\n" +
                "        <div class=\"wrapper\">\n" +
                "            <form action=\"CheckLogin\" method=\"post\" id=\"form\">\n" + // Form submits to CheckLogin
                                                                                           // servlet
                "                <h2>Login al Progetto</h2>\n" +

                "                <div class=\"input-wrapper\">\n" +
                "                    <label for=\"username\">Username</label>\n" +
                "                    <input type=\"text\" name=\"username\" id=\"username\" required autocomplete=\"off\" placeholder=\"Inserisci username\" />\n"
                +
                "                </div>\n" +

                "                <div class=\"input-wrapper\">\n" +
                "                    <label for=\"password\">Password</label>\n" +
                "                    <input type=\"password\" name=\"password\" id=\"password\" required autocomplete=\"off\" placeholder=\"Inserisci password\" />\n"
                +
                "                </div>\n" +

                "                <div class=\"submit\">\n" +
                "                    <input type=\"submit\" value=\"Accedi\"/>\n" + // Submit button
                "                </div>\n" +
                "            </form>\n" +

                "            <button onclick=\"DarkMode()\" id=\"darkMode\">☀️ - Light Mode</button>\n" + // Button
                                                                                                          // toggles
                                                                                                          // dark/light
                                                                                                          // mode

                "            <div class=\"exit\">\n" +
                "                <a href=\"index.jsp\"><button>Exit</button></a>\n" + // Exit button linking to
                                                                                      // index.jsp
                "            </div>\n" +
                "        </div>\n" +

                "        <footer>Questo progetto è a scopo didattico</footer>\n" + // Footer note
                "    </div>\n" +
                "</body>\n" +

                "<script>\n" +
                "        const DarkMode = () => {\n" +
                "            const body = document.body;\n" +
                "            body.classList.toggle('darkMode');\n" + // Toggle darkMode class on body
                "\n" +
                "            if (body.classList.contains('darkMode')) {\n" +
                "            document.getElementById('darkMode').textContent = '☀️ - Light Mode';\n" + // Change button
                                                                                                       // text
                "\n" +
                "            } else {\n" +
                "            document.getElementById('darkMode').textContent = '🌙 - Dark Mode';\n" +
                "            }\n" +
                "        }\n" +
                "    </script>\n" +
                "</html>\n");
    }

    // POST method left empty because login form submits to CheckLogin servlet
    // instead
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    // Called when servlet is destroyed, resource cleanup could be done here if
    // needed
    public void destroy() {
    }
}
