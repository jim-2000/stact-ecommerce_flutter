import 'package:stack/model/productModel.dart';
import 'package:stack/screens/ProductDetails.dart';
import 'package:stack/widgets/home/popularProducts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandNavRailItems extends StatelessWidget {
  BrandNavRailItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productAttribute = Provider.of<Product>(context, listen: false);
    return InkWell(
      onTap: () {
        //
        Navigator.of(context).pushNamed(ProductDetails.routeName,
            arguments: productAttribute.id);
      },
      // child: PopularProducts(
      //   name: "What is your name",
      //   imgs:
      //       'https://avatars.githubusercontent.com/u/64397792?s=400&u=b893043c1c3b0a6ef368d9c9e4ee71dda86159c6&v=4',
      // ),
      child: Padding(
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
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        productAttribute.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 10,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.pinkAccent,
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
                          "\$ ${productAttribute.price}",
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
                  productAttribute.title,
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
                        'namesfadfsdfalsajfljdlkjdslfkjafds',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
