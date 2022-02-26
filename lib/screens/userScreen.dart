import 'dart:io';

import 'package:badges/badges.dart';
import 'package:stack/controller/Themecontroller.dart';
import 'package:stack/provider/cartProvider.dart';
import 'package:stack/provider/wishListProvider.dart';
import 'package:stack/screens/cart_screen.dart';
import 'package:stack/screens/wishList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  static const routesName = "/user-screen";
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  double top = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.deepPurple,
                pinned: true,
                stretch: true,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/64397792?s=400&u=b893043c1c3b0a6ef368d9c9e4ee71dda86159c6&v=4 "),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text("Hossain Al Jim"),
                    ],
                  ),
                  background: Image.network(
                    "https://images.pexels.com/photos/296282/pexels-photo-296282.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      _usertiletext(text: "User Bag"),
                      SizedBox(
                        height: 10,
                      ),
                      Consumer<WishlistProvider>(
                        builder: (context, wp, _) {
                          return Badge(
                            toAnimate: true,
                            animationType: BadgeAnimationType.slide,
                            elevation: 6,
                            badgeContent:
                                Text(wp.getWishlist.length.toString()),
                            position: BadgePosition.topStart(top: 5, start: 5),
                            child: _userTilewidgets(
                              text: "Wish list",
                              licon: Icons.favorite,
                              liconColor: Colors.deepOrange,
                              ticon: Icons.arrow_forward_ios,
                              ticonColor: Colors.grey,
                              ontapped: () {
                                Navigator.of(context)
                                    .pushNamed(WishList.routeName);
                              },
                            ),
                          );
                        },
                      ),
                      Consumer<CartProvider>(builder: (context, cp, _) {
                        return Badge(
                          toAnimate: true,
                          animationType: BadgeAnimationType.slide,
                          elevation: 6,
                          badgeContent: Text(cp.getcartList.length.toString()),
                          position: BadgePosition.topStart(top: 5, start: 5),
                          child: _userTilewidgets(
                            text: "Card",
                            licon: Icons.shopping_cart_sharp,
                            liconColor: Colors.grey,
                            ticon: Icons.arrow_forward_ios,
                            ticonColor: Colors.grey,
                            ontapped: () {
                              Navigator.of(context)
                                  .pushNamed(CartScreen.routesName);
                            },
                          ),
                        );
                      }),
                      SizedBox(
                        height: 15,
                      ),
                      _usertiletext(
                        text: "User settings",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //
                      Card(
                        child: Consumer<ThemeNotifier>(
                            builder: (context, notifier, _) {
                          return SwitchListTile.adaptive(
                            secondary: notifier.isDark
                                ? Icon(
                                    Icons.dark_mode,
                                    color: Colors.amber.shade700,
                                  )
                                : Icon(
                                    Icons.light_mode,
                                    color: Colors.amber.shade700,
                                  ),
                            title: Text(
                              notifier.isDark ? "Dark Mode" : "Light Mode",
                            ),
                            value: notifier.isDark,
                            onChanged: (value) {
                              notifier.toogleTheme(value);
                              print(value);
                            },
                          );
                        }),
                      ),
                      _userTilewidgets(
                        text: "Log out",
                        // subtilte: "+880 1843687579",
                        licon: Icons.power_settings_new,
                        liconColor: Colors.redAccent,
                        ontapped: () {
                          Navigator.of(context).canPop()
                              ? Navigator.of(context).pop()
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _usertiletext(
                        text: "User Information",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //
                      _userTilewidgets(
                        text: "Phone",
                        subtilte: "+880 1843687579",
                        licon: Icons.phone,
                        liconColor: Colors.deepPurple,
                        ontapped: () {
                          print("Phooooonee");
                        },
                      ),
                      _userTilewidgets(
                        text: "Email",
                        subtilte: "Email",
                        licon: Icons.email,
                        liconColor: Colors.deepPurple,
                        ontapped: () {},
                      ),

                      _userTilewidgets(
                        text: "Join Date",
                        subtilte: "Email",
                        licon: Icons.watch_later,
                        liconColor: Colors.deepPurple,
                        ontapped: () {},
                      ),
                      _userTilewidgets(
                        text: "Address",
                        subtilte: "Dhaka,Bangladesh",
                        licon: Icons.local_shipping,
                        ontapped: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildFav()
        ],
      ),
    );
  }

  Widget _buildFav() {
    double defaultMargin = Platform.isIOS ? 270 : 250;
    double scrollStart = 230;
    double scrollEnd = scrollStart / 2;

    double top = defaultMargin;
    double scale = 1.0;

    if (_scrollController.hasClients) {
      double offSet = _scrollController.offset;
      top -= offSet;

      if (offSet < defaultMargin - scrollStart) {
        scale = 1;
      } else if (offSet < defaultMargin - scrollEnd) {
        scale = (defaultMargin - scrollEnd - offSet) / scrollEnd;
      } else {
        scale = 0;
      }
    }

    return Positioned(
      top: top,
      right: 20,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          heroTag: null,
          child: const Icon(Icons.camera),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _usertiletext extends StatelessWidget {
  String text;
  _usertiletext({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w700,
        // decoration: TextDecoration.underline,
        letterSpacing: 1.3,
      ),
      softWrap: true,
    );
  }
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
class _userTilewidgets extends StatelessWidget {
  final String text;
  final String? subtilte;
  final IconData? ticon;
  final Color? ticonColor;
  final IconData? licon;
  final Color? liconColor;
  final VoidCallback? ontapped;
  final VoidCallback? ticonontapped;
  const _userTilewidgets({
    Key? key,
    required this.text,
    this.subtilte,
    this.ticon,
    this.licon,
    this.liconColor,
    this.ticonColor,
    this.ontapped,
    this.ticonontapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapped,
      child: Card(
        elevation: 6,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          leading: Icon(
            licon,
            color: liconColor == null ? Colors.deepPurple : liconColor,
          ),
          title: Text(text),
          subtitle: subtilte != null ? Text(subtilte!) : null,
          trailing: IconButton(
            onPressed: ticonontapped,
            icon: Icon(
              ticon,
              color: ticonColor,
            ),
          ),
        ),
      ),
    );
  }
}
