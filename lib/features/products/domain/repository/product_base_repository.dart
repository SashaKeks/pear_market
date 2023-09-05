import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/domain/entities/filter_product_entity.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';

abstract class ProductBaseRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(
    ProductTypeEnum productType, [
    FilterProductEntity? filter,
  ]);
  Future<Either<Failure, ProductEntity>> getDetail(String productId);
  Future<Either<Failure, void>> addProduct(ProductEntity product);
  Future<Either<Failure, void>> deleteProduct(String productId);
  Future<Either<Failure, void>> updateProduct(ProductEntity updatedProduct);
}
