# Feature Architecture

## Overview

Every feature in Shop Lite follows the same internal architecture.

The purpose of this document is to define:

- How a feature is organized.
- What each folder is responsible for.
- How data flows through the feature.
- Where new files should be created.
- How each layer communicates with the others.

By following a consistent structure, every feature remains predictable, maintainable, and easy to understand.

---

# Why This Exists

Without a defined feature architecture, developers often struggle with questions such as:

- Where should this model go?
- Should this provider be inside `core` or inside the feature?
- Can this widget be shared?
- Where should API calls be made?
- Where should business logic live?

A consistent architecture removes uncertainty and keeps the project organized.

---

# Feature Structure

Every feature follows this structure:

```text
feature_name/

├── data/
│   ├── datasources/
│   │   ├── remote/
│   │   └── local/
│   │
│   ├── models/
│   │
│   ├── mappers/
│   │
│   └── repositories/
│
├── domain/
│   ├── entities/
│   │
│   ├── repositories/
│   │
│   └── usecases/
│
├── presentation/
│   ├── pages/
│   │
│   ├── widgets/
│   │
│   └── controllers/
│
└── providers/
```

Every folder has one clear responsibility.

---

# Layer Responsibilities

The feature consists of three main layers:

```text
Presentation
       │
       ▼
Domain
       │
       ▼
Data
```

Dependencies always flow downward.

The Data layer must never depend on the Presentation layer.

---

# Presentation Layer

The Presentation layer is responsible for everything the user sees and interacts with.

```text
presentation/

├── pages/
├── widgets/
└── controllers/
```

---

## Pages

Pages represent complete screens.

Examples:

```text
ProductsPage

ProductDetailsPage

SearchPage
```

Pages should:

- Build layouts.
- Watch providers.
- Respond to user interactions.
- Navigate between screens.

Pages should **not**:

- Call APIs directly.
- Parse JSON.
- Perform business calculations.

---

## Widgets

Widgets are reusable UI components specific to the feature.

Examples:

```text
ProductCard

ProductPrice

RatingStars

CategoryChip
```

If a widget is only used by the Products feature, it belongs here.

If it is reused across multiple features, move it to:

```text
shared/widgets/
```

---

## Controllers

Controllers manage UI-specific behavior.

Examples:

- ScrollController
- TextEditingController
- AnimationController

Business logic should not be placed here.

---

# Providers

Providers connect the Presentation layer with the Domain layer.

Example:

```text
ProductsPage
      │
      ▼
productsProvider
      │
      ▼
GetProductsUseCase
```

Providers are responsible for:

- Managing state.
- Calling use cases.
- Exposing loading, success, and error states.
- Dependency injection.

Providers should not:

- Parse JSON.
- Make HTTP requests directly.
- Contain UI code.

---

# Domain Layer

The Domain layer contains the application's business rules.

```text
domain/

├── entities/
├── repositories/
└── usecases/
```

The Domain layer has no knowledge of:

- Flutter
- Dio
- SQLite/Isar
- JSON
- Widgets

This keeps business logic independent of implementation details.

---

## Entities

Entities represent business objects.

Example:

```text
Product
```

An entity contains only the data and behavior needed by the business.

Entities do not include:

- JSON serialization
- API-specific fields
- Database annotations

---

## Repository Contracts

Repository contracts define what the feature needs, not how it is implemented.

Example:

```dart
abstract class ProductRepository {
  Future<List<Product>> getProducts();

  Future<Product> getProduct(int id);
}
```

The implementation belongs in the Data layer.

---

## Use Cases

Use cases represent business actions.

Examples:

```text
GetProducts

SearchProducts

GetProductDetails
```

Each use case should perform one business operation.

Example:

```text
User taps Refresh

        │

        ▼

GetProductsUseCase

        │

        ▼

Repository
```

---

# Data Layer

The Data layer communicates with external systems.

```text
data/

├── datasources/
├── models/
├── mappers/
└── repositories/
```

---

## Data Sources

Data sources know where data comes from.

Examples:

```text
ProductRemoteDataSource

ProductLocalDataSource
```

Responsibilities:

- Call REST APIs.
- Read/write local storage.
- Return models.

---

## Models

Models represent external data.

Examples:

```text
ProductModel

CategoryModel
```

Responsibilities:

- JSON serialization.
- JSON deserialization.
- API response mapping.

Models should not contain business logic.

---

## Mappers

Mappers convert between Models and Entities.

```text
ProductModel

      │

      ▼

Product
```

Example:

```dart
Product product = productModel.toEntity();
```

Keeping mapping separate prevents models from becoming tightly coupled to business logic.

---

## Repository Implementations

Repository implementations coordinate data retrieval.

Example:

```text
Repository

      │

      ├── Remote Data Source

      └── Local Data Source
```

Responsibilities:

- Decide where data comes from.
- Cache data when appropriate.
- Handle failures.
- Return entities to the Domain layer.

---

# Data Flow

A complete request follows this path:

```text
User
 │
 ▼
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

The response flows back through the same layers in reverse.

---

# Shared vs Feature Code

A simple rule:

**Feature-specific?**

Place it inside the feature.

Examples:

```text
ProductCard

ProductPrice

SearchProductsUseCase
```

---

**Used by multiple features?**

Move it to:

```text
shared/
```

Examples:

```text
PrimaryButton

AppTextField

AppCachedImage

AppLoader
```

---

# Naming Conventions

Use clear, descriptive names.

Examples:

```text
ProductRepository

ProductRemoteDataSource

GetProductsUseCase

ProductsPage

ProductCard

productsProvider
```

Avoid vague names such as:

```text
Manager

Helper

Utils

Processor

Thing
```

---

# Common Mistakes

### Putting API calls inside widgets

❌ Incorrect:

```dart
onPressed() async {
  final products = await dio.get(...);
}
```

Widgets should trigger actions, not perform networking.

---

### Returning Models from the Domain layer

The Domain layer should work with entities, not API models.

Correct flow:

```text
API
 ↓
ProductModel
 ↓
Mapper
 ↓
Product
```

---

### Mixing UI and business logic

Business rules belong in use cases or repositories.

Widgets should focus on presentation.

---

### Sharing feature-specific widgets

Do not place `ProductCard` in `shared/` if it is only used by the Products feature.

Move code to `shared/` only when it is genuinely reused.

---

# Best Practices

- Keep each layer independent.
- One responsibility per class.
- Depend on abstractions.
- Use entities in the Domain layer.
- Use models only in the Data layer.
- Keep providers focused on state management.
- Extract reusable widgets thoughtfully.
- Keep folder structures consistent across features.

---

# Review Checklist

Before adding a new file, ask:

- Does it belong to this feature?
- Is it Presentation, Domain, or Data?
- Does it have one responsibility?
- Should it be shared?
- Does it depend only on the correct layer?
- Will another developer know where to find it?

---

# Summary

Every Shop Lite feature follows the same internal architecture:

```text
Presentation
      │
      ▼
Domain
      │
      ▼
Data
```

Each layer has a clear responsibility:

- **Presentation** displays information and handles user interaction.
- **Domain** contains business rules and defines contracts.
- **Data** retrieves, stores, and transforms information.

Following this structure ensures that every feature is consistent, scalable, testable, and easy to maintain as Shop Lite grows.