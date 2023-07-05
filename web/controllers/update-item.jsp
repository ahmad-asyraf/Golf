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

            String itemID = request.getParameter("itemID");
            String itemName = request.getParameter("itemName");
            String itemDesc = request.getParameter("itemDesc");
            int itemQuantity = Integer.parseInt(request.getParameter("itemQuantity"));
            double itemPrice = Double.parseDouble(request.getParameter("itemPrice"));

            String sql = "UPDATE item SET itemName = ?, itemDesc = ?, itemQuantity = ?, itemPrice = ? WHERE itemID = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, itemName);
            statement.setString(2, itemDesc);
            statement.setInt(3, itemQuantity);
            statement.setDouble(4, itemPrice);
            statement.setString(5, itemID);

            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert('Update successful!');");
                out.print("location='../owner/view-item.jsp';");
                out.print("</script>");
            } else {
                out.print("<script type=\"text/javascript\">");
                out.print("alert('Update Failed!');");
                out.print("location='../owner/view-item.jsp';");
                out.print("</script>");
            }

            statement.close();
            con.close();
        %>
    </body>
</html>