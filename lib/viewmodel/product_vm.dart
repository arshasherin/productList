import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> productList = [];
  List<Product> tempList = [];
  Product tempData = Product();
  Product? selectedProduct;

  ProductViewModel() {
    getProduct();
  }

  Future<void> getProduct() async {
    try {
      String url = 'https://fakestoreapi.com/products';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          List<dynamic> data = json.decode(response.body);
          productList = data.map((json) => Product.fromJson(json)).toList();
        } else {
          productList = [];
        }
      } else {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    notifyListeners();
  }

  void addProduct() {
    tempList.add(tempData);
    notifyListeners();
  }

  void delete(Product?data) {
    tempList.remove(data);
    notifyListeners();
  }

  void selectProduct(Product product) {
    selectedProduct = product;
    notifyListeners();
  }

  void clearSelection() {
    selectedProduct = null;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
