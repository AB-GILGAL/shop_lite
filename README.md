# shop_lite

A new Flutter project.


# Low Connectivity Learning App

A production-style Flutter application built to learn and demonstrate modern Flutter development practices using an **Offline-First Architecture**.

The project focuses on building applications that continue to function reliably under poor or intermittent internet connectivity while following clean, scalable, and maintainable software architecture.

> **Status:** 🚧 In Development

---

# Project Goals

This project is designed as a learning journey to master professional Flutter application development.

The primary objectives are:

- Build production-quality Flutter applications
- Learn Feature-First Clean Architecture
- Implement Offline-First data synchronization
- Learn advanced Riverpod state management
- Master Dio networking
- Use Isar for local database storage
- Build reusable UI components
- Document architectural decisions professionally
- Practice professional Git workflows

---

# Features

## Current

- Project architecture
- Theme system
- Responsive design foundation
- GoRouter navigation
- Shared widgets
- Networking architecture

## Planned

- Product listing
- Product details
- Categories
- Search
- Offline cache
- Background synchronization
- Retry failed requests
- Image caching
- Local database
- Pagination
- Pull-to-refresh
- Error handling
- Loading skeletons (Shimmer)

---

# Technology Stack

| Technology | Purpose |
|------------|---------|
| Flutter | Cross-platform application framework |
| Riverpod | State management & dependency injection |
| Dio | Networking |
| Freezed | Immutable models |
| json_serializable | JSON serialization |
| Isar | Local database |
| GoRouter | Navigation |
| Cached Network Image | Image caching |
| Connectivity Plus | Network status detection |
| Internet Connection Checker | Internet availability verification |
| Flutter Hooks | Cleaner widget lifecycle management |
| Logger | Application logging |
| Flutter Secure Storage | Secure local storage |
| Workmanager | Background synchronization |
| dio_cache_interceptor | HTTP response caching |

---

# Architecture

The application follows a Feature-First Clean Architecture.

```
Presentation
        │
        ▼
Domain
        │
        ▼
Data
        │
        ▼
Core
```

Project structure:

```
lib/
│
├── app/
├── core/
├── features/
├── shared/
└── main.dart
```

---

# Project Structure

```
docs/
├── README.md
├── architecture.md
├── networking.md
├── project_structure.md
├── technology_stack.md
└── decisions/
```

Application source:

```
lib/
├── app/
├── core/
├── features/
└── shared/
```

---

# API

This project uses the EscuelaJS Fake Store API.

Base URL

```
https://api.escuelajs.co/api/v1
```

Main endpoints:

```
GET /products
GET /products/{id}
GET /categories
```

---

# Learning Focus

This project explores:

- Clean Architecture
- Repository Pattern
- Offline-First Architecture
- Local caching
- Network synchronization
- Dependency Injection
- Feature modularization
- Responsive UI
- Professional project organization

---

# Documentation

Additional project documentation can be found in the `docs/` directory.

- Architecture
- Networking
- State Management
- Offline-First Strategy
- Coding Guidelines
- Architecture Decision Records (ADR)

---

# Getting Started

## Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Git

## Installation

Clone the repository.

```bash
git clone <repository-url>
```

Navigate into the project.

```bash
cd low_connectivity_learning_app
```

Install dependencies.

```bash
flutter pub get
```

Run the application.

```bash
flutter run
```

---

# Project Status

| Module | Status |
|---------|--------|
| Project Setup | ✅ |
| Theme | ✅ |
| Router | ✅ |
| Responsive Layout | ✅ |
| Shared Widgets | ✅ |
| Network Configuration | 🚧 |
| API Client | ⏳ |
| Products Feature | ⏳ |
| Offline Cache | ⏳ |
| Background Sync | ⏳ |

---

# Roadmap

- Complete networking layer
- Build Products feature
- Implement Isar local database
- Offline synchronization
- Categories feature
- Search
- Performance optimization
- Testing
- CI/CD

---

# License

This project is intended for educational and learning purposes.