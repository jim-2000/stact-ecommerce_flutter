import 'dart:ffi';

import 'package:provider/provider.dart';
import 'package:stack/navScreens/bottom_nav_Screen.dart';
import 'package:stack/provider/cartProvider.dart';
import 'package:stack/screens/homeScreen.dart';
import 'package:stack/widgets/alerts/global_Dialog.dart';
import 'package:stack/widgets/cart/emptyCart.dart';
import 'package:stack/widgets/cart/fullCartscreen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routesName = "/cart-screen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();
    return cartProvider.getcartList.isEmpty
        ? Scaffold(
            body: EmptyCard(
              onButtonTap: (() {
                Navigator.of(context)
                    .pushReplacementNamed(BottomNavScreen.routesName);
              }),
              imgss: "assets/images/emptycart.png",
              title: 'Your cart is Empty',
              subtitle:
                  "The use of typography is a principal design element in the latest trends",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Cart (${cartProvider.getcartList.length})"),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showSnackBar(
                      context,
                      "You want to Delete all Item from Cart",
                      "Delete All",
                      () => cartProvider.removeAll(),
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: cartProvider.getcartList.length,
              itemBuilder: (ctx, index) {
                final singleCartItem =
                    cartProvider.getcartList.values.toList()[index];
                final cID = cartProvider.getcartList.keys.toList()[index];

                return ChangeNotifierProvider.value(
                  value: singleCartItem,
                  child: FullCardScreen(
                    cartPId: cID,
                    // productImg: singleCartItem.imageUrl.toString(),
                    // productName: singleCartItem.title,
                    // productPrice: singleCartItem.price,
                    // quantity: singleCartItem.quantity.toDouble(),
                    // productShippingPrice: 30,
                    isWishlist: false,
                  ),
                );
              },
            ),
            bottomSheet: _bottomCheckoutSection(
              total: cartProvider.totalAmount,
            ),
          );
  }
}

class _bottomCheckoutSection extends StatelessWidget {
  double total;
  _bottomCheckoutSection({
    required this.total,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              "Total: \$ ${total.toStringAsFixed(2)}",
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 22),
            )),
            ElevatedButton(
                onPressed: () {}, child: Text("    C H E C K O U T    "))
          ],
        ),
      ),
    );
  }
}
