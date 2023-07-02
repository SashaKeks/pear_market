import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';

class ProductBaseRemoteDataSourceImpl implements ProducBaseRemoteDataSource {
  @override
  Future<void> addProduct(Map<String, dynamic> product) async {
    CollectionReference productsCollection = FirebaseFirestore.instance
        .collection(ProductType.values[product["type"]].name);
    productsCollection
        .add(product)
        .catchError((error) => throw AddProductFailure(error.toString()));
  }

  @override
  Future<List<Map<String, dynamic>>> getAllProducts(
      ProductType productType) async {
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection(productType.name);

    final result = await productsCollection
        .where("type", isEqualTo: productType.index)
        .get()
        .then((snapshot) => snapshot.docs.map((e) {
              final product = e.data() as Map<String, dynamic>;
              product["id"] = e.id;
              return product;
            }).toList())
        .catchError((e) => throw ServerFailure(e.toString()));
    return result;
  }

  @override
  Future<void> updateProduct(Map<String, dynamic> updatedProduct) async {
    final docRef = FirebaseFirestore.instance
        .collection(ProductType.values[updatedProduct["type"]].name)
        .doc(updatedProduct["id"]);
    docRef
        .update(updatedProduct)
        .catchError((e) => throw UpdateProductFailure(e.toString()));
  }

  @override
  Future<void> deleteProduct(String productId, ProductType productType) async {
    final docRef =
        FirebaseFirestore.instance.collection(productType.name).doc(productId);
    docRef.delete().catchError((e) => throw DeleteProductFailure(e.toString()));
  }

  @override
  Future<Map<String, dynamic>> getDetail(
      String productId, ProductType productType) async {
    final docRef =
        FirebaseFirestore.instance.collection(productType.name).doc(productId);

    return docRef.get().then((value) {
      final product = value.data() as Map<String, dynamic>;
      product["id"] = value.id;
      return product;
    }).catchError((e) => throw ServerFailure(e.toString()));
  }
}
