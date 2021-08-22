import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_food_delivery_app/components/build_rating.dart';
import 'package:flutter_food_delivery_app/data/data.dart';
import 'package:flutter_food_delivery_app/models/food.dart';
import 'package:flutter_food_delivery_app/models/restaurant.dart';
import 'package:flutter_food_delivery_app/widgets/add_item.dart';

class ResturantScreen extends StatefulWidget {
  final Restaurant restaurant;
  final distance;

  const ResturantScreen(
      {Key? key, required this.restaurant, required this.distance})
      : super(key: key);

  @override
  _ResturantScreenState createState() =>
      _ResturantScreenState(restaurant: restaurant, distance: distance);
}

class _ResturantScreenState extends State<ResturantScreen> {
  final Restaurant restaurant;
  bool isFavourite = false;
  final distance;
  _ResturantScreenState({required this.restaurant, required this.distance});

  final _decorationShade = BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.black87.withOpacity(0.3),
            Colors.black54.withOpacity(0.3),
            Colors.black38.withOpacity(0.3),
          ],
          stops: [
            0.1,
            0.4,
            0.6,
            0.9
          ]));

  _swapFavourite() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  Widget _buildMenu(BuildContext context, Food menuItem) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 175.0,
            height: 175.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(menuItem.imageUrl), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15.0)),
          ),
          Container(
            width: 175.0,
            height: 175.0,
            decoration: _decorationShade,
          ),
          Positioned(
            bottom: 65.0,
            child: Column(
              children: [
                Text(
                  menuItem.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${menuItem.price}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: AddItem(
              marginRight: 0.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.restaurant.imageUrl,
                child: Image(
                  image: AssetImage(restaurant.imageUrl),
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: _decorationShade,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    IconButton(
                        onPressed: _swapFavourite,
                        icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: isFavourite
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          size: 30.0,
                        ))
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      this.restaurant.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$distance miles away',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 6.0,
                ),
                Rating(rating: restaurant.rating),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  restaurant.address,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundedButton(
                text: 'Reviews',
                onpressed: () {},
              ),
              RoundedButton(
                text: 'Contact',
                onpressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            'Menu',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 6.0,
          ),
          Expanded(
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(12.0),
              crossAxisCount: 2,
              children: List.generate(restaurant.menu.length, (index) {
                Food food = restaurant.menu[index];
                return _buildMenu(context, food);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final text;
  final VoidCallback onpressed;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18.0)),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 8.0),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
