import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/menu/domain/entities/generation_entity.dart';

abstract class GenerationRepository {
  Future<Either<Failure, List<GenerationEntity>>> getGenerations(
      {required ProductTypeEnum type});
}
