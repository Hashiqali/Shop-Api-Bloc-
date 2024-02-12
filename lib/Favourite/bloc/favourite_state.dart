part of 'favourite_bloc.dart';


@immutable

sealed class FavouriteState {}


abstract class FavActionState extends FavouriteState {}


final class FavouriteInitial extends FavouriteState {}


class FavSuccessState extends FavouriteState {

  final List<ProductModel> products;


  FavSuccessState({required this.products});

}

