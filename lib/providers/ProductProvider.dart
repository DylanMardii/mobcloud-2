import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _cart = [];
  List<Product> get cart => _cart;

  void addProductToCart(Product product) {
    print('Add product!');
    _cart.add(product);
    notifyListeners();
  }

  void removeProductFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    return _cart.fold(0, (sum, item) => sum + item.price);
  }

  void checkout() {
    _cart.clear();
    notifyListeners();
  }
}
