import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop_lite/features/products/presentation/controllers/product_details_controller.dart';
import 'package:shop_lite/shared/widgets/images/app_cached_image.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue = ref.watch(
      productDetailsControllerProvider(productId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: productAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 16),
                Text(error.toString(), textAlign: TextAlign.center),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(productDetailsControllerProvider(productId));
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
        data: (product) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.images.isNotEmpty)
                AspectRatio(
                  aspectRatio: 1,
                  child: AppCachedImage(
                    imageUrl: product.images.first,
                    width: double.infinity,
                  ),
                ),

              const SizedBox(height: 16),

              Text(
                product.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 8),

              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 8),

              Text(
                product.category.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 16),

              Text(
                product.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
