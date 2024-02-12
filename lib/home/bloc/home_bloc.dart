import 'dart:async';


import 'package:bloc/bloc.dart';


import 'package:bloc_project/Favourite/Favourite.dart';


import 'package:bloc_project/api_service/api_sevice.dart';


import 'package:bloc_project/cart/cart.dart';


import 'package:bloc_project/model/model.dart';


import 'package:meta/meta.dart';


part 'home_event.dart';


part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeInitial()) {

    on<InitialfetchEvent>(initialfetchEvent);


    on<HomeProductWishlistButtonClickedEvent>(

        homeProductWishlistButtonClickedEvent);


    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);


    on<HomeWishlistButtonNavigateButton>(homeWishlistButtonNavigateButton);


    on<HomeCartButtonNavigateButton>(homeCartButtonNavigateButton);

  }


  FutureOr<void> initialfetchEvent(

      InitialfetchEvent event, Emitter<HomeState> emit) async {

    emit(HomeLoadingState());


    final values = await getallproducts();


    emit(HomeLoadedSuccessState(product: values));

  }


  FutureOr<void> homeProductWishlistButtonClickedEvent(

      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {

    print('favourite');


    favourites.add(event.data);


    emit(SnackbarOfFavourites());

  }


  FutureOr<void> homeProductCartButtonClickedEvent(

      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {

    print('cart product');


    carts.add(event.data);


    emit(SnackbarOfCarts());

  }


  FutureOr<void> homeWishlistButtonNavigateButton(

      HomeWishlistButtonNavigateButton event, Emitter<HomeState> emit) {

    emit(HomeNavigateToWishlistPageActionButton());


    print('favourite clicked');

  }


  FutureOr<void> homeCartButtonNavigateButton(

      HomeCartButtonNavigateButton event, Emitter<HomeState> emit) {

    print('cart clicked');


    emit(HomeNavigateToCartPageActionButton());

  }

}

