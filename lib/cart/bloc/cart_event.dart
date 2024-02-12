part of 'cart_bloc.dart';


@immutable

sealed class CartEvent {}


class CartinitialEvent extends CartEvent {}


class CartRemoveEvent extends CartEvent {

  final ProductModel product;


  CartRemoveEvent({required this.product});

}

