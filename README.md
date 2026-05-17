# Contact Management App

A Flutter Contact book application that performs CRUD (Create, Read, Update, Delete) operations using REST API integration. Built with Bloc for state management and Dio for network requests, following a clean and maintainable architecture with proper loading and error handling states.

---

## Features

- Add new contacts
- Edit existing contacts
- Delete contacts
- View all contacts
- View contact details
- Mark contacts as favorites
- REST API CRUD operations
- State management using Bloc
- Network handling using Dio
- Loading and error handling states

---

## Technologies Used

- Flutter
- Dart
- Bloc (flutter_bloc)
- Dio
- REST API(mockapi.io)
- Equatable

---

## Project Structure

```bash
lib/
│
├── bloc/
├── core/
├── models/
├── repositories/
├── routes/
├── screens/
├── services/
├── widgets/
└── main.dart
```

---

## Screenshots

### Add Contact Screen
<img src="screenshots/add-contact.jpg" width="300"/>

### Delete Contact
<img src="screenshots/delete-contact.jpg" width="300"/>

### Edit Contact Screen
<img src="screenshots/edit-contact.jpg" width="300"/>

### Favorite Contact
<img src="screenshots/favorite-contact.jpg" width="300"/>

### View Added Contacts
<img src="screenshots/view-added-contacts.jpg" width="300"/>

### View All Contacts
<img src="screenshots/view-all-contacts.jpg" width="300"/>

### View Contact Detail Screen
<img src="screenshots/view-contact-detail.jpg" width="300"/>

---

## Getting Started

### Prerequisites

Install the following before running the project:

- Flutter SDK
- Dart SDK
- Android Studio or VS Code

---

### Installation

Clone the repository:

```bash
git clone https://github.com/your-username/contact-management-app.git
```

Move into the project folder:

```bash
cd contact-management-app
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

## State Management

This project uses **Bloc** for state management to handle:

- Fetch contacts
- Add contact
- Update contact
- Delete contact
- Loading states
- Error handling

---

## Networking

The application uses **Dio** for:

- GET requests
- POST requests
- PUT requests
- DELETE requests
- API error handling

---

## Author

Hayat Abdulkerim

UGR/0826/16

---

## License

This project is for educational purposes only.
