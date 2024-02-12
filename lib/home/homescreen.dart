// ignore_for_file: collection_methods_unrelated_type

import 'package:bloc_project/Favourite/Favourite.dart';
import 'package:bloc_project/api_service/api_sevice.dart';
import 'package:bloc_project/bloc/home/bloc/home_bloc.dart';
import 'package:bloc_project/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

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
        } else if (state is SnackbarOfFavourites) {
          snackbar('Added to Favourite', context);
        } else if (state is SnackbarOfCarts) {
          snackbar(' Added to Cart', context);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              homebloc.add(HomeWishlistButtonNavigateButton());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 57, 57, 56),
                                  borderRadius: BorderRadius.circular(10)),
                              height: size.height / 17,
                              width: size.width / 2.5,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite_outlined,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Favourite',
                                      style: TextStyle(fontFamily: 'Ashi'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              homebloc.add(HomeCartButtonNavigateButton());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 57, 57, 56),
                                  borderRadius: BorderRadius.circular(10)),
                              height: size.height / 17,
                              width: size.width / 2.5,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.shopping_bag, color: Colors.white),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5, top: 2),
                                    child: Text('Cart',
                                        style: TextStyle(fontFamily: 'Ashi')),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Text(
                      'FLAT 50% OFF',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ashi',
                          fontWeight: FontWeight.w800),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      child: FlutterCarousel(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: double.infinity,
                          height: 180.0,
                          showIndicator: true,
                          slideIndicator: const CircularSlideIndicator(),
                        ),
                        items: value.product.reversed.take(10).map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        image: DecorationImage(
                                            image: NetworkImage(i.imageurl),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        width: double.infinity,
                                        height: 50,
                                        child: Row(children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                i.name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: 'HASHI',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    color: Colors.black,
                                                  )),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.shopping_bag_outlined,
                                                    color: Colors.black,
                                                  ))
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 30,
                                          width: 190,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Rs: ${i.price}",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Ashi',
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7, left: 10),
                                                child: Text(
                                                  'Rating:${i.rating} ★',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'HASHI',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const Text(
                      'All Product',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ashi',
                          fontWeight: FontWeight.w800),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 10, left: 10, right: 10),
                      child: GridView.builder(
                          itemCount: value.product.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  crossAxisCount: 2),
                          itemBuilder: (ctx, index) {
                            final val = value.product[index];
                            return Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(val.imageurl),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 50,
                              width: 100,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurStyle: BlurStyle.outer,
                                              spreadRadius:
                                                  BorderSide.strokeAlignCenter)
                                        ]),
                                    height: 71,
                                    width: 200,
                                    child: SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2),
                                                  child: Text(
                                                    'Rs:${val.price}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Ashi',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2),
                                                  child: Text(
                                                    'Rating: ${val.rating} ★',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'HASHI',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      val.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontFamily: 'HASHI',
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          homebloc.add(
                                                              HomeProductWishlistButtonClickedEvent(
                                                                  data: val));
                                                        },
                                                        icon: !favourites
                                                                .contains(
                                                                    val.id)
                                                            ? const Icon(
                                                                Icons
                                                                    .favorite_border_outlined,
                                                                color: Colors
                                                                    .black,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .favorite_outlined,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                    IconButton(
                                                        onPressed: () {
                                                          homebloc.add(
                                                              HomeProductCartButtonClickedEvent(
                                                                  data: val));
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .shopping_bag_outlined,
                                                          color: Colors.black,
                                                        ))
                                                  ],
                                                )
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ))
                  ],
                ));

          case HomeErrorState:
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
