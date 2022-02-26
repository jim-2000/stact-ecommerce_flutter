import 'package:badges/badges.dart';
import 'package:stack/model/productModel.dart';
import 'package:stack/provider/cartProvider.dart';
import 'package:stack/provider/productNotifier.dart';
import 'package:stack/provider/wishListProvider.dart';
import 'package:stack/screens/cart_screen.dart';
import 'package:stack/screens/wishList.dart';
import 'package:stack/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatelessWidget {
  static const routesName = "/feed-screen";
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product_controller = Provider.of<ProductProvider>(context);
    List<Product> productsList = product_controller.product();
    final popular = ModalRoute.of(context)?.settings.arguments.toString();
    if (popular == 'popular') {
      productsList = product_controller.getPopular;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.list)),
        title: Text("Feed Screen"),
        actions: [
          Consumer<CartProvider>(builder: (context, cp, _) {
            return Badge(
              toAnimate: true,
              animationType: BadgeAnimationType.slide,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(cp.getcartList.length.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routesName);
                },
                icon: Icon(Icons.shopping_cart),
              ),
            );
          }),
          Consumer<WishlistProvider>(builder: (context, wp, _) {
            return Badge(
              toAnimate: true,
              animationType: BadgeAnimationType.slide,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(wp.getWishlist.length.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(WishList.routeName);
                },
                icon: Icon(Icons.favorite),
              ),
            );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: productsList.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, i) {
            final product = productsList[i];
            return ChangeNotifierProvider.value(
              value: product,
              child: FeedsProducts(
                  // product: product,
                  ),
            );
          },
        ),
      ),
    );
  }
}
/*
GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, i) {
          return FeedsProducts();
        },
      ),

*/