import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class ServiceConfig{
  static const String _endpoint ="https://api.openai.com/v1/completions";
  static const String _apiKey ="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";
  static Future<String> complete(
      {required String prompt,int maxTokens = 2000, double temperature = 0.7}) async {
    final response = await http.post(Uri.parse(_endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'max_tokens': 1500,
          "model": "text-davinci-003",
          'temperature': temperature,
        }));

    if (response.statusCode == 200) {
      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['choices'][0]['text'];
    } else {
      debugPrint(response.body.toString());
      throw Exception('Failed to complete prompt');
    }
  }
}