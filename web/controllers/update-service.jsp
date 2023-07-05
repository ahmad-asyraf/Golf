<%@page import="java.io.PrintWriter"%>
<%@page language="java" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Register</title>
    </head>
    <body> 
        <%
            Class.forName("com.mysql.jdbc.Driver");
            String db_url = "jdbc:mysql://localhost:3306/golfshopmanagementsystem";
            Connection con = DriverManager.getConnection(db_url, "root", "");

            String serviceid = request.getParameter("serviceid");
            String servicename = request.getParameter("servicename");
            String serviceprice = request.getParameter("serviceprice");

            String sql = "UPDATE service SET servicename = ?, serviceprice = ? WHERE serviceid = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, servicename);
            statement.setString(2, serviceprice);
            statement.setString(3, serviceid);

            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert('Update successful!');");
                out.print("location='../owner/view-service.jsp';");
                out.print("</script>");
            } else {
                out.print("<script type=\"text/javascript\">");
                out.print("alert('Update Failed!');");
                out.print("location='../owner/view-service.jsp';");
                out.print("</script>");
            }

            statement.close();
            con.close();
        %>
    </body>
</html>