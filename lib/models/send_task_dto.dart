import 'package:wp_test/models/result.dart';

class SendTaskDto {
  final String id;
  final Result result;

  const SendTaskDto({required this.id, required this.result});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': result.toJson(),
    };
  }

  factory SendTaskDto.fromJson(Map<String, dynamic> json) {
    return SendTaskDto(
      id: json['id'] as String,
      result: Result.fromJson(json['result'] as Map<String, dynamic>),
    );
  }
}
