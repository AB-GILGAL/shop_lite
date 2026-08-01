import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shop_lite/core/network/providers/network_providers.dart';
import 'package:shop_lite/features/products/data/datasources/product_remote_data_source.dart';
import 'package:shop_lite/features/products/data/repositories/product_repository_impl.dart';
import 'package:shop_lite/features/products/domain/repositories/product_repository.dart';

part 'product_providers.g.dart';

@riverpod
ProductRemoteDataSource productRemoteDataSource(Ref ref) {
  final apiClient = ref.read(apiClientProvider);

  return ProductRemoteDataSourceImpl(apiClient: apiClient);
}

@riverpod
ProductRepository productRepository(Ref ref) {
  final remoteDataSource = ref.read(productRemoteDataSourceProvider);

  return ProductRepositoryImpl(remoteDataSource: remoteDataSource);
}
