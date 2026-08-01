# SOLID Principles

## Overview

SOLID is a set of five software design principles introduced by Robert C. Martin ("Uncle Bob").

These principles help developers build software that is:

- Easy to understand
- Easy to extend
- Easy to test
- Easy to maintain
- Less prone to bugs

Rather than focusing on syntax, SOLID focuses on **how responsibilities should be distributed across classes and modules**.

Shop Lite follows these principles throughout its architecture.

---

# The Five Principles

SOLID stands for:

- **S** — Single Responsibility Principle (SRP)
- **O** — Open/Closed Principle (OCP)
- **L** — Liskov Substitution Principle (LSP)
- **I** — Interface Segregation Principle (ISP)
- **D** — Dependency Inversion Principle (DIP)

Each principle addresses a different aspect of software design.

---

# 1. Single Responsibility Principle (SRP)

> A class should have one reason to change.

Every class should focus on a single responsibility.

### Good Example

```text
ProductRepository

↓

Only retrieves product data.
```

```text
ProductRemoteDataSource

↓

Only communicates with the API.
```

```text
ProductModel

↓

Only represents product data.
```

Each class has a clear purpose.

---

### Poor Example

```text
ProductRepository

↓

Calls the API

Stores data locally

Formats prices

Logs analytics

Navigates to another page
```

This class now has many unrelated responsibilities.

---

### Shop Lite Examples

Good:

```
ApiClient

↓

Only performs HTTP requests.
```

```
PrimaryButton

↓

Only displays a styled button.
```

```
AppCachedImage

↓

Only displays cached images.
```

---

# 2. Open/Closed Principle (OCP)

> Software should be open for extension but closed for modification.

Instead of changing existing code, extend it.

Example:

Suppose we initially support only product images.

Later we want avatar images.

Instead of modifying:

```
AppCachedImage
```

to become increasingly specialized, we extend its capabilities through additional configurable properties.

Good:

```dart
AppCachedImage(
  imageUrl: url,
  shape: ImageShape.circle,
)
```

instead of creating:

```
ProductImage

AvatarImage

CategoryImage

BannerImage
```

that duplicate most of the implementation.

---

# 3. Liskov Substitution Principle (LSP)

> Subtypes should be usable wherever their base type is expected.

If a function expects a repository abstraction, any valid implementation should work.

Example:

```text
ProductRepository
```

can be implemented by:

```
RemoteProductRepository
```

or

```
FakeProductRepository
```

The caller should not need to know which implementation it receives.

This is especially useful for testing.

---

# 4. Interface Segregation Principle (ISP)

> Clients should not depend on methods they do not use.

Prefer small, focused interfaces.

Poor example:

```dart
abstract class Repository {
  getProducts();
  login();
  uploadImage();
  processPayment();
}
```

A product feature should not depend on authentication or payments.

Better:

```dart
abstract class ProductRepository {}
```

```dart
abstract class AuthRepository {}
```

```dart
abstract class PaymentRepository {}
```

Each interface serves one area of the application.

---

# 5. Dependency Inversion Principle (DIP)

> Depend on abstractions, not concrete implementations.

Instead of this:

```dart
class ProductRepository {

  final Dio dio = Dio();

}
```

Prefer:

```dart
class ProductRepository {

  ProductRepository(this._apiClient);

  final ApiClient _apiClient;

}
```

The repository depends on the abstraction (`ApiClient`) rather than constructing its own networking implementation.

Riverpod supplies the dependency.

---

# SOLID in Shop Lite

The architecture naturally supports SOLID.

```
Presentation

↓

Provider

↓

Repository

↓

Data Source

↓

ApiClient

↓

Dio
```

Each layer has a focused responsibility and communicates through clear boundaries.

---

# Benefits

Applying SOLID makes the application:

- Easier to test
- Easier to extend
- Easier to refactor
- More modular
- Less coupled
- More maintainable

---

# Common Mistakes

Avoid:

- Large "manager" classes that do everything.
- Widgets containing networking logic.
- Repositories creating their own dependencies.
- One interface covering unrelated features.
- Copying and modifying existing code instead of extending reusable components.

---

# Practical Checklist

Before creating or modifying a class, ask:

- Does this class have only one responsibility?
- Can I extend this instead of modifying existing behavior?
- Am I depending on an abstraction?
- Is this interface focused?
- Could I replace this implementation during testing?

If the answer to any question is "no," reconsider the design.

---

# Summary

SOLID provides a foundation for designing maintainable software.

In Shop Lite, it influences:

- Feature organization
- Dependency Injection
- Repository pattern
- Riverpod providers
- Reusable widgets
- Networking
- Testing

By following these principles consistently, the codebase remains easier to understand, evolve, and maintain as the application grows.