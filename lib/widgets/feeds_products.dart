import 'package:badges/badges.dart';
import 'package:stack/model/productModel.dart';
import 'package:stack/screens/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/widgets/alerts/feeds_product_dialog.dart';

class FeedsProducts extends StatefulWidget {
  @override
  State<FeedsProducts> createState() => _FeedsProductsState();
}

class _FeedsProductsState extends State<FeedsProducts> {
  // FeedsProducts({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetails.routeName, arguments: product.id);
      },
      child: Stack(
        children: [
          Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.orange),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 130,
                        maxHeight: MediaQuery.of(context).size.height * 0.2,
                        minWidth: double.infinity,
                        maxWidth: double.infinity,
                      ),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "\$ ${product.price}",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity " + product.quantity.toString() + ' left',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              onPressed: () async {
                return await showDialog(
                  context: context,
                  builder: (ctx) => FeedProductDialog(
                    product: product,
                  ),
                );
              },
              icon: Icon(Icons.more_horiz),
            ),
          ),
          Badge(
            toAnimate: true,
            animationType: BadgeAnimationType.fade,
            animationDuration: Duration(milliseconds: 950),
            shape: BadgeShape.square,
            borderRadius: BorderRadius.circular(0),
            badgeContent: Text(
              "New",
              style: TextStyle(color: Colors.white),
            ),
            badgeColor: Colors.deepPurpleAccent,
          ),
        ],
      ),
    );
  }
}
