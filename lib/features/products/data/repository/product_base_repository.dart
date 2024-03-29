import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pear_market/features/products/data/models/product_model.dart';
import 'package:pear_market/features/products/data/models/statistic_model.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/entities/statistic_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class ProductBaseRepositoryImpl extends ProductBaseRepository {
  final ProducBaseRemoteDataSource _remoteDatasource;

  ProductBaseRepositoryImpl(this._remoteDatasource);

  @override
  Future<DataState> addProduct(ProductEntity product) async {
    try {
      await _remoteDatasource
          .addProduct(ProductModel.fromEntity(product).toJson());
      await _remoteDatasource.addBuyStatistic(product);
      return DataSuccess("add product success");
    } on AddProductFailure catch (e) {
      return DataFailure(e.errorMessage);
    } catch (e) {
      throw UnknowingFailure(e.toString());
    }
  }

  @override
  Future<DataState> deleteProduct(String productId) async {
    try {
      await _remoteDatasource.deleteProduct(productId);
      return DataSuccess("product deleted success");
    } on ServerFailure catch (e) {
      return DataFailure(e.toString());
    } catch (e) {
      throw UnknowingFailure(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(
      ProductType productType,
      [Map<String, dynamic>? params]) async {
    try {
      final result =
          await _remoteDatasource.getAllProducts(productType, params);
      return right(
          result.map((e) => ProductModel.fromJson(e).toEntity()).toList());
    } on ServerFailure catch (e) {
      return left(ServerFailure(e.toString()));
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
  Future<DataState> updateProduct(ProductEntity updatedProduct) async {
    try {
      await _remoteDatasource
          .updateProduct(ProductModel.fromEntity(updatedProduct).toJson());
      await _remoteDatasource.addSellStatistic(updatedProduct);
      return DataSuccess("product updated success");
    } on UpdateProductFailure catch (e) {
      return DataFailure(e.toString());
    } catch (e) {
      throw UnknowingFailure(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<StatisticEntity>>> getStatistic() async {
    try {
      final result = await _remoteDatasource.getStatistic();

      return right(result.map((e) => StatisticModel.fromJson(e)).toList());
    } on ServerFailure catch (e) {
      return left(ServerFailure(e.toString()));
    } catch (e) {
      throw left(UnknowingFailure(e.toString()));
    }
  }
}
