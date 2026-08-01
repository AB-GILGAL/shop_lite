# State Management with Riverpod

## Overview

Shop Lite uses **Riverpod** as its state management and dependency injection solution.

Riverpod was chosen because it provides:

- Compile-time safety
- Dependency injection
- Testability
- Scalability
- Predictable state management
- No dependency on the widget tree

Unlike `Provider`, Riverpod providers exist independently of the widget hierarchy, making them easier to test and reuse.

---

# Why Riverpod?

As applications grow, managing state becomes increasingly complex.

Examples of state include:

- Product list
- Shopping cart
- User profile
- Search query
- Theme mode
- Network status
- Authentication status

Riverpod provides a structured way to manage all of these.

---

# Responsibilities

Riverpod is responsible for:

- Managing UI state
- Providing dependencies
- Creating repositories
- Managing services
- Exposing asynchronous data
- Reacting to state changes

Riverpod is **not** responsible for:

- Business logic
- Network requests
- Database implementation

Those responsibilities belong to repositories and data sources.

---

# State Flow

The application follows a one-way state flow.

```text
User Interaction
        │
        ▼
Widget
        │
        ▼
Provider
        │
        ▼
Repository
        │
        ▼
Data Source
        │
        ▼
API / Database
```

The response returns through the same chain.

---

# Provider Categories

Shop Lite uses different provider types depending on the problem being solved.

## Provider

Used for immutable dependencies.

Examples:

- ApiClient
- Logger
- Repository
- Services

Example:

```dart
final loggerProvider = Provider<Logger>((ref) {
  return Logger();
});
```

---

## FutureProvider

Used when loading asynchronous data once.

Examples:

- Load products
- Load categories
- Load settings

Example:

```dart
final productsProvider =
    FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});
```

---

## StateProvider

Used for simple mutable state.

Examples:

- Selected tab
- Search text
- Filter selection

Avoid using `StateProvider` for complex business logic.

---

## StateNotifierProvider

Used for complex mutable state.

Examples:

- Shopping cart
- Authentication
- Checkout process

Business rules should live inside the notifier, not inside widgets.

---

## StreamProvider

Used for continuous data streams.

Examples:

- Connectivity status
- Live synchronization
- Real-time updates

---

# Dependency Injection

Riverpod also manages dependencies.

Example:

```text
Repository Provider
        │
        ▼
Remote Data Source Provider
        │
        ▼
Api Client Provider
        │
        ▼
Dio Provider
```

Each layer receives only the dependencies it needs.

---

# Watching vs Reading

Riverpod provides two common ways to access providers.

## ref.watch()

Subscribes to changes.

The widget rebuilds whenever the provider changes.

Use inside widgets when the UI should react automatically.

---

## ref.read()

Reads the current value once.

Does not rebuild the widget.

Commonly used inside button callbacks or notifiers.

---

# Auto Dispose

Some providers should be automatically destroyed when no longer used.

Example:

- Search screen
- Product details
- Temporary filters

Using `autoDispose` helps reduce memory usage.

---

# Provider Naming Convention

All providers should end with `Provider`.

Examples:

```text
productRepositoryProvider

apiClientProvider

productsProvider

cartProvider
```

This makes providers easy to identify throughout the codebase.

---

# Folder Organization

Feature-specific providers belong inside the feature.

Example:

```text
features/
└── products/
    └── providers/
        ├── product_provider.dart
        └── product_state.dart
```

Application-wide providers belong in `core` or `shared` as appropriate.

---

# UI Responsibilities

Widgets should:

- Watch providers
- Display state
- Trigger actions

Widgets should **not**:

- Perform API calls
- Access databases directly
- Contain business logic

Keep widgets focused on presentation.

---

# Error Handling

Asynchronous providers expose three common states:

- Loading
- Data
- Error

The UI should handle each state explicitly to provide a good user experience.

---

# Testing

Because dependencies are provided through Riverpod, they can easily be overridden during tests.

Example:

```text
Real Repository

↓

Fake Repository
```

This allows UI and business logic to be tested independently of real APIs.

---

# Best Practices

- Keep providers focused on one responsibility.
- Keep business logic out of widgets.
- Use the simplest provider type that solves the problem.
- Group providers by feature.
- Name providers consistently.
- Avoid unnecessary provider nesting.
- Dispose of temporary state when appropriate.

---

# Summary

Riverpod serves as the central state management and dependency injection solution for Shop Lite.

It connects the UI to repositories, manages application state, and keeps dependencies organized while promoting a clean, scalable architecture.