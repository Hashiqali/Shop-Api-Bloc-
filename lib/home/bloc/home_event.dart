part of 'home_bloc.dart';

sealed class HomeEvent {}

class InitialfetchEvent extends HomeEvent {}

class AddFavButtonEvent extends HomeEvent {
  final ProductModel data;

  AddFavButtonEvent({required this.data});
}

class AddCartButtonEvent extends HomeEvent {
  final ProductModel data;

  AddCartButtonEvent({required this.data});
}

class NavigateToFav extends HomeEvent {}

class NavigateToCart extends HomeEvent {}

class Buttonupdate extends HomeEvent {
  final ProductModel data;

  Buttonupdate({required this.data});
}
