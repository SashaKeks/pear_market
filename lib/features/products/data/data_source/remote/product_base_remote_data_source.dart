import 'package:pear_market/core/util/enums.dart';

abstract class ProducBaseRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllProducts(
    ProductType productType,
  );
  Future<Map<String, dynamic>> getDetail(
    String productId,
    ProductType productType,
  );
  Future<void> addProduct(Map<String, dynamic> product);
  Future<void> deleteProduct(String productId, ProductType productType);
  Future<void> updateProduct(Map<String, dynamic> updatedProduct);
}
