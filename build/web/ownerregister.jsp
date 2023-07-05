

<html>
<head>
<meta charset="ISO-8859-1">
<title>Owner Register</title>
</head>
<body>
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
            	String ownerid1=request.getParameter("ownerid");
		String ownername1=request.getParameter("ownername");
		String email1=request.getParameter("email");
		String phoneno1=request.getParameter("phoneno");
		String pass1=request.getParameter("pass1");
		String pass2=request.getParameter("pass2");

		PreparedStatement ps1=null;
		PreparedStatement ps2=null;
		Connection conn=null;
		ResultSet rs=null;
	
		String query1="SELECT ownerid from owner WHERE ownerid=?";
		String query2="INSERT INTO owner(ownerid,ownername,email,phoneno,pass1,pass2) VALUES(?,?,?,?,?,?)";

		try{		
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem","root","");
			ps1=conn.prepareStatement(query1);
			ps1.setString(1,ownerid1);
			rs=ps1.executeQuery();
			if(rs.next())
			{
                        response.sendRedirect("ownerregister.html");
			}
			else
			{
				if(pass1.equals(pass2))
				{
					ps2=conn.prepareStatement(query2);
					ps2.setString(1,ownerid1);
					ps2.setString(2,ownername1);
					ps2.setString(3,email1);
					ps2.setString(4,phoneno1);
					ps2.setString(5,pass1);
					ps2.setString(6,pass2);
					int i=ps2.executeUpdate();
					response.sendRedirect("login.html");
				}
				else
                                  response.sendRedirect("registererror2-owner.html");
		}
}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>

