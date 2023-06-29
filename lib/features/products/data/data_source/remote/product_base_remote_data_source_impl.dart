import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';

class ProductBaseRemoteDataSourceImpl implements ProducBaseRemoteDataSource {
  @override
  Future<void> addProduct(Map<String, dynamic> product) async {
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection("products");
    productsCollection
        .add(product)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Future<void> deleteProduct(String productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllProducts(int productTypeId) async {
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection("products");

    final snapshot =
        await productsCollection.where("type", isEqualTo: productTypeId).get();
    final result =
        snapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList();
    return result;
  }

  @override
  Future<Map<String, dynamic>> getDetail(int productId) {
    // TODO: implement getDetail
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(Map<String, dynamic> updatedProduct) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
