<%-- 
    Document   : feedback_complaints
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="model.FeedbackFacade"%>
<%@include file="../header.jsp"%>
<%@include file="../includes.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Submit Feedback or Complaint</title>
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
            <h2>Submit Feedback or Complaint</h2>

            <%
                // Check for any success or error messages from the servlet
                String successMessage = (String) request.getAttribute("successMessage");
                String errorMessage = (String) request.getAttribute("errorMessage");

                if (successMessage != null) {
            %>
                <div class="alert alert-success"><%= successMessage %></div>
            <%
                }

                if (errorMessage != null) {
            %>
                <div class="alert alert-danger"><%= errorMessage %></div>
            <%
                }
            %>

            <form action="${pageContext.request.contextPath}/FeedbackServlet" method="POST">
                <div class="form-group">
                    <label for="aboutEmployee">Employee Name:</label>
                    <input type="text" class="form-control" name="aboutEmployee" id="aboutEmployee" required>
                </div>

                <div class="form-group">
                    <label for="feedbackType">Feedback Type:</label>
                    <select class="form-control" name="feedbackType" id="feedbackType" required>
                        <option value="Complaint">Complaint</option>
                        <option value="Suggestion">Suggestion</option>
                        <option value="General">General</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="message">Message:</label>
                    <textarea class="form-control" name="message" id="message" rows="4" placeholder="Enter your message here..." required></textarea>
                </div>

                <button type="submit" class="btn btn-submit">Submit Feedback</button>
            </form>
        </div>

        <footer class="text-center mt-5">
            <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
        </footer>
    </body>
</html>