import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
// import 'package:pear_market/features/products/domain/entities/statistic_entity.dart';

abstract class ProductBaseRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(
    ProductType productType, [
    Map<String, dynamic>? params,
  ]);
  Future<Either<Failure, ProductEntity>> getDetail(String productId);
  Future<void> addProduct(ProductEntity product);
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(ProductEntity updatedProduct);
  // Future<Either<Failure, List<StatisticEntity>>> getStatistic();
}
