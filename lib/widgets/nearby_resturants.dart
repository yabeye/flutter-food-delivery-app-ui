import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/components/build_rating.dart';
import 'package:flutter_food_delivery_app/data/data.dart';
import 'package:flutter_food_delivery_app/models/restaurant.dart';
import 'package:flutter_food_delivery_app/screens/resturant_screen.dart';

class NearbyResturant extends StatelessWidget {
  NearbyResturant({Key? key}) : super(key: key);

  final String getGeographicDistanceDifference =
      Random().nextDouble().toStringAsFixed(1).toString();

  Widget _buildNearByResturants(BuildContext context) {
    List<Widget> nearbyResturatsList = [];
    restaurants.forEach((Restaurant restaurant) {
      nearbyResturatsList.add(GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ResturantScreen(
                      restaurant: restaurant,
                      distance: getGeographicDistanceDifference,
                    ))),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Hero(
                  tag: restaurant.imageUrl,
                  child: Image(
                    image: AssetImage(restaurant.imageUrl),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Rating(rating: restaurant.rating),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        restaurant.address,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        '$getGeographicDistanceDifference miles away.',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    });

    return Column(
      children: nearbyResturatsList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Nearby Resturants',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: 1.2),
          ),
        ),
        _buildNearByResturants(context)
      ],
    );
  }
}
