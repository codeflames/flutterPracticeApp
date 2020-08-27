import 'package:flutter/material.dart';
import 'package:practice_app/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/product_home_screen_item.dart';
import '../screens/cart_screen.dart';

class ProductHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products = productData.item;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName)),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
          itemBuilder: (ctx, i) =>
          ChangeNotifierProvider.value(value: products[i],
            child: ProductHomeScreenItem(),
          )

          ),
      );
  }
}
