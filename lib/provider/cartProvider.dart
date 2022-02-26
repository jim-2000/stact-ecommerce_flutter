import 'package:flutter/cupertino.dart';
import 'package:stack/model/cartModel.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartList = {};
  Map<String, Cart> get getcartList => _cartList;

  double get totalAmount {
    double total = 0.0;
    _cartList.forEach((key, value) {
      total += value.quantity * value.price;
    });

    return total;
  }

  void addToCart(String pId, String title, String imageUrl, double price) {
    //
    if (_cartList.containsKey(pId)) {
      _cartList.update(
        pId,
        (value) => Cart(
          cartId: value.cartId,
          title: value.title,
          imageUrl: value.imageUrl,
          price: value.price,
          quantity: value.quantity + 1,
        ),
      );
      print("same product added multiple time");
    } else {
      _cartList.putIfAbsent(
        pId,
        () => Cart(
          cartId: DateTime.now().toIso8601String(),
          title: title,
          imageUrl: imageUrl,
          price: price,
          quantity: 1,
        ),
      );
      print(" product added  =======");
    }
    notifyListeners();
    //
  }

  void decriment(String pId) {
    if (_cartList.containsKey(pId)) {
      _cartList.update(
        pId,
        (value) => Cart(
          cartId: value.cartId,
          title: value.title,
          imageUrl: value.imageUrl,
          price: value.price,
          quantity: value.quantity - 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String pId) {
    _cartList.remove(pId);
    notifyListeners();
  }

  void removeAll() {
    _cartList.clear();
    notifyListeners();
  }
}
