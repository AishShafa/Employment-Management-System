<%-- 
    Document   : update_vacancy
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="../header.jsp" %>
<%@include file="../includes.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Vacancy</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .form-container {
            background-color: #ffffff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            border: 1px solid #dddddd;
        }
        .form-container h3 {
            margin-bottom: 15px;
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
    <div class="form-container">
        <br><br><br><br><br><br><br><br>
        <h3>Update Job Posting</h3>

        <%
            int vacancyId = Integer.parseInt(request.getParameter("vacancyId"));
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            String jobTitle = "";
            String companyName = "";
            String salaryRange = "";
            String jobType = "";
            String qualification = "";
            String location = "";
            String experience = "";
            String sector = "";
            String jobDescription = "";
            String closingDate = "";

            try {
                // Load the JDBC driver
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

                // Query the VACANCY table to get the selected job posting details
                String sql = "SELECT * FROM VACANCY WHERE ID = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, vacancyId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    jobTitle = rs.getString("JOBTITLE");
                    companyName = rs.getString("COMPANYNAME");
                    salaryRange = rs.getString("SALARYRANGE");
                    jobType = rs.getString("JOBTYPE");
                    qualification = rs.getString("QUALIFICATION");
                    location = rs.getString("LOCATION");
                    experience = rs.getString("EXPERIENCE");
                    sector = rs.getString("SECTOR");
                    jobDescription = rs.getString("JOBDESCRIPTION");
                    closingDate = rs.getString("CLOSINGDATE");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>

        <form method="POST" action="${pageContext.request.contextPath}/UpdateDeleteVacancyServlet?action=update&vacancyId=<%= vacancyId %>">
            <input type="hidden" name="vacancyId" value="<%= vacancyId %>">
            <div class="form-group">
                <label for="jobTitle">Job Title:</label>
                <input type="text" class="form-control" id="jobTitle" name="jobTitle" value="<%= jobTitle %>" required>
            </div>
            <div class="form-group">
                <label for="companyName">Company Name:</label>
                <input type="text" class="form-control" id="companyName" name="companyName" value="<%= companyName %>" required>
            </div>
            <div class="form-group">
                <label for="salaryRange">Salary Range:</label>
                <input type="text" class="form-control" id="salaryRange" name="salaryRange" value="<%= salaryRange %>" required>
            </div>
            <div class="form-group">
                <label for="jobType">Job Type:</label>
                <input type="text" class="form-control" id="jobType" name="jobType" value="<%= jobType %>" required>
            </div>
            <div class="form-group">
                <label for="qualification">Qualification:</label>
                <input type="text" class="form-control" id="qualification" name="qualification" value="<%= qualification %>" required>
            </div>
            <div class="form-group">
                <label for="location">Location:</label>
                <input type="text" class="form-control" id="location" name="location" value="<%= location %>" required>
            </div>
            <div class="form-group">
                <label for="experience">Experience:</label>
                <input type="text" class="form-control" id="experience" name="experience" value="<%= experience %>" required>
            </div>
            <div class="form-group">
                <label for="sector">Sector:</label>
                <input type="text" class="form-control" id="sector" name="sector" value="<%= sector %>" required>
            </div>
            <div class="form-group">
                <label for="jobDescription">Job Description:</label>
                <textarea class="form-control" id="jobDescription" name="jobDescription" rows="5" required><%= jobDescription %></textarea>
            </div>
            <div class="form-group">
                <label for="closingDate">Closing Date:</label>
                <input type="date" class="form-control" id="closingDate" name="closingDate" value="<%= closingDate %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Vacancy</button>
        </form>
    </div>
</div>
            <footer class="text-center mt-5">
        <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
    </footer>
    </body>
</html>
