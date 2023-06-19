import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/data/models/iphone_product_model.dart';

import '../../domain/entities/product_entity.dart';

abstract class RemoteDatasource {
  Future<List<Product>> getAllProducts(int productTypeId);
  Future<Product> getDetail(int productId);
  Future<void> addProduct(IphoneProductModel product);
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(Product updatedProduct);
}

class RemoteBaseDatasource implements RemoteDatasource {
  @override
  Future<void> addProduct(IphoneProductModel product) async {
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection("products");
    productsCollection
        .add(product.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    ;
  }

  @override
  Future<void> deleteProduct(String productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getAllProducts(int productTypeId) {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<Product> getDetail(int productId) {
    // TODO: implement getDetail
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(Product updatedProduct) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
