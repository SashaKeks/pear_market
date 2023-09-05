import 'package:dartz/dartz.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';

import '../../../../core/error/failure.dart';

abstract class ProductParametersRepository {
  Future<Either<Failure, List<String>>> getProductVersion(ProductTypeEnum type);

  Future<Either<Failure, List<String>>> getProductGeneration(
      ProductTypeEnum type);

  Future<Either<Failure, List<String>>> getProductProc(ProductTypeEnum type);

  Future<Either<Failure, List<String>>> getProductRam(ProductTypeEnum type);

  Future<Either<Failure, List<String>>> getProductVideo(ProductTypeEnum type);

  Future<Either<Failure, List<String>>> getProductColor(
      ProductTypeEnum type, String generation);

  Future<Either<Failure, List<String>>> getProductStorage(ProductTypeEnum type);
}
