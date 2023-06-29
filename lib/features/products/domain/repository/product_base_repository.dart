import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';

abstract class ProductBaseRepository<P> {
  Future<Either<Failure, List<P>>> getAllProducts(int productTypeId);
  Future<Either<Failure, P>> getDetail(int productId);
  Future<void> addProduct(P product);
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(P updatedProduct);
}
