# Application Architecture

## Overview

Shop Lite is built using a **Feature-First Clean Architecture** with an **Offline-First** approach.

The primary goal of this architecture is to produce an application that is:

- Scalable
- Maintainable
- Testable
- Modular
- Easy to understand
- Resilient under poor network connectivity

Rather than organizing the project by file type (models, screens, services, etc.), the application is organized around **features**. Each feature owns its presentation, domain, and data layers while sharing common infrastructure through the `core` module.

---

# Architectural Principles

The architecture follows these core principles.

## Single Responsibility Principle (SRP)

Every class, file, and folder should have one clear responsibility.

Examples:

- Theme configuration belongs in `app/theme`.
- Network configuration belongs in `core/network`.
- Product-related logic belongs in the `products` feature.

---

## Separation of Concerns

Presentation should never know how data is fetched.

Repositories should never know how widgets are built.

The networking layer should never contain business logic.

Each layer performs one specific job.

---

## Dependency Direction

Dependencies always point inward.

```text
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

Higher layers depend on lower layers.

Lower layers never depend on higher layers.

---

## Reusability

Shared functionality should exist only once.

Examples include:

- Buttons
- Text fields
- Network client
- Error handling
- Theme
- Utilities

These belong in shared or core modules rather than inside individual features.

---

## Offline-First Design

The application is designed to function reliably even when internet connectivity is poor or unavailable.

Whenever possible:

- Read from the local database.
- Synchronize with the server when connectivity is available.
- Cache frequently used resources.
- Reduce unnecessary network requests.

---

# High-Level Project Structure

```text
lib/
│
├── app/
├── core/
├── features/
├── shared/
└── main.dart
```

---

# Layer Responsibilities

## app/

Contains application-wide configuration.

Examples:

- Theme
- Routing
- Localization
- Application configuration

The `app` module should never contain feature-specific business logic.

---

## core/

Contains infrastructure shared across the entire application.

Examples:

- Networking
- Local database
- Error handling
- Utilities
- Services
- Dependency injection

Everything inside `core` should be reusable by every feature.

---

## features/

Contains all business features.

Example:

```text
features/
│
├── products/
├── categories/
├── search/
└── favorites/
```

Each feature is isolated and owns its own presentation, domain, and data layers.

---

## shared/

Contains reusable UI components.

Examples:

- PrimaryButton
- AppTextField
- AppCachedImage
- Loading widgets
- Empty views

Shared widgets should not contain feature-specific business logic.

---

# Feature Structure

Each feature follows the same internal organization.

```text
products/
│
├── data/
├── domain/
├── presentation/
└── providers/
```

## Presentation

Responsible for:

- Pages
- Widgets
- UI state
- User interactions

---

## Domain

Responsible for:

- Business rules
- Entities
- Repository contracts
- Use cases (if required)

The domain layer should not know where data comes from.

---

## Data

Responsible for:

- Models
- Remote data sources
- Local data sources
- Repository implementations

This layer communicates with APIs and the local database.

---

# Data Flow

A typical request follows this path.

```text
UI
        │
        ▼
Riverpod Provider
        │
        ▼
Repository
        │
   ┌────┴────┐
   ▼         ▼
Remote    Local
Data      Database
   │         │
   └────┬────┘
        ▼
   Repository
        ▼
Riverpod Provider
        ▼
UI
```

The UI never communicates directly with the network or local database.

---

# Dependency Rules

The following dependencies are allowed.

```text
Presentation
      ↓
Domain
      ↓
Data
      ↓
Core
```

The following dependencies are **not allowed**.

```text
Core → Presentation
```

```text
Data → Presentation
```

```text
Domain → Flutter Widgets
```

Maintaining these rules prevents tight coupling between layers.

---

# Architectural Goals

This architecture aims to achieve:

- High maintainability
- Feature isolation
- Easy testing
- Offline capability
- Modular development
- Reusable components
- Professional project organization

---

# Future Enhancements

As the project evolves, this document will be expanded to include:

- Repository Pattern
- Offline synchronization
- Caching strategy
- Background workers
- State management flow
- Dependency injection
- Error handling strategy
- Authentication architecture

---

# References

Additional architectural documentation can be found in:

- `project_structure.md`
- `dependency_flow.md`
- `feature_architecture.md`
- `networking/networking.md`
- `state_management/riverpod.md`
- `database/isar.md`