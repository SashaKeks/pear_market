import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pear_market/core/error/failure.dart';

class RemoteProductCreateSource {
  Future<Map<String, dynamic>> _readJson(String filename) async {
    final String response =
        await rootBundle.loadString('assets/data/$filename');
    final data = await json.decode(response);
    return data;
  }

  Future<List<String>> getProductVersion(String type) async {
    final json = await _readJson("version.json");
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductRam(String type) async {
    final json = await _readJson("ram.json");
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductProc(String type) async {
    final json = await _readJson("proc.json");
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductVideo(String type) async {
    final json = await _readJson("video.json");
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductGeneration(String type) async {
    final json = await _readData(collectionName: "generations", type: type);
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

  Future<Map<String, dynamic>> _readData(
      {required String collectionName, required String type}) async {
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection(collectionName);

    final result = await productsCollection
        .doc(type)
        .get()
        .then((value) => value.data() as Map<String, dynamic>)
        // .then((snapshot) => snapshot.docs.map((e) {
        //       final product = e.data() as Map<String, dynamic>;
        //       return product;
        //     }).toList())
        .catchError(
          (e) => throw ServerFailure(e.toString()),
        );

    return result;
  }
}
