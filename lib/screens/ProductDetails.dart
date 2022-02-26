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

class ProductDetails extends StatefulWidget {
  static const routeName = '/product-Details';
  // Product product;
  ProductDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
  GlobalKey _globalKey = GlobalKey();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final product_controller = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    List<Product> productsList = product_controller.product();
    final latestProduct = productsList.sublist(productsList.length - 10);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = product_controller.getById(productId);
    final wishlistAttibutes = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          Consumer<WishlistProvider>(builder: (context, wp, _) {
            return Badge(
              toAnimate: true,
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                wp.getWishlist.length.toString(),
              ),
              position: BadgePosition.topEnd(top: 5, end: 7),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(WishList.routeName);
                },
                icon: const Icon(Icons.favorite),
              ),
            );
          }),
          Consumer<CartProvider>(builder: (context, cp, _) {
            return Badge(
              toAnimate: true,
              animationType: BadgeAnimationType.slide,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                cp.getcartList.length.toString(),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routesName);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            );
          }),
        ],
      ),
      body: Stack(
        children: [
          Container(
            foregroundDecoration: const BoxDecoration(
              color: Colors.black12,
            ),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
              product.imageUrl.toString(),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 300,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            wishlistAttibutes.addToWishList(productId,
                                product.title, product.imageUrl, product.price);
                          },
                          icon: Icon(
                            wishlistAttibutes.getWishlist.containsKey(productId)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.share)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                "${product.title}",
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "\$ ${product.price}",
                              style: const TextStyle(
                                fontSize: 21,
                                color: Colors.purple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      _detailsProducts(
                        title: "Brand",
                        titleDetails: product.productBrandName,
                      ),
                      _detailsProducts(
                        title: "Quantity",
                        titleDetails: "${product.quantity}  left",
                      ),
                      _detailsProducts(
                        title: "Catagory",
                        titleDetails: "${product.productCatagoryName}",
                      ),
                      _detailsProducts(
                        title: "Popularity",
                        titleDetails: product.isPopular ? "Popular" : "Barely",
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      Container(
                        color: Colors.black54,
                        width: double.infinity,
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "No Reviews yet",
                                style: TextStyle(
                                  fontSize: 21,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Be The first To Review!",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    "Suggested Products",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: double.infinity,
                //   height: 600,
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     itemCount: latestProduct.length < 7
                //         ? (latestProduct.length - 5)
                //         : 7,
                //     itemBuilder: (context, index) {
                //       final product = latestProduct[index];
                //       return Expanded(
                //         child: ChangeNotifierProvider.value(
                //           value: product,
                //           child: FeedsProducts(
                //               // product: product,
                //               ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _bottomSheet(
        cartProvider: cartProvider,
        product: product,
        productId: productId,
        wishlistProvider: wishlistAttibutes,
      ),
    );
  }
}

class _detailsProducts extends StatelessWidget {
  String title;
  String titleDetails;
  _detailsProducts({
    Key? key,
    required this.title,
    required this.titleDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: ListTile(
          leading: Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
          title: Text(
            titleDetails,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _bottomSheet extends StatelessWidget {
  String productId;
  CartProvider cartProvider;
  Product product;
  WishlistProvider wishlistProvider;
  _bottomSheet({
    required this.productId,
    required this.cartProvider,
    required this.product,
    required this.wishlistProvider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWished = wishlistProvider.getWishlist.containsKey(productId);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.pinkAccent,
            height: 50,
            child: Center(
              child: TextButton(
                onPressed: cartProvider.getcartList.containsKey(productId)
                    ? () {}
                    : () => cartProvider.addToCart(productId, product.title,
                        product.imageUrl, product.price),
                child: Text(
                  cartProvider.getcartList.containsKey(productId)
                      ? "IN CART"
                      : "ADD TO CART",
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.white,
            height: 50,
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "BUY NOW",
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            height: 50,
            child: Center(
              child: IconButton(
                onPressed: () {
                  //
                  wishlistProvider.addToWishList(productId, product.title,
                      product.imageUrl, product.price);
                },
                icon: Icon(
                  isWished ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
