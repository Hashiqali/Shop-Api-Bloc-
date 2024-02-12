part of 'home_bloc.dart';


@immutable

sealed class HomeEvent {}


class InitialfetchEvent extends HomeEvent {}


class HomeProductWishlistButtonClickedEvent extends HomeEvent {

  final ProductModel data;


  HomeProductWishlistButtonClickedEvent({required this.data});

}


class HomeProductCartButtonClickedEvent extends HomeEvent {

  final ProductModel data;


  HomeProductCartButtonClickedEvent({required this.data});

}


class HomeWishlistButtonNavigateButton extends HomeEvent {}


class HomeCartButtonNavigateButton extends HomeEvent {}

