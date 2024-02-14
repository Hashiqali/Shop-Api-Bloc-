import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:bloc_project/cart/cart.dart';

import 'package:bloc_project/model/model.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartinitialEvent>(cartinitialEvent);

    on<CartRemoveEvent>(cartRemoveEvent);
  }

  FutureOr<void> cartinitialEvent(
      CartinitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessstate(products: carts));
  }

  FutureOr<void> cartRemoveEvent(
      CartRemoveEvent event, Emitter<CartState> emit) {
    carts.remove(event.product);

    emit(CartSuccessstate(products: carts));
  }
}
