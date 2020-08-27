import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart_screen_item.dart';
import './authentication_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartData = cart.cartItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.remove_shopping_cart),
            onPressed: () => cart.clearCart(),
          ),
          SizedBox(width: 9,)
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: cartData.length,
                itemBuilder: (ctx, i) => CartScreenItem(
                      name: cartData.values.toList()[i].name,
                      id: cartData.values.toList()[i].id,
                      price: cartData.values.toList()[i].price,
                      quantity: cartData.values.toList()[i].quantity,
//                 removeHandler: () => cart.removeFromCart(cartData.values.toList()[i].id),
                    )),
          ),
          Container(
            height: 150,
            color: Colors.lightBlueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Divider(
                  color: Colors.black,
                  thickness: 5,
                  height: 5,
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'TOTAL: ' + cart.totalAmount.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      RaisedButton(
                        child: Text('ORDER NOW'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AuthenticationScreen.routeName);
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
