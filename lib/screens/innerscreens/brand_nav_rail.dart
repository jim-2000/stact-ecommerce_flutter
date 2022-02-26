import 'package:stack/provider/productNotifier.dart';
import 'package:stack/widgets/home/brandNavrail.dart';
import 'package:stack/widgets/mycircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandNavRailScreen extends StatefulWidget {
  static const routeName = '/brands-nav-rail';
  const BrandNavRailScreen({Key? key}) : super(key: key);

  @override
  State<BrandNavRailScreen> createState() => _BrandNavRailScreenState();
}

class _BrandNavRailScreenState extends State<BrandNavRailScreen> {
  late String routeArgs;
  late String brands;
  int _selectedIndex = 0;
//

  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
    _selectedIndex = int.parse(routeArgs.substring(0, 1));
    if (_selectedIndex == 0) {
      setState(() {
        brands = "Phones";
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brands = "Laptops";
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brands = "Furniture";
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brands = "Watches";
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brands = "All";
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(
            builder: (context, cons) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: cons.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      elevation: 16,
                      leading: Mycircle(
                        img:
                            'https://avatars.githubusercontent.com/u/64397792?s=400&u=b893043c1c3b0a6ef368d9c9e4ee71dda86159c6&v=4',
                        isAsset: false,
                      ),
                      selectedLabelTextStyle: TextStyle(
                        fontSize: 25,
                        letterSpacing: 2.5,
                      ),
                      labelType: NavigationRailLabelType.all,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() {
                          _selectedIndex = index;
                          if (_selectedIndex == 0) {
                            setState(() {
                              brands = "Phones";
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              brands = "Laptops";
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              brands = "Furniture";
                            });
                          }

                          if (_selectedIndex == 3) {
                            setState(() {
                              brands = "Watches";
                            });
                          }

                          if (_selectedIndex == 4) {
                            setState(() {
                              brands = "All";
                            });
                          }
                        });
                      },
                      destinations: [
                        _navRailRotatedBox('Phones'),
                        _navRailRotatedBox('Laptops'),
                        _navRailRotatedBox('Furniture'),
                        _navRailRotatedBox('Watches'),
                        _navRailRotatedBox('All'),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          ContentSpace(
            brand: brands,
          ),
        ],
      ),
    );
  }

  NavigationRailDestination _navRailRotatedBox(String text) {
    return NavigationRailDestination(
      icon: Icon(null),
      label: RotatedBox(
        quarterTurns: 3,
        child: Text(text.toUpperCase()),
      ),
    );
  }
}

class ContentSpace extends StatelessWidget {
  String brand;
  ContentSpace({Key? key, required this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final productBrand = productData.getByBrand(brand);
//
    if (brand == 'All') {
      for (int i = 0; i < productData.getPopular.length; i++) {
        productBrand.add(productData.product()[i]);
      }
    }
    //
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: ListView.builder(
              itemCount: productBrand.length,
              itemBuilder: (context, i) {
                return ChangeNotifierProvider.value(
                  value: productBrand[i],
                  child: BrandNavRailItems(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
