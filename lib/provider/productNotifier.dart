import 'package:stack/model/newProducts.dart';
import 'package:stack/model/productModel.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  //
  List<Product> _products = Products.products;
  List<Product> product() => _products;
  //
  List<Product> getBycatagory(String name) {
    if (name.isNotEmpty) {
      List<Product> catList = _products
          .where((item) =>
              item.productCatagoryName.toLowerCase() == name.toLowerCase())
          .toList();
      return catList;
    }
    //
    List<Product> catList = _products
        .where((element) =>
            element.productCatagoryName.toLowerCase() == "Phone".toLowerCase())
        .toList();
    return catList;
  }

  //
  List<Product> getByBrand(String name) {
    List<Product> catList = _products
        .where((item) =>
            item.productCatagoryName.toLowerCase() == name.toLowerCase())
        .toList();
    return catList;

    //
  }
  //

  List<Product> get getPopular {
    return _products.where((element) => element.isPopular).toList();
  }

  //
  Product getById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }
  //

  List<Product> getBySearch(String search) {
    List<Product> prodList = _products
        .where((element) =>
            element.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
    notifyListeners();
    return prodList;
  }
}
