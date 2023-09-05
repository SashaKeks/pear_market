import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';

class GetProductColorParameterUsecase
    implements UseCase<List<String>, GetProductColorParams> {
  final ProductParametersRepository _productBaseRepository;

  GetProductColorParameterUsecase(this._productBaseRepository);

  @override
  Future<Either<Failure, List<String>>> call(
      {required GetProductColorParams params}) async {
    return await _productBaseRepository.getProductColor(
        params.type, params.generation);
  }
}

class GetProductColorParams {
  final ProductTypeEnum type;
  final String generation;

  GetProductColorParams({required this.type, required this.generation});
}
