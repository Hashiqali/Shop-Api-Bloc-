import 'package:bloc_project/Favourite/Favourite.dart';
import 'package:bloc_project/api_service/api_sevice.dart';
import 'package:bloc_project/widgets/carousel_widget/carousel_widget.dart';
import 'package:bloc_project/widgets/fav&cart_buttons/fav&cart_buttons.dart';
import 'package:bloc_project/widgets/grid_view/gird_view.dart';
import 'package:bloc_project/home/bloc/home_bloc.dart';
import 'package:bloc_project/cart/cart.dart';
import 'package:bloc_project/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homebloc.add(InitialfetchEvent());
    super.initState();
  }

  final HomeBloc homebloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    getallproducts();
    final size = MediaQuery.of(context).size;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionButton) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const FavouriteScreen()));
        } else if (state is HomeNavigateToCartPageActionButton) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const Cartscreen()));
        } else if (state is SnackbarOfFavouritesAdd) {
          snackbar('Added to Favourite', context);
        } else if (state is SnackbarOfCartsAdd) {
          snackbar('Added to Cart', context);
        } else if (state is SnackbarOfCartRemove) {
          snackbar('Removed from Cart', context);
        } else if (state is SnackbarOfFavouriteRemove) {
          snackbar('Removed from Favourite', context);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case const (HomeLoadedSuccessState):
            final value = state as HomeLoadedSuccessState;

            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'HASHI',
                      color: Color.fromARGB(255, 248, 248, 248),
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 45, 44, 44),
                ),
                body: Column(
                  children: [
                    inkwellbutton(homebloc: homebloc, size: size),
                    const Text(
                      'FLAT 50% OFF',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ashi',
                          fontWeight: FontWeight.w800),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      child: CrouselWidget(homebloc: homebloc, value: value),
                    ),
                    const Text(
                      'All Products',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ashi',
                          fontWeight: FontWeight.w800),
                    ),
                    GridViewWidget(
                      homebloc: homebloc,
                      value: value,
                    ),
                  ],
                ));

          case const (HomeErrorState):
            return const Scaffold(
              body: Center(
                child: Text(
                  'Error',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
        }

        return Container();
      },
    );
  }
}
