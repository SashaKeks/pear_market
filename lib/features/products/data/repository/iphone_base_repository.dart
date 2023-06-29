import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pear_market/features/products/data/models/iphone_product_model.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class IphoneBaseRepositoryImpl
    extends ProductBaseRepository<IphoneProductEntity> {
  final ProducBaseRemoteDataSource _remoteDatasource;

  IphoneBaseRepositoryImpl(this._remoteDatasource);

  @override
  Future<void> addProduct(IphoneProductEntity product) async {
    try {
      await _remoteDatasource
          .addProduct(IphoneProductModel.fromEntity(product).toJson());
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    try {
      await _remoteDatasource.deleteProduct(productId);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<IphoneProductEntity>>> getAllProducts(
      int productTypeId) async {
    try {
      final result = await _remoteDatasource.getAllProducts(productTypeId);
      return right(result
          .map((e) => IphoneProductModel.fromJson(e).toEntity())
          .toList());
    } on ServerFailure {
      throw left(ServerFailure("Somthing was wrong"));
    }
  }

  @override
  Future<Either<Failure, IphoneProductEntity>> getDetail(int productId) async {
    try {
      final result = await _remoteDatasource.getDetail(productId);
      return right(IphoneProductModel.fromJson(result).toEntity());
    } catch (e) {
      throw left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> updateProduct(IphoneProductEntity updatedProduct) async {
    try {
      await _remoteDatasource.updateProduct(
          IphoneProductModel.fromEntity(updatedProduct).toJson());
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
