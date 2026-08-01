# Cart Feature

## Overview

The Cart feature manages the products a user intends to purchase.

It allows users to:

* Add products to the cart.
* Remove products from the cart.
* Increase product quantity.
* Decrease product quantity.
* View cart contents.
* Calculate item subtotals.
* Calculate the cart total.
* Clear the cart.
* Proceed toward checkout.

The Cart is primarily a client-side feature. Unlike Products and Categories, its state is primarily created and modified through user interaction.

---

# Feature Responsibilities

The Cart feature is responsible for:

* Maintaining cart state.
* Adding products.
* Removing products.
* Updating quantities.
* Calculating subtotals.
* Calculating the total cart value.
* Determining whether the cart is empty.
* Clearing the cart.
* Persisting cart state when required.
* Providing cart state to the UI.

The Cart feature is not responsible for:

* Retrieving product catalogs.
* Managing product categories.
* Processing payments.
* Authenticating users.
* Placing orders.

Those responsibilities belong to their respective features.

---

# Feature Location

The feature is located at:

```text
lib/
└── features/
    └── cart/
```

The feature follows the standard Shop Lite feature architecture:

```text
cart/

├── data/
├── domain/
├── presentation/
└── providers/
```

Not every layer must be implemented immediately.

For example, if cart persistence has not yet been introduced, the Data layer may initially contain little or no code.

---

# Why Cart State Is Different

Products are primarily retrieved from the backend:

```text
API
 ↓
Products
```

Cart state is primarily controlled by the user:

```text
User
 ↓
Cart
```

For example:

```text
User taps "Add to Cart"
        ↓
Cart state changes
        ↓
UI rebuilds
```

Therefore, the Cart feature requires mutable application state.

---

# State Management

The Cart feature uses Riverpod.

A `NotifierProvider` is appropriate when the cart is represented as synchronous mutable state.

Conceptually:

```text
CartNotifier
      ↓
CartState
```

Example:

```dart
final cartProvider =
    NotifierProvider<CartNotifier, CartState>(
      CartNotifier.new,
    );
```

The exact implementation may evolve as the application's persistence requirements become clearer.

---

# Cart State

The Cart state should represent the current contents of the cart.

A possible structure is:

```dart
class CartState {
  final List<CartItem> items;

  const CartState({
    required this.items,
  });
}
```

The state may later include derived information such as:

```text
itemCount
subtotal
total
isEmpty
```

However, values that can reliably be calculated from `items` should generally remain derived rather than independently stored.

This avoids duplicated state.

---

# Cart Item

A cart item represents a product together with the quantity selected by the user.

Conceptually:

```text
CartItem

├── product
└── quantity
```

Example:

```dart
class CartItem {
  final Product product;
  final int quantity;
}
```

A cart item is different from a Product.

A Product represents something available for purchase.

A CartItem represents:

> A specific product and the quantity the user has selected.

---

# Adding a Product

When the user selects:

```text
Add to Cart
```

the CartNotifier handles the operation.

Flow:

```text
ProductCard
      ↓
CartNotifier
      ↓
CartState
      ↓
UI
```

If the product does not already exist:

```text
Product
      ↓
New CartItem
      ↓
quantity = 1
```

If the product already exists:

```text
Existing CartItem
      ↓
quantity + 1
```

This prevents duplicate cart entries for the same product.

---

# Removing a Product

When the user removes an item:

```text
Remove
   ↓
CartNotifier
   ↓
CartState
```

The corresponding `CartItem` is removed from the cart.

---

# Updating Quantity

The user can increase or decrease quantity.

Example:

```text
Quantity: 1

      ↓ +

Quantity: 2

      ↓ +

Quantity: 3
```

When decreasing:

```text
Quantity: 3

      ↓ -

Quantity: 2
```

A quantity should not normally fall below:

```text
1
```

If the user wants to remove the item completely, the Remove action should be used.

An alternative UX may remove the item automatically when quantity reaches zero. The final behavior should be standardized when the cart UI is implemented.

---

# Subtotal

Each cart item has a subtotal:

```text
subtotal = product price × quantity
```

Example:

```text
Product price = GHS 50
Quantity      = 3

Subtotal      = GHS 150
```

The subtotal should be derived from the current cart state.

---

# Cart Total

The cart total is the sum of all item subtotals.

Example:

```text
Item A
GHS 50 × 2 = GHS 100

Item B
GHS 80 × 1 = GHS 80

------------------
Cart Total = GHS 180
```

Conceptually:

```text
Cart
 ↓
Cart Items
 ↓
Item Subtotals
 ↓
Cart Total
```

---

# Quantity and Price Calculations

Calculations should not be performed directly inside widgets.

Avoid:

```dart
Text(
  '${item.product.price * item.quantity}',
)
```

when the calculation represents business logic.

Prefer exposing the required derived value through the appropriate domain/state model.

This keeps presentation code focused on displaying information.

---

# Cart Provider API

The CartNotifier may eventually expose operations such as:

```text
addItem(product)

removeItem(productId)

increaseQuantity(productId)

decreaseQuantity(productId)

updateQuantity(productId, quantity)

clearCart()
```

The exact API should remain as small as possible.

This follows the project's KISS and YAGNI principles.

---

# Cart UI

The Cart feature may contain:

```text
presentation/

├── pages/
│   └── cart_page.dart
│
└── widgets/
    ├── cart_item_card.dart
    ├── cart_summary.dart
    └── cart_empty_view.dart
```

The exact structure may evolve as the feature grows.

---

# Cart Page

The Cart page displays the user's current cart.

Possible sections:

```text
Cart Page

├── Cart Items
│
├── Quantity Controls
│
├── Remove Actions
│
└── Cart Summary
```

The page should react to changes in the Cart provider.

---

# Cart Item Card

The Cart Item Card may display:

* Product image.
* Product name.
* Product price.
* Quantity.
* Item subtotal.
* Increase quantity button.
* Decrease quantity button.
* Remove button.

Example:

```text
┌─────────────────────────────┐
│ Product Image   Product     │
│                 GHS 50      │
│                             │
│                 −  2  +     │
│                 GHS 100     │
│                       Remove│
└─────────────────────────────┘
```

The card should not contain cart business logic.

It should invoke the appropriate notifier actions.

---

# Cart Summary

The Cart Summary displays derived totals.

Possible information:

```text
Subtotal
Delivery Fee
Discount
Total
```

Initially, Shop Lite may only have:

```text
Subtotal
Total
```

Delivery fees, discounts, taxes, and other charges should be introduced only when the requirements are defined.

---

# Empty Cart

When there are no items:

```text
Cart
 ↓
items.isEmpty
 ↓
Empty Cart UI
```

Example message:

```text
Your cart is empty.
```

The screen may provide a navigation action:

```text
Continue Shopping
```

---

# Cart Badge

The application may display the number of cart items in navigation elements.

Example:

```text
Home     Categories     Cart(3)
```

The badge should derive its value from the Cart state.

Avoid maintaining a separate:

```text
cartBadgeCount
```

state.

Instead:

```text
CartState
   ↓
items
   ↓
derived item count
   ↓
Cart Badge
```

This prevents two pieces of state from becoming inconsistent.

---

# Product Interaction

Products can initiate Cart operations.

Example:

```text
ProductCard
      ↓
Add to Cart
      ↓
CartNotifier
```

However, the Products feature should not own the cart state.

The Cart feature owns:

```text
CartState
CartNotifier
CartItem
```

---

# Categories Interaction

Categories do not directly modify the cart.

The relationship is indirect:

```text
Category
   ↓
Products
   ↓
Add to Cart
   ↓
Cart
```

---

# Persistence

Cart persistence may be introduced so that the cart survives application restarts.

Possible storage solutions include:

* Hive.
* Isar.
* SharedPreferences for simple data.
* Secure storage only where sensitive information is involved.

The chosen storage mechanism should follow the project's persistence strategy.

Potential architecture:

```text
CartNotifier
      ↓
CartRepository
      ↓
LocalDataSource
      ↓
Local Storage
```

If persistence is not required initially, the cart can remain in memory.

---

# Offline Support

The Cart is fundamentally different from server-backed product data.

A user should generally be able to:

```text
Browse cached products
      ↓
Add to cart
      ↓
Modify cart
```

even when temporarily offline, provided the necessary product information is available locally.

However, checkout and order submission require backend connectivity.

Conceptually:

```text
Cart
 ↓
Local State
 ↓
Checkout
 ↓
Network Required
```

---

# Checkout Boundary

The Cart feature should not become the Checkout feature.

The boundary should be:

```text
Cart
 ↓
Review Items
 ↓
Proceed to Checkout
```

Then:

```text
Checkout
 ↓
Address
 ↓
Delivery
 ↓
Payment
 ↓
Order
```

This keeps the Cart focused.

---

# Order Interaction

The Cart should eventually provide the information required to create an order.

Example:

```text
Cart
 ↓
Checkout
 ↓
Order Request
 ↓
Order API
```

After a successful order:

```text
Order Created
      ↓
Cart Cleared
```

The exact transaction flow should be documented when the Checkout and Orders features are introduced.

---

# Error Handling

Most cart operations are local and therefore may not require network error handling.

However, errors can occur when:

* Persisting the cart.
* Synchronizing the cart.
* Validating products against the server.
* Starting checkout.

Errors should follow the application's central error-handling strategy.

The UI should display user-friendly messages rather than raw exceptions.

---

# Testing

The Cart feature should have strong unit test coverage because much of its behavior is deterministic.

## Cart State Tests

Test:

* Empty cart.
* Adding an item.
* Adding the same item twice.
* Removing an item.
* Increasing quantity.
* Decreasing quantity.
* Updating quantity.
* Clearing the cart.
* Calculating subtotal.
* Calculating total.
* Calculating item count.

---

## Provider Tests

Test:

* Initial state.
* Add operation.
* Remove operation.
* Quantity changes.
* State transitions.
* Persistence behavior when implemented.

---

## UI Tests

Test:

* Empty cart display.
* Cart items display.
* Quantity controls.
* Remove action.
* Total updates.
* Navigation to checkout.

---

# Feature Checklist

Before considering the Cart feature complete:

* [ ] Cart entity/state created.
* [ ] Cart item model/entity created.
* [ ] Cart provider created.
* [ ] Add item implemented.
* [ ] Remove item implemented.
* [ ] Increase quantity implemented.
* [ ] Decrease quantity implemented.
* [ ] Clear cart implemented.
* [ ] Subtotal calculation implemented.
* [ ] Total calculation implemented.
* [ ] Empty cart state implemented.
* [ ] Cart page implemented.
* [ ] Cart item widget implemented.
* [ ] Cart summary implemented.
* [ ] Cart badge implemented.
* [ ] Persistence implemented if required.
* [ ] Tests added.

---

# Future Improvements

Potential future functionality includes:

* Persistent cart.
* Server-side cart synchronization.
* Product availability validation.
* Discount codes.
* Promotional pricing.
* Tax calculation.
* Delivery fee calculation.
* Saved carts.
* Guest cart.
* Authenticated user cart synchronization.

These should only be implemented when they become actual requirements.

---

# Summary

The Cart feature manages the products selected by the user for purchase.

Its primary responsibility is local cart state and cart operations.

The architecture is:

```text
Product
   ↓
Add to Cart
   ↓
CartNotifier
   ↓
CartState
   ↓
Cart UI
```

When persistence is introduced:

```text
CartNotifier
      ↓
CartRepository
      ↓
LocalDataSource
      ↓
Local Storage
```

When checkout is introduced:

```text
Cart
 ↓
Checkout
 ↓
Payment
 ↓
Order
```

The Cart feature remains independent from Products, Categories, Authentication, Checkout, and Payments while exposing the state required by those features.
