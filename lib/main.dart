import 'package:bloc_project/Favourite/bloc/favourite_bloc.dart';
import 'package:bloc_project/cart/bloc/cart_bloc.dart';
import 'package:bloc_project/home/bloc/home_bloc.dart';
import 'package:bloc_project/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(
          create: (context) => FavouriteBloc(),
        ),
        BlocProvider(create: (context) => CartBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: const SplashScreen()),
    );
  }
}
