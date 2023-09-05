import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';

class GetProductVersionParameterUsecase
    implements UseCase<List<String>, ProductTypeEnum> {
  final ProductParametersRepository _productBaseRepository;

  GetProductVersionParameterUsecase(this._productBaseRepository);

  @override
  Future<Either<Failure, List<String>>> call(
      {required ProductTypeEnum params}) async {
    return await _productBaseRepository.getProductVersion(params);
  }
}
