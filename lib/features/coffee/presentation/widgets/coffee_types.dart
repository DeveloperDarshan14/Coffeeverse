import 'package:coffeeshopui/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CoffeeTypes extends StatelessWidget {

  final String? coffeeType;
  final bool isSelected;

  const CoffeeTypes({
    super.key,
    required this.coffeeType,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            coffeeType ?? AppConstants.emptyString,
            style: TextStyle(
              fontSize: 18,
              color: isSelected ? Colors.orange : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          if (isSelected)
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
            ),
        ],
      ),
    );
  }
}
