import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';

class ProductBaseRemoteDataSourceImpl implements ProducBaseRemoteDataSource {
  @override
  Future<void> addProduct(Map<String, dynamic> product) async {
    CollectionReference? productsCollection =
        FirebaseFirestore.instance.collection(AppConstants.productDB);
    productsCollection
        .add(product)
        .catchError((error) => throw AddProductFailure(error.toString()));
    productsCollection = null;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllProducts(ProductType productType,
      [Map<String, dynamic>? params]) async {
    CollectionReference? productsCollection =
        FirebaseFirestore.instance.collection(AppConstants.productDB);

    final result = await productsCollection
        .where("type", isEqualTo: productType.index)
        .where("storage", isEqualTo: params?["storage"])
        .where("generation", isEqualTo: params?["generation"])
        .where("version", isEqualTo: params?["version"])
        .where("color", isEqualTo: params?["color"])
        .where("condition", isEqualTo: params?["condition"])
        .where("status", isEqualTo: params?["status"])
        .orderBy((params?["status"] != null)
            ? (params?["generation"] != null)
                ? "id"
                : "generation"
            : "status")
        .get()
        .then((snapshot) {
      final productsListRef = snapshot.docs;

      return productsListRef.map((e) {
        final product = e.data() as Map<String, dynamic>;
        product["id"] = e.id;
        return product;
      }).toList();
    }).catchError(
      (e) => throw ServerFailure(e.toString()),
    );
    productsCollection = null;
    return result;
  }

  @override
  Future<void> updateProduct(Map<String, dynamic> updatedProduct) async {
    DocumentReference? docRef = FirebaseFirestore.instance
        .collection(AppConstants.productDB)
        .doc(updatedProduct["id"]);
    docRef
        .update(updatedProduct)
        .catchError((e) => throw UpdateProductFailure(e.toString()));
    docRef = null;
  }

  @override
  Future<void> deleteProduct(String productId) async {
    DocumentReference? docRef = FirebaseFirestore.instance
        .collection(AppConstants.productDB)
        .doc(productId);
    docRef.delete().catchError((e) => throw DeleteProductFailure(e.toString()));
    docRef = null;
  }

  @override
  Future<Map<String, dynamic>> getDetail(String productId) async {
    DocumentReference? docRef = FirebaseFirestore.instance
        .collection(AppConstants.productDB)
        .doc(productId);

    final result = docRef.get().then((value) {
      final product = value.data() as Map<String, dynamic>;
      product["id"] = value.id;
      return product;
    }).catchError((e) => throw ServerFailure(e.toString()));
    docRef = null;
    return result;
  }

  @override
  Future<Map<String, dynamic>> getOwner(String customUserId) {
    DocumentReference? docRef = FirebaseFirestore.instance
        .collection(AppConstants.usersDB)
        .doc(customUserId);
    final result =
        docRef.get().catchError((e) => throw ServerFailure(e.toString()));

    return result.then((value) => value.data() as Map<String, dynamic>);
  }
}
