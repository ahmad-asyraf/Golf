<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Orders</title>
    </head>
    <body>
        <%
            int userID = Integer.parseInt(request.getParameter("custID"));
            int itemID = Integer.parseInt(request.getParameter("itemID"));
            int quantity = Integer.parseInt(request.getParameter("orderquantity"));
            double price = Double.parseDouble(request.getParameter("itemPrice"));

            double total = price * quantity;
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem", "root", "");

                // Insert into orders table
                String orderQuery = "INSERT INTO orders (itemID, custID, quantity, totalPrice) VALUES (?, ?, ?, ?)";
                pstmt = conn.prepareStatement(orderQuery);
                pstmt.setInt(1, itemID);
                pstmt.setInt(2, userID);
                pstmt.setInt(3, quantity);
                pstmt.setDouble(4, price);
                int addItem = pstmt.executeUpdate();

                // Continue with any additional logic or redirect to a success page
                if (addItem > 0) {
                    out.print("<script> "
                            + "alert('Item successfully added to your cart'); "
                            + "window.location.href = '../customer/carts-list.jsp'; "
                            + "</script>");
                } else {
                    out.print("<script> "
                            + "alert('Failed to add item to your cart'); "
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
                try {
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>
