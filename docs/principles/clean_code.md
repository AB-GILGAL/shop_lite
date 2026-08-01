# KISS Principle

## Overview

KISS stands for **Keep It Simple, Stupid**.

Despite its name, the principle is not an insult. It reminds developers that the simplest solution that correctly solves the problem is usually the best solution.

Complexity should only be introduced when it provides clear value.

In Shop Lite, we aim to build software that is easy to understand, maintain, test, and extend.

---

# Why Simplicity Matters

Simple code is:

- Easier to read
- Easier to debug
- Easier to test
- Easier to maintain
- Easier for new developers to understand

Complex code often leads to:

- More bugs
- More time spent debugging
- Difficult onboarding
- Slower feature development

---

# The Core Idea

Before writing code, ask yourself:

> **Is there a simpler way to solve this problem?**

If the answer is yes, prefer the simpler solution.

---

# Simplicity Over Cleverness

Avoid writing code that is clever but difficult to understand.

Good:

```dart
if (products.isEmpty) {
  return const AppEmptyView(
    message: 'No products found.',
  );
}
```

Less desirable:

```dart
return products.isNotEmpty
    ? ProductGrid(products)
    : const AppEmptyView(message: 'No products found.');
```

The second version is shorter, but the first is often easier to read, especially as conditions grow.

---

# Don't Build for Imaginary Requirements

Suppose today's requirement is:

> Display a list of products.

A simple implementation is sufficient.

Avoid adding:

- Plugin systems
- Generic abstractions
- Multiple repository implementations
- Feature flags

unless there is a real requirement.

---

# Shop Lite Examples

### Good

```text
ProductRepository

↓

Fetches products.
```

### Avoid

```text
AbstractProductRepositoryFactory

↓

RepositoryFactoryManager

↓

RepositoryResolver

↓

ProductRepository
```

The additional layers provide no benefit if there is only one repository implementation.

---

# Avoid Premature Optimization

Don't optimize code before measuring its performance.

For example:

- Do not add complex caching unless needed.
- Do not use isolates without evidence of CPU bottlenecks.
- Do not introduce pagination until the dataset requires it.

Start simple. Optimize based on real measurements.

---

# Prefer Clear Names

Simple names are better than clever names.

Good:

```dart
ProductRepository
```

Avoid:

```dart
RepositoryCoordinatorEngine
```

Names should communicate intent.

---

# Keep Functions Focused

Instead of:

```dart
processOrder()
```

that:

- validates input
- calculates totals
- saves data
- sends emails
- updates inventory

prefer separate functions with focused responsibilities.

This also aligns with the Single Responsibility Principle.

---

# Simple Architecture

A good architecture is one that is:

- Easy to navigate
- Easy to understand
- Appropriate for the project's size

Architecture should solve today's problems while leaving room for reasonable growth.

---

# Simplicity in UI

Prefer reusable widgets over deeply nested widget trees.

Instead of:

```dart
Column(
  children: [
    ...
  ],
)
```

containing hundreds of lines,

extract reusable widgets such as:

- `ProductCard`
- `CategoryChip`
- `PriceLabel`

This improves readability and reusability.

---

# Simplicity in State Management

Use the simplest Riverpod provider that fits the problem.

Examples:

- `Provider` for immutable services.
- `FutureProvider` for one-time asynchronous data.
- `StateProvider` for simple mutable state.
- `StateNotifierProvider` (or modern `NotifierProvider`/`AsyncNotifierProvider` if adopted) for complex business logic.

Avoid using a complex provider when a simpler one is sufficient.

---

# Avoid Overengineering

Signs of overengineering include:

- Creating abstractions with only one implementation and no foreseeable need for alternatives.
- Introducing patterns that solve problems the application does not have.
- Excessive inheritance.
- Deeply nested generic types.
- Creating frameworks inside your application.

Every abstraction should solve a real problem.

---

# KISS in Shop Lite

Examples of applying KISS:

- A single `ApiClient` handles HTTP communication.
- Shared UI components reduce duplication without unnecessary abstraction.
- Feature-first folder organization keeps related code together.
- Riverpod manages dependencies instead of introducing a separate DI framework.
- Centralized design tokens replace scattered hard-coded values.

---

# Checklist

Before introducing complexity, ask:

- Does this solve a real problem?
- Can the code be simpler?
- Will another developer understand it quickly?
- Is this abstraction justified?
- Can this be removed without affecting functionality?

If the answer suggests the code is unnecessarily complex, simplify it.

---

# Summary

The KISS principle encourages developers to choose the simplest solution that correctly solves the current problem.

In Shop Lite, this means:

- Prefer clarity over cleverness.
- Avoid unnecessary abstractions.
- Build only what is needed.
- Keep functions, classes, and architecture simple.
- Introduce complexity only when it is justified by real requirements.

By following KISS, the codebase remains approachable, maintainable, and easier to evolve.