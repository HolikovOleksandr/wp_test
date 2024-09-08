import 'package:flutter/material.dart';
import 'package:wp_test/models/api_response.dart';
import 'package:wp_test/models/send_task_dto.dart';
import 'package:wp_test/models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

      if (error) {
        debugPrint("[DataProvider] :::>>>" + response.statusCode.toString());
        debugPrint("[DataProvider] :::>>>" + error.toString());
        return ApiResponse(error: error, message: message);
      }

      final List<Task> tasks = data.map((i) => Task.fromJson(i)).toList();
      return ApiResponse(error: error, message: message, data: tasks);
    } catch (e) {
      return ApiResponse(error: true, message: e.toString());
    }
  }

  static Future<bool> postRequest({
    required List<SendTaskDto> tasks,
    required String endpoint,
  }) async {
    try {
      final List<Map<String, dynamic>> tasksJson =
          tasks.map((t) => t.toJson()).toList();

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tasksJson),
      );

      debugPrint('[DataProvider] Response status: ${response.statusCode}');
      debugPrint('[DataProvider] Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody['error'] == false) {
          return true;
        } else {
          debugPrint('[DataProvider] Server error: ${responseBody['message']}');
          return false;
        }
      } else {
        // Handle unexpected status codes
        debugPrint(
            '[DataProvider] Unexpected status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle exceptions and log them
      debugPrint('[DataProvider] Exception: $e');
      throw http.ClientException('[DataProvider] :::>>>' + e.toString());
    }
  }
}
