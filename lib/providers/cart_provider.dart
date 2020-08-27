import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.quantity});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  void addToCart(
    String id,
    String name,
    double price,
  ) {
    if (_cartItems.containsKey(id)) {
      _cartItems.update(
          id,
          (existingValue) => CartItem(
              id: existingValue.id,
              name: existingValue.name,
              price: existingValue.price,
              quantity: existingValue.quantity + 1)
      );
    } else {
      _cartItems.putIfAbsent(
          id,
          () => CartItem(
              id: id,
              name: name,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    if (!_cartItems.containsKey(id)){
        return;
      }
      else if(_cartItems.containsKey(id)){
        print(_cartItems[id].name);
        if(_cartItems[id].quantity > 1){
          _cartItems.update(
              id,
                  (existingValue) => CartItem(
                  id: existingValue.id,
                  name: existingValue.name,
                  price: existingValue.price,
                  quantity: existingValue.quantity - 1));
        }
        else{
          _cartItems.remove(id);
        }
      }
    notifyListeners();


      }
  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }

  double get totalAmount{
    var total = 0.0;
    _cartItems.forEach((key, cartCalculator) {
      total += cartCalculator.price * cartCalculator.quantity;
    });
    return total;
  }
}
