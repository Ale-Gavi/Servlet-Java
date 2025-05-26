<%--
  Created by IntelliJ IDEA.
  User: alega
  Date: 15/05/2025
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>  <%-- Set content type and language --%>

<html>
<head>
    <title>Title</title>  <%-- Page title (generic) --%>
</head>
<body>
    <%
        // Invalidate the current user session to log out the user
        session.invalidate();
    %>

    <script>
        // Redirect the user to the login page after session invalidation
        window.location.href = "login";
    </script>
</body>
</html>
