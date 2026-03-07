part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class ClearCartEvent extends CartEvent {}
class AddToCart extends CartEvent {
  final CoffeeDetailsModel coffee;
  AddToCart(this.coffee);
}

class IncreaseQty extends CartEvent {
  final CoffeeDetailsModel coffee;
  IncreaseQty(this.coffee);
}

class DecreaseQty extends CartEvent {
  final CoffeeDetailsModel coffee;
  DecreaseQty(this.coffee);
}



class changeProductPrice extends CartEvent{
  final double price;
  final String size;
  changeProductPrice(this.size,this.price);
}

