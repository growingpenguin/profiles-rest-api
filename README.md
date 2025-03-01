# Profiles REST API

Profiles REST API course code.

## Profiles API

### Introduction
The Profiles API is a RESTful API designed to manage user profiles. <br/>
It allows users to create, update, retrieve, and delete profiles efficiently.  <br/>
This API ensures data validation and provides secure authentication for profile management. <br/>

### Features
**1. Create a New Profile** <br/>
-Handles user registration <br/>
-Validates profile data (ensures all required fields are provided) <br/>
-Allows users to set their email, name, and password <br/>
**2. List Existing Profiles** <br/>
-Provides a list of registered profiles <br/>
-Supports searching for profiles using email or name <br/>
-Helps users find other registered users in the system <br/>
**3. View Specific Profiles** <br/>
-Retrieve a user’s profile by their profile ID <br/>
**4. Update Profile (Logged-in User Only)** <br/>
-Allows users to modify their name, email, or password <br/>
-Ensures security by limiting changes to the logged-in user <br/>
**5. Delete Profile** <br/>
-Allows users to remove their profile from the system permanently. <br/>

### API Endpoints
The API is accessible via /api/profile/ and supports the following operations: <br/>
**1. Manage Profiles Collection** <br/>
-GET /api/profile/ : List all the profiles <br/>
Retrieves a list of existing user profiles. <br/>
Supports filtering profiles by email and name. <br/>
-POST /api/profile/ : Create a new profile<br/>
<br/>
**2. Manage Individual Profiles** <br/>
-GET /api/profile/<profile_id>/ : View a specific profile <br/>
Retrieves detailed information about a user profile by profile ID <br/>
-PUT /api/profile/<profile_id>/ : Update a specific profile <br/>
Allows users to update their profile details (name, email, password) <br/>
Requires authentication to ensure only the owner can make changes. <br/>
-PATCH /api/profile/<profile_id>/ : Partially update a specific profile <br/>
Allows users to update specific fields of their profile <br/>
Example: Changing only the email without modifying other details <br/>
-DELETE /api/profile/<profile_id>/ - Delete a specific profile <br/>
Permanently removes a user profile from the system <br/>
Requires authentication to prevent unauthorized deletions <br/>

### Authentication & Security
-Users must authenticate before modifying or deleting their profiles <br/>
-JWT-based authentication can be implemented for secure access <br/>

### Technologies Used
-Django Rest Framework (DRF) - For building RESTful APIs <br/>
-SQLite/PostgreSQL - For storing user data <br/>
-Python & Django - For backend logic <br/>

## Login API
### Introduction
The Login API provides authentication functionality for our Profiles API <br/>
It enables users to log in and obtain an authentication token to access protected endpoints <br/>
Token authentication ensures secure API requests by verifying user identity with every request <br/>

### Features
**1. Create Login API** <br/>
-Implements login functionality for user authentication <br/>
-Uses Token Authentication for secure access <br/>
-Generates a token upon successful login <br/>
-Users must include the token in headers for future authenticated requests <br/>
**2.Token Authentication** <br/>
-Each request to the API includes an authentication token in the headers <br/>
-The token is verified to grant or deny access <br/>
-Unauthorized requests are rejected <br/>

### API endpoints
**1. Create Login API** <br/>
POST /api/login/ <br/>
-Accepts username and password <br/>
-Returns an authentication token upon successful login <br/>
-Example request body: <br/>
```
{
    "username": "user@example.com",
    "password": "securepassword"
}
```
-Example response: <br/>
```
{
    "token": "abcd1234efgh5678ijkl"
}
```
<br/>
### Using Token Authentication
**1. Assign Token to API Requests** <br/>
-Users must include the authentication token in the Authorization header for all API requests <br/>
-The header format is: Authorization: Token <your_token> <br/>
-Example request: <br/>
```
GET /api/profile/
Authorization: Token abcd1234efgh5678ijkl
```
**2. Set Token Header using ModHeader Extension** <br/>
-The ModHeader Chrome extension helps to add authentication headers easily <br/>
-Steps: <br/>
(1)Install the ModHeader Chrome extension <br/>
(2)Add a new header <br/>
(3)Set the key as Authorization <br/>
(4)Set the value as Token <your_token> <br/>
(5)Test API requests with authentication <br/>

### Technologies Used
-Django Rest Framework (DRF) - For API development <br/>
-Django Token Authentication - For secure authentication <br/>
-ModHeader Extension - For testing token authentication in Chrome <br/>
<br/>
By following these steps, users can authenticate and securely access the Profiles API. <br/>
