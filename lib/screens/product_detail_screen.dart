import 'package:flutter/material.dart';
import 'package:practice_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetail';
  @override
  Widget build(BuildContext context) {
    final productName = ModalRoute.of(context).settings.arguments as String;
    final productDetail = Provider.of<ProductProvider>(context).item.firstWhere((element) => productName == element.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(productDetail.name),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                height:250,
                child: Image.asset('assets/appimages/' + productDetail.image, fit: BoxFit.cover,)),
            SizedBox(
              height: 25,
            ),
            Text(productDetail.price.toString()),
            SizedBox(
              height: 25,
            ),
            Text(productDetail.description),
          ],
        ),
      ),
    );
  }
}
