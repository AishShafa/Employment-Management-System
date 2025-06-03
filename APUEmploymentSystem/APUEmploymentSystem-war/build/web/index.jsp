<%-- 
    Document   : index
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jobseeker Home Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            height:fit-content;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .filter-bar {
            background-color: #ffffff;
            padding: 15px;
            border-bottom: 1px solid #dddddd;
            margin-bottom: 20px;
        }
        .filter-bar select {
            margin-right: 10px;
            margin-bottom: 10px;
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
        .filter-bar .btn {
            background-color: #00aabb;
            color: white;
        }
        .apply-btn, .rate-btn {
            margin-top: 10px;
        }
        .apply-btn {
            background-color: #28a745;
            color: white;
            margin-top: 10px;
        }
        .rate-btn {
            background-color: #ffc107;
            color: white;
        }
        html {
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
        <div class="filter-bar row"></div>
         <!-- Display success message -->
        <%
            String successMessage = request.getParameter("successMessage");
            if (successMessage == null) {
                successMessage = (String) request.getAttribute("successMessage");
            }

            if (successMessage != null) {
        %>
                <div class="alert alert-success"><%= successMessage %></div>
        <%
            }
        %>

           <!-- Dynamic Job Listings -->
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                // Load the JDBC driver (Adjust for your DB)
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

                // Query the VACANCY table
                String sql = "SELECT * FROM VACANCY";  // Select all columns to show full details
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                String userRole = (String) session.getAttribute("role"); // Get the user role from the session

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

                        <%
                            // Show Apply button if the user is logged in as an Employee
                            if ("Employee".equalsIgnoreCase(userRole)) {
                        %>
                            <form action="ApplyJobServlet" method="POST">
                                <input type="hidden" name="jobId" value="<%= rs.getInt("ID") %>">
                                <button type="submit" class="btn apply-btn">Apply for this job</button>
                            </form>
                                <form action="Employee/ratings.jsp" method="GET" style="display:inline;">
                                    <input type="hidden" name="jobId" value="<%= rs.getInt("ID") %>">
                                    <input type="hidden" name="companyName" value="<%= rs.getString("COMPANYNAME") %>">
                                    <button type="submit" class="btn rate-btn">Rate This Job</button>
                                </form>
                        <%
                            }
                        %>
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