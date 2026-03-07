import 'package:coffeeshopui/features/cart/presentation/pages/cart_page.dart';
import 'package:coffeeshopui/features/coffee/presentation/pages/favorite_page.dart';
import 'package:coffeeshopui/features/coffee/presentation/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'notification_page.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  late int _selectedIndex = 0;

  List<Widget> pages=[
    HomePage(),
    CartPage(),
    FavoritePage(),
    NotificationPage(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: _selectedIndex==0,
      onPopInvoked: (didpop) {
        if(_selectedIndex !=0){
          setState(() {
            _selectedIndex=0;
          });
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap:
          _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          items: [

            BottomNavigationBarItem(icon: Icon(Icons.home), label:  'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label:  'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),

          ],

        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
      ),
    );
  }
}
