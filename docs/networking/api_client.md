# API Client

## Overview

The API Client is an abstraction layer built on top of Dio.

Its purpose is to provide a clean and predictable way for the application to communicate with external APIs without exposing networking implementation details to the rest of the application.

The API Client is responsible for:

- Executing HTTP requests
- Handling common request patterns
- Returning structured responses
- Centralizing API communication behavior

---

# Why Do We Need an API Client?

Without an API Client, features would directly depend on Dio.

Example of an undesirable approach:

```text
ProductRepository

        ↓

Dio

        ↓

API
```

This creates tight coupling.

Problems:

- Every feature knows about Dio.
- Changing HTTP libraries becomes difficult.
- Testing becomes harder.
- Network logic spreads across the application.

---

# Recommended Flow

Shop Lite uses:

```text
Product Feature

        ↓

Product Remote Data Source

        ↓

ApiClient

        ↓

Dio

        ↓

Server
```

The feature only knows about the data source.

The data source only knows about the API client.

The API client handles HTTP communication.

---

# Location

The API client belongs inside:

```text
lib/
└── core/
    └── network/
        └── client/
            └── api_client.dart
```

---

# Responsibilities

The API Client handles:

## HTTP Methods

Common operations:

- GET
- POST
- PUT
- DELETE
- PATCH

Example:

```dart
get()

post()

put()

delete()
```

---

## Request Configuration

The API client manages:

- Headers
- Query parameters
- Request body
- Paths
- Options

Example:

```dart
GET /products?page=1
```

---

## Response Handling

The API client receives responses from Dio and converts them into usable results.

Example:

Dio response:

```text
Response<dynamic>
```

becomes:

```text
Map<String, dynamic>

or

List<dynamic>
```

---

## Error Handling

The API client catches Dio exceptions and converts them into application-friendly exceptions.

Example:

Dio:

```text
DioExceptionType.connectionTimeout
```

becomes:

```text
NetworkTimeoutException
```

---

# What the API Client Should NOT Do

The API Client should not:

- Know about products
- Know about users
- Contain business rules
- Convert JSON into domain entities
- Manage application state

Incorrect:

```dart
class ApiClient {

  Product getProducts(){

  }

}
```

Correct:

```dart
class ApiClient {

  Future<Response> get(
      String path
  );

}
```

The API client only understands HTTP communication.

---

# API Client and Repository Pattern

The repository decides what data is needed.

Example:

Product repository:

```text
I need products
```

Remote datasource:

```text
Call products endpoint
```

API Client:

```text
Perform GET request
```

Server:

```text
Return response
```

---

# Example Request Flow

A product request:

```text
User opens Products Page

        ↓

Products Provider

        ↓

GetProductsUseCase

        ↓

ProductRepository

        ↓

ProductRemoteDataSource

        ↓

ApiClient.get('/products')

        ↓

Dio

        ↓

EscuelaJS API
```

---

# API Client Interface

The application should depend on an abstraction.

Example:

```dart
abstract interface class ApiClient {

  Future<dynamic> get(
    String path,
  );

  Future<dynamic> post(
    String path,
    {
      Object? data,
    }
  );

  Future<dynamic> put(
    String path,
    {
      Object? data,
    }
  );

  Future<dynamic> delete(
    String path,
  );

}
```

The implementation can then use Dio.

---

# Dio Implementation

Example:

```text
ApiClient

        implemented by

DioApiClient
```

Structure:

```text
client/

├── api_client.dart

└── dio_api_client.dart
```

---

# Why Use an Interface?

Using an interface allows replacement.

Production:

```text
DioApiClient
```

Testing:

```text
FakeApiClient
```

The feature does not change.

---

# Example

Production:

```text
ProductRemoteDataSource

uses

DioApiClient

uses

Dio
```

Testing:

```text
ProductRemoteDataSource

uses

FakeApiClient
```

No real network call is required.

---

# API Endpoints

Endpoints should not be scattered throughout the application.

Incorrect:

```dart
dio.get(
'https://api.escuelajs.co/api/v1/products'
);
```

Correct:

```dart
ProductsEndpoints.products
```

---

# Endpoint Organization

Future structure:

```text
core/
└── network/
    └── endpoints/
        ├── product_endpoints.dart
        ├── category_endpoints.dart
        └── auth_endpoints.dart
```

Example:

```dart
abstract final class ProductEndpoints {

  static const products = '/products';

}
```

---

# API Client Error Flow

```text
Server Error

↓

Dio Exception

↓

API Client

↓

Exception Mapper

↓

Failure

↓

Repository

↓

UI
```

The user interface receives meaningful messages instead of technical errors.

---

# API Client and Offline Support

The API client itself does not decide whether data comes from:

- Network
- Cache
- Database

That decision belongs to the repository.

Example:

```text
Repository

checks

Local Database

        +

Remote API
```

The API client only performs remote communication.

---

# Future Improvements

The API client may later support:

- Request cancellation
- Automatic retries
- Upload progress
- Download progress
- Request queues
- Refresh tokens
- GraphQL support
- Multiple APIs

---

# Summary

The API Client provides a clean boundary between application logic and HTTP communication.

Responsibilities:

- Execute requests
- Handle responses
- Manage HTTP communication
- Convert technical errors

It does not:

- Contain business logic
- Know application features
- Manage state

The final communication flow is:

```text
Feature

↓

Repository

↓

Remote Data Source

↓

ApiClient

↓

Dio

↓

API
```

This keeps Shop Lite modular, testable, and ready for future growth.