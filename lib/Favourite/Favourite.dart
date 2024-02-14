// ignore_for_file: collection_methods_unrelated_type

import 'package:bloc_project/Favourite/bloc/favourite_bloc.dart';
import 'package:bloc_project/home/bloc/home_bloc.dart';

import 'package:bloc_project/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<ProductModel> favourites = [];

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final favBloc = FavouriteBloc();
  @override
  void initState() {
    favBloc.add(FavInitializeEvent());
    super.initState();
  }

  final HomeBloc homebloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteBloc, FavouriteState>(
      bloc: favBloc,
      listenWhen: (previous, current) => current is FavActionState,
      buildWhen: (previous, current) => current is! FavActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (FavSuccessState):
            final value = state as FavSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 45, 44, 44),
                centerTitle: true,
                title: const Text(
                  'Favourites',
                  style: TextStyle(
                      fontFamily: 'HASHI', fontWeight: FontWeight.w900),
                ),
              ),
              body: ListView.builder(
                  itemCount: value.products.length,
                  itemBuilder: (ctx, index) {
                    final data = value.products[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(data.imageurl),
                                fit: BoxFit.fill),
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
                                    data.name,
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
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: IconButton(
                                    onPressed: () {
                                      favBloc
                                          .add(FavdeleteEvent(product: data));

                                      homebloc.add(Buttonupdate(data: data));
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.black,
                                    )),
                              )
                            ]),
                          ),
                        ),
                      ),
                    );
                  }),
            );
        }
        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('Error'),
          ),
        );
      },
    );
  }
}
