import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/data/models/product_model.dart';
import 'package:pear_market/features/products/domain/entities/filter_product_entity.dart';

abstract class ProducBaseRemoteDataSource {
  Future<List<ProductModel>> getAllProducts(
    ProductTypeEnum productType, [
    FilterProductEntity? params,
  ]);
  Future<ProductModel> getDetail(String productId);
  Future<void> addProduct(ProductModel product);
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(ProductModel updatedProduct);
}
