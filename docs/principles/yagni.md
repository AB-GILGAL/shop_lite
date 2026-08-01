# YAGNI Principle

## Overview

YAGNI stands for:

> You Aren't Gonna Need It

The principle encourages developers to avoid implementing functionality, abstractions, or complexity based only on assumptions about future requirements.

Build what is needed now.

Add complexity when the need actually appears.

YAGNI does not mean ignoring future growth. It means avoiding unnecessary work without evidence that it will provide value.

---

# Why This Exists

Developers often try to predict every possible future requirement.

Example:

Today's requirement:

```
Display products from an API.
```

A developer creates:

```
ProductApiFactory

↓

MultiBackendResolver

↓

CloudProviderStrategy

↓

ProductSynchronizationEngine
```

before the application has any need for multiple backends.

The result:

- More code
- More concepts to understand
- More places for bugs
- Slower development

The future problem may never happen.

---

# The Core Idea

Solve today's problem well.

Do not solve imaginary problems.

The development process should be:

```
Current Requirement

        ↓

Simple Solution

        ↓

Real Need Appears

        ↓

Extend Solution
```

---

# YAGNI vs Good Architecture

A common misunderstanding:

> "If I follow YAGNI, I should not plan architecture."

This is incorrect.

Good architecture creates room for change.

YAGNI prevents unnecessary complexity.

Example:

## Good Preparation

Creating:

```
ProductRepository interface
```

because we know data may come from different sources:

- API
- Local database
- Cache

This creates a useful boundary.

---

## YAGNI Violation

Creating:

```
ProductRepositoryFactoryBuilderManager
```

when there is only one repository implementation.

The abstraction exists without a real problem.

---

# YAGNI in Shop Lite

## Example 1 — Payment Systems

Current requirement:

```
Learn products with fake API.
```

Avoid creating:

```
PaymentGatewayInterface

StripeAdapter

PaystackAdapter

FlutterwaveAdapter

PaypalAdapter
```

There is no payment feature yet.

When payment becomes a requirement:

```
Payment Feature

↓

Design Payment Architecture

↓

Implement Required Providers
```

---

## Example 2 — Authentication

Avoid creating:

```
MultiTenantAuthenticationManager
```

before authentication exists.

Start with the actual requirement:

```
Authentication Repository

↓

Login

↓

Session Management
```

Extend later if necessary.

---

## Example 3 — Database

Shop Lite may use:

```
Isar
```

for local persistence.

Avoid creating a generic database abstraction like:

```
UniversalDatabaseEngine
```

unless multiple databases are actually required.

---

# YAGNI and Documentation

Documentation should also follow YAGNI.

Avoid documenting imaginary features as if they already exist.

Good:

```
Current architecture

Current decisions

Current limitations
```

Avoid:

```
Future system supporting 15 payment providers
```

when payment is not part of the application.

---

# YAGNI and Code

Avoid:

```dart
class Product {
  final String id;
  final String name;
  final double price;

  // 20 future fields
}
```

only because they might be needed someday.

Add fields when requirements introduce them.

---

# Common Mistakes

## 1. Building for imaginary users

Example:

Adding:

- Enterprise permissions
- Multiple organizations
- Advanced analytics

when the application has no requirement for them.

---

## 2. Creating unnecessary abstractions

Example:

Only one implementation exists:

```
ProductRepositoryImpl
```

but the developer creates:

```
ProductRepositoryFactory
ProductRepositoryResolver
ProductRepositoryProvider
```

without a real reason.

---

## 3. Over-configuring simple features

Example:

A simple API call becomes:

```
RequestBuilder

↓

RequestManager

↓

RequestPipeline

↓

NetworkCoordinator
```

when a simple Dio call would work.

---

## 4. Adding dependencies without need

Every dependency introduces:

- Maintenance responsibility
- Learning cost
- Potential conflicts

Before adding a package, ask:

> Does this solve a current problem?

---

# YAGNI in Feature Development

A practical approach:

## Phase 1

Build the minimum working feature.

Example:

```
Product List

↓

Fetch Products

↓

Display Products
```

---

## Phase 2

Observe real requirements.

Example:

Users need:

```
Offline access
```

Then add:

```
Local database
```

---

## Phase 3

Improve based on evidence.

Example:

Large product lists require:

```
Pagination
```

Then implement pagination.

---

# Best Practices

- Build current requirements first.
- Keep architecture flexible but simple.
- Add complexity when problems appear.
- Avoid speculative features.
- Avoid unnecessary dependencies.
- Refactor when new requirements arrive.
- Let real usage guide improvements.

---

# Review Checklist

Before adding a feature, ask:

- Is this required now?
- Is there a user need for this?
- Is there evidence this problem exists?
- Am I solving a real problem or an imaginary one?
- Can this be added later without major difficulty?

Before creating an abstraction, ask:

- Do I have multiple implementations?
- Does this remove actual complexity?
- Does this make the code easier to understand?

---

# Summary

YAGNI encourages developers to avoid building unnecessary complexity based on assumptions about the future.

In Shop Lite, YAGNI means:

- Build required features first.
- Keep architecture flexible but simple.
- Avoid unnecessary abstractions.
- Add complexity only when real requirements demand it.

Combined with:

- KISS → Keep solutions simple.
- DRY → Maintain one source of truth.
- SOLID → Design maintainable structures.

YAGNI helps Shop Lite remain clean, understandable, and adaptable as it grows.