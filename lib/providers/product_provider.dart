import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {

  List<Product> _items = [
    Product(
        "Pixel", 'a', "Pixel is the most featureful phone ever", 800, "pixel.png"),
    Product("Laptop", 'b', "Laptop is most productive development tool", 2000,
        "laptop.png"),
    Product("Tablet",'c', "Tablet is the most useful device ever for meeting", 1500,
        "tablet.png"),
    Product(
        "Pendrive", 'd',  "iPhone is the stylist phone ever", 100, "pendrive.png"),
    Product(
        "Floppy Drive", 'e',"iPhone is the stylist phone ever", 20, "floppy.png"),
    Product("iPhone", 'f', "iPhone is the stylist phone ever", 1000, "iphone.png"),
  ];



  List<Product> get item{
    return [..._items];
  }
}
