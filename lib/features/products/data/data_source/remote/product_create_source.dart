import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';

class RemoteProductCreateSource {
  Future<List<String>> getProductVersion(ProductTypeEnum type) async {
    final json = await _readData(collectionName: "versions", type: type.name);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductRam(ProductTypeEnum type) async {
    final json = await _readData(collectionName: "ram", type: type.name);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductProc(ProductTypeEnum type) async {
    final json = await _readData(collectionName: "processors", type: type.name);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductVideo(ProductTypeEnum type) async {
    final json =
        await _readData(collectionName: "video_cards", type: type.name);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductGeneration(ProductTypeEnum type) async {
    final json =
        await _readData(collectionName: "generations", type: type.name);
    final list = (json[type] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductColor(
      ProductTypeEnum type, String generation) async {
    final json = await _readData(collectionName: "colors", type: type.name);
    final list = (json[generation] as List).map((e) => e.toString()).toList();
    return list;
  }

  Future<List<String>> getProductStorage(ProductTypeEnum type) async {
    final json = await _readData(collectionName: "storages", type: type.name);
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
          (e) => throw ServerNotFoundException(),
        );
    return result;
  }
}
