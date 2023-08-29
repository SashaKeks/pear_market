import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/menu/domain/entities/generation.dart';
import 'package:pear_market/features/menu/domain/repository/generation_repository.dart';

class GetGenerationsUseCase {
  final GenerationRepository _generationRepository;

  GetGenerationsUseCase(this._generationRepository);

  Future<Either<Failure, List<Generation>>> call(
      {required ProductType type}) async {
    return await _generationRepository.getGenerations(type: type);
  }
}
