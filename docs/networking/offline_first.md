# Offline-First Strategy

## Overview

Shop Lite is designed using an **Offline-First** architecture.

Instead of treating the network as the primary source of data, the application considers **local storage** to be the primary source of truth whenever possible.

This approach provides a faster, more reliable user experience, especially in environments with poor or intermittent internet connectivity.

---

# What is Offline-First?

Traditional applications work like this:

```text
User

↓

API

↓

Response

↓

UI
```

If the API cannot be reached, the application often becomes unusable.

An Offline-First application behaves differently.

```text
User

↓

Repository

↓

Local Database

↓

UI
```

The repository decides when to synchronize with the server.

The user can continue using the application even when the network is unavailable.

---

# Why Offline-First?

Many users experience:

- Slow internet connections
- Unstable mobile networks
- Temporary connection loss
- High data costs

An Offline-First application:

- Starts faster
- Uses less bandwidth
- Continues working without internet
- Feels more responsive
- Improves the overall user experience

---

# Core Principle

The application follows this principle:

> **Read locally first. Synchronize remotely when appropriate.**

Instead of asking:

> "Can I reach the server?"

the application asks:

> "Do I already have the data locally?"

---

# Data Sources

Every repository may communicate with two data sources.

```text
Repository
     │
 ┌───┴────┐
 ▼        ▼
Local   Remote
```

## Local Data Source

Examples:

- Isar Database
- Cached images
- Secure storage

Local storage provides:

- Fast access
- Offline availability
- Reduced network usage

---

## Remote Data Source

Examples:

- REST API
- Authentication server

Remote storage provides:

- Latest data
- Synchronization
- Shared information

---

# Repository Responsibilities

The repository decides:

- Where data comes from
- When to fetch new data
- When to update local storage
- How to resolve conflicts

Neither the UI nor the API client should make these decisions.

---

# Read Strategy

When reading data, the repository follows this sequence.

```text
User Request

↓

Read Local Database

↓

Data Exists?

      │
 ┌────┴────┐
 │         │
Yes        No
 │         │
 ▼         ▼
Return     Fetch API
Local      Data
 │          │
 │          ▼
 │      Save Locally
 │          │
 └──────┬───┘
        ▼
    Return Data
```

This ensures that users receive data as quickly as possible.

---

# Synchronization Strategy

When an internet connection is available:

```text
API

↓

Repository

↓

Update Local Database

↓

UI
```

The repository keeps the local database synchronized with the server.

---

# Offline Behaviour

When there is no internet connection:

```text
User

↓

Repository

↓

Local Database

↓

UI
```

The user should still be able to:

- Browse products
- View categories
- Open product details
- Search cached products

Some actions that require the server may be unavailable until connectivity returns.

---

# Network Detection

Shop Lite uses two packages to monitor connectivity.

## connectivity_plus

Determines the current network type.

Examples:

- Wi-Fi
- Mobile data
- Ethernet
- No network

This package does **not** confirm that the internet is reachable.

---

## internet_connection_checker

Confirms whether the device can actually reach the internet.

Example:

```text
Wi-Fi Connected

↓

No Internet Access
```

This package verifies internet availability before attempting synchronization.

---

# Background Synchronization

Future versions of Shop Lite will synchronize data automatically.

Example:

```text
Internet Restored

↓

Background Worker

↓

Fetch Latest Data

↓

Update Local Database

↓

Notify UI
```

This process will use:

- `workmanager`
- Riverpod
- Isar

---

# Caching Strategy

Different types of data require different caching approaches.

| Data | Strategy |
|------|----------|
| Products | Store locally in Isar |
| Categories | Store locally in Isar |
| Product Images | Cache using CachedNetworkImage |
| API Responses | Cache with dio_cache_interceptor where appropriate |
| Authentication Tokens | Store securely with flutter_secure_storage |

---

# Freshness Strategy

Not all data needs to be refreshed at the same frequency.

Examples:

| Data | Suggested Refresh |
|------|-------------------|
| Categories | Infrequently |
| Product List | Periodically or on pull-to-refresh |
| Product Details | When viewed or stale |
| User Profile | On demand or after updates |

The refresh policy should balance freshness with bandwidth usage.

---

# Error Handling

Offline is not considered an application error.

Instead of displaying:

```text
Connection Failed
```

the application should:

- Display cached data when available.
- Inform the user that the information may not be the latest.
- Retry synchronization when connectivity returns.

Only when no cached data exists should the user see an empty or error state.

---

# User Experience Principles

An Offline-First application should:

- Start quickly.
- Avoid unnecessary loading indicators.
- Show cached content immediately.
- Synchronize quietly in the background.
- Inform users of important synchronization failures without interrupting normal use.

---

# Benefits

Implementing an Offline-First architecture provides:

- Better performance
- Improved reliability
- Reduced bandwidth consumption
- Faster perceived loading times
- Better user satisfaction
- Greater resilience to poor network conditions

---

# Future Enhancements

As Shop Lite evolves, the Offline-First strategy may include:

- Background synchronization queues
- Conflict resolution policies
- Optimistic updates
- Selective synchronization
- Cache expiration rules
- Synchronization status indicators

---

# Summary

Shop Lite follows an Offline-First architecture where:

- Local storage is the primary source for reading data whenever practical.
- Repositories decide when to synchronize with remote services.
- Users continue to access previously stored information even without internet connectivity.
- Background synchronization keeps local data aligned with the server when connectivity is restored.

This strategy supports the project's goal of delivering a fast, reliable experience under both stable and unreliable network conditions.Alright next