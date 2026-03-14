import 'package:coffeeshopui/core/router/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class NavigationPage extends StatefulWidget {
  final Widget child;
  const NavigationPage({super.key, required this.child});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late int currentIndex = 0;

  List<String> routes = [
    RoutesNames.home,
    RoutesNames.cart,
    RoutesNames.favorite,
    RoutesNames.notification,
  ];

  void _onItemTapped(int index) {
    context.go(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex = routes.indexWhere((route) => location.startsWith(route));

    print('current index is $currentIndex');

    if (currentIndex < 0) currentIndex = 0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didpop, result) async {
        if (didpop) return;
        if (currentIndex != 0) {
          setState(() {
            currentIndex = 0;
          });

          context.go(RoutesNames.home);
          return;
        }
        bool? exit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit App"),
            content: const Text("Do you want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Yes"),
              ),
            ],
          ),
        );

        if (exit == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
          ],
        ),
        body: widget.child,
      ),
    );
  }
}
