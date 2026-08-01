# Theming

## Overview

Shop Lite uses a centralized theming system to ensure a consistent user interface across the entire application.

Instead of defining colors, text styles, spacing, or shapes directly inside widgets, all visual design decisions are centralized in the application's theme.

This approach improves:

- Consistency
- Maintainability
- Reusability
- Scalability
- Accessibility

---

# Design Philosophy

The application's visual language follows three principles.

## Consistency

A button should look and behave the same regardless of where it appears.

The same applies to:

- Typography
- Colors
- Icons
- Cards
- Text fields
- Dialogs

---

## Reusability

Widgets should consume design tokens rather than hard-coded values.

Example:

Instead of:

```dart
padding: const EdgeInsets.all(16),
```

use:

```dart
padding: EdgeInsets.all(AppSizes.md),
```

Instead of:

```dart
color: Colors.blue,
```

use:

```dart
color: AppColors.primary,
```

---

## Centralization

All design values should exist in one place.

Changing the primary color should require editing a single file rather than searching the entire project.

---

# Theme Structure

```text
lib/
└── app/
    └── theme/
        ├── app_colors.dart
        ├── app_text_styles.dart
        ├── app_sizes.dart
        ├── app_spacing.dart
        ├── app_radius.dart
        ├── app_durations.dart
        ├── app_theme.dart
        └── theme_extensions.dart
```

Each file has a single responsibility.

---

# Colors

All application colors are defined in one location.

Examples:

- Primary
- Secondary
- Success
- Warning
- Error
- Background
- Surface
- Text colors

Widgets should never use random `Color(...)` values unless creating a new design token.

---

# Typography

Typography is centralized inside `AppTextStyles`.

Benefits include:

- Consistent font sizes
- Predictable font weights
- Better readability
- Easier scaling

Widgets should use predefined styles rather than creating new `TextStyle` objects.

---

# Spacing

Spacing uses predefined values from `AppSizes`.

Example:

```dart
const SizedBox(height: AppSizes.md);
```

instead of:

```dart
const SizedBox(height: 16);
```

Using a spacing scale creates visual rhythm throughout the application.

---

# Border Radius

Corner radii are also centralized.

Examples:

- Small
- Medium
- Large
- Circular

This prevents inconsistent rounded corners.

---

# Durations

Animation and transition durations are defined in `AppDurations`.

Example:

```dart
AppDurations.medium
```

instead of:

```dart
Duration(milliseconds: 300)
```

---

# Light and Dark Themes

The application theme is defined in `app_theme.dart`.

Responsibilities include:

- Color scheme
- Typography
- Input decoration
- Buttons
- Cards
- Dialogs
- Navigation
- Material components

Switching between light and dark themes should require minimal code changes.

---

# Theme Extensions

When Material's default theme is insufficient, custom values can be added through Theme Extensions.

Examples:

- Custom elevations
- Brand-specific colors
- Component-specific styling

This keeps custom design values integrated with Flutter's theming system.

---

# Best Practices

- Never hard-code colors.
- Never hard-code spacing if a design token exists.
- Prefer reusable text styles.
- Keep theme definitions centralized.
- Extend the theme rather than duplicating values.

---

# Summary

The Shop Lite theming system provides a single source of truth for the application's visual design.

By centralizing colors, typography, spacing, radii, durations, and component themes, the UI remains consistent, maintainable, and easy to evolve as the project grows.