<%--
  Created by IntelliJ IDEA.
  User: alega
  Date: 15/05/2025
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        session.invalidate();
    %>
    <script>
        window.location.href = "login";
    </script>
</body>
</html>
