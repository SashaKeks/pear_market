import 'package:pear_market/data/source/remote_base_datasource.dart';
import 'package:pear_market/domain/entities/product_entity.dart';

import 'package:pear_market/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repository/product_base_repository.dart';

class ProductBaseRepositoryImpl implements ProductBaseRepository {
  final RemoteDatasource _remoteDatasource;

  ProductBaseRepositoryImpl(this._remoteDatasource);

  @override
  Future<void> addProduct(Product product) async {
    try {
      await _remoteDatasource.addProduct(product);
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
  Future<Either<Failure, List<Product>>> getAllProducts(
      int productTypeId) async {
    try {
      final result = await _remoteDatasource.getAllProducts(productTypeId);
      return right(result);
    } catch (e) {
      throw left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getDetail(int productId) async {
    try {
      final result = await _remoteDatasource.getDetail(productId);
      return right(result);
    } catch (e) {
      throw left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> updateProduct(Product updatedProduct) async {
    try {
      await _remoteDatasource.updateProduct(updatedProduct);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
