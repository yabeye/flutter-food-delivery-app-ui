import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/data/data.dart';
import 'package:flutter_food_delivery_app/models/order.dart';
import 'package:flutter_food_delivery_app/screens/cart_summary.dart';
import 'package:flutter_food_delivery_app/widgets/cart_operation.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  _getTotalCost() {
    // To get the total cost we have to loop throw all orders
    // quantity multiply by each food price
    double total = 0.0;
    currentUser.orders
        .forEach((order) => total += order.quantity * order.food.price);

    return total.toStringAsFixed(2); // To round the price in cents(0.0)
  }

  Widget _buildCartItem(Order order) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      height: 130.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image(
                    image: AssetImage(order.food.imageUrl),
                    width: 130.0,
                    height: 130.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          //color: Colors.blue,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.food.name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        order.restaurant.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      // Dec or Inc Quantity //
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10.0),
                                child: Text(
                                  '\$${order.quantity * order.food.price}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CartOperation(
                        context: context,
                        order: order,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart(${currentUser.orders.length})'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < currentUser.orders.length) {
              Order order = currentUser.orders[index];
              return _buildCartItem(order);
            }
            return Column(
              children: [
                CartSummary(
                  title: 'Estimated Delivery Time :',
                  value:
                      '25 min', // this has to deal with the back end so i will leave it //
                  valueColor: Colors.black,
                ),
                CartSummary(
                  title: 'Total Cost :',
                  value: '\$${_getTotalCost()}',
                  valueColor: Colors.green,
                ),
                SizedBox(
                  height: 100.0,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Divider(
                color: Colors.black12,
                height: 1.0,
              ),
            );
          },
          itemCount: currentUser.orders.length + 1),
      bottomSheet: Container(
        // UI for the checkout logic //
        height: 80.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, -1),
                blurRadius: 6.0,
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
        child: Center(
          child: TextButton(
              onPressed: () {},
              child: Text(
                'Checkout',
                style: TextStyle(
                    letterSpacing: 2.0, color: Colors.white, fontSize: 24),
              )),
        ),
      ),
    );
  }
}
