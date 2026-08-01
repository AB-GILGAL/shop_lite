# Networking Architecture

## Overview

Shop Lite uses a structured networking layer designed for reliability, maintainability, and offline-first development.

The networking architecture is built around:

- Dio as the HTTP client
- Centralized configuration
- Request/response interception
- Error handling
- API abstraction
- Offline-first principles

The goal is to prevent network logic from spreading throughout the application.

---

# Networking Goals

The networking layer is designed to provide:

- A single communication point with external APIs
- Consistent request handling
- Centralized error management
- Better debugging
- Easy API replacement
- Support for poor network conditions
- Future caching and synchronization

---

# Technology Choice

## Dio

Shop Lite uses Dio as the HTTP client.

Dio was selected because it provides:

- Interceptors
- Request cancellation
- Timeout configuration
- Global headers
- Error handling
- File uploads
- Custom adapters
- Better control compared to the basic HTTP package

---

# Network Layer Structure

The networking layer exists inside:

```text
lib/
└── core/
    └── network/
```

Current structure:

```text
network/
│
├── config/
│   ├── network_configuration.dart
│   ├── network_environment.dart
│   ├── network_constants.dart
│   ├── network_headers.dart
│   └── network_durations.dart
│
├── client/
│
├── interceptors/
│
├── exceptions/
│
└── models/
```

---

# Configuration Layer

Location:

```text
core/network/config/
```

The configuration layer contains values that control network behavior.

---

## Network Environment

File:

```text
network_environment.dart
```

Defines available environments.

Example:

```dart
enum NetworkEnvironment {
  development,
  staging,
  production,
}
```

The purpose is to allow the application to switch between backend environments easily.

---

## Network Configuration

File:

```text
network_configuration.dart
```

Provides environment-specific settings.

Responsibilities:

- Base URL selection
- Environment management
- Future API configuration

Example:

```dart
NetworkConfiguration.baseUrl
```

---

## Network Constants

File:

```text
network_constants.dart
```

Contains values that do not change frequently.

Examples:

```dart
application/json
```

---

## Network Headers

File:

```text
network_headers.dart
```

Contains standard HTTP header names.

Examples:

```text
Accept

Content-Type

Authorization
```

---

## Network Durations

File:

```text
network_durations.dart
```

Contains timeout values.

Examples:

```text
Connect timeout

Receive timeout

Send timeout
```

---

# Request Flow

A network request follows this path:

```text
Feature

↓

Repository

↓

Remote Data Source

↓

API Client

↓

Dio

↓

Internet

↓

Server
```

The response returns through the same layers:

```text
Server

↓

Dio

↓

API Client

↓

Remote Data Source

↓

Repository

↓

Feature

↓

UI
```

---

# Why Use an API Client?

The application should not expose Dio directly.

Incorrect:

```dart
ProductRepository

uses

Dio
```

Correct:

```text
ProductRepository

↓

ProductRemoteDataSource

↓

ApiClient

↓

Dio
```

The API client creates an abstraction between business logic and the networking library.

---

# Interceptors

Interceptors allow us to observe and modify requests.

Shop Lite will use interceptors for:

- Logging
- Authentication
- Error handling
- Token refresh
- Request modification

Example flow:

```text
Request

↓

Logger Interceptor

↓

Auth Interceptor

↓

Dio

↓

Server
```

---

# Error Handling

Network errors should be converted into application-friendly failures.

Examples:

API error:

```text
404 Not Found
```

should become:

```text
ProductNotFoundFailure
```

Connection error:

```text
No Internet
```

should become:

```text
NetworkFailure
```

The UI should not know about Dio exceptions.

---

# Offline-First Networking Strategy

Shop Lite is designed for users with unreliable connectivity.

The application follows this principle:

> Local data is the primary source of truth. The network updates local data when available.

---

# Online Flow

When internet is available:

```text
User

↓

Repository

↓

Check Local Data

↓

Fetch Remote Data

↓

Update Local Database

↓

Return Data

↓

UI
```

---

# Offline Flow

When internet is unavailable:

```text
User

↓

Repository

↓

Local Database

↓

Return Cached Data

↓

UI
```

The user should still be able to use the application.

---

# Caching Strategy

Caching will be handled using:

- Local database storage
- HTTP caching
- Cached images

Planned technologies:

- Isar
- dio_cache_interceptor
- CachedNetworkImage

---

# Network Security

Sensitive information should never be stored inside:

- Source code
- Git repository
- Public configuration files

Sensitive data includes:

- API keys
- Authentication tokens
- User credentials

Secure storage will be handled using:

```text
flutter_secure_storage
```

---

# Current API

Shop Lite currently uses:

EscuelaJS Fake Store API

Base URL:

```text
https://api.escuelajs.co/api/v1
```

Main endpoints:

```text
GET /products

GET /products/{id}

GET /categories

POST /products

PUT /products/{id}

DELETE /products/{id}
```

---

# Future Networking Improvements

Planned additions:

- Authentication interceptor
- Token refresh mechanism
- Retry failed requests
- Request queue
- Background synchronization
- API pagination
- Network monitoring
- Better offline conflict handling

---

# Summary

The Shop Lite networking layer follows these principles:

- Centralized configuration
- Dio-based communication
- Repository-controlled access
- No direct API calls from UI
- Interceptors for cross-cutting concerns
- Offline-first data strategy
- Clear separation between network and business logic

This design allows the application to remain reliable even under unstable network conditions while remaining easy to maintain and extend.