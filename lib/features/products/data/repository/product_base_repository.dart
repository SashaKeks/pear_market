import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pear_market/features/products/data/models/product_model.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class ProductBaseRepositoryImpl extends ProductBaseRepository {
  final ProducBaseRemoteDataSource _remoteDatasource;

  ProductBaseRepositoryImpl(this._remoteDatasource);

  @override
  Future<void> addProduct(ProductEntity product) async {
    try {
      await _remoteDatasource
          .addProduct(ProductModel.fromEntity(product).toJson());
    } on AddProductFailure catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknowingFailure(e.toString());
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    try {
      await _remoteDatasource.deleteProduct(productId);
    } on ServerFailure catch (e) {
      throw ServerFailure(e.toString());
    } catch (e) {
      throw UnknowingFailure(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(
    ProductType productType, [
    Map<String, dynamic>? params,
  ]) async {
    try {
      final result =
          await _remoteDatasource.getAllProducts(productType, params);
      return right(result.map((e) {
        final result = ProductModel.fromJson(e).toEntity();
        return result;
      }).toList());
    } on ServerFailure catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(UnknowingFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getDetail(String productId) async {
    try {
      final result = await _remoteDatasource.getDetail(productId);
      return right(ProductModel.fromJson(result).toEntity());
    } on ServerFailure catch (e) {
      return left(ServerFailure(e.toString()));
    } catch (e) {
      return left(UnknowingFailure(e.toString()));
    }
  }

  @override
  Future<void> updateProduct(ProductEntity updatedProduct) async {
    try {
      await _remoteDatasource
          .updateProduct(ProductModel.fromEntity(updatedProduct).toJson());
    } on UpdateProductFailure catch (e) {
      ServerFailure(e.toString());
    } catch (e) {
      throw UnknowingFailure(e.toString());
    }
  }
}
