<%-- 
    Document   : view_notifications
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp" %>
<%@include file="../includes.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Notifications</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .notification-listing {
                background-color: #ffffff;
                padding: 15px;
                margin-bottom: 10px;
                border-radius: 4px;
                border: 1px solid #dddddd;
            }
            .notification-listing h5 {
                margin: 0;
            }
            .notification-listing p {
                margin: 0;
                font-size: 14px;
                color: #777;
            }
            html, body {
                height: fit-content;
            }
            .container-fluid {
                padding: 15px;
                box-sizing: border-box;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <br><br><br><br><br><br><br><br>
            <h2>Your Notifications</h2>

            <!-- Dynamic Notification Listings for Employee -->
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String employeeEmail = (String) session.getAttribute("email"); // Get the logged-in employee's email

                try {
                    // Load the JDBC driver (Adjust for your DB)
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

                    // Query the NOTIFICATIONS table to get notifications for the logged-in employee
                    String sql = "SELECT * FROM NOTIFICATIONS WHERE CAST(TOWHO AS VARCHAR(128)) = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, employeeEmail); // Set the employee email as the filter
                    rs = ps.executeQuery();

                    // Loop through the results and display each notification
                    boolean hasResults = false; // To check if there are any results
                    while (rs.next()) {
                        hasResults = true;
            %>
                        <div class="notification-listing">
                            <h5>From: <%= rs.getString("FROMWHO") %></h5>
                            <p>Date: <%= rs.getDate("WHATDATE") %></p>
                            <p>Message: <%= rs.getString("MESSAGE") %></p>
                        </div>
            <%
                    }
                    
                    if (!hasResults) {
            %>
                        <p>No notifications found.</p>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                }
            %>
        </div>

        <footer class="text-center mt-5">
            <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
        </footer>
    </body>
</html>