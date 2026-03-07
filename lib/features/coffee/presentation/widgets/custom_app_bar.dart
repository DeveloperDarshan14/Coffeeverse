import 'package:coffeeshopui/features/coffee/presentation/pages/address_selection_page.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(75);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(

        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressSelectionPage(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: .only(right: 8.0),
                    child: Row(

                      children: const [
                        Icon(Icons.location_on, color: Colors.white, size: 20),
                        SizedBox(width: 4),
                        Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),

                  const Text(
                    "Wing B 003, Siddhi Apartments, Mumbai Maharashtra",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ],
              )
            ),
          ),
          InkWell(
            onTap: () {},


            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
