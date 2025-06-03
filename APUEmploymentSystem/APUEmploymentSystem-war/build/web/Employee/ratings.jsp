<%-- 
    Document   : ratings
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="../header.jsp"%>
<%@include file="../includes.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Submit Rating</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            height: fit-content;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            padding: 15px;
            box-sizing: border-box;
            background-color: #ffffff;
            border-radius: 4px;
            border: 1px solid #dddddd;
        }
        html {
            height: fit-content;
        }
        .form-group label {
            font-weight: bold;
        }
        .btn-submit {
            background-color: #28a745;
            color: white;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <br><br><br><br><br><br><br><br>
    <h2>Submit Rating for Job</h2>
    <%
        String jobId = request.getParameter("jobId");
        String companyName = request.getParameter("companyName");
        String employeeEmail = (String) session.getAttribute("email"); // Get the logged-in employee's email

        if (jobId == null || companyName == null || employeeEmail == null) {
            out.println("<p>Error: Missing job or employee information.</p>");
        } else {
    %>
        <form action="${pageContext.request.contextPath}/RatingsServlet" method="POST">
            <input type="hidden" name="jobId" value="<%= jobId %>">
            <input type="hidden" name="companyName" value="<%= companyName %>">
            <input type="hidden" name="employeeEmail" value="<%= employeeEmail %>">

            <div class="form-group">
                <label for="rating">Rating:</label>
                <select class="form-control" name="rating" id="rating" required>
                    <option value="1">1 - Very Poor</option>
                    <option value="2">2 - Poor</option>
                    <option value="3">3 - Average</option>
                    <option value="4">4 - Good</option>
                    <option value="5">5 - Excellent</option>
                </select>
            </div>

            <div class="form-group">
                <label for="comment">Comment:</label>
                <textarea class="form-control" name="comment" id="comment" rows="4" placeholder="Enter your comment here..." required></textarea>
            </div>

            <button type="submit" class="btn btn-submit">Submit Rating</button>
        </form>
    <%
        }
    %>
</div>

<footer class="text-center mt-5">
    <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
</footer>
</body>
</html>
