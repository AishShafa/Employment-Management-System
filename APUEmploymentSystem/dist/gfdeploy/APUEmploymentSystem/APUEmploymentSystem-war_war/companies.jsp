<%-- 
    Document   : companies
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
        <title>Companies List</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                height: fit-content;
            }
            .company-listing {
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
            .company-listing h5 {
                margin: 0;
                font-size: 18px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <br><br><br><br><br><br><br><br>
            <h2>List of Companies</h2>
            <!-- Dynamic Company Listings -->
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                PreparedStatement ratingPs = null;
                ResultSet ratingRs = null;

                try {
                    // Load the JDBC driver (Adjust for your DB)
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

                    // Query the VACANCY table to get distinct company names, casting to VARCHAR to avoid comparison issues
                    String sql = "SELECT DISTINCT CAST(COMPANYNAME AS VARCHAR(255)) AS COMPANYNAME FROM VACANCY ORDER BY COMPANYNAME";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    // Loop through the results and display each company name with its average rating or "Unrated"
                    while (rs.next()) {
                        String companyName = rs.getString("COMPANYNAME");

                        // Calculate the total rating for the company from the RATINGS table
                        String ratingSql = "SELECT SUM(RATING) AS totalRating, COUNT(*) AS ratingCount FROM RATINGS WHERE CAST(TOWHO AS VARCHAR(255)) = ?";
                        ratingPs = conn.prepareStatement(ratingSql);
                        ratingPs.setString(1, companyName);
                        ratingRs = ratingPs.executeQuery();

                        double averageRating = 0.0;
                        String ratingText = "Unrated";

                        if (ratingRs.next()) {
                            int totalRating = ratingRs.getInt("totalRating");
                            int ratingCount = ratingRs.getInt("ratingCount");

                            if (ratingCount > 0) {
                                // Correct calculation: total rating divided by the number of ratings
                                averageRating = totalRating / (double) ratingCount;
                                ratingText = String.format("%.2f / 5.00", averageRating);
                            }
                        }
            %>
                        <div class="company-listing">
                            <h5><a href="companyDetails.jsp?companyName=<%= companyName %>"><%= companyName %></a></h5>
                            <p>Average Rating: <%= ratingText %></p>
                        </div>
            <%
                        if (ratingRs != null) ratingRs.close();
                        if (ratingPs != null) ratingPs.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                    <div class="alert alert-danger">An error occurred while retrieving the companies list.</div>
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