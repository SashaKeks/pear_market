import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class UpdateProductUseCase implements UseCase<void, ProductEntity> {
  final ProductBaseRepository _productBaseRepository;

  UpdateProductUseCase(this._productBaseRepository);

  @override
  Future<Either<Failure, void>> call({required ProductEntity params}) async {
    return await _productBaseRepository.updateProduct(params);
  }
}
