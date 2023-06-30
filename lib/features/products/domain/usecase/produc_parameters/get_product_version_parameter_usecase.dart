import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';

class GetProductVersionParameterUsecase {
  final ProductParametersRepository _productBaseRepository;

  GetProductVersionParameterUsecase(this._productBaseRepository);

  Future<Either<Failure, List<String>>> call(String type) async {
    return await _productBaseRepository.getProductVersion(type);
  }
}
