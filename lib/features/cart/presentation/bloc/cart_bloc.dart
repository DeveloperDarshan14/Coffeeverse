import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../coffee/data/models/coffee_details_model.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CoffeeDetailsModel> _carts = [];

  CartBloc() : super(CartInitial()) {

    on<AddToCart>((event, emit) {
      final existingIndex =
      _carts.indexWhere((item) => item.coffeeName == event.coffee.coffeeName);

      if (existingIndex != -1) {
        _carts[existingIndex].qty++;
      } else {
        event.coffee.qty = 1;
        _carts.add(event.coffee);
      }

      _emitUpdatedState(emit);
    });

    on<IncreaseQty>((event, emit) {
      event.coffee.qty++;
      _emitUpdatedState(emit);
    });

    on<changeProductPrice>((event,emit){

    });
    on<DecreaseQty>((event, emit) {
      event.coffee.qty--;

      if (event.coffee.qty <= 0) {
        _carts.remove(event.coffee);
      }

      _emitUpdatedState(emit);
    });

    on<ClearCartEvent>((event,emit){
      _emitUpdateCartState(emit);
    });
  }

     void _emitUpdateCartState(Emitter<CartState> emit){
       _carts.clear();

       emit(CartUpdated(
         carts: [],
         subTotal: 0,
         gst: 0,
         total: 0,
       ));
     }
  void _emitUpdatedState(Emitter<CartState> emit) {
    double subTotal = 0;

    for (var item in _carts) {
      subTotal += (item.coffeePrice ?? 0) * item.qty;
    }

    double gst = subTotal * 0.05;
    double total = subTotal + gst;

    emit(CartUpdated(
      carts: List.from(_carts),
      subTotal: subTotal,
      gst: gst,
      total: total,
    ));
  }
}