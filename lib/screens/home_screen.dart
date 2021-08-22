import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/data/data.dart';
import 'package:flutter_food_delivery_app/screens/cart_screen.dart';
import 'package:flutter_food_delivery_app/widgets/nearby_resturants.dart';
import 'package:flutter_food_delivery_app/widgets/recent_orders.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => print('Current user is ${currentUser.name}'),
            icon: Icon(
              Icons.account_circle,
              size: 30,
            )),
        title: Text(
          "Yabe Delivery",
          style: TextStyle(
              fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartScreen())),
              child: Stack(
                children: [
                  Icon(
                    Icons.badge_sharp,
                    size: 35,
                    color: Colors.white,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 15,
                      margin: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        ' ${currentUser.orders.length}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Search Food or Resturants',
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: Theme.of(context).primaryColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                      width: 0.8, color: Theme.of(context).primaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                      width: 0.8, color: Theme.of(context).primaryColor),
                ),
                suffixIcon: Icon(
                  Icons.clear,
                  color: Colors.black38,
                  //size: 20.0,
                ),
              ),
            ),
          ),
          RecentOrders(),
          // Near by resturants //
          NearbyResturant(),
        ],
      ),
    );
  }
}
