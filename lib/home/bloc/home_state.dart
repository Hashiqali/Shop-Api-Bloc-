part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  List<ProductModel> product;

  HomeLoadedSuccessState({required this.product});
}

class FvouriteListstate extends HomeState {
  List<ProductModel> favourite;

  FvouriteListstate({required this.favourite});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionButton extends HomeActionState {}

class HomeNavigateToCartPageActionButton extends HomeActionState {}

class SnackbarOfCarts extends HomeActionState {}

class SnackbarOfFavourites extends HomeActionState {}
