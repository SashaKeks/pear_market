import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/menu/domain/entities/generation.dart';

abstract class GenerationRepository {
  Future<Either<Failure, List<Generation>>> getGenerations(
      {required ProductType type});
}
