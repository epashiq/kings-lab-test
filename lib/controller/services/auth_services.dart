import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    int expiresInMins = 30,
  }) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
          'expiresInMins': expiresInMins,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        Fluttertoast.showToast(msg: 'Login failed: ${response.statusMessage}');
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Login failed: ${e.toString()}');
      throw Exception("Login error: $e");
    }
  }
}
