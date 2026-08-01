import 'package:go_router/go_router.dart';
import 'package:shop_lite/app/router/app_routes.dart';
import 'package:shop_lite/features/cart/presentation/widgets/cart.dart';
import 'package:shop_lite/features/favorites/presentation/widgets/favorites.dart';
import 'package:shop_lite/features/home/presentation/widgets/home.dart';
import 'package:shop_lite/features/onboarding/presentation/widgets/onboarding.dart';
import 'package:shop_lite/features/products/presentation/pages/product_details_page.dart';
import 'package:shop_lite/features/products/presentation/pages/products_page.dart';
import 'package:shop_lite/features/profile/presentation/widgets/profile.dart';
import 'package:shop_lite/features/settings/presentation/widgets/settings.dart';
import 'package:shop_lite/features/splash/presentation/widgets/splash.dart';
final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),

    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),

    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: AppRoutes.cart,
      builder: (context, state) => const CartPage(),
    ),

    GoRoute(
      path: AppRoutes.favorites,
      builder: (context, state) => const FavoritesPage(),
    ),

    GoRoute(
      path: AppRoutes.product,
      builder: (context, state) => const ProductsPage(),
    ),

    GoRoute(
  path: AppRoutes.productDetails,
  builder: (context, state) {
    final productId = int.parse(state.pathParameters['id']!);

    return ProductDetailsPage(
      productId: productId,
    );
  },
),

    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfilePage(),
    ),

    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);