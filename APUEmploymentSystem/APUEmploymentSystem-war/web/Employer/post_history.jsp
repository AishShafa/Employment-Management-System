<%-- 
    Document   : post_history
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
        <title>Vacancy History Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .job-listing {
            background-color: #ffffff;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 4px;
            border: 1px solid #dddddd;
        }
        .job-listing h5 {
            margin: 0;
        }
        .job-listing p {
            margin: 0;
            font-size: 14px;
            color: #777;
        }
        .action-buttons {
            margin-top: 10px;
        }
        html,body {
            height:fit-content;
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
    <h2>Your Posting History</h2>
    
    <!-- Search Form -->
    <form method="get" action="post_history.jsp" class="mb-4">
        <input type="text" name="searchTitle" class="form-control" placeholder="Search by job title">
        <button type="submit" class="btn btn-primary mt-2">Search</button>
    </form>

    <!-- Dynamic Job Listings for Employer -->
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String employerEmail = (String) session.getAttribute("email"); // Get the logged-in employer's email
        String searchTitle = request.getParameter("searchTitle");

        try {
            // Load the JDBC driver (Adjust for your DB)
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

            // Query the VACANCY table to get jobs posted by the logged-in employer
            String sql = "SELECT * FROM VACANCY WHERE EMPLOYEREMAIL = ?";
            if (searchTitle != null && !searchTitle.trim().isEmpty()) {
                sql += " AND JOBTITLE LIKE ?";
            }
            ps = conn.prepareStatement(sql);
            ps.setString(1, employerEmail); // Set the employer email as the filter
            if (searchTitle != null && !searchTitle.trim().isEmpty()) {
                ps.setString(2, "%" + searchTitle + "%"); // Set the search filter for job title
            }
            rs = ps.executeQuery();

            // Loop through the results and display each job
            while (rs.next()) {
    %>
                <div class="job-listing">
                    <h5><%= rs.getString("JOBTITLE") %></h5>
                    <p>Company: <%= rs.getString("COMPANYNAME") %></p>
                    <p>Salary: <%= rs.getString("SALARYRANGE") %> / Location: <%= rs.getString("LOCATION") %></p>
                    <p>Job Type: <%= rs.getString("JOBTYPE") %></p>
                    <p>Experience Required: <%= rs.getString("EXPERIENCE") %></p>
                    <p>Qualification: <%= rs.getString("QUALIFICATION") %></p>
                    <p>Sector: <%= rs.getString("SECTOR") %></p>
                    <p>Closing Date: <%= rs.getString("CLOSINGDATE") %></p>
                    <p>Job Description: <%= rs.getString("JOBDESCRIPTION") %></p>

                    <div class="action-buttons">
                        <br>
                        <form method="POST" action="update_vacancy.jsp">
                            <input type="hidden" name="vacancyId" value="<%= rs.getInt("ID") %>">
                            <button type="submit" name="action" value="update" class="btn btn-warning">Update</button>
                        </form>
                            <br>
                        <form method="POST" action="${pageContext.request.contextPath}/UpdateDeleteVacancyServlet" style="display:inline;">
                            <input type="hidden" name="vacancyId" value="<%= rs.getInt("ID") %>">
                            <button type="submit" name="action" value="delete" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
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
