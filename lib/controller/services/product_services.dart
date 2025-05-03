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
}
