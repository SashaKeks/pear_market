import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class ProductParametersRepository {
  Future<Either<Failure, List<String>>> getProductVersion(String type);

  Future<Either<Failure, List<String>>> getProductGeneration(String type);

  Future<Either<Failure, List<String>>> getProductProc(String type);

  Future<Either<Failure, List<String>>> getProductRam(String type);

  Future<Either<Failure, List<String>>> getProductVideo(String type);

  Future<Either<Failure, List<String>>> getProductColor(
      String type, String generation);

  Future<Either<Failure, List<String>>> getProductStorage(String type);
}
