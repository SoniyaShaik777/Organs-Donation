<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Organ Donation System</title>
    
    <style>
        body, html {
            height: 100%;
            margin: 0;
            overflow: hidden;
        }

        body {
            background-image: url('life.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            height: 100vh;
            
            padding: 0;
        }

        .container {
            display: flex;
            flex-direction: column;
            height: 100%;
            align-items: center;
            justify-content: center;
        }

        .header {
            
            margin-bottom: 20px;
        }

        .links {
            text-align: center;
            margin-bottom: 20px;
            
        }

        .links a {
            display: block;
            margin: 10px;
            padding: 10px 20px;
            text-decoration: none;
            color: #000;
            border: 1px solid #000;
            background-color: #f1f1f1;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .links a:hover {
            background-color: #000;
            color: #fff;
        }

        .footer-links {
            text-align: center;
        }

        .footer-links a {
            margin: 5px;
            text-decoration: none;
            color: #000;
        }
        .message {
            color: blue;
            font-weight: bold;
            padding: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="header">DONATE LIFE - DONATE ORGAN</h1>
        <% 
            String message = request.getParameter("message");
            if ("add_success".equals(message)) {
        %>
            <div class="message">Thank you! Donation added successfully.</div>
        <% 
            } else if ("delete_success".equals(message)) {
        %>
            <div class="message"><h3>Donation deleted successfully.</h3></div>
        <% 
            } else if ("update_success".equals(message)) {
        %>
            <div class="message">Donation updated successfully.</div>
        <% 
            }
        %>
        
        <div class="links">
            <a href="add_donation.jsp">Add Donation</a>
            <a href="list_donations.jsp">List of Donations</a>
            <a href="update_donation.jsp">Update Donation</a>
            <a href="delete_donation.jsp">Delete Donation</a>
        </div>
        
        <div class="footer-links">
            <a href="login.jsp">Login</a> |
            <a href="register.jsp">Register</a> |
            <a href="logout">Logout</a>
        </div>
    </div>
</body>
</html>
