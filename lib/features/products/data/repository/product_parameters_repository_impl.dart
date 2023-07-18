import 'package:pear_market/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_create_source.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';

class ProductParametersRepositoryImpl extends ProductParametersRepository {
  RemoteProductCreateSource source;
  ProductParametersRepositoryImpl(this.source);

  @override
  Future<Either<Failure, List<String>>> getProductColor(
      String type, String generation) async {
    try {
      final result = await source.getProductColor(type, generation);
      return right(result);
    } catch (e) {
      return left(ReadJsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductGeneration(
      String type) async {
    try {
      final result = await source.getProductGeneration(type);
      return right(result);
    } catch (e) {
      return left(ReadJsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductStorage(String type) async {
    try {
      final result = await source.getProductStorage(type);
      return right(result);
    } catch (e) {
      return left(ReadJsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductVersion(String type) async {
    try {
      final result = await source.getProductVersion(type);
      return right(result);
    } catch (e) {
      return left(ReadJsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductProc(String type) async {
    try {
      final result = await source.getProductProc(type);
      return right(result);
    } catch (e) {
      return left(ReadJsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductRam(String type) async {
    try {
      final result = await source.getProductRam(type);
      return right(result);
    } catch (e) {
      return left(ReadJsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductVideo(String type) async {
    try {
      final result = await source.getProductVideo(type);
      return right(result);
    } catch (e) {
      return left(ReadJsonFailure(e.toString()));
    }
  }
}
