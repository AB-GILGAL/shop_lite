import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shop_lite/features/products/domain/entities/product.dart';
import 'package:shop_lite/features/products/providers/product_providers.dart';

part 'product_controller.g.dart';

@riverpod
class ProductController extends _$ProductController {
  @override
  Future<List<Product>> build() async {
    final repository = ref.read(productRepositoryProvider);

    return repository.getProducts();
  }

  Future<void> refreshProducts() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() {
      final repository = ref.read(productRepositoryProvider);

      return repository.getProducts();
    });
  }
}
