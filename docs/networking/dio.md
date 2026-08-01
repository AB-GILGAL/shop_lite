# Dio HTTP Client

## Overview

Shop Lite uses **Dio** as the primary HTTP client for communicating with external APIs.

Dio provides a powerful abstraction over HTTP communication while giving us control over:

- Request configuration
- Response handling
- Error processing
- Authentication
- Logging
- Request modification
- Network debugging

The application does not use Dio directly inside features.

Instead, Dio is wrapped inside a centralized API client.

---

# Why Dio?

Flutter provides the `http` package for making network requests.

However, Shop Lite requires more advanced networking capabilities because it is designed for low connectivity environments.

Dio was selected because it provides:

## Interceptors

Ability to intercept requests and responses.

Examples:

- Add authentication tokens
- Log API calls
- Handle errors globally
- Refresh expired tokens

---

## Timeout Configuration

Dio allows separate timeout settings:

- Connection timeout
- Receive timeout
- Send timeout

Example:

```dart
connectTimeout: Duration(seconds: 15)

receiveTimeout: Duration(seconds: 15)

sendTimeout: Duration(seconds: 15)
```

---

## Better Error Handling

Dio provides structured errors:

```dart
DioException
```

instead of generic exceptions.

This allows us to map errors into application failures.

---

## Request Cancellation

Useful when:

- Searching products
- User leaves a screen
- A request is no longer needed

Example:

User searches:

```
phone
```

then quickly types:

```
phone case
```

The previous request can be cancelled.

---

# Dio Location in Architecture

Dio belongs to the infrastructure layer.

Location:

```text
lib/
└── core/
    └── network/
        └── client/
            └── dio_client.dart
```

The dependency flow is:

```text
Feature

↓

Repository

↓

Remote Data Source

↓

Api Client

↓

Dio

↓

Server
```

---

# Dio Client Responsibility

The Dio client is responsible for creating and configuring Dio.

It handles:

- Base URL
- Timeouts
- Headers
- Interceptors
- Default options

It should NOT handle:

- Product logic
- User logic
- Business rules

---

# Dio Configuration

The Dio instance receives configuration from:

```text
NetworkConfiguration
NetworkConstants
NetworkHeaders
NetworkDurations
```

Example:

```text
Dio Client

uses

├── Base URL
├── Timeout values
├── Default headers
└── Interceptors
```

This prevents configuration values from being scattered throughout the application.

---

# Base URL

The base URL is managed centrally.

Current API:

```text
https://api.escuelajs.co/api/v1
```

Accessed through:

```dart
NetworkConfiguration.baseUrl
```

Features should never contain:

```dart
'https://api.escuelajs.co/api/v1/products'
```

because changing the API would require editing many files.

---

# Headers

Common headers are applied globally.

Examples:

```http
Content-Type: application/json

Accept: application/json
```

Future authenticated requests may include:

```http
Authorization: Bearer token
```

---

# Timeout Strategy

Poor connectivity requires careful timeout handling.

Shop Lite defines:

```text
Connection Timeout

How long to wait when establishing a connection.


Receive Timeout

How long to wait for server response.


Send Timeout

How long to wait when uploading data.
```

These values are centralized so they can be adjusted based on real-world usage.

---

# Interceptors

Interceptors are one of Dio's most powerful features.

They allow us to execute logic before and after requests.

---

# Request Flow

```text
User Action

↓

Repository

↓

Remote Data Source

↓

API Client

↓

Request Interceptor

↓

Dio

↓

Server
```

---

# Response Flow

```text
Server

↓

Dio

↓

Response Interceptor

↓

API Client

↓

Remote Data Source

↓

Repository

↓

UI
```

---

# Planned Interceptors

## Logger Interceptor

Purpose:

- Debug requests
- Inspect responses
- Identify failures

Example:

```text
GET /products

Status: 200

Duration: 450ms
```

Technology:

```text
logger package
```

---

## Authentication Interceptor

Purpose:

Automatically attach authentication information.

Example:

```http
Authorization: Bearer abc123
```

---

## Error Interceptor

Purpose:

Convert technical errors into meaningful failures.

Example:

Dio error:

```text
DioExceptionType.connectionTimeout
```

becomes:

```text
NetworkTimeoutFailure
```

---

## Cache Interceptor

Purpose:

Store and reuse responses.

Technology:

```text
dio_cache_interceptor
```

Useful for:

- Product lists
- Categories
- Frequently accessed data

---

# Error Handling Strategy

Dio errors should never reach the UI directly.

Incorrect:

```text
DioException

↓

Screen
```

Correct:

```text
DioException

↓

Failure Mapper

↓

Application Failure

↓

UI
```

Example:

```text
SocketException

↓

NoInternetFailure

↓

"Please check your connection"
```

---

# Dio and Low Connectivity

Since Shop Lite targets low connectivity environments, Dio is only one part of the solution.

Dio handles:

- HTTP communication
- Request management
- Network errors

Other components handle:

| Requirement | Technology |
|---|---|
| Network status | connectivity_plus |
| Internet availability | internet_connection_checker |
| Local persistence | Isar |
| HTTP cache | dio_cache_interceptor |
| Background sync | workmanager |
| Image caching | cached_network_image |

---

# Testing Dio

Because Dio is wrapped behind an API client, testing becomes easier.

Instead of testing:

```dart
Dio
```

directly inside features, we can replace:

```text
Real Api Client

with

Mock Api Client
```

during tests.

---

# Example Future Structure

The final networking structure will look like:

```text
core/
└── network/
    │
    ├── config/
    │   ├── network_configuration.dart
    │   ├── network_environment.dart
    │   ├── network_headers.dart
    │   └── network_durations.dart
    │
    ├── client/
    │   ├── dio_client.dart
    │   └── api_client.dart
    │
    ├── interceptors/
    │   ├── logger_interceptor.dart
    │   ├── auth_interceptor.dart
    │   └── cache_interceptor.dart
    │
    └── exceptions/
        └── network_exception.dart
```

---

# Summary

Shop Lite uses Dio because it provides:

- Advanced HTTP communication
- Interceptor support
- Better error handling
- Timeout control
- Request cancellation
- Extensibility

The Dio layer is isolated inside `core/network` and exposed to features through abstractions.

The architecture ensures that:

- Features do not depend directly on Dio.
- Network changes do not affect business logic.
- Offline-first capabilities can be added cleanly.
- Testing remains simple.