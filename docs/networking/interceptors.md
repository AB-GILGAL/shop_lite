# Interceptors

## Overview

Interceptors are middleware components that sit between the application and the server.

Every HTTP request and response passes through one or more interceptors before reaching its final destination.

Interceptors allow cross-cutting concerns to be implemented once and automatically applied to every request.

Examples include:

- Logging
- Authentication
- Request modification
- Response transformation
- Error handling
- Caching
- Retry logic

Instead of repeating this logic throughout the application, it is centralized in the networking layer.

---

# Why Use Interceptors?

Without interceptors, every API request might contain duplicated code.

Example:

```dart
// Add Authorization header
// Log request
// Handle timeout
// Catch exceptions
// Retry request
```

Repeating this across dozens of API calls leads to:

- Code duplication
- Inconsistent behavior
- Difficult maintenance

Interceptors solve this by applying common behavior automatically.

---

# Where Interceptors Live

```text
lib/
└── core/
    └── network/
        └── interceptors/
            ├── logger_interceptor.dart
            ├── auth_interceptor.dart
            ├── error_interceptor.dart
            ├── cache_interceptor.dart
            └── retry_interceptor.dart
```

Each interceptor has a single responsibility.

---

# Request Lifecycle

Every outgoing request follows this pipeline.

```text
UI
    │
    ▼
Repository
    │
    ▼
Remote Data Source
    │
    ▼
ApiClient
    │
    ▼
Dio
    │
    ▼
Logger Interceptor
    │
    ▼
Authentication Interceptor
    │
    ▼
Cache Interceptor
    │
    ▼
Retry Interceptor
    │
    ▼
Server
```

The response returns through the interceptors in reverse order.

```text
Server
    │
    ▼
Retry Interceptor
    │
    ▼
Cache Interceptor
    │
    ▼
Authentication Interceptor
    │
    ▼
Logger Interceptor
    │
    ▼
Dio
    │
    ▼
ApiClient
    │
    ▼
Repository
    │
    ▼
UI
```

---

# Logger Interceptor

## Purpose

Logs requests and responses during development.

Typical information:

- HTTP method
- Endpoint
- Headers
- Request body
- Status code
- Response time

Example log:

```text
GET /products

Status: 200

Duration: 312 ms
```

Benefits:

- Easier debugging
- Performance monitoring
- Faster issue diagnosis

Logging should be disabled or reduced in production builds.

---

# Authentication Interceptor

## Purpose

Automatically attaches authentication information to every protected request.

Example:

```http
Authorization: Bearer <token>
```

Instead of manually adding the token to every request, the interceptor handles it centrally.

Future responsibilities include:

- Reading secure tokens
- Adding authentication headers
- Refreshing expired tokens
- Clearing invalid sessions

---

# Error Interceptor

## Purpose

Converts low-level networking errors into application-specific exceptions.

Example:

```
DioExceptionType.connectionTimeout
```

becomes

```
NetworkTimeoutException
```

Another example:

```
SocketException
```

becomes

```
NoInternetException
```

This prevents technical errors from leaking into the UI.

---

# Cache Interceptor

## Purpose

Reduces unnecessary network requests by serving cached responses when appropriate.

Future implementation:

```
dio_cache_interceptor
```

Benefits:

- Faster loading
- Reduced bandwidth usage
- Better offline experience

Typical candidates for caching:

- Product lists
- Categories
- Product details

Cache rules should be configured carefully to avoid serving stale data for operations that require fresh information.

---

# Retry Interceptor

## Purpose

Automatically retries requests that fail because of temporary network issues.

Typical scenarios:

- Brief connection loss
- Temporary server errors
- Request timeout

Example:

```text
Attempt 1

↓

Timeout

↓

Wait

↓

Attempt 2

↓

Success
```

Retries should be limited to avoid unnecessary network traffic.

---

# Interceptor Order

The order of interceptors matters.

Recommended order:

```text
1. Logger
2. Authentication
3. Cache
4. Retry
5. Error Handling
```

Reason:

- Logger records everything.
- Authentication prepares the request.
- Cache checks whether a request can be served locally.
- Retry handles transient failures.
- Error handling converts remaining failures into application exceptions.

Changing the order may produce unexpected behavior.

---

# Responsibilities

Each interceptor should perform exactly one responsibility.

Good:

```text
Logger Interceptor

↓

Only logs requests
```

Bad:

```text
Logger Interceptor

↓

Logs

Authenticates

Caches

Handles errors
```

Keeping interceptors focused makes them easier to test and maintain.

---

# Offline-First Considerations

Shop Lite is designed for low-connectivity environments.

Interceptors support this strategy by:

- Reducing duplicate requests
- Reusing cached responses
- Retrying temporary failures
- Providing meaningful errors

However, interceptors do **not** decide where data comes from.

That responsibility belongs to the repository layer.

---

# Example Flow

Fetching products:

```text
Products Page

↓

Repository

↓

Remote Data Source

↓

ApiClient

↓

Logger

↓

Authentication

↓

Cache

↓

Retry

↓

Server

↓

Response

↓

Repository

↓

UI
```

The UI remains unaware of the networking infrastructure.

---

# Best Practices

- One responsibility per interceptor.
- Keep interceptors stateless where possible.
- Avoid business logic inside interceptors.
- Keep request and response transformations predictable.
- Log sensitive information carefully.
- Disable verbose logging in production.
- Make interceptor order intentional and well documented.

---

# Summary

Interceptors provide reusable networking behavior that is automatically applied to every request and response.

In Shop Lite, they are responsible for:

- Logging
- Authentication
- Caching
- Retry logic
- Error transformation

By centralizing these concerns, the networking layer remains clean, consistent, and easier to maintain while supporting the project's offline-first architecture.