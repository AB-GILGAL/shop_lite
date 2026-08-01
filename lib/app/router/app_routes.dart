abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const product = '/products';
  static const productDetails = '/products/:id';
  static const cart = '/cart';
  static const favorites = '/favorites';
  static const profile = '/profile';
  static const settings = '/settings';

  static String productDetailsPath(int id) {
    return '/products/$id';
  }
}