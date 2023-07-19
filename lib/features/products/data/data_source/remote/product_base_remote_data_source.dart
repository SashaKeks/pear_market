import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';

abstract class ProducBaseRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllProducts(
    ProductType productType, [
    Map<String, dynamic>? params,
  ]);
  Future<Map<String, dynamic>> getDetail(String productId);
  Future<void> addBuyStatistic(ProductEntity productStatistic);
  Future<void> addSellStatistic(ProductEntity productStatistic);
  Future<void> addProduct(Map<String, dynamic> product);
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(Map<String, dynamic> updatedProduct);
  Future<List<Map<String, dynamic>>> getStatistic();
}
