class CoffeeDetailsModel {

  final String coffeeName;
  final String coffeeDesc;
  final double coffeePrice;
  final String coffeeImage;
  final double smallPrice;
  final double mediumPrice;
  final double largePrice;
  int qty;

  CoffeeDetailsModel({
    required this.coffeeName,
    required this.coffeePrice,
    required this.coffeeDesc,
    required this.coffeeImage,
    required this.smallPrice,
    required this.mediumPrice,
    required this.largePrice,
    this.qty=0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CoffeeDetailsModel &&
              runtimeType == other.runtimeType &&
              coffeeName == other.coffeeName;

  @override
  int get hashCode => coffeeName.hashCode;
}
