part of 'favourite_bloc.dart';


@immutable

sealed class FavouriteEvent {}


class FavInitializeEvent extends FavouriteEvent {}


class FavdeleteEvent extends FavouriteEvent {

  final ProductModel product;


  FavdeleteEvent({required this.product});

}

