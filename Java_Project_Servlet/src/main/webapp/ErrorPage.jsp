<%--
  Created by IntelliJ IDEA.
  User: alega
  Date: 15/05/2025
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>  <%-- Set page content type and language --%>

<!DOCTYPE html>
<html lang="it">
    <head>
        <meta charset="UTF-8">
        <title>Login Fallito</title>  <%-- Page title: Login Failed --%>

        <script>
            // When the page loads, show an alert notifying the user of failed login
            window.onload = function() {
                alert("Login Fallito - Credenziali Errate");  // Alert message
                
                // Redirect user to Logout.jsp (likely to clear session or go back to login)
                window.location.href = "Logout.jsp";
            };
        </script>
    </head>
    <body>
        <%-- Empty body since all logic is handled in JavaScript on page load --%>
    </body>
</html>
