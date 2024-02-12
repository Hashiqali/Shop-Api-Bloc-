import 'dart:async';


import 'package:bloc/bloc.dart';


import 'package:bloc_project/Favourite/Favourite.dart';


import 'package:bloc_project/model/model.dart';


import 'package:meta/meta.dart';


part 'favourite_event.dart';


part 'favourite_state.dart';


class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {

  FavouriteBloc() : super(FavouriteInitial()) {

    on<FavInitializeEvent>(favInitializeEvent);


    on<FavdeleteEvent>(favdeleteEvent);

  }


  FutureOr<void> favInitializeEvent(

      FavInitializeEvent event, Emitter<FavouriteState> emit) {

    emit(FavSuccessState(products: favourites));

  }


  FutureOr<void> favdeleteEvent(

      FavdeleteEvent event, Emitter<FavouriteState> emit) {

    favourites.remove(event.product);


    emit(FavSuccessState(products: favourites));

  }

}

