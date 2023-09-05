import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pear_market/features/products/data/models/product_model.dart';
import 'package:pear_market/features/products/domain/entities/filter_product_entity.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class ProductBaseRepositoryImpl extends ProductBaseRepository {
  final ProducBaseRemoteDataSource _remoteDatasource;

  ProductBaseRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, void>> addProduct(ProductEntity product) async {
    try {
      await _remoteDatasource.addProduct(ProductModel.fromEntity(product));
      return right(null);
    } on ServerAddProductException {
      return left(AddProductFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    try {
      await _remoteDatasource.deleteProduct(productId);
      return right(null);
    } on ServerDeleteProductException {
      return left(DeleteProductFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(
    ProductTypeEnum productType, [
    FilterProductEntity? filter,
  ]) async {
    try {
      return right(await _remoteDatasource.getAllProducts(productType, filter));
    } on ServerGetProductException {
      return left(ServerFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getDetail(String productId) async {
    try {
      return right(await _remoteDatasource.getDetail(productId));
    } on ServerGetProductException {
      return left(ServerFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(
      ProductEntity updatedProduct) async {
    try {
      await _remoteDatasource
          .updateProduct(ProductModel.fromEntity(updatedProduct));
      return right(null);
    } on ServerUpdateProductException {
      return left(UpdateProductFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }
}
