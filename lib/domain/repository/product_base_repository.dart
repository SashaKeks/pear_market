import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/domain/entities/product_entity.dart';

abstract class ProductBaseRepository {
  Future<Either<Failure, List<Product>>> getAllProducts(int productTypeId);
  Future<Either<Failure, Product>> getDetail(int productId);
  Future<void> addProduct(Product product);
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(Product updatedProduct);
}
