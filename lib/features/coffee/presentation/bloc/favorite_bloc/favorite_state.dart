import '../../../data/models/coffee_details_model.dart';

class FavoriteState {
  final List<CoffeeDetailsModel> favorites;
  final bool isAdded;
  final CoffeeDetailsModel? coffee;
  final int selectedIndex;

  const FavoriteState({
    this.favorites = const [],
    this.isAdded = false,
    this.coffee,
    this.selectedIndex = 0,
  });

  FavoriteState copyWith({
    List<CoffeeDetailsModel>? favorites,
    bool? isAdded,
    CoffeeDetailsModel? coffee,
    int? selectedIndex,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      isAdded: isAdded ?? this.isAdded,
      coffee: coffee ?? this.coffee,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}