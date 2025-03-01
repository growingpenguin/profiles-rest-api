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
