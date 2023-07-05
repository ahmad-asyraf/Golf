<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Add Item</title>
    </head>
    <body>
        <%
            String itemID = request.getParameter("itemID");
            String itemName = request.getParameter("itemName");
            String itemDesc = request.getParameter("itemDesc");
            String itemQuantityStr = request.getParameter("itemQuantity"); // Retrieve the value of itemQuantity
            int itemQuantity = Integer.parseInt(itemQuantityStr); // Parse itemQuantity as an integer
            String itemPrice1 = request.getParameter("itemPrice");
            int itemPrice2 = Integer.parseInt(itemPrice1);

            PreparedStatement ps1 = null;
            PreparedStatement ps2 = null;
            ResultSet rs = null;
            Connection conn = null;

            String query1 = "SELECT itemID from item WHERE itemID=?";
            String query2 = "INSERT INTO item(itemID,ItemName,itemDesc,itemQuantity,itemPrice) VALUES(?,?,?,?,?)";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem", "root", "");
                ps1 = conn.prepareStatement(query1);
                ps1.setString(1, itemID);
                rs = ps1.executeQuery();
                if (!rs.next()) {
                    ps2 = conn.prepareStatement(query2);;
                    ps2.setString(1, itemID);
                    ps2.setString(2, itemName);
                    ps2.setString(3, itemDesc);
                    ps2.setInt(4, itemQuantity);
                    ps2.setInt(5, itemPrice2);

                    int i = ps2.executeUpdate();
                    response.sendRedirect("../owner/view-item.jsp");
                } else {
                    response.sendRedirect("../owner/homepage.jsp");
                }
            } catch (Exception e) {
                out.println(e);
            }
        %>
    </body>
</html>