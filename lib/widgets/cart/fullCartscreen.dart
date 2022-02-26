// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/model/cartModel.dart';
import 'package:stack/model/productModel.dart';
import 'package:stack/provider/cartProvider.dart';
import 'package:stack/screens/ProductDetails.dart';

class FullCardScreen extends StatelessWidget {
  // String productImg;
  // String productName;
  // String? id;
  String cartPId;
  // String? description;
  // double productPrice;
  // double quantity;
  // double productShippingPrice;
  Product? product;
  bool isWishlist;
  FullCardScreen({
    Key? key,
    // this.id,
    // this.product,
    // required this.productImg,
    // required this.productName,
    // required this.productPrice,
    // required this.quantity,
    // required this.productShippingPrice,
    required this.isWishlist,
    required this.cartPId,
    // this.description,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartAttribute = Provider.of<Cart>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetails.routeName, arguments: cartPId);
      },
      child: Card(
        elevation: 26,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Row(
              children: [
                Container(
                  width: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        cartAttribute.imageUrl.toString(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              cartAttribute.title.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () => cartProvider.removeItem(cartPId),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Price :",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                          Flexible(
                            child: Text(
                              "\$ ${cartAttribute.price.toString()}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      // if (isWishlist)
                      //   Column(
                      //     crossAxisAlignment: CrossAxisAlignment.stretch,
                      //     children: [
                      //       Container(
                      //         child: Text("Description :"),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.zero,
                      //         padding: EdgeInsets.zero,
                      //         child: Text(
                      //            description ?? "",
                      //           maxLines: 4,
                      //           overflow: TextOverflow.ellipsis,
                      //           style: TextStyle(fontSize: 18),
                      //         ),
                      //       ),
                      //     ],
                      //   )
                      if (isWishlist)
                        SizedBox()
                      else
                        Row(
                          children: [
                            const Text(
                              "Subtotal :",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16),
                            ),
                            Flexible(
                              child: Text(
                                "\$ ${(cartAttribute.price * cartAttribute.quantity).toStringAsFixed(2)}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      isWishlist
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: cartAttribute.quantity < 2
                                        ? () {}
                                        : () => cartProvider.decriment(cartPId),
                                    icon: Icon(Icons.remove)),
                                Text(
                                  "${cartAttribute.quantity}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                    onPressed: () => cartProvider.addToCart(
                                        cartPId,
                                        cartAttribute.title,
                                        cartAttribute.imageUrl,
                                        cartAttribute.price),
                                    icon: Icon(Icons.add)),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
