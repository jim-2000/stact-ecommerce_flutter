import 'package:stack/model/productModel.dart';
import 'package:stack/provider/cartProvider.dart';
import 'package:stack/provider/productNotifier.dart';
import 'package:stack/provider/wishListProvider.dart';
import 'package:stack/screens/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final porductAttibute = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishlistProvider>(context);
    final isWishList =
        wishListProvider.getWishlist.containsKey(porductAttibute.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: 250,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProductDetails.routeName,
                          arguments: porductAttibute.id);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        porductAttibute.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  child: CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        wishListProvider.addToWishList(
                            porductAttibute.id,
                            porductAttibute.title,
                            porductAttibute.imageUrl,
                            porductAttibute.price);
                      },
                      icon: Icon(
                        isWishList ? Icons.favorite : Icons.favorite_border,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "\$ ${porductAttibute.price}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                porductAttibute.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      porductAttibute.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap:
                        cartProvider.getcartList.containsKey(porductAttibute.id)
                            ? () {}
                            : () => cartProvider.addToCart(
                                porductAttibute.id,
                                porductAttibute.title,
                                porductAttibute.imageUrl,
                                porductAttibute.price),
                    child:
                        cartProvider.getcartList.containsKey(porductAttibute.id)
                            ? Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.teal,
                                ),
                              )
                            : Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
