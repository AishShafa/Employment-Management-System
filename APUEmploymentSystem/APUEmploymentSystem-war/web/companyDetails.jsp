<%-- 
    Document   : companyDetails
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="header.jsp"%>
<%@include file="includes.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Company Ratings and Comments</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                height: fit-content;
            }
            .rating-listing {
                background-color: #ffffff;
                padding: 15px;
                margin-bottom: 10px;
                border-radius: 4px;
                border: 1px solid #dddddd;
                font-size: 16px;
            }
            .container {
                padding: 15px;
                box-sizing: border-box;
            }
            .rating-listing h5 {
                margin: 0;
                font-size: 18px;
                font-weight: bold;
            }
            .rating-listing p {
                margin: 0;
            }
            .btn-rate {
                background-color: #ffc107;
                color: white;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <br><br><br><br><br><br><br><br>
            <h2>Company Ratings and Comments</h2>

            <!-- Check if user is logged in -->
            <%
                String employeeEmail = (String) session.getAttribute("email");
                String companyName = request.getParameter("companyName");

                if (employeeEmail == null) {
            %>
                <div class="alert alert-warning">You must be logged in to rate and comment on a company. <a href="login.jsp">Login here</a>.</div>
            <%
                } else {
            %>
                <!-- Button to rate the company -->
                <form action="Employee/ratings.jsp" method="GET">
                    <input type="hidden" name="companyName" value="<%= companyName %>">
                    <input type="hidden" name="jobId" value=""> <!-- Leave jobId blank -->
                    <button type="submit" class="btn btn-rate">Rate This Company</button>
                </form>
            <%
                }
            %>

            <!-- Dynamic Ratings and Comments Listing -->
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    // Load the JDBC driver (Adjust for your DB)
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

                    // Query the RATINGS table to get all ratings and comments for the selected company
                    String sql = "SELECT CAST(FROMWHO AS VARCHAR(255)) AS FROMWHO, RATING, COMMENT, WHATDATE FROM RATINGS WHERE CAST(TOWHO AS VARCHAR(255)) = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, companyName);
                    rs = ps.executeQuery();

                    // Loop through the results and display each rating and comment
                    boolean hasRatings = false;
                    while (rs.next()) {
                        hasRatings = true;
            %>
                        <div class="rating-listing">
                            <h5>Rated by: <%= rs.getString("FROMWHO") %></h5>
                            <p>Rating: <%= rs.getInt("RATING") %> / 5</p>
                            <p>Comment: <%= rs.getString("COMMENT") %></p>
                            <p>Date: <%= rs.getDate("WHATDATE") %></p>
                        </div>
            <%
                    }
                    
                    if (!hasRatings) {
            %>
                        <div class="alert alert-info">No ratings or comments available for this company.</div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                    <div class="alert alert-danger">An error occurred while retrieving the company details.</div>
            <%
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (ps != null) try { ps.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                }
            %>
        </div>

        <footer class="text-center mt-5">
            <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
        </footer>
    </body>
</html>