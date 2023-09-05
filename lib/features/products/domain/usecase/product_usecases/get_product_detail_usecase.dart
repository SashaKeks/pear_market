import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class GetProductDetailUseCase implements UseCase<ProductEntity, String> {
  final ProductBaseRepository _productBaseRepository;

  GetProductDetailUseCase(this._productBaseRepository);

  @override
  Future<Either<Failure, ProductEntity>> call({required String params}) async {
    return await _productBaseRepository.getDetail(params);
  }
}
