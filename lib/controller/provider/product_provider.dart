import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kings_lab_test/controller/services/product_services.dart';
import 'package:kings_lab_test/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  final ProductServices productServices = ProductServices();

  List<Product> productList = [];

  Future<void> getProducts() async {
    try {
      final productModel = await productServices.getProducts();
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

  Future<Product?> getProductById(int id) async {
    try {
      final product = await productServices.getProductById(id);
      return product;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to fetch product: ${e.toString()}',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }
  }

  Future<bool> updateProduct(int id, Map<String, dynamic> productData) async {
    try {
      bool result = await ProductServices().updateProduct(id, productData);
      if (result) {
        // await getProducts();
        log('Products updated successfully');
        Fluttertoast.showToast(msg: 'Products updated successfully');
        return true;
      }
      return false;
    } catch (e) {
      log("Error updating product: $e");
      return false;
    }
  }
}
