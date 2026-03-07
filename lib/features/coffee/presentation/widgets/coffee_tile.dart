import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class CoffeeTile extends StatelessWidget {
  final String? coffeeName;
  final String? coffeeDesc;
  final double? coffeePrice;
  final String? coffeeImage;

  const CoffeeTile({
    super.key,
    this.coffeeName,
    this.coffeeDesc,
    this.coffeePrice,
    this.coffeeImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
      child: Container(
        padding: EdgeInsets.all(8),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image.asset(coffeeImage ??  AppConstants.emptyString, fit: BoxFit.cover),
              ),
            ),
            //coffee name
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(coffeeName ??  AppConstants.emptyString, style: TextStyle(fontSize: 20)),
                  SizedBox(height: 4),
                  Text(
                    coffeeDesc ??  AppConstants.emptyString,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            //coffee price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${coffeePrice ??  AppConstants.emptyString}'),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
