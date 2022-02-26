//
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier {
  final String cartId;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  Cart({
    required this.cartId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}
//


