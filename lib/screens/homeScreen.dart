import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stack/provider/cartProvider.dart';
import 'package:stack/provider/productNotifier.dart';
import 'package:stack/provider/wishListProvider.dart';
import 'package:stack/screens/cart_screen.dart';
import 'package:stack/screens/feedScreen.dart';
import 'package:stack/screens/innerscreens/brand_nav_rail.dart';
import 'package:stack/screens/userScreen.dart';
import 'package:stack/screens/wishList.dart';
import 'package:stack/widgets/home/backLayer.dart';
import 'package:stack/widgets/home/catagory.dart';
import 'package:stack/widgets/home/frontLayer.dart';
import 'package:stack/widgets/home/popularProducts.dart';
import 'package:stack/widgets/mycircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routesName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _carouselImg = [
      Image.asset("assets/images/carousel1.png"),
      Image.asset("assets/images/carousel2.jpeg"),
      Image.asset("assets/images/carousel3.jpeg"),
      Image.asset("assets/images/carousel4.png"),
    ];
    final List _swiperlImg = [
      "assets/images/addidas.jpeg",
      "assets/images/samsung.jpeg",
      "assets/images/nike.jpeg",
      "assets/images/h&m.jpeg",
      "assets/images/Huawei.jpeg",
      "assets/images/Dell.jpeg",
    ];
    List<Map<String, Object>> _catagories = [
      {
        'catName': 'Phones',
        'catImage': 'assets/images/CatPhones.png',
      },
      {
        'catName': 'Beauty',
        'catImage': 'assets/images/CatBeauty.jpeg',
      },
      {
        'catName': 'Furniture',
        'catImage': 'assets/images/CatFurniture.jpeg',
      },
      {
        'catName': 'Cloth',
        'catImage': 'assets/images/CatClothes.jpeg',
      },
      {
        'catName': 'Laptops',
        'catImage': 'assets/images/CatLaptops.png',
      },
      {
        'catName': 'Shoe',
        'catImage': 'assets/images/CatShoes.jpeg',
      },
      {
        'catName': 'Watch',
        'catImage': 'assets/images/CatWatches.jpeg',
      },
    ];

    final productData = Provider.of<ProductProvider>(context);
    final popularProducts = productData.getPopular;
    return Scaffold(
      body: BackdropScaffold(
        backLayerBackgroundColor: Colors.transparent,
        headerHeight: MediaQuery.of(context).size.height * 0.4,
        appBar: BackdropAppBar(
          title: Text("E-com"),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          actions: <Widget>[
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
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/64397792?s=400&u=b893043c1c3b0a6ef368d9c9e4ee71dda86159c6&v=4'),
                ),
              ),
            )
          ],
        ),
        backLayer: BackLayer(),
        frontLayer: ListView(
          children: [
            _caraosel(carouselImg: _carouselImg),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Catagory",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _catagories.length,
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      HomeCatagory(
                        catName: _catagories[i]['catName'].toString(),
                        catimg: _catagories[i]['catImage'].toString(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Brands",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        BrandNavRailScreen.routeName,
                        arguments: 4,
                      );
                    },
                    child: Text("View all"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            _swiper(swiperlImg: _swiperlImg),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Products",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //
                      Navigator.of(context).pushNamed(FeedsScreen.routesName,
                          arguments: 'popular');
                    },
                    child: Text("View all"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: ListView.builder(
                itemCount: popularProducts.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      print(i);
                    },
                    child: ChangeNotifierProvider.value(
                      value: popularProducts[i],
                      child: PopularProducts(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _caraosel extends StatelessWidget {
  const _caraosel({
    Key? key,
    required List<Widget> carouselImg,
  })  : _carouselImg = carouselImg,
        super(key: key);

  final List<Widget> _carouselImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Carousel(
        images: _carouselImg,
        animationDuration: Duration(seconds: 3),
        animationCurve: Curves.fastOutSlowIn,
        dotSize: 2,
        boxFit: BoxFit.cover,
        autoplay: true,
      ),
    );
  }
}

class _swiper extends StatelessWidget {
  const _swiper({
    Key? key,
    required List swiperlImg,
  })  : _swiperlImg = swiperlImg,
        super(key: key);

  final List _swiperlImg;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Swiper(
        onTap: (int i) {
          Navigator.of(context).pushNamed(
            BrandNavRailScreen.routeName,
            arguments: i,
          );
        },
        viewportFraction: 0.9,
        autoplay: true,
        scale: 0.9,
        loop: true,
        curve: Curves.easeInOutBack,
        itemBuilder: (ctx, i) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                _swiperlImg[i],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: _swiperlImg.length,
      ),
    );
  }
}
