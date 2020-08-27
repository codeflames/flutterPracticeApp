
import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier{

  final String name;
  final String id;
  final String description;
  final double price;
  final String image;

  Product(this.name,this.id, this.description, this.price, this.image);
}