import 'package:coffeeshopui/features/cart/presentation/pages/cart_page.dart';
import 'package:coffeeshopui/features/coffee/presentation/pages/favorite_page.dart';
import 'package:coffeeshopui/features/coffee/presentation/pages/homepage.dart';
import 'package:coffeeshopui/features/coffee/presentation/pages/notification_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/coffee/data/models/coffee_details_model.dart';
import '../../features/coffee/presentation/pages/coffee_details_page.dart';
import '../../features/coffee/presentation/pages/navigation_page.dart';
import '../splash/splashscreen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splashScreen',
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) => NavigationPage(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => HomePage()),
          GoRoute(path: '/cart', builder: (context, state) => CartPage()),
          GoRoute(
            path: '/favorite',
            builder: (context, state) => FavoritePage(),
          ),
          GoRoute(
            path: '/notification',
            builder: (context, state) => NotificationPage(),
          ),
        ],
      ),

      GoRoute(
        path: '/splashScreen',
        builder: (context, state) => SplashScreen(),
      ),

      GoRoute(
        path: '/coffeeDetailsPage',
        builder: (context, state) {
          final coffee = state.extra as CoffeeDetailsModel;
          return CoffeeDetailsPage(coffeeDetailsModel: coffee);
        },
      ),
      GoRoute(
        path: '/searchPage',
        builder: (context, state) {
          final coffee = state.extra as CoffeeDetailsModel;
          return CoffeeDetailsPage(coffeeDetailsModel: coffee);
        },
      ),

    ],
  );
}
