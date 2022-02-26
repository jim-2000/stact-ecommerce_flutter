import 'package:provider/provider.dart';
import 'package:stack/navScreens/bottom_nav_Screen.dart';
import 'package:stack/provider/wishListProvider.dart';
import 'package:stack/screens/homeScreen.dart';
import 'package:stack/widgets/alerts/global_Dialog.dart';
import 'package:stack/widgets/cart/emptyCart.dart';
import 'package:stack/widgets/cart/fullCartscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stack/widgets/wishlist/wish.dart';

class WishList extends StatelessWidget {
  static const routeName = '/wishlist';
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistAttibutes = Provider.of<WishlistProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();
    return wishlistAttibutes.getWishlist.isEmpty
        ? Scaffold(
            body: EmptyCard(
              imgss: "assets/images/empty-wishlist.png",
              title: "Your wishlist is now Empty",
              subtitle: "Looks Like you dont't add anything yet",
              onButtonTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(BottomNavScreen.routesName);
              },
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("WISHLIST"),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showSnackBar(
                      context,
                      "You want to Delete all Item from wishlist",
                      "Delete All",
                      () => wishlistAttibutes.removeAll(),
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: wishlistAttibutes.getWishlist.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: wishlistAttibutes.getWishlist.values.toList()[index],
                  child: WishItem(
                    wId: wishlistAttibutes.getWishlist.keys.toList()[index],
                  ),
                );
              },
            ),
          );
  }
}
