# 📋 Project Task Manager — Flutter Frontend

A full-featured **project and task management** mobile & web application built with **Flutter**, designed for a multi-role workflow involving **Buyers**, **Developers**, and **Admins**. Buyers create projects and assign tasks with hourly rates; developers pick up tasks, submit solutions as ZIP files, and get paid upon approval.

> **Backend API:** [project-task-backend-fmq6.onrender.com](https://project-task-backend-fmq6.onrender.com)

---

## ✨ Features

### 🔐 Authentication
- Email & password login / registration
- Role selection during sign-up (`buyer`, `developer`, `admin`)
- JWT-based session management via `GetStorage`
- Auth middleware protecting all authenticated routes

### 👤 Role-Based Dashboards
| Role | Dashboard |
|------|-----------|
| **Buyer** | View owned projects, create new projects, create & assign tasks to developers, review submissions, make payments, download solution files |
| **Developer** | View assigned projects/tasks, start tasks, upload ZIP solutions with hours logged |
| **Admin** | Platform-wide stats — total projects, tasks, completed tasks, hours logged, payments, revenue |

### 📁 Project Management
- Create projects with title & description
- View project list with pull-to-refresh
- Navigate into project to see all associated tasks

### ✅ Task Lifecycle
```
TODO → IN PROGRESS → SUBMITTED → PAID
```
- **Buyer** creates a task with title, description, developer assignment (dropdown), and hourly rate
- **Developer** starts the task, works on it, then submits a `.zip` file along with hours spent
- **Buyer** reviews the submission and pays — unlocking the solution file for download
- Real-time status chips with color coding

### 💳 Payments
- One-click payment for submitted tasks
- Automatic total calculation (`hourly_rate × hours_spent`)
- Solution file download unlocked after payment

### 📦 File Upload & Download
- ZIP file upload for task submissions (supports both Android & Web)
- Solution file download via URL launcher

---

## 🏗️ Architecture

The project follows a **modular architecture** with the **GetX** ecosystem for state management, dependency injection, and routing.

```
lib/
├── core/
│   ├── config/
│   │   └── api_config.dart          # API endpoint configuration
│   ├── middleware/
│   │   └── auth_middleware.dart      # Route guard for authenticated pages
│   └── services/
│       └── api_service.dart          # Dio HTTP client with auth interceptor
├── modules/
│   ├── admin/                        # Admin dashboard & stats
│   │   ├── binding/
│   │   ├── controller/
│   │   └── views/
│   ├── auth/                         # Login, register, user management
│   │   ├── bindings/
│   │   ├── controller/
│   │   ├── model/
│   │   ├── repositories/
│   │   └── views/
│   ├── dashboard/                    # Role-based dashboard hub
│   │   ├── binding/
│   │   ├── controller/
│   │   └── views/
│   ├── payment/                      # Payment processing
│   │   ├── model/
│   │   └── repository/
│   ├── project/                      # Project CRUD
│   │   ├── binding/
│   │   ├── controller/
│   │   ├── model/
│   │   ├── repository/
│   │   └── views/
│   └── task/                         # Task lifecycle management
│       ├── binding/
│       ├── controller/
│       ├── model/
│       ├── repository/
│       └── views/
├── routes/
│   ├── app_pages.dart                # Route-to-page mapping with bindings
│   └── app_routes.dart               # Route constants
└── main.dart                         # App entry point
```

### Design Patterns
- **Repository Pattern** — Abstract repositories with concrete implementations for clean data layer separation
- **Dependency Injection** — GetX bindings register repositories and controllers per route
- **Reactive State** — Observable variables (`Rx`) with `Obx` widgets for automatic UI updates

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Flutter 3.x (Dart SDK ^3.10.3) |
| **State Management** | GetX |
| **HTTP Client** | Dio (with interceptors for JWT auth) |
| **Local Storage** | GetStorage |
| **Routing** | GetX named routes with middleware |
| **File Picker** | file_picker |
| **URL Launcher** | url_launcher |
| **Theming** | Material 3 with dynamic color scheme |

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.x or later)
- Android Studio / VS Code with Flutter extension
- An Android/iOS device or emulator (also runs on Web)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-username/project-task-flutter.git
cd project-task-flutter

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Run on specific platforms

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web (Chrome)
flutter run -d chrome

# List all available devices
flutter devices
```

### Backend Configuration

The API base URL is configured in `lib/core/config/api_config.dart`:

```dart
class ApiConfig {
  static const String baseUrl = "https://project-task-backend-fmq6.onrender.com";
  // ...
}
```

Update this if you're running a local backend instance (e.g., `http://10.0.2.2:8000` for Android emulator).

---

## 📱 Screens

| Screen | Route | Description |
|--------|-------|-------------|
| Login | `/login` | Email & password authentication |
| Register | `/register` | New user registration with role selection |
| Dashboard | `/dashboard` | Role-based home (Buyer / Developer / Admin) |
| Create Project | `/create-project` | Buyer creates a new project |
| Task List | `/task-list` | All tasks for a project |
| Create Task | `/create-task` | Buyer creates & assigns a task to a developer |
| Task Detail | `/task-detail` | Full task view with role-specific actions |

---

## 🔄 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/auth/login` | Login |
| `POST` | `/auth/register` | Register |
| `GET` | `/auth/me` | Get current user |
| `GET` | `/auth/userlist?role=developer` | List users by role |
| `GET` | `/projects/mine` | Get user's projects |
| `POST` | `/projects/` | Create project |
| `GET` | `/tasks/project/:id` | Get tasks for a project |
| `GET` | `/tasks/:id` | Get task details |
| `POST` | `/tasks/` | Create task |
| `POST` | `/tasks/:id/start` | Start a task |
| `POST` | `/tasks/:id/submit` | Submit task (multipart: ZIP + hours) |
| `POST` | `/payments/:taskId` | Pay for a task |
| `GET` | `/admin/stats` | Admin platform statistics |

---

## 🎨 Theming

The app uses **Material 3** with a purple-based dynamic color scheme that supports both light and dark modes (following system preference):

```dart
ThemeData(
  colorSchemeSeed: Color(0xFF6750A4),
  useMaterial3: true,
)
```

---

## 📄 License

This project is for interview/assessment purposes.
