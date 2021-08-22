import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/data/data.dart';
import 'package:flutter_food_delivery_app/models/order.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
            Order order = currentUser.orders[index];
            return _buildCartItem(order);
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
          itemCount: currentUser.orders.length),
    );
  }
}

class CartOperation extends StatelessWidget {
  const CartOperation({
    Key? key,
    required this.context,
    required this.order,
  }) : super(key: key);

  final BuildContext context;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          border: Border.all(
            width: 1.5,
            color: Theme.of(context).primaryColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OperationButton(
            context: context,
            iconData: Icons.remove,
            onPressed: () {},
          ),
          Text(
            order.quantity.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          OperationButton(
            context: context,
            iconData: Icons.add,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class OperationButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  const OperationButton({
    Key? key,
    required this.context,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Icon(
          iconData,
          color: Theme.of(context).primaryColor,
        ));
  }
}
