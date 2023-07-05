<%-- 
    Document   : error
    Created on : 5 Jul 2023, 7:24:10 pm
    Author     : Asyraf
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
    <center>
        <h1>Failed to process the request.</h1>
        <%
            out.print(exception);
        %>
    </center>
</body>
</html>
