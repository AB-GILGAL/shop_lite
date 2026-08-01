// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productDetailsControllerHash() =>
    r'929a754533a0bb92495a31f64265e97082ad5a7f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProductDetailsController
    extends BuildlessAutoDisposeAsyncNotifier<Product> {
  late final int productId;

  FutureOr<Product> build(int productId);
}

/// See also [ProductDetailsController].
@ProviderFor(ProductDetailsController)
const productDetailsControllerProvider = ProductDetailsControllerFamily();

/// See also [ProductDetailsController].
class ProductDetailsControllerFamily extends Family<AsyncValue<Product>> {
  /// See also [ProductDetailsController].
  const ProductDetailsControllerFamily();

  /// See also [ProductDetailsController].
  ProductDetailsControllerProvider call(int productId) {
    return ProductDetailsControllerProvider(productId);
  }

  @override
  ProductDetailsControllerProvider getProviderOverride(
    covariant ProductDetailsControllerProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productDetailsControllerProvider';
}

/// See also [ProductDetailsController].
class ProductDetailsControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ProductDetailsController,
          Product
        > {
  /// See also [ProductDetailsController].
  ProductDetailsControllerProvider(int productId)
    : this._internal(
        () => ProductDetailsController()..productId = productId,
        from: productDetailsControllerProvider,
        name: r'productDetailsControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productDetailsControllerHash,
        dependencies: ProductDetailsControllerFamily._dependencies,
        allTransitiveDependencies:
            ProductDetailsControllerFamily._allTransitiveDependencies,
        productId: productId,
      );

  ProductDetailsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final int productId;

  @override
  FutureOr<Product> runNotifierBuild(
    covariant ProductDetailsController notifier,
  ) {
    return notifier.build(productId);
  }

  @override
  Override overrideWith(ProductDetailsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductDetailsControllerProvider._internal(
        () => create()..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductDetailsController, Product>
  createElement() {
    return _ProductDetailsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailsControllerProvider &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductDetailsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<Product> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _ProductDetailsControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ProductDetailsController,
          Product
        >
    with ProductDetailsControllerRef {
  _ProductDetailsControllerProviderElement(super.provider);

  @override
  int get productId => (origin as ProductDetailsControllerProvider).productId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
