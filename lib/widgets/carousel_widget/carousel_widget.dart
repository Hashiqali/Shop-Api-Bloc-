import 'package:bloc_project/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

// ignore: must_be_immutable
class CrouselWidget extends StatelessWidget {
  CrouselWidget({super.key, required this.homebloc, required this.value});
  HomeBloc homebloc;

  HomeLoadedSuccessState value;
  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
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
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(i.imageurl), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: 50,
                      child: Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
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
                                onPressed: () {
                                  homebloc.add(AddFavButtonEvent(data: i));
                                },
                                icon: BlocBuilder<HomeBloc, HomeState>(
                                  bloc: homebloc,
                                  builder: (context, state) {
                                    return Icon(
                                      homebloc.checkfav.contains(i)
                                          ? Icons.favorite_outlined
                                          : Icons.favorite_border_outlined,
                                      color: homebloc.checkfav.contains(i)
                                          ? Colors.red
                                          : Colors.black,
                                    );
                                  },
                                )),
                            IconButton(
                                onPressed: () {
                                  homebloc.add(AddCartButtonEvent(data: i));
                                },
                                icon: BlocBuilder<HomeBloc, HomeState>(
                                  bloc: homebloc,
                                  builder: (context, state) {
                                    return Icon(
                                      homebloc.checkcart.contains(i)
                                          ? Icons.shopping_bag
                                          : Icons.shopping_bag_outlined,
                                      color: homebloc.checkcart.contains(i)
                                          ? const Color.fromARGB(255, 3, 3, 3)
                                          : Colors.black,
                                    );
                                  },
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
                      padding: const EdgeInsets.only(left: 40),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: 30,
                        width: 200,
                        child: Row(
                          children: [
                            Text(
                              "USD ${i.price}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Ashi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7, left: 10),
                              child: Text(
                                'Rating:${i.rating} ★',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'HASHI',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900),
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
    );
  }
}
