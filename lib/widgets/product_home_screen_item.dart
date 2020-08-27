
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/models/product_model.dart';
import 'package:practice_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';

class ProductHomeScreenItem extends StatelessWidget {
//final String image;
//final String name;
//final String description;
//
//  ProductHomeScreenItem({this.name, this.image, this.description});

void productDetailHandler(ctx, String id){
  Navigator.of(ctx).pushNamed(ProductDetailScreen.routeName, arguments: id);
}

  @override
  Widget build(BuildContext context) {
  final cart = Provider.of<CartProvider>(context, listen: false);
    final product = Provider.of<Product>(context);
    return Container(
      height: 100,
      child: ListTile(
        leading: GestureDetector(
          onTap: () => productDetailHandler(context,product.id),
            child: Image.asset('assets/appimages/'+ product.image, height: 100, width: 100, fit: BoxFit.contain,)),
        title: Text(product.name),
        subtitle: Text(product.price.toString()),
        trailing: IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.lightBlue,), onPressed: () =>cart.addToCart(product.id, product.name, product.price),)
      ),
    );
  }
}
