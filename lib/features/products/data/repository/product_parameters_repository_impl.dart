import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_create_source.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';

class ProductParametersRepositoryImpl extends ProductParametersRepository {
  RemoteProductCreateSource source;
  ProductParametersRepositoryImpl(this.source);

  @override
  Future<Either<Failure, List<String>>> getProductColor(
      ProductTypeEnum type, String generation) async {
    try {
      final result = await source.getProductColor(type, generation);
      return right(result);
    } on ServerNotFoundException {
      return left(ServerFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductGeneration(
      ProductTypeEnum type) async {
    try {
      final result = await source.getProductGeneration(type);
      return right(result);
    } on ServerNotFoundException {
      return left(ServerFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductStorage(
      ProductTypeEnum type) async {
    try {
      final result = await source.getProductStorage(type);
      return right(result);
    } on ServerNotFoundException {
      return left(ServerFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductVersion(
      ProductTypeEnum type) async {
    try {
      final result = await source.getProductVersion(type);
      return right(result);
    } on ServerNotFoundException {
      return left(ServerFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductProc(
      ProductTypeEnum type) async {
    try {
      final result = await source.getProductProc(type);
      return right(result);
    } on ServerNotFoundException {
      return left(ServerFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductRam(
      ProductTypeEnum type) async {
    try {
      final result = await source.getProductRam(type);
      return right(result);
    } on ServerNotFoundException {
      return left(ServerFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductVideo(
      ProductTypeEnum type) async {
    try {
      final result = await source.getProductVideo(type);
      return right(result);
    } on ServerNotFoundException {
      return left(ServerFailure());
    } catch (e) {
      return left(UnknownFailure());
    }
  }
}
