import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';

class GetProductRamParameterUsecase {
  final ProductParametersRepository _productBaseRepository;

  GetProductRamParameterUsecase(this._productBaseRepository);

  Future<Either<Failure, List<String>>> call(String type) async {
    return await _productBaseRepository.getProductRam(type);
  }
}
