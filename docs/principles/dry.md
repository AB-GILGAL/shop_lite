# DRY Principle

## Overview

DRY stands for:

> Don't Repeat Yourself

The principle encourages developers to avoid unnecessary duplication by ensuring that every piece of knowledge or logic has a single, authoritative representation.

The goal is not to eliminate every repeated line of code.

The goal is to prevent multiple places from maintaining the same information independently.

In Shop Lite, DRY helps maintain consistency across the application.

---

# Why This Exists

Duplication creates a maintenance problem.

Consider this example:

```dart
TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
)
```

This style appears in:

- Product cards
- Profile screens
- Checkout pages
- Settings pages

Later, the design changes:

```text
Font size should become 18.
```

Without DRY:

```
File A → Change
File B → Change
File C → Change
File D → Change
```

Some places may be forgotten.

With DRY:

```
AppTextStyles.titleMedium

        ↓

Change once
```

Every screen updates automatically.

---

# The Core Idea

Every important piece of knowledge should have one source of truth.

Examples:

```
Primary Color

        ↓

AppColors.primary
```

```
API URL

        ↓

NetworkConfiguration.baseUrl
```

```
Button Design

        ↓

PrimaryButton
```

```
Product Mapping Logic

        ↓

ProductMapper
```

---

# Types of Duplication

Duplication can happen in several ways.

---

## 1. Code Duplication

The same logic appears in multiple places.

Example:

```dart
final price = product.price * 0.9;
```

appearing throughout the application.

Better:

```dart
final discountedPrice =
    PriceCalculator.calculateDiscount(product.price);
```

---

## 2. Configuration Duplication

The same configuration values appear repeatedly.

Bad:

```dart
const baseUrl =
'https://api.escuelajs.co/api/v1';
```

appearing in multiple files.

Better:

```dart
NetworkConfiguration.baseUrl;
```

---

## 3. UI Duplication

The same widget structure appears repeatedly.

Bad:

```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
  ),
)
```

repeated across screens.

Better:

```dart
AppCard();
```

---

## 4. Knowledge Duplication

This is the most important type.

Knowledge duplication means the same business rule exists in multiple places.

Example:

A product can be considered unavailable when:

```text
stock == 0
```

If this rule exists in:

- Product page
- Cart page
- Checkout page

the business rule is duplicated.

Better:

```dart
product.isAvailable
```

The rule exists in one place.

---

# DRY in Shop Lite

## Theme System

Without DRY:

```dart
Colors.teal
Colors.teal
Colors.teal
```

With DRY:

```dart
AppColors.primary
```

---

## Spacing System

Without DRY:

```dart
SizedBox(height: 16)
SizedBox(height: 16)
SizedBox(height: 16)
```

With DRY:

```dart
AppSizes.md
```

---

## Network Configuration

Without DRY:

```dart
Dio(
  BaseOptions(
    baseUrl:
      'https://api.escuelajs.co/api/v1',
  ),
);
```

created in multiple places.

With DRY:

```dart
NetworkConfiguration.baseUrl
```

---

## API Handling

Without DRY:

Every repository handles:

- Timeout errors
- Connection errors
- Server errors

With DRY:

```
ErrorInterceptor

        ↓

Central error handling
```

---

## Shared Widgets

Without DRY:

Every screen creates:

- Buttons
- Text fields
- Empty states
- Loading indicators

With DRY:

```
shared/widgets/

├── PrimaryButton

├── AppTextField

├── AppEmptyView

└── AppLoader
```

---

# DRY Does Not Mean Everything Must Be Reused

This is a very important point.

Bad interpretation:

> "If two things look similar, immediately create an abstraction."

Example:

Two screens have:

```dart
Padding(
  padding: EdgeInsets.all(16),
)
```

Does this require:

```dart
UniversalPaddingWidget()
```

Probably not.

The duplication may not represent the same concept.

---

# Avoid Premature Abstraction

Before creating reusable code, ask:

1. Is this duplication likely to change?
2. Does it represent the same concept?
3. Will reuse make the code clearer?

If the answer is no, duplication may be acceptable.

---

# Example

## Bad DRY

Creating:

```text
GenericDataManager
```

because:

```text
ProductRepository
UserRepository
CategoryRepository
```

have some similar methods.

This may hide important differences.

---

## Good DRY

Creating:

```text
ApiClient
```

because all repositories communicate with the same HTTP layer.

The concept is genuinely shared.

---

# Common Mistakes

## Removing duplication too early

A developer sees repeated code twice and immediately creates an abstraction.

Problem:

The abstraction may be based on incomplete understanding.

---

## Creating giant utility classes

Example:

```text
Utils.dart
```

containing:

- Date formatting
- Validation
- Navigation
- API calls
- Calculations

This creates a dumping ground.

Prefer focused files:

```text
utils/

├── validators.dart

├── formatters.dart

└── extensions.dart
```

---

## Copy-Pasting Business Logic

Example:

Cart calculations exist in:

- Cart page
- Checkout page
- Payment page

This creates inconsistency.

Business rules should have one home.

---

# Best Practices

- Centralize application-wide constants.
- Create reusable components for repeated UI patterns.
- Keep business rules in appropriate layers.
- Avoid unnecessary duplication of configuration.
- Extract code when duplication represents the same concept.
- Prefer clarity over forced reuse.

---

# Review Checklist

Before duplicating code, ask:

- Does this already exist somewhere?
- Should this become a reusable component?
- Is this a shared business rule?
- Will this value change in the future?
- Is this duplication accidental or intentional?

Before creating an abstraction, ask:

- Does this solve a real problem?
- Does it improve readability?
- Is the shared concept clearly understood?

---

# Summary

The DRY principle helps maintain consistency by ensuring important knowledge exists in one place.

In Shop Lite, DRY is applied through:

- Centralized design tokens
- Shared widgets
- Common networking configuration
- Reusable services
- Repository abstractions
- Shared error handling

However, DRY should be applied with judgment.

The goal is not the removal of all repetition.

The goal is:

> One source of truth for every important piece of knowledge.