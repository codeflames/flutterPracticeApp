import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreenItem extends StatelessWidget {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final Function removeHandler;

  const CartScreenItem({this.id, this.name, this.quantity, this.price, this.removeHandler});

  @override
  Widget build(BuildContext context) {
    //final cartData = Provider.of<CartProvider>(context, listen: false);
    final total = price * quantity;
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: FittedBox(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(total.toString()),
          )),
        ),
        title: Text(name, style: TextStyle(fontSize: 16)),
        subtitle: Text(
            price.toString() + '        X' + quantity.toString() + ' pieces'),
        trailing: Consumer<CartProvider>(
            builder: (ctx, cartt, child) => IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    //print(quantity);
                    if(quantity == 0){
                      return;
                    }else{
                      cartt.removeFromCart(id);
                    }

                  },
                )),
      ),
    );
  }
}
