# Clean Code

## Overview

Clean Code is the practice of writing software that is easy to read, understand, maintain, and extend.

Code is read far more often than it is written. Therefore, every piece of code should communicate its purpose clearly.

The goal of Clean Code is not simply to make the program work—it is to make the program understandable.

Shop Lite follows Clean Code principles throughout the codebase.

---

# Why Clean Code?

Imagine returning to this project after one year.

Would you immediately understand:

```dart
final x = y.a(b);
```

Probably not.

Now compare it with:

```dart
final products = repository.getProducts();
```

The second version clearly communicates its intention.

Good code should explain itself.

---

# Core Principles

Clean Code is built upon several guiding principles.

- Meaningful names
- Small functions
- Single responsibility
- Readability
- Consistency
- Simplicity
- Low duplication
- Proper formatting

---

# 1. Use Meaningful Names

Names should explain purpose.

Good:

```dart
final productRepository = ref.read(productRepositoryProvider);
```

Bad:

```dart
final p = ref.read(repo);
```

Readers should not have to guess what a variable represents.

---

## Class Names

Classes should represent nouns.

Good:

```text
ProductRepository

ProductModel

ApiClient

NetworkConfiguration
```

Avoid vague names.

Bad:

```text
Manager

Helper

Processor

Utility

Handler
```

These names usually hide multiple responsibilities.

---

## Method Names

Methods should describe actions.

Good:

```dart
fetchProducts()

saveProducts()

deleteProduct()

updateCart()
```

Avoid:

```dart
run()

execute()

process()

doStuff()
```

Method names should explain exactly what they do.

---

## Boolean Variables

Boolean names should read naturally.

Good:

```dart
isLoading

hasInternetConnection

canCheckout

isLoggedIn
```

Bad:

```dart
loading

internet

checkout

login
```

The reader should immediately know the variable represents a true/false value.

---

# 2. Keep Functions Small

Functions should perform one task.

Good:

```dart
void refreshProducts() {
  repository.refreshProducts();
}
```

Avoid functions that span hundreds of lines or perform unrelated operations.

Large functions are difficult to understand and test.

---

# 3. One Responsibility Per Function

Each function should answer one question.

Good:

```dart
calculateTotal()
```

Bad:

```dart
calculateTotalAndSendEmail()
```

Separate responsibilities into separate functions.

---

# 4. Avoid Deep Nesting

Deep nesting reduces readability.

Instead of:

```dart
if (user != null) {
  if (user.isVerified) {
    if (user.hasSubscription) {
      // ...
    }
  }
}
```

Prefer early returns:

```dart
if (user == null) return;

if (!user.isVerified) return;

if (!user.hasSubscription) return;

// ...
```

The main logic becomes easier to follow.

---

# 5. Prefer Constants

Avoid repeating values.

Instead of:

```dart
SizedBox(height: 16)
```

use:

```dart
SizedBox(height: AppSizes.md)
```

Instead of:

```dart
Duration(milliseconds: 300)
```

use:

```dart
AppDurations.medium
```

Centralized values improve consistency.

---

# 6. Avoid Magic Numbers

Numbers without context make code difficult to understand.

Bad:

```dart
if (products.length > 20)
```

Better:

```dart
if (products.length > maxProductsPerPage)
```

The name explains the purpose of the value.

---

# 7. Avoid Duplicate Code

If the same logic appears multiple times, consider extracting it.

Instead of:

```dart
TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
)
```

repeated across many widgets, define:

```dart
AppTextStyles.titleMedium
```

Reuse improves consistency and reduces maintenance.

---

# 8. Keep Widgets Small

Widgets should have one responsibility.

Good:

```text
ProductCard
```

Bad:

```text
ProductsPage

↓

Contains

AppBar

Search

Grid

Pagination

Filtering

Sorting

Dialogs

Navigation
```

Break large screens into reusable widgets.

---

# 9. Write Self-Documenting Code

Good code minimizes the need for comments.

Instead of:

```dart
// Increment page number
page++;
```

Prefer:

```dart
currentPage++;
```

The code already communicates its purpose.

---

# 10. Comment Why, Not What

Use comments to explain decisions rather than obvious behavior.

Good:

```dart
// Categories rarely change, so we cache them for 24 hours.
```

Avoid:

```dart
// Add one to currentPage.
currentPage++;
```

The code already makes that clear.

---

# 11. Keep Files Focused

Each file should have a clear purpose.

Good:

```text
product_repository.dart
```

Avoid:

```text
helpers.dart
```

filled with unrelated functions.

---

# 12. Consistent Formatting

Follow consistent formatting rules.

Examples:

- One public class per file.
- Organized imports.
- Consistent spacing.
- Consistent indentation.
- Consistent line length.

Formatting consistency improves readability.

---

# 13. Fail Clearly

Handle errors in a way that makes failures easy to understand.

Instead of ignoring exceptions, provide meaningful messages or propagate them appropriately.

---

# 14. Refactor Regularly

Clean Code is not written once.

As understanding improves:

- Rename unclear variables.
- Extract reusable methods.
- Remove duplication.
- Simplify logic.

Refactoring is a normal part of development.

---

# Clean Code in Shop Lite

Examples of clean code already adopted in this project:

- `AppCachedImage` has a single responsibility.
- `NetworkConfiguration` centralizes environment settings.
- `ApiClient` abstracts HTTP communication.
- `AppSizes` removes magic spacing values.
- `AppDurations` centralizes animation timing.
- Feature-first organization keeps related code together.
- Constructor injection makes dependencies explicit.

---

# Code Review Checklist

Before committing code, ask:

- Are names descriptive?
- Does each class have one responsibility?
- Is the function doing only one thing?
- Are constants used instead of magic numbers?
- Can this code be simplified?
- Is duplication avoided?
- Would another developer understand this without explanation?

If the answer to any question is "no," consider refactoring.

---

# Summary

Clean Code is about writing software that humans can easily read and maintain.

In Shop Lite, this means:

- Meaningful names
- Small, focused classes and functions
- Reusable components
- Consistent formatting
- Centralized constants
- Minimal duplication
- Self-documenting code
- Continuous refactoring

Following these practices makes the application easier to maintain, extend, and collaborate on as it grows.