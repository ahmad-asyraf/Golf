



<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete</title>
    </head>
    <body>
        <%@ page import="java.sql.*" %>
        <%@ page import="javax.sql.*" %>
        <%
            PrintWriter pw = response.getWriter();
            String id = request.getParameter("promoID");
            Connection con = null;
            Statement stmt = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem", "root", "");
                stmt = con.createStatement();
                int i = stmt.executeUpdate("DELETE FROM promotion WHERE promoID='" + id + "'");
                if (i > 0) {
                    pw.println("<script type='text/javascript'>");
                    pw.println("alert('Successful Delete');");
                    pw.println("window.location.href = '../owner/view-promotion.jsp';");
                    pw.println("</script>");
                } else {
                    pw.println("<script type='text/javascript'>");
                    pw.println("alert('Delete Failed');");
                    pw.println("window.location.href = '../owner/view-promotion.jsp';");
                    pw.println("</script>");
                }
            } catch (Exception e) {
                pw.println("<script type='text/javascript'>");
                pw.println("alert('Error: " + e + "');");
                pw.println("window.location.href = '../owner/view-promotion.jsp';");
                pw.println("</script>");
            } finally {
                try {
                    if (stmt != null) {
                        stmt.close();
                    }
                } catch (Exception e) {
                }
                try {
                    if (con != null) {
                        con.close();
                    }
                } catch (Exception e) {
                }
            }
        %>
    </body>
</html>

