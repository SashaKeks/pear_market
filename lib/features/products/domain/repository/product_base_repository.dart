import 'package:dartz/dartz.dart';
import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';

abstract class ProductBaseRepository<P> {
  Future<Either<Failure, List<P>>> getAllProducts(ProductType productType);
  Future<Either<Failure, P>> getDetail(
      String productId, ProductType productType);
  Future<DataState> addProduct(P product);
  Future<DataState> deleteProduct(String productId, ProductType productType);
  Future<DataState> updateProduct(P updatedProduct);
}
