# Feature-First Architecture

## Overview

Shop Lite follows a Feature-First Architecture approach.

Feature-First Architecture organizes the application around business features rather than technical layers.

Instead of grouping all files by type:

```
lib/

├── models/

├── repositories/

├── screens/

├── services/

└── widgets/
```

the application is organized by what the user does:

```
lib/

├── features/

│   ├── products/

│   ├── categories/

│   ├── cart/

│   ├── favorites/

│   └── profile/

└── core/
```

---

# Why This Exists

As applications grow, traditional layer-based structures become difficult to maintain.

Example:

```
models/

product_model.dart

category_model.dart

cart_model.dart


repositories/

product_repository.dart

cart_repository.dart


screens/

products_page.dart

cart_page.dart
```

The code for one feature becomes scattered across the entire project.

A developer working on products must search multiple folders.

---

# Feature-First Solution

Each feature owns its related code.

Example:

```
features/

└── products/

    ├── data/

    ├── domain/

    ├── presentation/

    └── providers/
```

Everything related to products exists together.

---

# Shop Lite Structure

The high-level structure:

```
lib/

├── app/

├── core/

├── features/

├── shared/

└── main.dart
```

---

# App Folder

The `app` folder contains application-level configuration.

Example:

```
app/

├── router/

├── theme/

├── app.dart

└── constants/
```

Responsibilities:

- Application initialization
- Navigation
- Theme configuration
- Global settings

---

# Core Folder

The `core` folder contains functionality shared across the entire application.

Example:

```
core/

├── network/

├── database/

├── errors/

├── utils/

├── extensions/

└── storage/
```

Examples:

```
Dio configuration

Logger

Database setup

Exceptions

Validators

Extensions
```

Core should not contain feature-specific logic.

---

# Features Folder

The `features` folder contains business features.

Example:

```
features/

├── products/

├── categories/

├── cart/

├── authentication/

└── profile/
```

Each feature is independent.

---

# Feature Internal Structure

Each feature follows a clean architecture structure.

Example:

```
products/

├── data/

│   ├── datasources/

│   ├── models/

│   └── repositories/


├── domain/

│   ├── entities/

│   ├── repositories/

│   └── usecases/


├── presentation/

│   ├── pages/

│   ├── widgets/

│   └── states/


└── providers/
```

---

# Data Layer

The data layer handles external communication.

Responsibilities:

- API calls
- Database operations
- Data conversion

Contains:

## Models

Example:

```
ProductModel
```

Responsible for:

- JSON conversion
- Data representation

---

## Data Sources

Example:

```
ProductRemoteDataSource
```

Responsible for:

- Calling API endpoints
- Reading local database

---

## Repository Implementation

Example:

```
ProductRepositoryImpl
```

Responsible for coordinating:

```
Remote Data

+

Local Data
```

---

# Domain Layer

The domain layer contains business rules.

Responsibilities:

- Entities
- Use cases
- Repository contracts

The domain layer should not know about:

- Dio
- JSON
- Flutter widgets
- Database implementation

---

## Entities

Entities represent business concepts.

Example:

```
Product
```

not:

```
ProductModel
```

because models belong to data sources.

---

## Repository Contracts

Example:

```dart
abstract class ProductRepository {

  Future<List<Product>> getProducts();

}
```

The domain layer defines what is needed.

The data layer decides how it is achieved.

---

## Use Cases

Use cases represent application actions.

Examples:

```
GetProducts

GetProductDetails

SearchProducts
```

They contain business logic.

---

# Presentation Layer

The presentation layer contains everything related to the UI.

Contains:

```
pages/

widgets/

states/
```

Responsibilities:

- Display data
- Handle user interaction
- React to state changes

Should not:

- Call APIs directly
- Access databases
- Perform business calculations

---

# Providers

Providers connect the presentation layer with business logic.

Example:

```
ProductPage

↓

productsProvider

↓

ProductRepository

↓

API
```

Providers manage:

- State
- Dependencies
- Async operations

---

# Shared Folder

Shared contains reusable UI components.

Example:

```
shared/

├── widgets/

├── components/

└── animations/
```

Examples:

```
PrimaryButton

AppTextField

AppCachedImage

AppLoader
```

Shared components should not contain feature-specific logic.

---

# Dependency Direction

Dependencies should flow inward.

Correct:

```
Presentation

↓

Domain

↓

Data

↓

Core
```

A lower layer should never depend on a higher layer.

---

# Example Feature Flow

Product loading:

```
ProductPage

↓

productsProvider

↓

GetProductsUseCase

↓

ProductRepository

↓

ProductRemoteDataSource

↓

ApiClient

↓

API
```

---

# Adding a New Feature

When creating a new feature:

Example:

```
favorites
```

Follow this process:

## Step 1

Create feature folder:

```
features/favorites
```

---

## Step 2

Create layers:

```
data/

domain/

presentation/

providers/
```

---

## Step 3

Define domain requirements.

Example:

```
FavoriteProduct entity

FavoriteRepository contract
```

---

## Step 4

Implement data sources.

Example:

```
FavoriteLocalDataSource
```

---

## Step 5

Create providers.

Example:

```
favoritesProvider
```

---

## Step 6

Build UI.

Example:

```
FavoritesPage
```

---

# Common Mistakes

## Creating a giant shared folder

Avoid:

```
shared/

product_widgets/

cart_logic/

user_features/
```

Shared should only contain truly reusable code.

---

## Putting business logic inside widgets

Avoid:

```dart
onPressed(){

 callApi();

 saveDatabase();

 calculateTotal();

}
```

Widgets should trigger actions, not perform them.

---

## Mixing features

Avoid:

```
products/

imports cart/

imports profile/
```

Features should communicate through clearly defined interfaces.

---

# Benefits

Feature-First Architecture provides:

- Easier navigation
- Better scalability
- Independent features
- Easier testing
- Smaller files
- Better team collaboration
- Clear ownership

---

# Review Checklist

Before adding files, ask:

- Does this belong to a feature?
- Is this shared across the entire application?
- Is this business logic or presentation?
- Is the dependency direction correct?
- Can another developer find this quickly?

---

# Summary

Shop Lite uses Feature-First Architecture to organize code around business capabilities.

The structure separates:

- Application configuration
- Shared infrastructure
- Individual features
- UI components

By combining Feature-First Architecture with Clean Architecture principles, Riverpod dependency injection, and SOLID design principles, Shop Lite becomes easier to understand, test, and scale.