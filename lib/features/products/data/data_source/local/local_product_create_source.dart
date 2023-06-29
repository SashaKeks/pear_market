import 'dart:convert';

import 'package:flutter/services.dart';

class LocalProductCreateSource {
  Future<Map<String, dynamic>> _readJson(String filename) async {
    final String response =
        await rootBundle.loadString('assets/data/$filename');
    final data = await json.decode(response);
    return data;
  }

  Future<List<String>> getProductVersion(String type) async {
    final json = await _readJson("version.json");
    return json[type];
  }

  Future<List<String>> getProductGeneration(String type) async {
    final json = await _readJson("generations.json");
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductColor(String type, String generation) async {
    final json = await _readJson("colors.json");
    final list =
        (json[type][generation] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductStorage(String type) async {
    final json = await _readJson("storage.json");
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }
}
