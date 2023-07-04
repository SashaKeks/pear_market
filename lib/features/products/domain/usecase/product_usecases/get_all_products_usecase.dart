import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class GetAllProductsUseCase {
  final ProductBaseRepository<ProductEntity> _productBaseRepository;

  GetAllProductsUseCase(this._productBaseRepository);

  Future<Either<Failure, List<ProductEntity>>> call(
      ProductType productType) async {
    return await _productBaseRepository.getAllProducts(productType);
  }
}
