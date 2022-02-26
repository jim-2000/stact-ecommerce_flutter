import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/model/productModel.dart';
import 'package:stack/provider/cartProvider.dart';
import 'package:stack/provider/wishListProvider.dart';
import 'package:stack/screens/ProductDetails.dart';

class FeedProductDialog extends StatelessWidget {
  Product product;
  FeedProductDialog({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<WishlistProvider>(builder: (context, wp, _) {
              return CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: IconButton(
                  onPressed: () {
                    wp.addToWishList(product.id, product.title,
                        product.imageUrl, product.price);
                  },
                  icon: wp.getWishlist.containsKey(product.id)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                ),
              );
            }),
            Consumer<CartProvider>(builder: (context, cp, _) {
              return CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: IconButton(
                  onPressed: () {
                    cp.addToCart(product.id, product.title, product.imageUrl,
                        product.price);
                  },
                  icon: cp.getcartList.containsKey(product.id)
                      ? Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                ),
              );
            }),
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ProductDetails.routeName,
                      arguments: product.id);
                },
                icon: const Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
