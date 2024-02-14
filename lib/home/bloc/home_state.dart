part of 'home_bloc.dart';

sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  List<ProductModel> product;

  HomeLoadedSuccessState({required this.product});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionButton extends HomeActionState {}

class HomeNavigateToCartPageActionButton extends HomeActionState {}

class SnackbarOfCartsAdd extends HomeActionState {}

class SnackbarOfFavouritesAdd extends HomeActionState {}

class SnackbarOfFavouriteRemove extends HomeActionState {}

class SnackbarOfCartRemove extends HomeActionState {}

class NavigateToHome extends HomeActionState {}

class Updateiconstate extends HomeActionState {}
