import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';

class GetProductColorParameterUsecase {
  final ProductParametersRepository _productBaseRepository;

  GetProductColorParameterUsecase(this._productBaseRepository);

  Future<Either<Failure, List<String>>> call(
      String type, String generation) async {
    return await _productBaseRepository.getProductColor(type, generation);
  }
}
