part of 'cart_bloc.dart';


@immutable

sealed class CartState {}


abstract class cartActionState extends CartState {}


final class CartInitial extends CartState {}


class CartSuccessstate extends CartState {

  final List<ProductModel> products;


  CartSuccessstate({required this.products});

}

