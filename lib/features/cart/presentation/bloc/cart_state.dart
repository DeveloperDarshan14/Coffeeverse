part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartUpdated extends CartState {
  final List<CoffeeDetailsModel> carts;
  final double subTotal;
  final double gst;
  final double total;


  CartUpdated({
    required this.carts, required this.subTotal, required this.gst, required this.total,
  });



}
