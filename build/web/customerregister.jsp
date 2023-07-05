
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Register</title>
</head>
<body>
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
          
                String custid1=request.getParameter("custid");
		String firstname1=request.getParameter("firstname");
		String lastname1=request.getParameter("lastname");
		String email1=request.getParameter("email");
		String phoneno1=request.getParameter("phoneno");
		String address1=request.getParameter("address");
		String pass1=request.getParameter("pass1");
		String pass2=request.getParameter("pass2");

		PreparedStatement ps1=null;
		PreparedStatement ps2=null;
		Connection conn=null;
		ResultSet rs=null;
	
		String query1="SELECT custid from customer WHERE custid=?";
		String query2="INSERT INTO customer(custid,firstname,lastname,email,phoneno,address,pass1,pass2) VALUES(?,?,?,?,?,?,?,?)";

		try{		
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem","root","");
			ps1=conn.prepareStatement(query1);
			ps1.setString(1,custid1);
			rs=ps1.executeQuery();
			if(rs.next())
			{
				response.sendRedirect("registererror1-cust.html");
			}
			else
			{
				if(pass1.equals(pass2))
				{
					ps2=conn.prepareStatement(query2);
					ps2.setString(1,custid1);
					ps2.setString(2,firstname1);
					ps2.setString(3,lastname1);
					ps2.setString(4,email1);
					ps2.setString(5,phoneno1);
                                        ps2.setString(6,address1);
                                        ps2.setString(7,pass1);
                                        ps2.setString(8,pass2);
					int i=ps2.executeUpdate();
					response.sendRedirect("login.html");
				}
				else
					response.sendRedirect("registererror2-cust.html");
		}
}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>
