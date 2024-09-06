import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wp_test/models/api_response.dart';
import 'package:wp_test/models/task.dart';

class DataProvider {
  static Future<ApiResponse<List<Task>>> getRequest({
    required String endpoint,
  }) async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      final Map<String, dynamic> decodedJson = json.decode(response.body);

      final bool error = decodedJson['error'];
      final String message = decodedJson['message'];
      final List<dynamic> data = decodedJson['data'];

      if (error) return ApiResponse(error: true, message: message, data: null);

      final List<Task> tasks = data.map((i) => Task.fromJson(i)).toList();      
      return ApiResponse(error: error, message: message, data: tasks);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(error: true, message: e.toString(), data: null);
    }
  }
}
