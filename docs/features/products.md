# Products Feature

## 1. Overview

The Products feature is responsible for retrieving, displaying, and viewing product information in Shop Lite.

The feature currently supports:

- Product listing
- Product details
- Remote API communication
- Product JSON parsing
- Loading states
- Error states
- Retry handling
- Product image rendering
- Navigation from the product list to product details

---

## 2. Feature Structure

The Products feature is organized into data, domain, presentation,
and provider layers.

```text
lib/features/products/

├── data/
│   ├── datasources/
│   │   └── product_remote_data_source.dart
│   │
│   ├── models/
│   │   └── product_model.dart
│   │
│   └── repositories/
│       └── product_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   └── product.dart
│   │
│   └── repositories/
│       └── product_repository.dart
│
├── presentation/
│   ├── controllers/
│   │   ├── product_controller.dart
│   │   ├── product_controller.g.dart
│   │   ├── product_details_controller.dart
│   │   └── product_details_controller.g.dart
│   │
│   ├── pages/
│   │   ├── products_page.dart
│   │   └── product_details_page.dart
│   │
│   └── widgets/
│       └── product_card.dart
│
└── providers/
    ├── product_providers.dart
    └── product_providers.g.dart