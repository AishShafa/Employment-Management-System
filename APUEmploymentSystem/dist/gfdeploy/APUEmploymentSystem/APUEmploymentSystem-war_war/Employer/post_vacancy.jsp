<%-- 
    Document   : post_vacancy
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post a Job Vacancy</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
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
    <%@ include file="../header.jsp" %>

    <div class="container">
        <br><br><br><br><br><br><br><br>
        <h2>Post a Job Vacancy</h2>
        <form action="${pageContext.request.contextPath}/PostVacancyServlet" method="POST">
            <div class="form-group">
                <label for="companyName">Company Name:</label>
                <input type="text" class="form-control" id="companyName" name="companyName" required>
            </div>
            
            <div class="form-group">
                <label for="jobTitle">Job Title:</label>
                <input type="text" class="form-control" id="jobTitle" name="jobTitle" required>
            </div>

            <div class="form-group">
                <label for="salaryRange">Salary Range:</label>
                <input type="text" class="form-control" id="salaryRange" name="salaryRange" placeholder="RM10000 - 11999" required>
            </div>

            <div class="form-group">
                <label for="jobType">Job Type:</label>
                <select class="form-control" id="jobType" name="jobType">
                    <option value="Full-time">Full-time</option>
                    <option value="Part-time">Part-time</option>
                    <option value="Contract">Contract</option>
                    <option value="Temporary">Temporary</option>
                    <option value="Internship">Internship</option>
                </select>
            </div>

            <div class="form-group">
                <label for="qualification">Qualification:</label>
                <select class="form-control" id="qualification" name="qualification">
                    <option value="Advanced Diploma">Advanced Diploma</option>
                    <option value="Diploma">Diploma</option>
                    <option value="Degree">Degree</option>
                    <option value="Masters">Masters</option>
                    <option value="PhD">PhD</option>
                </select>
            </div>

            <div class="form-group">
                <label for="location">Location:</label>
                <input type="text" class="form-control" id="location" name="location" value="Male'" required>
            </div>

            <div class="form-group">
                <label for="experience">Experience:</label>
                <input type="text" class="form-control" id="experience" name="experience" placeholder="1 - 2 years" required>
            </div>

            <div class="form-group">
                <label for="sector">Sector:</label>
                <select class="form-control" id="sector" name="sector">
                    <option value="Private">Private</option>
                    <option value="Public">Public</option>
                    <option value="Others">Others</option>
                </select>
            </div>

            <div class="form-group">
                <label for="jobDescription">Job Description:</label>
                <textarea class="form-control" id="jobDescription" name="jobDescription" rows="5" required></textarea>
            </div>

            <div class="form-group">
                <label for="closingDate">Closing on:</label>
                <input type="date" class="form-control" id="closingDate" name="closingDate" required>
            </div>

            <button type="submit" class="btn btn-primary">Post Vacancy</button>
            
        </form>
    </div>
            <footer class="text-center mt-5">
    <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
</footer>
</html>
</body>
</html>