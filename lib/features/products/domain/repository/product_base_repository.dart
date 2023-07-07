import 'package:dartz/dartz.dart';
import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';

abstract class ProductBaseRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(
      ProductType productType,
      [Map<String, dynamic>? params]);
  Future<Either<Failure, ProductEntity>> getDetail(String productId);
  Future<DataState> addProduct(ProductEntity product);
  Future<DataState> deleteProduct(String productId);
  Future<DataState> updateProduct(ProductEntity updatedProduct);
}
