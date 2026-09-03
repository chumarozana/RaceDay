# RaceDay API Endpoint Plan

## Authentication

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| POST | /api/auth/register | Registers a new participant account. | Public | FirstName, LastName, Email, Password, Phone, DateOfBirth | 201 Created – User registered successfully |
| POST | /api/auth/login | Authenticates a user and returns an access token. | Public | Email, Password | 200 OK – Authentication token and user details |

## User Profile

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /api/users/profile | Retrieves the profile of the currently authenticated user. | Participant or Organiser | None | 200 OK – User profile (including role) |
| PUT | /api/users/profile | Updates the currently authenticated user's profile. | Participant or Organiser | FirstName, LastName, Phone, DateOfBirth | 200 OK – Updated profile |

## Events

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /api/events | Retrieves all available events. | Public | None | 200 OK – List of events |
| GET | /api/events/{id} | Retrieves a specific event by ID. | Public | None | 200 OK – Event details |
| POST | /api/events | Creates a new race event. | Organiser | EventName, EventDate, Location, Description, EntryFee, Status | 201 Created – Event created |
| PUT | /api/events/{id} | Updates an existing race event. | Organiser (owner) | EventName, EventDate, Location, Description, EntryFee, Status | 200 OK – Event updated |
| DELETE | /api/events/{id} | Deletes an existing race event. | Organiser (owner) | None | 204 No Content – Event deleted |

## Categories

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /api/events/{eventId}/categories | Retrieves all categories for a specific event. | Public | None | 200 OK – List of categories |
| GET | /api/categories/{id} | Retrieves a specific category. | Public | None | 200 OK – Category details |
| POST | /api/events/{eventId}/categories | Creates a new category for an event. | Organiser (event owner) | CategoryName, DistanceKm, Description | 201 Created – Category created |
| PUT | /api/categories/{id} | Updates an existing category. | Organiser (event owner) | CategoryName, DistanceKm, Description | 200 OK – Category updated |
| DELETE | /api/categories/{id} | Deletes an existing category (if no enrolments). | Organiser (event owner) | None | 204 No Content – Category deleted |

## Event Enrolments

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /api/enrolments/my | Retrieves enrolments for the authenticated participant. | Participant | None | 200 OK – List of enrolments with event and category details |
| GET | /api/enrolments/{id} | Retrieves a specific enrolment. | Participant or Organiser | None | 200 OK – Enrolment details |
| POST | /api/enrolments | Enrols the authenticated participant in an event category. | Participant | EventCategoryID | 201 Created – Enrolment created with status 'pending' |
| PUT | /api/enrolments/{id} | Updates the status of an enrolment. | Organiser (event owner) or Participant (own, only to cancel) | EnrolmentStatus | 200 OK – Enrolment updated |
| DELETE | /api/enrolments/{id} | Cancels an enrolment. | Participant (owner) or Organiser | None | 204 No Content – Enrolment cancelled |
| GET | /api/events/{eventId}/enrolments | Retrieves all enrolments for a specific event (organiser view). | Organiser (event owner) | None | 200 OK – List of enrolments with participant details |

## Results

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /api/results | Retrieves race results (public leaderboard). | Public | None | 200 OK – List of results with participant names |
| GET | /api/results/{id} | Retrieves a specific race result. | Public | None | 200 OK – Result details |
| POST | /api/results | Records a participant's race result. | Organiser (event owner) | EnrolmentID, FinishTime, Position, ResultStatus | 201 Created – Result recorded |
| PUT | /api/results/{id} | Updates an existing race result. | Organiser (event owner) | FinishTime, Position, ResultStatus | 200 OK – Result updated |
| DELETE | /api/results/{id} | Removes a race result. | Organiser (event owner) | None | 204 No Content – Result deleted |
| GET | /api/users/me/results | Retrieves the authenticated participant's own results. | Participant | None | 200 OK – List of results for this participant |

## Payments

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| POST | /api/payments | Records payment for enrolment. | Participant | EnrolmentID, PaymentMethod | 201 Created – Payment recorded with status 'paid' |
| GET | /api/payments/{id} | Retrieves a specific payment. | Participant (owner) or Organiser | None | 200 OK – Payment details |
| GET | /api/enrolments/{enrolmentId}/payment | Retrieves payment for a specific enrolment. | Participant or Organiser | None | 200 OK – Payment details |

## Audit Logs

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| GET | /api/events/{eventId}/logs | Retrieves audit logs for a specific event. | Organiser (event owner) | None | 200 OK – List of log entries |
