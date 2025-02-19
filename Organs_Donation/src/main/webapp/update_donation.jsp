<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Donation</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial;
            
            background-image: url('life.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            height: 100vh;
            margin: 0;
            padding: 0;
        }

        .center-form {
            background-color: peachpuff; 
            padding: 40px; 
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 300px; 
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        input[type="number"],
        input[type="text"] {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color:black;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: white;
            color:black;
        }
    </style>
</head>
<body>
    <div class="center-form">
        <h1>Update Donation</h1>
        <form action="DonationServlet" method="post">
            <input type="hidden" name="action" value="update">
            ID: <input type="number" name="id"><br>
            Another Organ Name: <input type="text" name="organ_name"><br>
            <input type="submit" value="Update Donation">
        </form>
    </div>
</body>
</html>
