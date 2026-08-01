# Folder and File Conventions

## Overview

This document defines the naming and organization conventions used throughout the Shop Lite project.

The purpose of these conventions is to ensure:

- Consistency across the codebase
- Easier navigation
- Predictable file locations
- Better collaboration
- Easier maintenance as the project grows

All new files and folders should follow these guidelines.

---

# General Principles

## One Responsibility Per File

Each file should have one clear responsibility.

Good:

```text
product_repository.dart
```

Contains:

- Product repository contract or implementation.

Bad:

```text
helpers.dart
```

Containing:

- Date formatting
- API calls
- Validation
- Navigation
- Storage logic

Large generic files become difficult to maintain.

---

## One Public Class Per File

Each public class should have its own file.

Example:

```text
primary_button.dart

class PrimaryButton {}

```

Avoid:

```text
widgets.dart

class PrimaryButton {}
class AppTextField {}
class AppLoader {}
```

unless the file is specifically designed as an export file.

---

# Folder Naming Convention

Folders use:

```text
snake_case
```

Examples:

Correct:

```text
product_details

network_client

shared_widgets
```

Incorrect:

```text
ProductDetails

productDetails

PRODUCT_DETAILS
```

---

# Dart File Naming Convention

Dart files use:

```text
snake_case.dart
```

Examples:

Correct:

```text
product_model.dart

network_configuration.dart

auth_repository.dart
```

Incorrect:

```text
ProductModel.dart

networkConfiguration.dart
```

---

# Class Naming Convention

Classes use:

```text
PascalCase
```

Examples:

```dart
ProductModel

NetworkConfiguration

PrimaryButton

AuthRepository
```

---

# Variable Naming Convention

Variables use:

```text
camelCase
```

Examples:

```dart
productList

currentUser

baseUrl

isLoading
```

---

# Constant Naming Convention

Constants use:

```text
camelCase
```

Examples:

```dart
static const appName = 'Shop Lite';

static const defaultPadding = 16.0;
```

Avoid:

```dart
static const APP_NAME = 'Shop Lite';
```

Dart style does not follow the uppercase constant convention used in some other languages.

---

# Private Members

Private members begin with an underscore.

Example:

```dart
class ProductRepository {

  final ProductRemoteDataSource _remoteDataSource;

}
```

Private members should only be accessed within their own library.

---

# Feature Folder Convention

Every feature follows the same structure.

Example:

```text
features/
└── products/
    │
    ├── data/
    ├── domain/
    ├── presentation/
    └── providers/
```

---

# Data Layer Convention

The data layer handles external data sources.

Structure:

```text
data/
│
├── models/
├── datasources/
└── repositories/
```

Example:

```text
data/
├── models/
│   └── product_model.dart
│
├── datasources/
│   └── product_remote_datasource.dart
│
└── repositories/
    └── product_repository_impl.dart
```

Responsibilities:

## Models

Convert external data.

Example:

```dart
ProductModel.fromJson()
```

---

## Data Sources

Communicate with external systems.

Examples:

- API
- Database
- Cache

---

## Repository Implementations

Combine data sources and provide data to the domain layer.

---

# Domain Layer Convention

The domain layer contains business rules.

Structure:

```text
domain/
│
├── entities/
├── repositories/
└── usecases/
```

Example:

```text
domain/
├── entities/
│   └── product.dart
│
├── repositories/
│   └── product_repository.dart
│
└── usecases/
    └── get_products.dart
```

The domain layer should not depend on:

- Flutter widgets
- Dio
- Isar
- Firebase

---

# Presentation Layer Convention

The presentation layer contains UI.

Structure:

```text
presentation/
│
├── pages/
├── widgets/
└── controllers/
```

Example:

```text
presentation/
├── pages/
│   └── products_page.dart
│
├── widgets/
│   └── product_card.dart
│
└── controllers/
```

---

# Provider Convention

Riverpod providers should be grouped separately.

Example:

```text
providers/
│
├── product_provider.dart
└── product_state.dart
```

Provider files should not contain business logic.

They connect:

```text
UI

↓

Provider

↓

Repository
```

---

# Core Folder Convention

The `core` folder contains application-wide infrastructure.

Example:

```text
core/
│
├── network/
├── database/
├── errors/
├── services/
├── utils/
└── extensions/
```

Core code should not depend on features.

Incorrect:

```text
core/network/product_api.dart
```

Correct:

```text
features/products/data/datasources/product_remote_datasource.dart
```

---

# Shared Folder Convention

The shared folder contains reusable components.

Example:

```text
shared/
│
├── widgets/
├── dialogs/
├── loaders/
└── extensions/
```

Shared components should be generic.

Good:

```text
AppButton
AppTextField
AppCachedImage
```

Avoid:

```text
ProductButton
CheckoutImageWidget
```

Feature-specific widgets belong inside the feature.

---

# Import Rules

Imports should follow this order:

1. Dart imports
2. Flutter imports
3. Package imports
4. Project imports

Example:

```dart
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop_lite/core/network/dio_client.dart';
```

---

# Avoid These Practices

## Avoid Large Utility Files

Avoid:

```text
utils.dart
helpers.dart
common.dart
```

with hundreds of unrelated functions.

Prefer:

```text
date_formatter.dart

validators.dart

currency_formatter.dart
```

---

## Avoid Deep Folder Nesting

Avoid:

```text
features/products/presentation/widgets/cards/components/product/
```

If a folder becomes too deep, reconsider the structure.

---

# Summary

The Shop Lite project follows these conventions:

- Feature-first organization
- Snake case folders and files
- PascalCase classes
- camelCase variables
- One responsibility per file
- One public class per file
- Core contains infrastructure
- Shared contains reusable components
- Features contain business functionality

These conventions keep the codebase predictable and scalable.