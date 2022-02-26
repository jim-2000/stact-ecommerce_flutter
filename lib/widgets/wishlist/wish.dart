import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/model/productModel.dart';
import 'package:stack/model/wishlistModel.dart';
import 'package:stack/provider/wishListProvider.dart';
import 'package:stack/screens/ProductDetails.dart';

class WishItem extends StatelessWidget {
  String wId;

  WishItem({Key? key, required this.wId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishListAttributes = Provider.of<WishListModel>(context);
    return InkWell(
      onTap: () {
        // Navigator.of(context)
        //     .pushNamed(ProductDetails.routeName, arguments: cartPId);
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
                        wishListAttributes.imageUrl.toString(),
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
                              wishListAttributes.title.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () => wishlistProvider.removeItem(wId),
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
                              "\$ ${wishListAttributes.price.toString()}",
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
                              "\$ ${(wishListAttributes.price).toStringAsFixed(2)}",
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
