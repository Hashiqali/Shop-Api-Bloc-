import 'package:bloc_project/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class GridViewWidget extends StatelessWidget {
  HomeBloc homebloc;
  HomeLoadedSuccessState value;

  GridViewWidget({
    super.key,
    required this.homebloc,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    print('builded');
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
      child: GridView.builder(
          itemCount: value.product.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: 2),
          itemBuilder: (ctx, index) {
            final val = value.product[index];
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(val.imageurl), fit: BoxFit.fill),
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
                              spreadRadius: BorderSide.strokeAlignCenter)
                        ]),
                    height: 71,
                    width: 200,
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    'USD ${val.price}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Ashi',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    'Rating: ${val.rating} ★',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'HASHI',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      val.name,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          homebloc.add(
                                              AddFavButtonEvent(data: val));
                                        },
                                        icon: BlocBuilder<HomeBloc, HomeState>(
                                          bloc: homebloc,
                                          buildWhen: (previous, current) =>
                                              true,
                                          builder: (context, state) {
                                            if (state is Updateiconstate) {
                                              return Icon(
                                                homebloc.checkfav.contains(val)
                                                    ? Icons.favorite_outlined
                                                    : Icons
                                                        .favorite_border_outlined,
                                                color: homebloc.checkfav
                                                        .contains(val)
                                                    ? Colors.red
                                                    : Colors.black,
                                              );
                                            }
                                            return Icon(
                                              homebloc.checkfav.contains(val)
                                                  ? Icons.favorite_outlined
                                                  : Icons
                                                      .favorite_border_outlined,
                                              color: homebloc.checkfav
                                                      .contains(val)
                                                  ? Colors.red
                                                  : Colors.black,
                                            );
                                          },
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          homebloc.add(
                                              AddCartButtonEvent(data: val));
                                        },
                                        icon: BlocBuilder<HomeBloc, HomeState>(
                                          bloc: homebloc,
                                          builder: (context, state) {
                                            return Icon(
                                              homebloc.checkcart.contains(val)
                                                  ? Icons.shopping_bag
                                                  : Icons.shopping_bag_outlined,
                                              color: homebloc.checkcart
                                                      .contains(val)
                                                  ? const Color.fromARGB(
                                                      255, 3, 3, 3)
                                                  : Colors.black,
                                            );
                                          },
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
    ));
  }
}
