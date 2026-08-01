# Dependency Flow

## Overview

This document explains how dependencies should flow throughout the Shop Lite application.

The goal is to maintain:

- Low coupling
- High testability
- Clear responsibilities
- Easy feature expansion
- Maintainable code

The application follows a **unidirectional dependency flow**.

Higher-level layers depend on lower-level abstractions, but lower-level layers should never depend on higher-level layers.

---

# Dependency Direction

The general dependency direction is:

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

Each layer has a specific responsibility.

---

# Layer Responsibilities

## Presentation Layer

Responsible for:

- Screens
- Widgets
- User interactions
- UI state
- Display logic

Examples:

```text
products_page.dart

product_card.dart

product_controller.dart
```

The presentation layer communicates with:

- Providers
- Use cases
- Domain entities

The presentation layer should NOT communicate directly with:

- APIs
- Databases
- Dio
- Isar

---

## Domain Layer

Responsible for:

- Business rules
- Entities
- Repository contracts
- Use cases

Examples:

```text
Product

ProductRepository

GetProductsUseCase
```

The domain layer represents the application's business logic.

It should be independent of external technologies.

The domain layer should NOT know about:

- Flutter widgets
- Dio
- Isar
- HTTP responses
- JSON

---

## Data Layer

Responsible for:

- Retrieving data
- Mapping models
- Implementing repositories
- Communicating with external sources

Examples:

```text
ProductModel

ProductRemoteDataSource

ProductLocalDataSource

ProductRepositoryImpl
```

The data layer communicates with:

- APIs
- Databases
- Cache

The data layer implements contracts defined by the domain layer.

---

## Core Layer

Responsible for shared infrastructure.

Examples:

```text
core/network/

core/database/

core/errors/

core/utils/
```

Core provides technical capabilities used throughout the application.

Examples:

- Dio client
- Database configuration
- Logging
- Error handling
- Storage services

Core should not know anything about business features.

---

# Dependency Rules

## Allowed Dependencies

### Presentation → Domain

Allowed:

```text
ProductsPage

        ↓

GetProductsUseCase
```

---

### Domain → Nothing External

The domain layer should remain independent.

Allowed:

```text
Domain Entity

Domain Repository Contract

Use Case
```

---

### Data → Domain

Allowed:

```text
ProductRepositoryImpl

implements

ProductRepository
```

The data layer provides the implementation.

---

### Data → Core

Allowed:

```text
ProductRemoteDataSource

uses

DioClient
```

---

### Presentation → Core

Limited usage is allowed.

Example:

```text
Presentation

uses

AppColors
AppTextStyles
```

However, business logic should not be placed in core.

---

# Forbidden Dependencies

## Data Should Not Depend on Presentation

Incorrect:

```text
ProductRepository

↓

ProductPage
```

The repository should not know that screens exist.

---

## Domain Should Not Depend on Data

Incorrect:

```text
ProductEntity

↓

ProductModel
```

The domain should not know how data is stored.

---

## Core Should Not Depend on Features

Incorrect:

```text
core/network/

↓

features/products/
```

Core is shared infrastructure.

It should work even if all features are removed.

---

# Example: Loading Products

A complete product request follows this flow:

```text
User opens Products Page

        ↓

Products Provider

        ↓

Get Products Use Case

        ↓

Product Repository Interface

        ↓

Product Repository Implementation

        ↓

Remote Data Source

        ↓

Dio Client

        ↓

API
```

The response returns through the same path:

```text
API

↓

Remote Data Source

↓

Repository

↓

Use Case

↓

Provider

↓

UI
```

---

# Offline-First Flow

Because Shop Lite is designed for low connectivity, data flow includes local storage.

Normal flow:

```text
UI

↓

Provider

↓

Repository

↓

Local Database
        +
Remote API

↓

Repository

↓

Provider

↓

UI
```

When internet is unavailable:

```text
UI

↓

Provider

↓

Repository

↓

Local Database

↓

UI
```

The UI does not need to know whether data came from:

- API
- Cache
- Database

That decision belongs to the repository layer.

---

# Dependency Injection

Dependencies are provided using Riverpod.

Example:

```text
DioClient

↓

ApiClient

↓

Repository

↓

Provider

↓

UI
```

Riverpod manages:

- Object creation
- Dependency relationships
- Lifecycle
- Testing overrides

---

# Why This Architecture?

This structure allows us to:

## Replace the API

Changing:

```text
EscuelaJS API
```

to:

```text
Real production API
```

should only affect:

```text
Data Layer
```

---

## Replace the Database

Changing:

```text
Isar
```

to:

```text
Another local database
```

should only affect:

```text
Data/Core Layer
```

---

## Test Easily

Because dependencies are separated, we can replace:

```text
Real Repository

with

Fake Repository
```

during testing.

---

# Summary

Shop Lite follows these dependency rules:

```
Presentation
      ↓
Domain
      ↓
Data
      ↓
Core
```

Rules:

- UI never talks directly to APIs.
- UI never talks directly to databases.
- Domain contains pure business logic.
- Data handles external communication.
- Core provides reusable infrastructure.
- Features remain isolated.
- Dependencies move in one direction only.

Following these rules keeps the application scalable, maintainable, and easy to test.