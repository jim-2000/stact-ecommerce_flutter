//
import 'package:flutter/cupertino.dart';

class WishListModel with ChangeNotifier {
  final String wishId;
  final String title;
  final String imageUrl;
  final double price;

  WishListModel({
    required this.wishId,
    required this.title,
    required this.imageUrl,
    required this.price,
  });
}
//


