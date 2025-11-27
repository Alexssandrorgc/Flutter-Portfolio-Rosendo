import 'package:dio/dio.dart';

class ApiService {
  // Asegúrate de que la baseUrl esté definida
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  // Método modificado para cumplir la tarea
  Future<List<dynamic>> getUsers() async {
    try {
      // Endpoint actualizado de '/post' a '/users'
      final response = await _dio.get('/users');
      return response.data;
    } on DioException catch (e) {
      print('Error en getUsers(): ${e.message}');
      return [];
    }
  }
}