import 'package:bloc/bloc.dart';
import 'package:coffeeshopui/features/coffee/data/models/coffee_details_model.dart';
import 'package:coffeeshopui/features/coffee/data/models/coffee_types_model.dart';
import 'package:meta/meta.dart';

import 'favorite_state.dart';

part 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState()) {
    on<ToggleFavoriteEvent>((event, emit) {
      final favorites = List<CoffeeDetailsModel>.from(state.favorites);
      bool isAdded;
      if (favorites.contains(event.coffee)) {
        favorites.remove(event.coffee);
        isAdded = false;
      } else {
        favorites.add(event.coffee);
        isAdded = true;
      }
      emit(
        FavoriteState(
          favorites: List.from(favorites),
          isAdded: isAdded,
          coffee: event.coffee,
        ),
      );
    });

    on<SetSelectedCoffeeTypes>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}
