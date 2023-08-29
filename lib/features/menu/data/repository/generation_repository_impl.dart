import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/menu/data/source/generation_source.dart';
import 'package:pear_market/features/menu/domain/entities/generation.dart';
import 'package:pear_market/features/menu/domain/repository/generation_repository.dart';

class GenerationRepositoryImpl implements GenerationRepository {
  final GenerationSource _datasource;
  GenerationRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, List<Generation>>> getGenerations(
      {required ProductType type}) async {
    try {
      final result = await _datasource.getGenerations(type: type);
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
