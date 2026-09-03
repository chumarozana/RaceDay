RaceDay System

RaceDay is a race event management system designed to manage running events, race categories, participant enrolments, payments, results and event activities. The system uses a relational database and a RESTful API design to support participants and organisers.

User Roles

Participant

Participants can:

* Register and log in.
* View available race events and categories.
* Enrol in race categories.
* View and manage their own enrolments.
* Make payments for enrolments.
* View their own race results.
* Manage their profile.

Organiser

Organisers can:

* Create and manage race events.
* Add and manage event categories.
* View participant enrolments for their events.
* Record and manage race results.
* View payments related to their events.
* View audit logs for their events.

Project Documentation

The planning and database documentation is available in the /docs folder:

* RaceDay ERD
* API Endpoint Plan
* RaceDay Database SQL Script

Database

The RaceDay system uses Microsoft SQL Server. The database contains the following entities:

1. Roles
2. Users
3. Events
4. Categories
5. EventCategories
6. EventEnrolments
7. Results
8. Payments
9. AuditLogs

The SQL database script was tested in SQL Server Management Studio (SSMS) and executed successfully without errors.

CI/CD

GitHub Actions is used to validate the required project documentation and database files.

Successful Build

The green GitHub Actions build confirms that the required documentation files are present in the repository.

Walkthrough Video

A YouTube walkthrough demonstrating the RaceDay planning documents, ERD decisions, API endpoint plan and SQL database execution will be added here.

YouTube Link: Coming soon
