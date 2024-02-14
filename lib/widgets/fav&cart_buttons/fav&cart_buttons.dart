// ignore_for_file: file_names
import 'package:bloc_project/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

inkwellbutton({homebloc, size}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            homebloc.add(NavigateToFav());
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
            homebloc.add(NavigateToCart());
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
                  child: Text('Cart', style: TextStyle(fontFamily: 'Ashi')),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
