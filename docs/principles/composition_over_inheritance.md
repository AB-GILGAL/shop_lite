# Composition Over Inheritance

## Overview

Composition Over Inheritance is a software design principle that encourages building complex behavior by combining smaller, independent components rather than creating deep inheritance hierarchies.

The principle states:

> Prefer assembling objects and components together rather than creating rigid parent-child relationships.

Flutter strongly embraces this approach through its widget composition model.

---

# Why This Exists

Inheritance creates a strong relationship between classes.

Example:

```text
Animal

  ↓

Dog
```

The child class depends heavily on the parent class.

As applications grow, inheritance chains can become difficult to maintain.

Example:

```text
Widget

↓

CustomWidget

↓

AnimatedCustomWidget

↓

AdvancedAnimatedCustomWidget

↓

SpecialProductWidget
```

Problems:

- Hard to understand
- Difficult to modify
- Changes can affect many classes
- Less flexibility

---

# The Core Idea

Instead of asking:

> "What class should this extend?"

Ask:

> "What smaller pieces can I combine to create this?"

---

# Inheritance Example

Imagine creating buttons.

A developer may create:

```
Button

↓

PrimaryButton

↓

LoadingPrimaryButton

↓

AnimatedLoadingPrimaryButton
```

The hierarchy becomes complicated.

---

# Composition Approach

Instead, create independent components:

```
Button

+

LoadingIndicator

+

Animation

+

Icon
```

Then combine them.

Example:

```dart
PrimaryButton(
  isLoading: true,
  icon: Icons.shopping_cart,
)
```

The behavior is composed through configuration.

---

# Composition in Flutter

Flutter widgets are composed.

Example:

```dart
Scaffold(
  body: Column(
    children: [
      AppBar(),
      ProductCard(),
      PrimaryButton(),
    ],
  ),
);
```

A screen is not usually created by extending another screen.

It is built by combining smaller widgets.

---

# Shop Lite Examples

## Example 1 — Product Card

Instead of:

```
BaseCard

↓

ProductCard

↓

DiscountProductCard

↓

FeaturedDiscountProductCard
```

Use:

```
ProductCard

+

PriceWidget

+

BadgeWidget

+

AppCachedImage
```

The product card is assembled from smaller reusable parts.

---

# Example 2 — Buttons

Avoid creating:

```
BaseButton

↓

PrimaryButton

↓

DangerPrimaryButton

↓

LoadingDangerPrimaryButton
```

Prefer:

```dart
PrimaryButton(
  text: "Buy Now",
  isLoading: true,
  icon: Icons.shopping_cart,
)
```

The component is configured rather than extended.

---

# Example 3 — Images

Instead of:

```
ImageWidget

↓

CircularImage

↓

ProfileCircularImage

↓

UserAvatarImage
```

Use:

```dart
AppCachedImage(
  imageUrl: url,
  shape: ImageShape.circle,
)
```

The same component supports different use cases.

---

# Composition and Riverpod

Composition is also used in dependency management.

Example:

Instead of one giant service:

```
ApplicationService

    Handles:
    - API
    - Database
    - Authentication
    - Analytics
    - Notifications
```

Compose smaller services:

```
ApiClient

DatabaseService

AuthService

AnalyticsService
```

Each service has a focused purpose.

---

# Composition and Clean Architecture

Our architecture already follows composition.

Example:

```
Product Feature

├── Presentation

├── Provider

├── Repository

├── Remote Data Source

├── Local Data Source

└── Model
```

The feature is built by combining smaller responsibilities.

---

# When Inheritance Is Appropriate

Composition does not mean inheritance is always bad.

Inheritance is useful when there is a true "is-a" relationship.

Examples:

Good:

```
Exception

↓

NetworkException
```

```
Animal

↓

Dog
```

```
Shape

↓

Circle
```

The child genuinely represents a specialized version of the parent.

---

# When To Prefer Composition

Prefer composition when:

- You are combining behaviors.
- You want reusable UI components.
- You expect requirements to change.
- You want independent testing.
- You need flexible configurations.

---

# Common Mistakes

## Creating Huge Base Classes

Example:

```
BaseScreen
```

containing:

- Navigation
- API calls
- State handling
- UI logic
- Error handling

This creates hidden dependencies.

---

## Overusing Inheritance For Widgets

Avoid:

```
CustomProductScreen extends ProductScreen
```

Prefer:

```
ProductScreen(
   customHeader: HeaderWidget(),
)
```

---

## Building Generic Components Too Early

Do not create:

```
UniversalWidgetBuilder
```

before understanding the repeated pattern.

Start simple.

Extract reusable components when repetition becomes meaningful.

---

# Composition in Shop Lite

Examples:

## AppCachedImage

Composed with:

- Image provider
- Placeholder
- Error widget
- Shape configuration

---

## ProductCard

Composed with:

- Image component
- Text styles
- Price display
- Action button

---

## Application Theme

Composed with:

- Colors
- Typography
- Component themes
- Extensions

---

# Best Practices

- Build small reusable components.
- Prefer configuration over subclassing.
- Keep widgets focused.
- Combine simple pieces into larger features.
- Use inheritance only for genuine specialization.
- Favor flexibility over rigid hierarchies.

---

# Review Checklist

Before creating a subclass, ask:

- Is this truly an "is-a" relationship?
- Would composition make this easier to change?
- Can this behavior be provided as a parameter?
- Am I creating unnecessary hierarchy?
- Can smaller components solve this problem?

---

# Summary

Composition Over Inheritance encourages developers to create flexible systems by combining smaller independent pieces.

In Shop Lite, this principle appears everywhere:

- Flutter widgets are composed together.
- Shared components are configurable.
- Services are separated by responsibility.
- Features are built from independent layers.

By preferring composition, the application becomes easier to extend, test, and maintain as requirements evolve.