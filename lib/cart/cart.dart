import 'package:bloc_project/cart/bloc/cart_bloc.dart';
import 'package:bloc_project/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<ProductModel> carts = [];

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  final cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartinitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is cartActionState,
        buildWhen: (previous, current) => current is! cartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessstate:
              final value = state as CartSuccessstate;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 45, 44, 44),
                  centerTitle: true,
                  title: const Text(
                    'Carts',
                    style: TextStyle(
                        fontFamily: 'HASHI', fontWeight: FontWeight.w900),
                  ),
                ),
                body: ListView.builder(
                    itemCount: carts.length,
                    itemBuilder: (ctx, index) {
                      final data = value.products[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.amber,
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
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          cartBloc.add(
                                              CartRemoveEvent(product: data));
                                        },
                                        icon: const Icon(
                                          Icons.shopping_bag,
                                          color: Colors.black,
                                        ))
                                  ],
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
        });
  }
}
