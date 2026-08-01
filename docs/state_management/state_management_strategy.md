# State Management Strategy

## Overview

Shop Lite uses Riverpod as its primary state management solution.

The purpose of state management is to provide a predictable way to:

- Store application data.
- React to changes.
- Coordinate user interactions.
- Manage asynchronous operations.
- Keep UI independent from business logic.

State should be managed according to its responsibility and lifecycle.

---

# Why This Exists

Poor state management often leads to:

- Business logic inside widgets.
- Unnecessary rebuilds.
- Duplicate API calls.
- Difficult debugging.
- Unclear ownership of data.

A clear state strategy helps developers decide:

- Where state belongs.
- Who owns the state.
- How the state changes.
- How the UI observes updates.

---

# Core Principle

Not every value needs global state.

The default rule:

> Keep state as close as possible to where it is used.

Only promote state when multiple parts of the application need access to it.

---

# Types of State

Shop Lite recognizes four major categories of state:

```text
Local UI State

↓

Feature State

↓

Application State

↓

Persistent State
```

---

# 1. Local UI State

Local UI state belongs to a single widget.

Examples:

- Password visibility.
- Selected tab.
- Expansion state.
- Animation state.
- Text field state.

Example:

```dart
bool isPasswordVisible = false;
```

This does not need Riverpod.

Use:

- `StatefulWidget`
- `ValueNotifier`
- Flutter controllers

---

Example:

```dart
class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() =>
      _PasswordFieldState();
}
```

---

# 2. Feature State

Feature state belongs to a specific business feature.

Examples:

Products:

```
productsProvider
```

Cart:

```
cartProvider
```

Favorites:

```
favoritesProvider
```

Authentication:

```
authProvider
```

This state is managed using Riverpod.

---

Example:

```
features/products/

└── providers/

    └── products_provider.dart
```

---

# 3. Application State

Application state is shared across multiple features.

Examples:

- Theme mode.
- User session.
- App settings.
- Language preference.

Location:

```
core/providers/
```

Example:

```text
themeProvider

authSessionProvider
```

---

# 4. Persistent State

Persistent state survives application restarts.

Examples:

- Login token.
- User preferences.
- Cart items.
- Cached products.

Storage options:

- SharedPreferences.
- Isar.
- Secure Storage.

Persistent state should not be directly accessed by widgets.

Flow:

```
Widget

↓

Provider

↓

Repository

↓

Storage
```

---

# Riverpod Provider Selection

Shop Lite uses the simplest provider that solves the problem.

---

# Provider

Use for dependencies.

Examples:

```dart
apiClientProvider

databaseProvider
```

Purpose:

```
Create and expose objects
```

---

# FutureProvider

Use for simple asynchronous reads.

Example:

```dart
productsProvider
```

when:

- Data is loaded.
- Displayed.
- Not manually modified.

Flow:

```
API

↓

FutureProvider

↓

UI
```

---

# NotifierProvider

Use for state that changes through user actions.

Examples:

```
CartNotifier

ThemeNotifier

AuthNotifier
```

When we need:

- Add item.
- Remove item.
- Update quantity.
- Toggle state.

---

Example:

```dart
class CartNotifier
    extends Notifier<List<CartItem>> {

}
```

---

# AsyncNotifierProvider

Use for complex asynchronous state.

Examples:

- Authentication flow.
- Checkout process.
- Profile updates.

It combines:

- State management.
- Async operations.
- Loading/error handling.

---

# State Flow

The standard Shop Lite flow:

```
User Action

↓

Widget

↓

Riverpod Provider

↓

Repository

↓

Data Source

↓

State Update

↓

UI Rebuild
```

---

# Example: Loading Products

User opens products page.

```
ProductsPage

↓

productsProvider

↓

ProductRepository

↓

API

↓

Products State

↓

UI Updates
```

---

# Example: Cart

User taps:

```
Add To Cart
```

Flow:

```
ProductCard

↓

cartNotifier

↓

Cart State

↓

Cart Badge Updates
```

---

# State Classes

For complex features, prefer explicit state classes.

Example:

```dart
class ProductsState {

 final bool isLoading;

 final List<Product> products;

 final String? error;

}
```

This is clearer than multiple unrelated variables.

---

# AsyncValue Pattern

For simple asynchronous state:

```dart
AsyncValue<List<Product>>
```

provides:

```text
Loading

↓

Data

↓

Error
```

Example:

```dart
ref.watch(productsProvider)
```

---

# Avoiding Bad State Management

## Do Not Put State Everywhere

Avoid:

```
Global Provider

for every variable
```

Not every value needs global state.

---

## Do Not Put Business Logic In Providers

Bad:

```dart
productsProvider {

 calculateDiscount();

 formatPrice();

 callDatabase();

}
```

Providers should coordinate, not become service classes.

---

## Do Not Let Widgets Own Business State

Bad:

```dart
ProductsPage {

 callApi();

 saveData();

}
```

Widgets should only display and interact.

---

# Shop Lite State Organization

Example:

```
features/

└── products/

    ├── presentation/

    │   └── pages/

    │
    └── providers/

        └── products_provider.dart
```

---

Global state:

```
core/

└── providers/

    ├── theme_provider.dart

    └── app_settings_provider.dart
```

---

# Testing Benefits

Good state separation makes testing easier.

Example:

Replace:

```
Real ProductRepository
```

with:

```
Fake ProductRepository
```

The provider does not need modification.

---

# Best Practices

- Keep state close to usage.
- Avoid unnecessary global state.
- Use the simplest provider type.
- Keep providers focused.
- Separate state from business logic.
- Let repositories handle data.
- Let widgets react to state.

---

# Review Checklist

Before creating state:

- Who needs this state?
- How long should it live?
- Does it survive app restart?
- Is it UI state or business state?
- Which provider type is appropriate?
- Can this remain local?

---

# Summary

Shop Lite uses Riverpod with a clear state management strategy.

The application separates:

- Local UI state.
- Feature state.
- Application state.
- Persistent state.

Riverpod providers manage communication between the UI and business layers while keeping widgets clean and maintainable.

The goal is predictable state flow, minimal complexity, and scalable feature development.
