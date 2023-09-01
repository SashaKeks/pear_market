import 'package:pear_market/core/util/enums.dart';

abstract class ProducBaseRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllProducts(
    ProductType productType, [
    Map<String, dynamic>? params,
  ]);
  Future<Map<String, dynamic>> getDetail(String productId);
  Future<Map<String, dynamic>> getOwner(String customUserId);
  Future<void> addProduct(Map<String, dynamic> product);
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(Map<String, dynamic> updatedProduct);
}
