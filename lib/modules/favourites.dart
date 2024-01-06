import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              color: Colors.pinkAccent,
              child: Column(
                children: [
                  Text(favList[index].name),
                  Text(favList[index].category),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10,),
          itemCount: favList.length),
    );
  }
}
