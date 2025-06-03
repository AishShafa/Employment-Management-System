<%-- 
    Document   : employer_dashboard
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Corporate Customers Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="../header.jsp" %>

        <div class="container">
            <div class="col-md-12">
                <h2>Corporate Customers Dashboard</h2>
                <hr>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Manage Profile</h5>
                            <p class="card-text">Edit your profile.</p>
                            <a href="${pageContext.request.contextPath}/edit_profile.jsp" class="btn btn-primary">Go to Profile</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Post New Vacancies</h5>
                            <p class="card-text">Post new job postings.</p>
                            <a href="${pageContext.request.contextPath}/Employer/post_vacancy.jsp" class="btn btn-primary">Post new Job Vacancies</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Shortlist Applicants</h5>
                            <p class="card-text">Shortlist applicants for interview.</p>
                            <a href="${pageContext.request.contextPath}/Employer/applicants_list.jsp" class="btn btn-primary">Go to Shortlisting Applicants</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mt-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">View Application History</h5>
                            <p class="card-text">Check the history of your job applications.</p>
                            <a href="${pageContext.request.contextPath}/Employer/post_history.jsp" class="btn btn-primary">Go to Application History</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mt-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Send Feedback to Admin</h5>
                            <p class="card-text">Send complaints to Admin.</p>
                            <a href="${pageContext.request.contextPath}/Employer/feedback_complaints.jsp" class="btn btn-primary">Go to Feedback</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="text-center mt-5">
            <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
        </footer>
    </body>
</html>
