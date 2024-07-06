<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
    <title>List of Donations</title>
    <style>
    
    body {
            
            
             background-image: url('life.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            height: 100vh;
            margin: 0;
            padding: 0;
        }
     .link {
     		text-align:center;
             text-decoration: none;
            color: black;
            margin-top: 10px;
            display: block;
        }

        .link:hover {
             text-decoration: none;
            background-color:none;
            color:white;
    
    </style>
</head>
<body>
    <h1 style="text-align: center;">List of Donations</h1>
    <%@ page import="java.sql.*" %>
    <%@ page import="javax.sql.*" %>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OrganDonation", "root", "Soniya@777");
            stmt = conn.createStatement();
            String sql = "SELECT * FROM donors";
            rs = stmt.executeQuery(sql);
            
            out.println("<table style='width: 80%; margin: 0 auto; border: 1px solid black;'>");
            out.println("<tr>");
            out.println("<th style='border: 1px solid black; padding: 8px; text-align: center;'>ID</th>");
            out.println("<th style='border: 1px solid black; padding: 8px; text-align: center;'>Name</th>");
            out.println("<th style='border: 1px solid black; padding: 8px; text-align: center;'>Organ Name</th>");
            out.println("<th style='border: 1px solid black; padding: 8px; text-align: center;'>Blood Group</th>");
            out.println("</tr>");
            
            // Output table rows
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td style='border: 1px solid black; padding: 8px; text-align: center;'>" + rs.getInt("id") + "</td>");
                out.println("<td style='border: 1px solid black; padding: 8px; text-align: left;'>" + rs.getString("name") + "</td>");
                out.println("<td style='border: 1px solid black; padding: 8px; text-align: left;'>" + rs.getString("organ_name") + "</td>");
                out.println("<td style='border: 1px solid black; padding: 8px; text-align: center;'>" + rs.getString("blood_group") + "</td>");
                out.println("</tr>");
            }
            
            // End table
            out.println("</table>");
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
    <br>
     <div class="link">
    <a href="index.jsp" class="link"><h3>Back to Home</h3></a>
    </div>
</body>
</html>