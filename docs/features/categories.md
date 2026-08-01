# Categories Feature

## Overview

The Categories feature allows users to discover and organize products according to their categories.

Categories provide a way to group related products and make product discovery easier.

The feature is closely related to the Products feature, but it has its own responsibility and state.

---

# Feature Responsibilities

The Categories feature is responsible for:

* Retrieving available categories.
* Displaying categories.
* Retrieving a category by ID.
* Creating categories when administrative functionality is required.
* Updating categories when administrative functionality is required.
* Deleting categories when administrative functionality is required.
* Providing category information to other features.

The Categories feature is not responsible for:

* Managing products.
* Managing the shopping cart.
* Managing authentication.
* Processing payments.

Those responsibilities belong to their respective features.

---

# Feature Location

The feature is located at:

```text
lib/
└── features/
    └── categories/
```

It follows the standard Shop Lite feature architecture:

```text
categories/

├── data/
├── domain/
├── presentation/
└── providers/
```

---

# Relationship With Products

Categories and Products have a direct relationship.

A product belongs to a category.

Conceptually:

```text
Category
   │
   └── contains
          ↓
       Products
```

However, the Categories feature should not own the Products feature.

Instead:

```text
Categories
      ↓
Category information

Products
      ↓
Product information
```

A product may contain a category reference or category object depending on the API response and domain requirements.

---

# Data Flow

The standard Categories data flow is:

```text
CategoriesPage
      ↓
Categories Provider
      ↓
Category Repository
      ↓
Category Remote Data Source
      ↓
ApiClient
      ↓
Dio
      ↓
Categories API
```

The response travels back through the layers:

```text
Categories API
      ↓
Dio
      ↓
ApiClient
      ↓
Category Remote Data Source
      ↓
Category Model
      ↓
Mapper
      ↓
Category Entity
      ↓
Repository
      ↓
Provider
      ↓
UI
```

---

# API

Shop Lite currently uses the EscuelaJS API for development.

Base URL:

```text
https://api.escuelajs.co/api/v1
```

The base URL is managed by the application's network configuration.

The Categories feature should not hard-code the base URL.

---

# Category Endpoints

## Get All Categories

```http
GET /categories
```

Full endpoint:

```text
https://api.escuelajs.co/api/v1/categories
```

Purpose:

Retrieves the available categories.

---

## Get Category By ID

```http
GET /categories/{id}
```

Example:

```http
GET /categories/1
```

Purpose:

Retrieves a specific category.

---

## Get Products By Category

The API supports retrieving products associated with a category.

Conceptually:

```http
GET /categories/{id}/products
```

Example:

```http
GET /categories/1/products
```

This operation creates an important relationship between Categories and Products.

The final implementation should follow the API capabilities available at the time of implementation.

---

## Create Category

```http
POST /categories/
```

Purpose:

Creates a new category.

This will generally be more relevant to administrative functionality than the customer-facing application.

---

## Update Category

```http
PUT /categories/{id}
```

Purpose:

Updates an existing category.

---

## Delete Category

```http
DELETE /categories/{id}
```

Purpose:

Deletes a category.

---

# Category Model

The Data layer represents API responses using:

```text
CategoryModel
```

The model is responsible for:

* JSON deserialization.
* JSON serialization where required.
* Representing API-specific data.

Typical fields include:

```text
id
name
slug
image
```

The exact fields must follow the actual API response.

---

# Category Entity

The Domain layer uses:

```text
Category
```

The entity represents the business concept of a category.

The Domain layer should not depend directly on:

```text
CategoryModel
```

Conversion should occur through a mapper:

```text
CategoryModel
      ↓
CategoryMapper
      ↓
Category
```

This keeps API-specific structures out of the Domain layer.

---

# Repository

The Domain layer defines the repository contract.

Example responsibilities:

```text
getCategories()

getCategoryById()

getProductsByCategory()

createCategory()

updateCategory()

deleteCategory()
```

The actual implementation belongs to the Data layer.

```text
CategoryRepository
        ↓
CategoryRepositoryImpl
```

---

# Remote Data Source

The remote data source is responsible for communicating with the Categories API.

Example:

```text
CategoryRemoteDataSource
```

Responsibilities:

* Retrieve categories.
* Retrieve a category.
* Retrieve products belonging to a category.
* Create categories.
* Update categories.
* Delete categories.

The remote data source should return API models and should not contain UI logic.

---

# Providers

Providers expose category-related state to the Presentation layer.

Possible providers include:

```text
categoriesProvider

categoryProvider(id)

productsByCategoryProvider(categoryId)
```

The actual provider type should follow the project's Riverpod strategy.

For simple asynchronous reads:

```text
FutureProvider
```

may be appropriate.

For more complex asynchronous state:

```text
AsyncNotifierProvider
```

may be appropriate.

---

# Categories Page

The Categories page displays available categories.

Possible responsibilities:

* Load categories.
* Display category cards.
* Display loading state.
* Display empty state.
* Display error state.
* Navigate to category products.

Example flow:

```text
CategoriesPage
      ↓
CategoryCard
      ↓
Category Products
      ↓
ProductsPage
```

---

# Category Card

A Category Card represents an individual category.

It may display:

* Category image.
* Category name.
* Product count, if available.
* Navigation affordance.

Example:

```text
┌──────────────────────┐
│                      │
│   Category Image     │
│                      │
├──────────────────────┤
│ Electronics       →  │
└──────────────────────┘
```

The exact design should follow the Shop Lite Design System.

---

# Category Products

When the user selects a category, the application can display products belonging to that category.

Flow:

```text
CategoryCard
      ↓
Selected Category
      ↓
Category Products Provider
      ↓
Product Repository
      ↓
API
      ↓
Product List
```

An important architectural decision is that the resulting products remain **Product domain objects**, not Category-owned product objects.

The Categories feature determines which category is selected; the Products feature remains responsible for product presentation and product business rules.

---

# Loading State

When categories are being retrieved, the UI should display an appropriate loading state.

Possible implementations include:

```text
AppLoader
```

or:

```text
CategoryCardShimmer
```

The loading experience should follow the application's Design System.

---

# Empty State

If no categories are available, display an appropriate empty state.

Example:

```text
No categories available.
```

The empty state should provide clear information rather than leaving the user with a blank screen.

---

# Error State

If the Categories API request fails, the application should display a user-friendly message.

Avoid exposing raw exceptions such as:

```text
DioException: connectionTimeout
```

Prefer a message such as:

```text
Unable to load categories.
Please try again.
```

The actual exception-to-message conversion should follow the application's error-handling strategy.

---

# Caching and Offline Support

Categories may be suitable for caching because category data generally changes less frequently than transactional data.

Potential flow:

```text
Categories Request
      ↓
Repository
      ├── Local Cache
      │
      └── Remote API
```

The actual caching policy should follow:

```text
docs/networking/offline_first.md
```

The Categories feature should not independently create a separate caching mechanism.

---

# Interaction With Other Features

Categories may interact with:

```text
Products
Search
Home
```

The main relationship is with Products.

Example:

```text
Category
   ↓
Selected Category
   ↓
Products
   ↓
Product Details
```

Categories should not directly manipulate:

```text
Cart
Authentication
Payments
```

Those operations belong to their respective features.

---

# Testing

The Categories feature should eventually include tests for:

## Data Layer

* Category JSON parsing.
* Remote data source.
* Repository implementation.
* API error handling.

## Domain Layer

* Category entity.
* Repository contract.
* Business rules where applicable.

## Providers

* Successful category loading.
* Failed category loading.
* Category selection.
* Product retrieval by category.

## Presentation

* Categories displayed.
* Loading state.
* Empty state.
* Error state.
* Navigation to category products.

---

# Future Improvements

Potential future functionality includes:

* Category search.
* Category filtering.
* Product counts per category.
* Category hierarchy.
* Featured categories.
* Category caching.
* Category-based recommendations.

These features should only be implemented when they become actual requirements.

This follows the project's YAGNI principle.

---

# Feature Checklist

Before considering the Categories feature complete:

* [ ] Category model created.
* [ ] Category entity created.
* [ ] Category mapper created.
* [ ] Category repository contract created.
* [ ] Category repository implementation created.
* [ ] Category remote data source created.
* [ ] Category providers created.
* [ ] Categories page implemented.
* [ ] Category card implemented.
* [ ] Category product filtering implemented.
* [ ] Loading state implemented.
* [ ] Empty state implemented.
* [ ] Error state implemented.
* [ ] Tests added.

---

# Summary

The Categories feature provides product categorization and discovery within Shop Lite.

Its primary responsibility is category information and category selection.

The feature follows the application's standard architecture:

```text
Presentation
      ↓
Providers
      ↓
Domain
      ↓
Data
      ↓
Network
```

Categories can initiate product discovery, but the Products feature remains responsible for product-related business logic and presentation.

The feature should remain independent, testable, and consistent with the project's established architecture and engineering principles.

````

With this, your feature documentation now begins cleanly:

```text
docs/
└── features/
    ├── products.md
    └── categories.md
````

The next feature should be **Cart**, because it is the first feature that introduces significant client-side mutable state and will tie directly into the Riverpod patterns we've documented.
