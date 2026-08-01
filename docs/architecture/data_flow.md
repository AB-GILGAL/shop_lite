# Data Flow

## Overview

Every application exists to move data.

A user performs an action, the application processes that request, retrieves or modifies data, updates the user interface, and waits for the next interaction.

Understanding how data flows through Shop Lite is essential for building predictable, maintainable, and testable features.

This document defines the standard data flow for every feature in the application.

---

# Why This Exists

Without a defined data flow, developers often:

- Call APIs directly from widgets.
- Mix business logic with UI code.
- Duplicate network requests.
- Update state in multiple places.
- Create unpredictable application behavior.

A consistent data flow ensures that every request follows the same path.

---

# The Core Principle

Data always flows through the architecture.

It never skips layers.

The standard flow is:

```text
User
    │
    ▼
Presentation
    │
    ▼
Provider
    │
    ▼
Use Case
    │
    ▼
Repository
    │
    ▼
Data Source
    │
    ▼
ApiClient / Database
```

The response then travels back through the same path.

---

# Request Flow

Suppose a user opens the Products page.

The request moves through the application like this:

```text
ProductsPage

      │

      ▼

productsProvider

      │

      ▼

GetProductsUseCase

      │

      ▼

ProductRepository

      │

      ▼

ProductRepositoryImpl

      │

      ▼

ProductRemoteDataSource

      │

      ▼

ApiClient

      │

      ▼

REST API
```

The API returns data.

The response follows the reverse path.

---

# Response Flow

```text
REST API

      │

      ▼

ApiClient

      │

      ▼

ProductModel

      │

      ▼

ProductMapper

      │

      ▼

Product Entity

      │

      ▼

Repository

      │

      ▼

Use Case

      │

      ▼

Provider

      │

      ▼

ProductsPage
```

The UI is updated automatically.

---

# Why Models Become Entities

The API returns models.

Example:

```text
ProductModel
```

The UI should not depend on API-specific structures.

Instead:

```text
ProductModel

      │

      ▼

ProductMapper

      │

      ▼

Product
```

The application now works with business objects rather than API objects.

This protects the application from API changes.

---

# Provider Responsibilities

Providers manage application state.

They are responsible for:

- Triggering use cases.
- Exposing loading state.
- Exposing success state.
- Exposing error state.
- Refreshing data.

Providers should not:

- Parse JSON.
- Call Dio directly.
- Contain widget code.

---

# Repository Responsibilities

Repositories coordinate data.

They decide:

- Should data come from the API?
- Should cached data be used?
- Should local storage be updated?

Repositories hide these implementation details from the rest of the application.

---

# Data Sources

Data sources retrieve data.

Examples:

```text
Remote Data Source

↓

REST API
```

```text
Local Data Source

↓

Isar Database
```

Each data source knows only one storage mechanism.

---

# Offline-First Flow

When offline support is enabled, the flow becomes:

```text
User

 │

 ▼

Provider

 │

 ▼

Repository

 ├─────────────┐
 │             │
 ▼             ▼

Local      Remote
Data        Data

 │             │
 └──────┬──────┘
        ▼

   Repository

        ▼

    Provider

        ▼

       UI
```

The repository determines the appropriate source based on network availability and caching policies.

---

# Error Flow

Errors follow the same architecture.

```text
API

↓

ApiClient

↓

NetworkException

↓

Repository

↓

Failure

↓

Provider

↓

UI
```

The user interface receives a meaningful state instead of a raw exception.

---

# State Flow

Every asynchronous operation should expose four primary states.

```text
Loading

↓

Success

↓

Empty

↓

Error
```

Example:

```dart
AsyncValue<List<Product>>
```

The UI reacts to the state instead of manually managing loading flags.

---

# User Action Example

Example:

The user taps:

```
Add to Cart
```

Flow:

```text
Button

↓

Provider

↓

AddToCartUseCase

↓

CartRepository

↓

Local Database

↓

Provider

↓

Cart Badge Updates
```

The widget never communicates directly with the database.

---

# Why This Architecture Works

Each layer has one responsibility.

| Layer | Responsibility |
|--------|----------------|
| Presentation | Display information |
| Provider | Manage state |
| Use Case | Execute business action |
| Repository | Coordinate data |
| Data Source | Retrieve or store data |
| ApiClient | Perform HTTP requests |

This separation keeps the application predictable and easy to test.

---

# Common Mistakes

### Calling APIs from widgets

Incorrect:

```dart
onPressed() async {
  await dio.get(...);
}
```

Correct:

```dart
ref.read(productsProvider.notifier).refresh();
```

---

### Returning Models to the UI

Incorrect:

```text
ProductModel
```

Correct:

```text
Product Entity
```

The UI should remain independent of API implementation details.

---

### Skipping Layers

Incorrect:

```text
Widget

↓

Repository
```

Correct:

```text
Widget

↓

Provider

↓

Use Case

↓

Repository
```

Maintaining the complete flow keeps responsibilities clear.

---

# Real Shop Lite Example

Loading products follows this sequence:

```text
ProductsPage

↓

productsProvider

↓

GetProductsUseCase

↓

ProductRepository

↓

ProductRepositoryImpl

↓

ProductRemoteDataSource

↓

ApiClient

↓

https://api.escuelajs.co/api/v1/products
```

The response:

```text
ProductModel

↓

ProductMapper

↓

Product

↓

Provider

↓

ProductsPage
```

---

# Best Practices

- Follow the same flow for every feature.
- Never skip architectural layers.
- Keep each layer focused on one responsibility.
- Convert models to entities before reaching the Domain layer.
- Let providers expose state.
- Keep widgets passive.

---

# Review Checklist

Before implementing a feature, ask:

- Does the request follow the correct data flow?
- Is business logic inside the Use Case?
- Does the repository coordinate data sources?
- Are models converted to entities?
- Does the UI react only to provider state?
- Are exceptions translated into user-friendly states?

---

# Summary

Every feature in Shop Lite follows a consistent data flow:

```text
User
   ↓
Presentation
   ↓
Provider
   ↓
Use Case
   ↓
Repository
   ↓
Data Source
   ↓
ApiClient / Database
```

This predictable flow improves maintainability, testability, and scalability while keeping responsibilities clearly separated across the application.