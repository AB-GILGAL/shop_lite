import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shop_lite/features/products/domain/entities/product.dart';
import 'package:shop_lite/features/products/providers/product_providers.dart';

part 'product_details_controller.g.dart';

@riverpod
class ProductDetailsController extends _$ProductDetailsController {
  @override
  Future<Product> build(int productId) async {
    final repository = ref.read(productRepositoryProvider);

    return repository.getProductById(productId);
  }
}
