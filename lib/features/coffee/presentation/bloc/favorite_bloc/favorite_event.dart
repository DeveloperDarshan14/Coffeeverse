part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}


class ToggleFavoriteEvent extends FavoriteEvent{

  final CoffeeDetailsModel coffee;

  ToggleFavoriteEvent(this.coffee);
}
class AddToFavorite extends FavoriteEvent{

  final String item;
  AddToFavorite(this.item);

}


class SetSelectedCoffeeTypes extends FavoriteEvent{
  final int index;
  SetSelectedCoffeeTypes(this.index);
}
class RemoveFromFavorite extends FavoriteEvent{

  final String item;
  RemoveFromFavorite(this.item);

}
