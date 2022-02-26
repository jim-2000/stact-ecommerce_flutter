import 'package:flutter/cupertino.dart';
import 'package:stack/model/cartModel.dart';
import 'package:stack/model/wishlistModel.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishListModel> _wishList = {};
  Map<String, WishListModel> get getWishlist => _wishList;

  void addToWishList(String wId, String title, String imageUrl, double price) {
    //
    if (_wishList.containsKey(wId)) {
      _wishList.remove(wId);
    } else {
      _wishList.putIfAbsent(
        wId,
        () => WishListModel(
          wishId: DateTime.now().toIso8601String(),
          title: title,
          imageUrl: imageUrl,
          price: price,
        ),
      );
      print(" product added To wishlist  =======");
    }
    notifyListeners();
    //
  }

  void removeItem(String wId) {
    _wishList.remove(wId);
    notifyListeners();
  }

  void removeAll() {
    _wishList.clear();
    notifyListeners();
  }
}
