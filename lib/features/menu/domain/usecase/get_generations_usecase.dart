import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/menu/domain/entities/generation_entity.dart';
import 'package:pear_market/features/menu/domain/repository/generation_repository.dart';

class GetGenerationsUseCase
    extends UseCase<List<GenerationEntity>, ProductTypeEnum> {
  final GenerationRepository _generationRepository;

  GetGenerationsUseCase(this._generationRepository);

  @override
  Future<Either<Failure, List<GenerationEntity>>> call(
      {required ProductTypeEnum params}) async {
    return await _generationRepository.getGenerations(type: params);
  }
}
