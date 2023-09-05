import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/menu/data/datasource/generation_datasource.dart';
import 'package:pear_market/features/menu/domain/entities/generation_entity.dart';
import 'package:pear_market/features/menu/domain/repository/generation_repository.dart';

class GenerationRepositoryImpl implements GenerationRepository {
  final GenerationDataSource _datasource;
  GenerationRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, List<GenerationEntity>>> getGenerations(
      {required ProductTypeEnum type}) async {
    try {
      final result = await _datasource.getGenerations(type: type);
      return right(result);
    } on LoadDataFromFireBaseException {
      return left(ServerFailure());
    } catch (_) {
      return left(UnknownFailure());
    }
  }
}
