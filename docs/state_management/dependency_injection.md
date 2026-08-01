# Dependency Injection

## Overview

Dependency Injection (DI) is a software design principle used to supply an object with the dependencies it needs instead of allowing the object to create those dependencies itself.

In Shop Lite, Dependency Injection is implemented using **Riverpod**.

This approach improves:

- Testability
- Flexibility
- Maintainability
- Scalability
- Separation of concerns

---

# What is a Dependency?

A dependency is any object another object requires to perform its work.

Example:

```text
ProductsPage

↓

ProductRepository
```

The `ProductRepository` is a dependency of `ProductsPage`.

Another example:

```text
ProductRepository

↓

ProductRemoteDataSource
```

Here, the remote data source is a dependency of the repository.

---

# The Problem Without Dependency Injection

Imagine a repository that creates everything itself.

```dart
class ProductRepository {

  final Dio dio = Dio();

}
```

Problems:

- Cannot replace Dio.
- Difficult to test.
- Tightly coupled.
- Every repository creates its own network client.
- Configuration becomes duplicated.

This approach violates several software engineering principles.

---

# The Better Approach

Instead, dependencies are provided externally.

```text
Riverpod

↓

Creates Dio

↓

Creates ApiClient

↓

Creates Repository

↓

Provides Repository

↓

UI
```

Objects receive dependencies instead of constructing them.

---

# Dependency Graph

Shop Lite follows this dependency graph.

```text
Dio
 │
 ▼
ApiClient
 │
 ▼
Remote Data Source
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
UI
```

Each object depends only on the layer directly beneath it.

---

# Object Creation

Instead of this:

```dart
final dio = Dio();
```

we use Riverpod providers.

Example:

```dart
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});
```

Other providers depend on it.

```dart
final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);

  return DioApiClient(dio);
});
```

Notice that the API client does not create Dio itself.

---

# Constructor Injection

Shop Lite uses **constructor injection**.

Example:

```dart
class ProductRepositoryImpl
    implements ProductRepository {

  ProductRepositoryImpl(
    this._remoteDataSource,
  );

  final ProductRemoteDataSource _remoteDataSource;
}
```

The dependency is supplied through the constructor.

Advantages:

- Easy to understand
- Easy to test
- Explicit dependencies
- Immutable objects

This is the preferred form of dependency injection throughout the project.

---

# Provider Composition

Providers build upon one another.

Example:

```text
dioProvider
      │
      ▼
apiClientProvider
      │
      ▼
remoteDataSourceProvider
      │
      ▼
productRepositoryProvider
      │
      ▼
productsProvider
```

This creates a clear dependency chain.

---

# Why Not Use Global Variables?

Avoid:

```dart
final dio = Dio();
```

declared globally and used everywhere.

Problems:

- Hidden dependencies
- Difficult testing
- Shared mutable state
- Harder lifecycle management

Riverpod solves these issues by managing object creation and scope.

---

# Lifetime Management

Different dependencies have different lifetimes.

Examples:

## Application Lifetime

Created once and reused.

Examples:

- Dio
- Logger
- ApiClient
- Database

---

## Feature Lifetime

Created when a feature is used.

Examples:

- ProductRepository
- CartRepository

---

## Screen Lifetime

Created when a screen opens and disposed when it closes.

Examples:

- Search state
- Temporary filters
- Product details state

Riverpod manages these lifecycles automatically.

---

# Dependency Flow

Dependencies always flow downward.

```text
UI

↓

Provider

↓

Repository

↓

Remote Data Source

↓

ApiClient

↓

Dio
```

Lower layers should never depend on higher layers.

Incorrect:

```text
Repository

↓

ProductsPage
```

---

# Testing Benefits

Dependency Injection makes testing straightforward.

Production:

```text
ProductsProvider

↓

Real Repository

↓

Real API
```

Testing:

```text
ProductsProvider

↓

Fake Repository

↓

Fake Data
```

The UI behaves the same while using predictable test data.

---

# Single Responsibility

Each provider should create only one object.

Good:

```dart
Provider<ApiClient>
```

Bad:

```dart
Provider<ApiClient>

↓

Creates Dio

Creates Logger

Creates Repository

Creates Database
```

Keep providers focused.

---

# Circular Dependencies

Avoid situations where objects depend on each other.

Incorrect:

```text
Repository A

↓

Repository B

↓

Repository A
```

Circular dependencies increase complexity and make object creation impossible.

Design dependencies to flow in one direction.

---

# Best Practices

- Use constructor injection.
- Keep dependencies explicit.
- Avoid global singletons where Riverpod can manage lifecycles.
- One provider should create one object.
- Depend on abstractions where practical.
- Keep dependency graphs simple.
- Let Riverpod manage object creation.

---

# Common Mistakes

Avoid:

- Creating `Dio()` inside repositories.
- Creating databases inside widgets.
- Creating repositories inside pages.
- Using `new` instances throughout the codebase.
- Hiding dependencies as static variables.

Instead, expose these objects through providers.

---

# Summary

Dependency Injection is the mechanism by which objects receive the dependencies they require rather than constructing them themselves.

In Shop Lite:

- Riverpod acts as the dependency injection framework.
- Dependencies are provided through constructor injection.
- Providers compose the dependency graph.
- Lifecycles are managed automatically.
- The architecture remains modular, testable, and scalable.