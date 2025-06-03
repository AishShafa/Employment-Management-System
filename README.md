//Created in 2024//

This project consists of an employment system for the company APU. The primary objective of this project is to create a robust, scalable, and user-friendly employment management platform that can handle various tasks such as job postings, applications, user management, and feedback processing. The system is intended to streamline the employment process, making it easier for employers to post job vacancies, employees to apply for jobs, and administrators to manage the overall system efficiently. Some key features found in the system include: 
•     User Management: The system supports multiple user roles (Admin, Employer, Employee), each with specific functionalities and access levels. This allows for a tailored user experience depending on the user's role within the system.
•     Job Posting and Application: Employers can post job vacancies, and employees can apply for these jobs through a streamlined interface. The system also tracks applications, allowing both employers and employees to manage and review job applications effectively.
•     Feedback and Notifications: The platform enables employers to provide feedback on employees, which can be managed by administrators. Notifications are also sent to users to keep them informed about important events, such as job application status updates or feedback received.
•     Security and Data Integrity: The system ensures that all user data is securely stored and managed. Role-based access control is implemented to ensure that sensitive information is accessible only to authorized users.
The system utilizes a three-tier architecture to ensure modularity and scalability. The system was made for 3 main user roles which are Admin, Employer and Employees. Each contain their own different functionalities and access privileges. The project is implemented using a three-tier architecture:
1.  Presentation Tier:
o    JSP Pages: These pages serve as the user interface, allowing users to interact with the system. Different pages are designed for different roles (Admin, Employer, Employee), and include features like login, registration, and dashboard views.
o    Servlets: These act as controllers that process user requests from the JSP pages, invoke the appropriate business logic, and return responses back to the user.
2.  Business Tier:
o    Facade Classes: These classes encapsulate the business logic of the application. They interact with the entity classes to perform CRUD (Create, Read, Update, Delete) operations.
o    Entity Classes: These classes represent the data model, corresponding to database tables. They hold the attributes and relationships that define how data 
is stored and managed.
3.  Database Tier:
oDatabase: This tier consists of the actual database where all the data is stored. Entity classes map directly to database tables, ensuring data is persisted and retrieved efficiently.

Below are some few screenshots of the project. For more details please refer to the documentation. 

![image](https://github.com/user-attachments/assets/84c6f4f0-c435-4fca-bd53-9330732ee43e)

![image](https://github.com/user-attachments/assets/142d009f-858f-4205-a91e-392a3d3d44c4)

![image](https://github.com/user-attachments/assets/5561e9a4-eb10-4113-9aa4-2ab6dbe279b2)

![image](https://github.com/user-attachments/assets/c433151b-7f52-4af3-9ad2-ac82913e64c0)

![image](https://github.com/user-attachments/assets/98e3121b-8e91-41d8-874c-49d541693673)

![image](https://github.com/user-attachments/assets/2d1bef34-2fbf-4542-b0f1-b450c4f6cd18)

![image](https://github.com/user-attachments/assets/6e5ab4a0-09bc-44e6-a130-45cefc4210c6)

![image](https://github.com/user-attachments/assets/aa5a2688-7e85-4219-90a6-74a44838085f)

![image](https://github.com/user-attachments/assets/d9113cb4-7c5d-41ec-beeb-1e7fac176cca)

![image](https://github.com/user-attachments/assets/2ed5119e-1c7f-43b1-bb06-72e81055429c)

![image](https://github.com/user-attachments/assets/fe854794-fb2f-457b-b374-62c29cadefb5)

![image](https://github.com/user-attachments/assets/9c10fd3e-e179-409a-9faf-a6d00531cc10)
