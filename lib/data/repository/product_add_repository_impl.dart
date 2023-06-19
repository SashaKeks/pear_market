import 'package:pear_market/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pear_market/data/source/local_product_create_source.dart';
import 'package:pear_market/domain/repository/product_add_repository.dart';

class ProductAddRepositoryImpl extends ProductAddRepository {
  LocalProductCreateSource source;
  ProductAddRepositoryImpl(this.source);

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
}
