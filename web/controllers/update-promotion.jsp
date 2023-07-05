<%@page import="java.io.PrintWriter"%>
<%@page language="java" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Update</title>
    </head>
    <body> 
        <%
            Class.forName("com.mysql.jdbc.Driver");
            String db_url = "jdbc:mysql://localhost:3306/golfshopmanagementsystem";
            Connection con = DriverManager.getConnection(db_url, "root", "");

            String promoID = request.getParameter("promoID");
            String promovalue = request.getParameter("promovalue");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            String sql = "UPDATE promotion SET promovalue = ?, startDate = ?, endDate = ? WHERE promoID = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, promovalue);
            statement.setString(2, startDate);
            statement.setString(3, endDate);
            statement.setString(4, promoID);

            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert('Update successful!');");
                out.print("location='../owner/view-promotion.jsp';");
                out.print("</script>");
            } else {
                out.print("<script type=\"text/javascript\">");
                out.print("alert('Update Failed!');");
                out.print("location='../owner/view-promotion.jsp';");
                out.print("</script>");
            }
            statement.close();
            con.close();
        %>
    </body>
</html>