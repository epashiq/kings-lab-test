import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kings_lab_test/controller/services/product_services.dart';
import 'package:kings_lab_test/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  final ProductServices productServices = ProductServices();

  List<Product> productList = [];

  Future<void> getProducts() async {
    try {
      final productModel =
          await productServices.getProducts(); 
      productList = productModel.products;
      notifyListeners();

      Fluttertoast.showToast(msg: 'Products fetched successfully');
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to fetch products: ${e.toString()}',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
