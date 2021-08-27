import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/data/data.dart';
import 'package:flutter_food_delivery_app/screens/cart_screen.dart';
import 'package:flutter_food_delivery_app/widgets/nearby_resturants.dart';
import 'package:flutter_food_delivery_app/widgets/recent_orders.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    OutlineInputBorder _focus_and_enabled_border_style = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(width: 0.8, color: Theme.of(context).primaryColor),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            /** ToDo on clicking this button
             * 1. get the current user if he/she already signup and change the widget to profile image
             * 2. or navidate the user to sign up page
             */
            onPressed: () => print('Current user is ${currentUser.name}'),
            icon: Icon(
              Icons.account_circle,
              size: 30,
            )),
        title: Text(
          // This is just my sax off :)
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
                    FontAwesomeIcons.cartPlus,
                    size: 30,
                    color: Colors.white,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      //margin: EdgeInsets.all(3.0),
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
              // This is Search Food or Resturants Widget.
              // UI is not completed, b/c when scroling back it has to appear
              // while you are mid way there.

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
                focusedBorder: _focus_and_enabled_border_style,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: _focus_and_enabled_border_style,
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
