import 'package:coffeeshopui/features/coffee/data/models/coffee_details_model.dart';
import 'package:flutter/material.dart';

class CoffeeTileRowHomepage extends StatelessWidget {
  final CoffeeDetailsModel coffee;
  const CoffeeTileRowHomepage({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(
                  coffee.coffeeImage,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
                // Image.asset(coffee.coffeeImage, fit: BoxFit.cover,gaplessPlayback: true,),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.coffeeName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  coffee.coffeeDesc,
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ],
            ),
            const Spacer(),
            Text(
              '\$${coffee.coffeePrice.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            Material(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
