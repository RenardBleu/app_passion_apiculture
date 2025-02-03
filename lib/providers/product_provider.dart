import 'package:app_passion_apiculture/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void setProducts(String jsonResponse) {
    _products = Product.fromJson(jsonResponse);
    print("+++++++++++++++++++++++++++++");
    print(_products[1].title);
    print("+++++++++++++++++++++++++++++");
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(int id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  void updateProduct(Product updatedProduct) {
    final index = _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }
}