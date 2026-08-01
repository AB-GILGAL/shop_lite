# Design System

## Overview

The Shop Lite Design System defines the visual language and reusable building blocks used throughout the application.

Its purpose is to ensure that every screen, widget, and interaction feels consistent regardless of who develops it.

The design system consists of:

- Design Tokens
- Typography
- Color Palette
- Spacing Scale
- Component Library
- Layout Rules
- Iconography
- Motion
- Accessibility Guidelines

---

# Design Principles

Every UI component should follow these principles.

## Consistency

Components that perform the same function should have the same appearance and behavior.

Example:

Every primary action button should look identical throughout the application.

---

## Simplicity

Components should solve one problem well.

Avoid creating widgets that perform multiple unrelated responsibilities.

Good:

```
PrimaryButton
```

Bad:

```
SmartButton
```

that automatically handles networking, validation, loading, and navigation.

---

## Reusability

Components should be reusable across multiple screens.

If the same UI appears more than once, it should become a reusable widget.

---

## Accessibility

Every component should be usable by as many people as possible.

Consider:

- Readable font sizes
- Sufficient color contrast
- Touch targets
- Screen readers
- Keyboard navigation (where applicable)

---

# Design Tokens

Design tokens are the smallest reusable design values.

Examples:

```text
Color

Spacing

Radius

Duration

Typography

Elevation
```

They should never be hard-coded inside widgets.

Example:

Instead of:

```dart
padding: EdgeInsets.all(16)
```

use:

```dart
padding: EdgeInsets.all(AppSizes.md)
```

---

# Component Hierarchy

The component library is divided into three levels.

## Level 1 — Primitive Components

Basic reusable widgets.

Examples:

```text
PrimaryButton

AppTextField

AppCachedImage

AppLoader

AppDivider

AppChip
```

These components should not contain business logic.

---

## Level 2 — Composite Components

Built from multiple primitive components.

Examples:

```text
ProductCard

CategoryTile

SearchBar

CartItem

ProfileHeader
```

These combine primitives into meaningful UI blocks.

---

## Level 3 — Feature Components

Feature-specific widgets.

Examples:

```text
CheckoutSummary

ProductReviews

CartFooter
```

These belong inside their respective feature folders.

---

# Layout System

Layouts should be responsive.

Avoid fixed dimensions whenever possible.

Preferred:

```dart
Expanded

Flexible

AspectRatio

LayoutBuilder
```

Avoid:

```dart
Container(
  width: 327,
  height: 148,
)
```

unless a fixed size is a deliberate design requirement.

---

# Spacing

Spacing follows the application's spacing scale.

Example:

```text
xs

sm

md

lg

xl
```

Developers should avoid arbitrary spacing values.

Incorrect:

```dart
SizedBox(height: 13)
```

Correct:

```dart
SizedBox(height: AppSizes.md)
```

---

# Typography

Text should use predefined styles.

Example:

```dart
AppTextStyles.titleLarge

AppTextStyles.bodyMedium

AppTextStyles.labelSmall
```

Avoid creating custom text styles for every screen.

---

# Color Usage

Colors must come from `AppColors`.

Avoid:

```dart
Color(0xFF2196F3)
```

Use:

```dart
AppColors.primary
```

This allows the application's appearance to evolve without widespread code changes.

---

# Images

Images should be displayed through reusable components.

Example:

```text
AppCachedImage
```

Benefits:

- Consistent placeholders
- Error handling
- Image caching
- Rounded corners
- Loading indicators

---

# Buttons

Buttons should use shared components.

Examples:

```text
PrimaryButton

SecondaryButton

TextButton

IconButton
```

Business screens should not create custom button implementations unless absolutely necessary.

---

# Forms

Form controls should use shared widgets.

Examples:

```text
AppTextField

AppDropdown

AppCheckbox

AppSwitch
```

This ensures consistent validation, spacing, and styling.

---

# Icons

Use Material icons unless the project adopts a dedicated icon library.

Guidelines:

- Keep icon sizes consistent.
- Pair icons with labels when clarity is improved.
- Avoid decorative icons that do not add meaning.

---

# Motion

Animations should be subtle and purposeful.

Good uses include:

- Screen transitions
- Loading states
- Expand/collapse interactions
- Button feedback

Avoid excessive or distracting animations.

All durations should come from `AppDurations`.

---

# Accessibility

Components should support accessibility best practices.

Recommendations:

- Minimum touch target of approximately 48 × 48 logical pixels.
- Meaningful semantic labels for important controls.
- Avoid relying solely on color to convey information.
- Ensure text remains readable with larger system font sizes.

---

# Component Evolution

New UI should follow this process:

1. Can an existing component be reused?
2. Can an existing component be extended?
3. Does a new primitive component need to be created?
4. Is the component feature-specific?

This helps avoid unnecessary duplication.

---

# Summary

The Shop Lite Design System provides a shared language for building the user interface.

By relying on design tokens, reusable components, responsive layouts, and accessibility guidelines, the application remains visually consistent, easier to maintain, and scalable as new features are added.