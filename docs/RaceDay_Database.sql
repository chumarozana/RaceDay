CREATE DATABASE RaceDay;
GO

USE RaceDay;
GO

CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    RoleID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    DateOfBirth DATE,
    CONSTRAINT FK_Users_Roles
        FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
GO

CREATE TABLE Events (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID INT NOT NULL,
    EventName VARCHAR(100) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    Description VARCHAR(500),
    EntryFee DECIMAL(10,2) NOT NULL,
    Status VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Events_Organiser
        FOREIGN KEY (OrganiserID) REFERENCES Users(UserID),
    CONSTRAINT CK_Events_EntryFee
        CHECK (EntryFee >= 0)
);
GO

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    Description VARCHAR(500),
    CONSTRAINT CK_Categories_Distance
        CHECK (DistanceKm > 0)
);
GO

CREATE TABLE EventCategories (
    EventCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,
    CONSTRAINT FK_EventCategories_Events
        FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT FK_EventCategories_Categories
        FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT UQ_EventCategories
        UNIQUE (EventID, CategoryID)
);
GO

CREATE TABLE EventEnrolments (
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    EventCategoryID INT NOT NULL,
    EnrolmentDate DATETIME NOT NULL DEFAULT GETDATE(),
    EnrolmentStatus VARCHAR(30) NOT NULL DEFAULT 'Pending',
    CONSTRAINT FK_EventEnrolments_Users
        FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_EventEnrolments_EventCategories
        FOREIGN KEY (EventCategoryID) REFERENCES EventCategories(EventCategoryID),
    CONSTRAINT CK_EventEnrolments_Status
        CHECK (EnrolmentStatus IN ('Pending', 'Confirmed', 'Cancelled'))
);
GO

CREATE TABLE Results (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE,
    FinishTime TIME,
    Position INT,
    ResultStatus VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Results_Enrolments
        FOREIGN KEY (EnrolmentID) REFERENCES EventEnrolments(EnrolmentID),
    CONSTRAINT CK_Results_Position
        CHECK (Position IS NULL OR Position > 0)
);
GO

CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(30) NOT NULL DEFAULT 'Paid',
    PaymentDate DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_Enrolments
        FOREIGN KEY (EnrolmentID) REFERENCES EventEnrolments(EnrolmentID),
    CONSTRAINT CK_Payments_Status
        CHECK (PaymentStatus IN ('Pending', 'Paid', 'Failed', 'Refunded'))
);
GO

CREATE TABLE AuditLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    UserID INT NOT NULL,
    Action VARCHAR(255) NOT NULL,
    LogDate DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_AuditLogs_Events
        FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT FK_AuditLogs_Users
        FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

INSERT INTO Roles (RoleName)
VALUES
('Participant'),
('Organiser');
GO

INSERT INTO Users
(RoleID, FirstName, LastName, Email, PasswordHash, Phone, DateOfBirth)
VALUES
(2, 'Thando', 'Mthembu', 'thando@raceday.co.za', 'hashed_password_1', '0712345678', '1995-04-15'),
(2, 'Lerato', 'Dlamini', 'lerato@raceday.co.za', 'hashed_password_2', '0723456789', '1993-08-22'),
(1, 'Sipho', 'Ndlovu', 'sipho@example.com', 'hashed_password_3', '0734567890', '2002-01-10'),
(1, 'Amahle', 'Khumalo', 'amahle@example.com', 'hashed_password_4', '0745678901', '2001-06-18');
GO

INSERT INTO Events
(OrganiserID, EventName, EventDate, Location, Description, EntryFee, Status)
VALUES
(1, 'Durban Summer Run', '2026-11-15', 'Durban, KwaZulu-Natal',
 'Annual road running event for participants of different levels.', 250.00, 'Open'),
(2, 'Umhlanga Beach Run', '2026-12-05', 'Umhlanga, KwaZulu-Natal',
 'Scenic coastal running event.', 180.00, 'Open');
GO

INSERT INTO Categories
(CategoryName, DistanceKm, Description)
VALUES
('5K Fun Run', 5.00, 'Short recreational running category.'),
('10K Race', 10.00, 'Competitive 10 kilometre race.'),
('21K Half Marathon', 21.10, 'Half marathon category.'),
('42K Marathon', 42.20, 'Full marathon category.');
GO

INSERT INTO EventCategories
(EventID, CategoryID)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2);
GO

INSERT INTO EventEnrolments
(UserID, EventCategoryID, EnrolmentDate, EnrolmentStatus)
VALUES
(3, 1, GETDATE(), 'Confirmed'),
(4, 2, GETDATE(), 'Confirmed'),
(3, 4, GETDATE(), 'Pending');
GO

INSERT INTO Results
(EnrolmentID, FinishTime, Position, ResultStatus)
VALUES
(1, '00:28:35', 1, 'Finished'),
(2, '00:55:20', 3, 'Finished');
GO

INSERT INTO Payments
(EnrolmentID, PaymentMethod, PaymentStatus, PaymentDate)
VALUES
(1, 'Card', 'Paid', GETDATE()),
(2, 'EFT', 'Paid', GETDATE());
GO

INSERT INTO AuditLogs
(EventID, UserID, Action, LogDate)
VALUES
(1, 1, 'Created event', GETDATE()),
(1, 1, 'Added race categories', GETDATE()),
(2, 2, 'Created event', GETDATE());
GO

SELECT * FROM Roles;
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM EventCategories;
SELECT * FROM EventEnrolments;
SELECT * FROM Results;
SELECT * FROM Payments;
SELECT * FROM AuditLogs;
GO
