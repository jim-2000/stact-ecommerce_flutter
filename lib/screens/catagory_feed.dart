import 'package:stack/model/productModel.dart';
import 'package:stack/provider/productNotifier.dart';
import 'package:stack/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Catagory_feed extends StatelessWidget {
  static final routeName = 'catagory-feeds';
  const Catagory_feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final catName = ModalRoute.of(context)!.settings.arguments;
    //
    final product_controller = Provider.of<ProductProvider>(context);
    List<Product> productsList =
        product_controller.getBycatagory(catName.toString());
    print(productsList);
    return Scaffold(
      appBar: AppBar(
        title: Text("Catagory-Feeds"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: productsList.isNotEmpty
            ? GridView.builder(
                itemCount: productsList.length,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, i) {
                  final product = productsList[i];
                  return ChangeNotifierProvider.value(
                    value: product,
                    child: FeedsProducts(
                        // product: product,
                        ),
                  );
                },
              )
            : Center(
                child: Text("Nothing is in this catagory"),
              ),
      ),
    );
  }
}
