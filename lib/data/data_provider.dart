import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wp_test/models/api_response.dart';
import 'package:wp_test/models/task.dart';

class DataProvider {
  static Future<ApiResponse<List<Task>>> getRequest(
      {required String endpoint}) async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      final Map<String, dynamic> decodedJson = json.decode(response.body);

      if (decodedJson['error'] == true) {
        return ApiResponse(
          error: true,
          message: decodedJson['message'],
          data: [],
        );
      }

      return ApiResponse.fromJson(
        decodedJson,
        (data) => (data as List).map((e) => Task.fromJson(e)).toList(),
      );
    } catch (e) {
      return ApiResponse(
        error: true,
        message: e.toString(),
        data: [],
      );
    }
  }
}
