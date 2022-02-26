import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/model/productModel.dart';
import 'package:stack/provider/productNotifier.dart';
import 'package:stack/widgets/feeds_products.dart';

class SearchScreen extends StatefulWidget {
  static const routesName = "/search-screen";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  //
  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  late List<Product> _searachList;
  //
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final productsList = productData.product();
    return Scaffold(
      bottomSheet: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: ((value) {
          setState(() {
            _searachList = productData.getBySearch(value);
          });
        }),
        minLines: 1,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _controller.clear();
              _focusNode.unfocus();
            },
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.close,
                color: _controller.text.isNotEmpty ? Colors.red : Colors.grey),
            onPressed: _controller.text.isEmpty
                ? () {}
                : () {
                    _controller.clear();
                    _focusNode.unfocus();
                  },
          ),
        ),
      ),
      body: _controller.text.isNotEmpty && _searachList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.search),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No Result Found",
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: _controller.text.isNotEmpty
                    ? _searachList.length
                    : productsList.length,
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
                    value:
                        _controller.text.isNotEmpty ? _searachList[i] : product,
                    child: FeedsProducts(),
                  );
                },
              ),
            ),
    );
  }
}
