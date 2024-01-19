import 'dart:convert';
import 'package:flutter/services.dart';

class LoadConfig {
  Future<Map<String, dynamic>> loadJson() async {
    String data = await rootBundle.loadString('assets/config.json');
    Map<String, dynamic> jsonResult = json.decode(data);
    print(jsonResult);
    return jsonResult;
  }
}
