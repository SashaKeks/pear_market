import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class DeleteProductUseCase implements UseCase<void, String> {
  final ProductBaseRepository _productBaseRepository;

  DeleteProductUseCase(this._productBaseRepository);

  @override
  Future<Either<Failure, void>> call({required String params}) async {
    return await _productBaseRepository.deleteProduct(params);
  }
}
