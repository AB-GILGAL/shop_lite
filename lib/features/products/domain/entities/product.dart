class Product {
  const Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
  });

  final int id;

  final String title;

  final String slug;

  final double price;

  final String description;

  final ProductCategory category;

  final List<String> images;

  final DateTime creationAt;

  final DateTime updatedAt;
}

class ProductCategory {
  const ProductCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  final int id;

  final String name;

  final String slug;

  final String image;

  final DateTime creationAt;

  final DateTime updatedAt;
}
