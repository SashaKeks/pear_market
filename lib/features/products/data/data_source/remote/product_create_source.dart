import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/failure.dart';

class RemoteProductCreateSource {
  Future<List<String>> getProductVersion(String type) async {
    final json = await _readData(collectionName: "versions", type: type);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductRam(String type) async {
    final json = await _readData(collectionName: "ram", type: type);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductProc(String type) async {
    final json = await _readData(collectionName: "processors", type: type);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductVideo(String type) async {
    final json = await _readData(collectionName: "video_cards", type: type);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductGeneration(String type) async {
    final json = await _readData(collectionName: "generations", type: type);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductColor(String type, String generation) async {
    final json = await _readData(collectionName: "colors", type: type);
    final list = (json[generation] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductStorage(String type) async {
    final json = await _readData(collectionName: "storages", type: type);
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
        .catchError(
          (e) => throw ServerFailure(e.toString()),
        );

    return result;
  }
}
