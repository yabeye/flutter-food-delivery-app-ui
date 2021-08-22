import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final rating;
  const Rating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < rating; i++)
          Icon(
            Icons.star,
            size: 20,
            color: Colors.redAccent,
          )
      ],
    );
  }
}
