# APU Employment Management System

A Java EE web application for managing employment and recruitment workflows at Asia Pacific University (APU). The system brings employees (jobseekers), employers (corporate customers), and administrators together in one portal: employers can publish vacancies and review applicants, employees can browse and apply for jobs, and administrators can manage platform data, feedback, and warnings.

> This is an academic project created in 2024. The application is structured as a Java EE 7 enterprise application and uses JSP, Servlets, EJB, JPA, and a configured application-server datasource.

## Table of contents

- [Project goals](#project-goals)
- [Roles and features](#roles-and-features)
- [How the code is organized](#how-the-code-is-organized)
- [Technology stack](#technology-stack)
- [Run locally](#run-locally)
- [Screenshots](#screenshots)
- [Project documentation](#project-documentation)

## Project goals

Recruitment work involves several connected tasks: maintaining user accounts, publishing job vacancies, receiving applications, reviewing candidates, and communicating outcomes. This application provides role-specific screens and server-side request handling for those workflows. Separating the web interface from the business/data modules also makes the project easier to navigate and extend.

The system uses a **three-tier architecture**:

1. **Presentation Tier** — JSP pages (UI for each role) and Servlets (controllers that process requests and invoke business logic).
2. **Business Tier** — Facade classes (encapsulate business logic and CRUD operations) and Entity classes (map to database tables).
3. **Database Tier** — The actual database where data is persisted; entities map directly to tables.

## Roles and features

The system has three main user roles: **Admin**, **Employer (Corporate Customer)**, and **Employee (Jobseeker)**. Each has its own access privileges and functionalities.

### Employee (Jobseeker)

- Create an employee account and sign in.
- Browse the public Jobs page and submit job applications (with confirmation, e.g. "Application submitted successfully!").
- Access a **Jobseeker Dashboard** with options to:
  - Manage/edit profile.
  - View application history (searchable by job title).
  - View notifications (e.g. warnings, shortlisting, job confirmation).
- Submit ratings and comments for job listings and companies (must be logged in; public users can view existing ratings/comments but must log in to post).
- Accounts receive warnings from the admin; **after 3 warnings the employee account is automatically deleted**.

### Employer (Corporate Customer)

- Create an employer account and access the **Corporate Customers Dashboard**.
- Post new vacancies, view posting history, and edit or delete previously posted vacancies.
- Review the applicants list (showing applicant name, birthdate, gender, email, job ID, applied date) and **shortlist** candidates or **confirm the job** for them.
- Submit feedback or complaints to the admin (feedback type: Complaint, etc.).

### Administrator

- Access the **Admin Dashboard**, with options to edit admin profile, manage all accounts, and manage feedbacks and warnings.
- **Search & Manage Accounts**: search by role, username, gender, email, birthdate, etc.; edit, delete, or add new customer accounts.
- **Feedback Management**: view complaints made by corporate customers, issue warnings to employees, and view all previously sent warnings.

### Public (not logged in)

- View the **Jobs** page (list of vacancies) and **Companies** page (list of companies with average ratings, e.g. "Average Rating: 4.50 / 5.00").
- View a company's existing ratings and comments (must log in to post).

## How the code is organized

The project is a NetBeans enterprise application with separate web and EJB modules:

```text
APUEmploymentSystem/
├── APUEmploymentSystem-war/       # Web application: JSP pages, assets, and servlets
│   ├── src/java/controller/       # HTTP request handlers (servlets)
│   └── web/                       # JSP views, CSS, JavaScript, images, WEB-INF config
├── APUEmploymentSystem-ejb/       # Business/data module
│   └── src/java/model/            # JPA entities, facades, persistence operations
├── nbproject/                     # NetBeans project configuration
└── build.xml                      # Ant build entry point
```

### Presentation and request handling — `APUEmploymentSystem-war`

The WAR module contains the browser-facing application. JSP pages and servlets are organized per role.

**JSP pages (`web/`):**

- `login.jsp` — entry point / sign-in page (includes links to Register and Forgot Password; the client URL used in the NetBeans run configuration).
- **Employee pages:** `employee_dashboard.jsp` (jobseeker dashboard), `application_history.jsp` (application history), plus profile edit and notifications views.
- **Employer pages:** `employer_dashboard.jsp` (corporate customer dashboard), `post_vacancy.jsp` (post a new job vacancy), plus posting history and feedback/complaint submission views.
- **Admin pages:** `admin_dashboard.jsp` (admin dashboard), `admin_feedback_management.jsp` (feedback management), plus account search/manage views.
- **Public pages:** Jobs listing and Companies listing (accessible before login).
- Shared assets: `style.css` (`web/CSS`), `app.js` (`web/JS`), and `logo.png` (images).

**Servlets (`src/java/controller/`):** handle submitted requests and coordinate actions such as login, registration (Admin/Employer/Employee), applying for a job, posting a vacancy, and processing feedback. For example:

- `AdminServlet.java` — admin-related requests.
- `EmployerServlet.java` — employer-related requests.
- `LoginServlet.java` — authentication/session handling.
- `EmployeeServlet.java` — employee-related requests.
- `RegisterServlet.java` — registration workflows.
- `AdminFeedbackServlet.java` — feedback management by the admin.
- `ApplyJobServlet.java` — job application process for employees.
- `PostVacancyServlet.java` — posting new job vacancies by employers.

In broad terms, a JSP form sends a request to a servlet; the servlet uses the business/data layer and then forwards or redirects to an appropriate page.

### Business and persistence — `APUEmploymentSystem-ejb`

The EJB module contains the JPA model classes and persistence facades.

**Facade classes (`model` package):** encapsulate business logic and perform CRUD operations. Example facades include `AdminFacade`, `EmployerFacade`, `LoginFacade`, `EmployeeFacade`, `RegisterFacade`, `ApplicantsFacade`, and `VacancyFacade`. `AbstractFacade` supplies common operations such as finding records, listing records, paging, and counting.

**Entity classes (`model` package):** represent the data model and map to database tables, including `LoginEntity`, `AdminEntity`, `EmployeeEntity`, `EmployerEntity`, `RegisterEntity`, `Applicants` (Applicants table), and `Vacancy` (job vacancies with fields such as job title, description, and associated employer). Entities also cover feedback, ratings, and notifications.

The persistence unit is named `APUEmploymentSystem-ejbPU` and uses the JTA datasource `jdbc/sample`. Its schema-generation setting is configured to create the database schema when the persistence provider initializes, so verify your environment and data-retention needs before running it against any database containing important data.

### Request-to-data flow

1. A user opens a role-specific JSP page and submits a form or action.
2. A servlet in the WAR module validates and handles the request.
3. The servlet calls the relevant EJB/model facade to perform persistence work (e.g. `LoginServlet` → `LoginFacade` → `LoginEntity`).
4. JPA maps entity objects to database records through the configured datasource.
5. The servlet returns the user to a JSP view with the resulting page or status.

### Database design (from the original report)

Main tables:

- **MyCustomer** — `EMAIL`, `BIRTHDATE`, `GENDER`, `PASSWORD`, `ROLE` (Admin / Employer / Employee / Staff), `USERNAME`.
- **Vacancy** — `ID`, `CLOSINGDATE`, `COMPANYNAME`, `EXPERIENCE`, `JOBTITLE`, `JOBTYPE`, `LOCATION`, `QUALIFICATION`, `SALARYRANGE`, `SECTOR`, `JOBDESCRIPTION`, `EMPLOYEREMAIL`.
- **Applicants** — `ID`, `NAME`, `BIRTHDATE`, `APPLIED_DATE`, `GENDER`, `EMAIL`, `JOBID` (foreign key to Vacancy).
- **Feedback** — `ID`, `FROMEMPLOYER`, `ABOUTEMPLOYEE`, `FEEDBACKDATE`, `FEEDBACKTYPE`, `MESSAGE`, `STATUS` (e.g. Pending), `ADMINRESPONSE`.
- **Notifications** — `ID`, `FROMwHO`, `MESSAGE`, `WHATDATE`, `TOwHO`.
- **Ratings** — `ID`, `COMMENT`, `TOwHO`, `FROMwHO`, `WHATDATE`, `RATING` (1–5 stars), `JOBID` (foreign key to Vacancy).

Relationships: one-to-many between Employer and Vacancy, and between Vacancy and Applicants; a many-to-many relationship between Applicants and Vacancy is managed through a join table. Indexes on key columns (e.g. `ID`, `JOBID`) improve retrieval speed, and foreign keys (e.g. `JOBID` in Applicants → Vacancy) enforce referential integrity.

## Technology stack

- **Java 8** (configured source and target level)
- **Java EE 7** enterprise application
- **JSP and Servlets** for the web interface and request handling
- **EJB and JPA 2.1** for business/data access and persistence
- **Ant and NetBeans** project/build configuration
- **GlassFish** Java EE application server configuration
- **Bootstrap 4.5.2**, CSS, and JavaScript for the web UI

## Run locally

The repository is configured as a NetBeans/Ant enterprise project. To run it in a compatible development environment:

1. Install **JDK 8** and **Apache NetBeans** with Java EE support.
2. Configure a compatible **GlassFish** server in NetBeans. The project configuration targets Java EE 7 and references a GlassFish server installation.
3. Configure the application server's JTA datasource with the JNDI name **`jdbc/sample`**, pointing it to a database available in your environment.
4. Open the `APUEmploymentSystem` directory as a project in NetBeans and resolve any server or library references requested by the IDE.
5. Build and deploy the enterprise application (`APUEmploymentSystem.ear`) to the configured server, then open the application's deployed URL. The NetBeans run configuration uses `login.jsp` as the client URL.

The exact database vendor, connection credentials, and server URL depend on your local GlassFish setup and are not specified as portable deployment settings in this README. Do not commit real database credentials to the repository.

## Screenshots

The images below show representative screens from the application. Each caption describes the workflow area represented by the screenshot.

### 1. Public-facing application

![Public-facing employment portal](https://github.com/user-attachments/assets/84c6f4f0-c435-4fca-bd53-9330732ee43e)

The starting point for users exploring the employment portal and its available navigation options.

### 2. Account access

![Account access screen](https://github.com/user-attachments/assets/142d009f-858f-4205-a91e-392a3d3d44c4)

The account-access workflow through which a registered user enters the system.

### 3. User registration

![User registration screen](https://github.com/user-attachments/assets/5561e9a4-eb10-4113-9aa4-2ab6dbe279b2)

A registration view for collecting the information required to create a user account.

### 4. Employee workspace

![Employee workspace](https://github.com/user-attachments/assets/c433151b-7f52-4af3-9ad2-ac82913e64c0)

An employee-facing screen for accessing job-seeking features such as vacancies, applications, or account information.

### 5. Vacancy browsing

![Vacancy browsing screen](https://github.com/user-attachments/assets/98e3121b-8e91-41d8-874c-49d541693673)

A view of the recruitment experience where employees can explore available job opportunities.

### 6. Application workflow

![Job application screen](https://github.com/user-attachments/assets/2d1bef34-2fbf-4542-b0f1-b450c4f6cd18)

A job-seeker workflow screen associated with reviewing a vacancy or submitting an application.

### 7. Employer workspace

![Employer workspace](https://github.com/user-attachments/assets/6e5ab4a0-09bc-44e6-a130-45cefc4210c7)

An employer-facing view for reaching vacancy and candidate-management features.

### 8. Vacancy management

![Vacancy management screen](https://github.com/user-attachments/assets/aa5a2688-7e85-4219-90a6-74a44838085f)

A screen associated with creating, viewing, or updating job vacancy information.

### 9. Candidate review

![Applicant review screen](https://github.com/user-attachments/assets/d9113cb4-7c5d-41ec-beeb-1e7fac176cca)

The employer-side workflow for reviewing applications and managing candidates.

### 10. Administration

![Administrative screen](https://github.com/user-attachments/assets/2ed5119e-1c7f-43b1-bb06-72e81055429c)

An administration view for overseeing platform records and management tasks.

### 11. Feedback and notifications

![Feedback and notifications screen](https://github.com/user-attachments/assets/fe854794-fb2f-457b-b374-62c29cadefb5)

A screen illustrating the communication and feedback features available within the system.

### 12. Additional application view

![Additional employment system screen](https://github.com/user-attachments/assets/9c10fd3e-e179-409a-9faf-a6d00531cc10)

An additional view of the application's role-based interface and employment-management workflow.

## Project documentation

For more detailed design and project information, see [Employment Management System.pdf](Employment%20Management%20System.pdf) in the repository.
