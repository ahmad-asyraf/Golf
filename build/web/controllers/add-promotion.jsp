
<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String promoID = request.getParameter("promoID");
    String promovalue = request.getParameter("promovalue");
    String startDateString = request.getParameter("startDate");
    String endDateString = request.getParameter("endDate");

    Connection conn = null;
    PreparedStatement ps1 = null;
    PreparedStatement ps2 = null;
    ResultSet rs = null;

    String query1 = "SELECT promoID FROM promotion WHERE promoID=?";
    String query2 = "INSERT INTO promotion(promoID, promovalue, startDate, endDate) VALUES (?, ?, ?, ?)";

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a database connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem", "root", "");

        // Prepare the first query to check if the promoID already exists
        ps1 = conn.prepareStatement(query1);
        ps1.setString(1, promoID);
        rs = ps1.executeQuery();

        if (!rs.next()) {
            // The promoID doesn't exist, so proceed with inserting the new promotion
            ps2 = conn.prepareStatement(query2);
            ps2.setString(1, promoID);
            ps2.setString(2, promovalue);

            // Convert and set the startDate and endDate parameters to the correct format
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            Date startDate = dateFormat.parse(startDateString);
            Date endDate = dateFormat.parse(endDateString);

            ps2.setDate(3, new java.sql.Date(startDate.getTime()));
            ps2.setDate(4, new java.sql.Date(endDate.getTime()));

            int rowsAffected = ps2.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("ViewPromotion.jsp");
            } else {
                out.println("Failed to add the promotion.");
            }
        } else {
            response.sendRedirect("homepage.jsp");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close all database resources
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps1 != null) {
            try {
                ps1.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps2 != null) {
            try {
                ps2.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
