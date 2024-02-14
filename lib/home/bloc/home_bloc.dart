import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:bloc_project/Favourite/Favourite.dart';

import 'package:bloc_project/api_service/api_sevice.dart';

import 'package:bloc_project/cart/cart.dart';

import 'package:bloc_project/model/model.dart';

part 'home_event.dart';

part 'home_state.dart';

List<ProductModel> allproducts = [];

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitialfetchEvent>(initialfetchEvent);

    on<AddFavButtonEvent>(addFavButtonEvent);

    on<AddCartButtonEvent>(addCartButtonEvent);

    on<NavigateToFav>(navigateToFav);

    on<NavigateToCart>(navigateToCart);
    on<Buttonupdate>(buttonupdate);
  }
  List<ProductModel> checkfav = [];
  List<ProductModel> checkcart = [];

  FutureOr<void> initialfetchEvent(
      InitialfetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    final values = await getallproducts();
    allproducts.addAll(values);
    emit(HomeLoadedSuccessState(product: values));
    emit(NavigateToHome());
  }

  FutureOr<void> addFavButtonEvent(
      AddFavButtonEvent event, Emitter<HomeState> emit) {
    if (!favourites.contains(event.data)) {
      favourites.add(event.data);
      checkfav.add(event.data);
      print(checkfav);
      emit(SnackbarOfFavouritesAdd());
    } else {
      favourites.remove(event.data);
      checkfav.remove(event.data);
      emit(SnackbarOfFavouriteRemove());
    }
  }

  FutureOr<void> addCartButtonEvent(
      AddCartButtonEvent event, Emitter<HomeState> emit) {
    if (!carts.contains(event.data)) {
      carts.add(event.data);
      checkcart.add(event.data);

      emit(SnackbarOfCartsAdd());
    } else {
      carts.remove(event.data);
      checkcart.remove(event.data);
      emit(SnackbarOfCartRemove());
    }
  }

  FutureOr<void> navigateToFav(NavigateToFav event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistPageActionButton());
  }

  FutureOr<void> navigateToCart(NavigateToCart event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionButton());
  }

  FutureOr<void> buttonupdate(Buttonupdate event, Emitter<HomeState> emit) {
    checkfav.remove(event.data);
    print(checkfav);
    print('deleted');
    print(checkfav);
    emit(Updateiconstate());
  }
}
