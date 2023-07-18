import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';

class GetProductProcParameterUsecase {
  final ProductParametersRepository _productBaseRepository;

  GetProductProcParameterUsecase(this._productBaseRepository);

  Future<Either<Failure, List<String>>> call(String type) async {
    return await _productBaseRepository.getProductProc(type);
  }
}
