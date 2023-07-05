<%@page import="java.sql.*"%>
<%
    int orderID = Integer.parseInt(request.getParameter("orderID"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem", "root", "");

        // Delete item from orders
        String deleteQuery = "DELETE FROM orders WHERE orderID = ?";
        pstmt = conn.prepareStatement(deleteQuery);
        pstmt.setInt(1, orderID);
        int deletedRows = pstmt.executeUpdate();

        if (deletedRows > 0) {
            out.print("<script> "
                    + "alert('Item successfully deleted'); "
                    + "window.location.href = '../customer/carts-list.jsp'; "
                    + "</script>");
        } else {
            out.print("<script> "
                    + "alert('Failed to delete item'); "
                    + "window.location.href = '../customer/carts-list.jsp'; "
                    + "</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        // Handle any exceptions or redirect to an error page
        String errorMessage = "An error occurred while processing your request.";
        out.print("<script> "
                + "alert('" + errorMessage + "'); "
                + "window.location.href = '../customer/carts-list.jsp'; "
                + "</script>");
    } finally {
        // Close connections and statements
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>