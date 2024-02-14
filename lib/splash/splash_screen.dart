// ignore_for_file: await_only_futures

import 'package:bloc_project/home/bloc/home_bloc.dart';
import 'package:bloc_project/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HomeBloc homebloc = HomeBloc();
  @override
  void initState() {
    splashtime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listener: (context, state) {
        if (state is NavigateToHome) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const Home()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            color: Colors.white,
            child: Center(
              child: LottieBuilder.asset(
                  'assets/animation/Animation - 1707742105361.json'),
            ),
          ),
        );
      },
    );
  }

  splashtime() async {
    await Future.delayed(const Duration(seconds: 3));
    homebloc.add(InitialfetchEvent());
  }
}
