import 'package:shop_lite/features/products/domain/entities/product.dart';
import 'package:shop_lite/features/products/domain/repositories/product_repository.dart';

import '../datasources/product_remote_data_source.dart';

final class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required ProductRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getProducts() async {
    return _remoteDataSource.getProducts();
  }

  @override
  Future<Product> getProductById(int id) {
    return _remoteDataSource.getProductById(id);
  }
}
