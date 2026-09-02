
# API Endpoint Plan

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|-------------|-------|-------------|---------------|--------------|-------------------|
| POST | /api/auth/register | Register a new user (participant or organiser). | None | { "email", "password", "full_name", "role" } | 201 Created with { "user_id", "email", "role", "message" } |
| POST | /api/auth/login | Login and receive a JWT token. | None | { "email", "password" } | 200 OK with { "token", "user_id", "role" } |
| GET | /api/users/me | Get the authenticated user's profile. | Any authenticated | - | 200 OK with { "user_id", "email", "full_name", "role", "created_at" } |
| PUT | /api/users/me | Update the authenticated user's profile. | Any authenticated | { "full_name", "email" } | 200 OK with updated user object |
| GET | /api/events | List all events (with optional filters: status, date). | Any (including guest) | - | 200 OK with array of event objects |
| POST | /api/events | Create a new event. | Organiser | { "name", "description", "date", "location", "status" } | 201 Created with full event object |
| GET | /api/events/{eventId} | Get details of a specific event. | Any | - | 200 OK with event object including categories |
| PUT | /api/events/{eventId} | Update an existing event. | Organiser (owner) | { "name", "description", "date", "location", "status" } | 200 OK with updated event object |
| DELETE | /api/events/{eventId} | Delete an event. | Organiser (owner) | - | 204 No Content |
| GET | /api/events/{eventId}/categories | List all categories for an event. | Any | - | 200 OK with array of category objects |
| POST | /api/events/{eventId}/categories | Add a new category to an event. | Organiser (owner) | { "name", "distance", "age_group", "gender", "fee" } | 201 Created with category object |
| PUT | /api/categories/{categoryId} | Update a category. | Organiser (event owner) | { "name", "distance", "age_group", "gender", "fee" } | 200 OK with updated category object |
| DELETE | /api/categories/{categoryId} | Delete a category (if no enrolments). | Organiser (event owner) | - | 204 No Content |
| POST | /api/enrolments | Enrol a participant in a category. | Participant | { "category_id" } | 201 Created with enrolment object |
| GET | /api/enrolments/my | Get all enrolments for the authenticated participant. | Participant | - | 200 OK with array of enrolment objects |
| PUT | /api/enrolments/{enrolmentId} | Update enrolment status (e.g., cancel). | Participant (owner) or Organiser | { "status" } | 200 OK with updated enrolment |
| GET | /api/events/{eventId}/enrolments | List all enrolments for an event (organiser view). | Organiser (event owner) | - | 200 OK with array of enrolments |
| POST | /api/results | Record a result for an enrolment. | Organiser (event owner) | { "enrolment_id", "finish_time", "position", "notes" } | 201 Created with result object |
| PUT | /api/results/{resultId} | Update a result. | Organiser (event owner) | { "finish_time", "position", "notes" } | 200 OK with updated result |
| GET | /api/events/{eventId}/results | Get all results for an event (leaderboard). | Any | - | 200 OK with array of results |
| GET | /api/users/me/results | Get the authenticated participant's own results. | Participant | - | 200 OK with array of results |
| POST | /api/payments | Process payment for an enrolment. | Participant | { "enrolment_id", "method" } | 201 Created with payment object |
| GET | /api/events/{eventId}/logs | Get audit logs for an event. | Organiser (owner) | - | 200 OK with array of log entries |
