import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kings_lab_test/model/product_model.dart';

class ProductServices {
  final dio = Dio();

  Future<ProductModel> getProducts() async {
    try {
      final resp = await dio.get('https://dummyjson.com/products');
      if (resp.statusCode == 200) {
        return ProductModel.fromJson(resp.data);
      } else {
        throw Exception('faild to load products');
      }
    } catch (e) {
      throw Exception('faild to load products');
    }
  }

  Future<Product> getProductById(int id) async {
    final response = await dio.get('https://dummyjson.com/products/$id');
    if (response.statusCode == 200) {
      return Product.fromJson(response.data);
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<bool> updateProduct(int id, Map<String, dynamic> productData) async {
    try {
      final resp = await dio.put(
        'https://dummyjson.com/products/$id',
        data: productData,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (resp.statusCode == 200) {
        log(resp.statusCode.toString());
       
        return true;
      } else {
        throw Exception('Failed to update product');
      }
    } catch (error) {
      log('Error updating product: $error');
      return false;
    }
  }
}
