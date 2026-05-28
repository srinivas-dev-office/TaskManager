# TaskManager Flutter App

A simple and modern Flutter Task Management app with authentication, task management, drag & drop support, and Hive local storage.

---

## Features

* Login Authentication
* Create Tasks
* Edit Tasks
* Delete Tasks
* Task Status Management
* Priority Selection
* Drag & Drop Tasks
* Hive Local Storage
* Clean & Responsive UI
* Gradient Design

---

## Screens

* Login Screen
* Dashboard
* All Tasks Screen
* Add Task Screen
* Edit Task Screen

---

## Tech Stack

* Flutter
* Dart
* Hive Database
* Provider State Management

---

## Project Structure

```bash
lib/
├── core/
├── models/
├── providers/
├── screens/
├── widgets/
├── Bottom_navbar.dart
 ── splash_screen.dart
└── main.dart
```

---

## Login Credentials

```bash
Email    : srinivas@gmail.com
Password : 123456
```

---

## Getting Started

### Install Dependencies

```bash
flutter pub get
```

### Generate Hive Files

```bash
flutter packages pub run build_runner build
```

### Run Project

```bash
flutter run
```

---

## Packages Used

```yaml
provider
hive
hive_flutter
build_runner
hive_generator
drag_and_drop_lists
```

---

## Task Status

* Pending
* In Progress
* Completed

---

## Priority Levels

* Low
* Medium
* High

---

## Database

This project uses Hive Database for offline task storage.
